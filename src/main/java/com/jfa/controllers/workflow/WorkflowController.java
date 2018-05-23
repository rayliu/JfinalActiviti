package com.jfa.controllers.workflow;

import java.io.File;
import java.io.InputStream;
import java.io.StringWriter;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import cn.hutool.core.io.FileUtil;
import com.jfa.controllers.workflow.util.ActivitiKit;
import com.jfa.controllers.workflow.util.BpmsActivityTypeEnum;
import com.jfa.controllers.workflow.util.UtilMisc;
import com.jfa.interceptor.SetAttrLoginUserInterceptor;
import com.jfa.util.ImgRender;
import com.jfa.util.JfaRenderUtil;
import com.jfinal.kit.PropKit;
import com.jfinal.render.RenderManager;
import com.jfinal.template.Engine;
import com.jfinal.template.Template;
import com.jfinal.template.source.ClassPathSourceFactory;
import org.activiti.bpmn.model.BpmnModel;
import org.activiti.bpmn.model.FlowNode;
import org.activiti.bpmn.model.SequenceFlow;
import org.activiti.engine.ProcessEngine;
import org.activiti.engine.ProcessEngines;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.history.HistoricActivityInstance;
import org.activiti.engine.history.HistoricProcessInstance;
import org.activiti.engine.repository.Deployment;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.image.ProcessDiagramGenerator;

import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.log.Log;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;


@Before(SetAttrLoginUserInterceptor.class)
public class WorkflowController extends Controller {
    private Log logger = Log.getLog(WorkflowController.class);
   
    public void index() {
       redirect("/workflow/processList");
    }
    
    public void deploy() {
        render("deploy.html");
    }
    
    public void processList() {
        URL url = WorkflowController.class.getResource("");
        String protocol = url.getProtocol();
        if("jar".equals(protocol)){
            // jar 中
            JfaRenderUtil.render("template/layui/workflow/processList.html", this);
        }else if("file".equals(protocol)){
            // 非jar 中 （文件class 中）
            render("processList.html");
        }
    }
    
    public void processListQuery() {
//        ProcessEngine processEngine = ProcessEngines.getDefaultProcessEngine();
//        RepositoryService repositoryService = processEngine.getRepositoryService();
//        List<Deployment> deploymentList = repositoryService.createDeploymentQuery().list();

        String sLimit = "";
        String condition = " ";
        String pageIndex = getPara("draw");
        if (getPara("start") != null && getPara("length") != null) {
           sLimit = " LIMIT " + getPara("start") + ", " + getPara("length");
        }
       Record login_user = getAttr("user");
       String sql=" select * from ACT_RE_PROCDEF ";
       List<Record> orderList = Db.find(sql+condition+" order by id_ desc");
       String sqlTotal = "select count(1) total from (" + sql + ") B";
       Record rec = Db.findFirst(sqlTotal);
       Map<String,Object> map = new HashMap<String,Object>();
        String templateFolder = PropKit.get("ui_folder");
        if("/template/layui".equals(templateFolder)){
            map.put("code", 0);
            map.put("count", orderList.size());
            map.put("data", orderList);
        }else {
            map.put("draw", pageIndex);
            map.put("recordsTotal", rec.getLong("total"));
            map.put("recordsFiltered", rec.getLong("total"));
            map.put("data", orderList);
        }

       renderJson(map); 
       
    }

    public void readProccessImage(){
        String id=getPara("processInstanceId");
        try {
            // 获取历史流程实例
            HistoricProcessInstance historicProcessInstance = ActivitiKit.getHistoryService().createHistoricProcessInstanceQuery().processInstanceId(id).singleResult();
                        
            // 获取流程中已经执行的节点，按照执行先后顺序排序
            List<HistoricActivityInstance> historicActivityInstanceList = ActivitiKit.getHistoryService().createHistoricActivityInstanceQuery().processInstanceId(id).orderByHistoricActivityInstanceId().asc().list();
            
            // 构造已执行的节点ID集合
            List<String> executedActivityIdList = new ArrayList<String>();
            for (HistoricActivityInstance activityInstance : historicActivityInstanceList) {
                executedActivityIdList.add(activityInstance.getActivityId());
            }
            // 获取bpmnModel
            BpmnModel bpmnModel = ActivitiKit.getRepositoryService().getBpmnModel(historicProcessInstance.getProcessDefinitionId());
            // 获取流程已发生流转的线ID集合
            List<String> flowIds = this.getExecutedFlows(bpmnModel, historicActivityInstanceList);
            
            // 使用默认配置获得流程图表生成器，并生成追踪图片字符流
            ProcessDiagramGenerator processDiagramGenerator = ActivitiKit.getProcessEngine()
                    .getProcessEngineConfiguration().getProcessDiagramGenerator();
            InputStream imageStream = processDiagramGenerator.generateDiagram(bpmnModel, "jpeg", executedActivityIdList,
                    flowIds, "宋体", "微软雅黑", "黑体", null, 2.0);
            render(new ImgRender(imageStream));
        } catch (Exception e) {
            e.printStackTrace();
            renderNull();
        }
        
    }
    
    private List<String> getExecutedFlows(BpmnModel bpmnModel, List<HistoricActivityInstance> historicActivityInstances) {
        // 流转线ID集合
        List<String> flowIdList = new ArrayList<String>();
        // 全部活动实例
        List<FlowNode> historicFlowNodeList = new LinkedList<FlowNode>();
        // 已完成的历史活动节点
        List<HistoricActivityInstance> finishedActivityInstanceList = new LinkedList<HistoricActivityInstance>();
        for (HistoricActivityInstance historicActivityInstance : historicActivityInstances) {
            historicFlowNodeList.add((FlowNode) bpmnModel.getMainProcess().getFlowElement(historicActivityInstance.getActivityId(), true));
            if (historicActivityInstance.getEndTime() != null) {
                finishedActivityInstanceList.add(historicActivityInstance);
            }
        }
        
        // 遍历已完成的活动实例，从每个实例的outgoingFlows中找到已执行的
        FlowNode currentFlowNode = null;
        for (HistoricActivityInstance currentActivityInstance : finishedActivityInstanceList) {
            // 获得当前活动对应的节点信息及outgoingFlows信息
            currentFlowNode = (FlowNode) bpmnModel.getMainProcess().getFlowElement(currentActivityInstance.getActivityId(), true);
            List<SequenceFlow> sequenceFlowList = currentFlowNode.getOutgoingFlows();
            
            /**
             * 遍历outgoingFlows并找到已已流转的
             * 满足如下条件认为已已流转：
             * 1.当前节点是并行网关或包含网关，则通过outgoingFlows能够在历史活动中找到的全部节点均为已流转
             * 2.当前节点是以上两种类型之外的，通过outgoingFlows查找到的时间最近的流转节点视为有效流转
             */
            FlowNode targetFlowNode = null;
            if (BpmsActivityTypeEnum.PARALLEL_GATEWAY.getType().equals(currentActivityInstance.getActivityType())
                    || BpmsActivityTypeEnum.INCLUSIVE_GATEWAY.getType().equals(currentActivityInstance.getActivityType())) {
                // 遍历历史活动节点，找到匹配Flow目标节点的
                for (SequenceFlow sequenceFlow : sequenceFlowList) {
                    targetFlowNode = (FlowNode) bpmnModel.getMainProcess().getFlowElement(sequenceFlow.getTargetRef(), true);
                    if (historicFlowNodeList.contains(targetFlowNode)) {
                        flowIdList.add(sequenceFlow.getId());
                    }
                }
            } else {
                List<Map<String, String>> tempMapList = new LinkedList<Map<String,String>>();
                // 遍历历史活动节点，找到匹配Flow目标节点的
                for (SequenceFlow sequenceFlow : sequenceFlowList) {
                    for (HistoricActivityInstance historicActivityInstance : historicActivityInstances) {
                        if (historicActivityInstance.getActivityId().equals(sequenceFlow.getTargetRef())) {
                            //tempMapList.add(UtilMisc.toMap("flowId", sequenceFlow.getId(), "activityStartTime", String.valueOf(historicActivityInstance.getStartTime().getTime())));
                        }
                    }
                }
                
                // 遍历匹配的集合，取得开始时间最早的一个
                long earliestStamp = 0L;
                String flowId = null;
                for (Map<String, String> map : tempMapList) {
                    long activityStartTime = Long.valueOf(map.get("activityStartTime"));
                    if (earliestStamp == 0 || earliestStamp >= activityStartTime) {
                        earliestStamp = activityStartTime;
                        flowId = map.get("flowId");
                    }
                }
                flowIdList.add(flowId);
            }
        }
        return flowIdList;
    }
}
