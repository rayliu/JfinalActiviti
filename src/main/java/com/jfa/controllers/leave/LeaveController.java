package com.jfa.controllers.leave;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfa.controllers.workflow.util.ActivitiKit;
import com.jfa.interceptor.SetAttrLoginUserInterceptor;
import com.jfinal.kit.PropKit;
import com.jfinal.kit.StrKit;
import com.shuyan.wxl.annotation.JAction;
import org.activiti.engine.IdentityService;
import org.activiti.engine.ProcessEngine;
import org.activiti.engine.ProcessEngines;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;

import org.apache.commons.lang3.BooleanUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.apache.shiro.subject.Subject;

import com.google.gson.Gson;
import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.log.Log;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.activerecord.tx.Tx;


//shiro注解, 要求必须登录才能访问
@RequiresAuthentication
@Before(SetAttrLoginUserInterceptor.class)

//JAction注解, 无需在config中再配置
@JAction(value = "/leave",viewPath = "/leave")
public class LeaveController extends Controller {
    private Log logger = Log.getLog(LeaveController.class);
    Subject currentUser = SecurityUtils.getSubject();

    //返回leave list页面
    public void index() {
        redirect("/leave/list");
    }

    public void list() {
        render("leaveList.html");
    }

    //返回list页面所需的json
    public void getList(){
        String sLimit = "";
        String condition = " ";
        String pageIndex = getPara("draw");
        if (getPara("start") != null && getPara("length") != null) {
            sLimit = " LIMIT " + getPara("start") + ", " + getPara("length");
        }
        Record login_user = getAttr("user");
        String sql=" select l.*, user.name user_name from t_leave l left join t_rbac_user user on l.user_id=user.id ";
        List<Record> orderList = Db.find(sql+condition+" order by id desc");

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

    //返回create页面
    public void create() {
        Record login_user = getAttr("user");
        
        Record order = new Record();
        order.set("user_id", login_user.get("id"));
        order.set("user_name", login_user.get("name"));
        setAttr("order", order);
        render("leaveForm.html");
    }
    
    //返回edit页面
    public void edit() {
        Record login_user = getAttr("user");
        String id = getPara("id");
        Record order = Db.findFirst("select l.*, user.name user_name from t_leave l left join t_rbac_user user on l.user_id=user.id where l.id=?",id);
        
        setAttr("order", order);
        render("leaveForm.html");
    }
    
    //返回task页面
    public void task() {
        Record login_user = getAttr("user");
        render("taskList.html");
    }
    
    //返回deptLeaderVerify页面
    public void deptLeaderVerify() {
        String task_id = getPara("task_id");
        //获取task
        Task task = ActivitiKit.getTaskService().createTaskQuery().taskId(task_id).singleResult();
        if(task!=null) {
            //获取processInstance
            ProcessInstance processInstance = ActivitiKit.getRuntimeService().createProcessInstanceQuery()
                    .processInstanceId(task.getProcessInstanceId()).singleResult();

            //BusinessKey就是我们启动流程时传进来的leave id
            String leave_id = processInstance.getBusinessKey();
            //获取请假单 leave
            Record order = Db.findFirst("select l.*, user.name user_name from t_leave l left join t_rbac_user user on l.user_id=user.id where l.id=?", leave_id);
            order.set("task_id", task_id);
            setAttr("order", order);
            render("taskDeptLeaderVerify.html");
        }else{//任务不存在, 跳转到 taskList
            redirect("/leave/task");
        }
    }
    
  
    public void deptLeaderVerifySave() {
        String jsonStr=getPara("params");
        Gson gson = new Gson();  
        Map<String, ?> dto= gson.fromJson(jsonStr, HashMap.class); 
        Record login_user = getAttr("user");

        String order_id = (String)dto.get("order_id");
        String task_id = (String)dto.get("task_id");
        String p_B_deptLeaderApproved = (String)dto.get("deptLeaderApproved");
       
        //构建variables
        Map<String, Object> variables=new HashMap<String, Object>();
        //deptLeaderApproved 要对应leave.bpmn中的activiti:formProperty id
        variables.put("deptLeaderApproved", BooleanUtils.toBoolean(p_B_deptLeaderApproved));
        
        //设置任务完成
        ActivitiKit.getTaskService().complete(task_id, variables);
        
       
        render("ok");
    }
    
    //返回hrVerify页面
    public void hrVerify() {
        String task_id = getPara("task_id");
        //获取task
        Task task = ActivitiKit.getTaskService().createTaskQuery().taskId(task_id).singleResult();
        //获取processInstance
        ProcessInstance processInstance = ActivitiKit.getRuntimeService().createProcessInstanceQuery()
                .processInstanceId(task.getProcessInstanceId()).singleResult();
        
        //BusinessKey就是我们启动流程时传进来的leave id
        String leave_id = processInstance.getBusinessKey();
        //获取请假单 leave 
        Record order = Db.findFirst("select l.*, user.name user_name from t_leave l left join t_rbac_user user on l.user_id=user.id where l.id=?", leave_id);
        order.set("task_id", task_id);
        setAttr("order", order);
        render("taskHrVerify.html");
    }
    
  
    public void hrVerifySave() {
        String jsonStr=getPara("params");
        Gson gson = new Gson();  
        Map<String, ?> dto= gson.fromJson(jsonStr, HashMap.class); 
        Record login_user = getAttr("user");

        String order_id = (String)dto.get("order_id");
        String task_id = (String)dto.get("task_id");
        String p_B_deptLeaderApproved = (String)dto.get("hrApproved");
       
        //构建variables
        Map<String, Object> variables=new HashMap<String, Object>();
        //deptLeaderApproved 要对应leave.bpmn中的activiti:formProperty id
        variables.put("hrApproved", BooleanUtils.toBoolean(p_B_deptLeaderApproved));
        
        //设置任务完成
        ActivitiKit.getTaskService().complete(task_id, variables);
        
        renderText("ok");
    }
    
    //返回reportBack页面
    public void reportBack() {
        String task_id = getPara("task_id");
        //获取task
        Task task = ActivitiKit.getTaskService().createTaskQuery().taskId(task_id).singleResult();
        //获取processInstance
        ProcessInstance processInstance = ActivitiKit.getRuntimeService().createProcessInstanceQuery()
                .processInstanceId(task.getProcessInstanceId()).singleResult();
        
        //BusinessKey就是我们启动流程时传进来的leave id
        String leave_id = processInstance.getBusinessKey();
        //获取请假单 leave 
        Record order = Db.findFirst("select l.*, user.name user_name from t_leave l left join t_rbac_user user on l.user_id=user.id where l.id=?", leave_id);
        order.set("task_id", task_id);
        setAttr("order", order);
        render("taskReportBack.html");
    }
    
  
    public void reportBackSave() {
        String jsonStr=getPara("params");
        Gson gson = new Gson();  
        Map<String, ?> dto= gson.fromJson(jsonStr, HashMap.class); 
        Record login_user = getAttr("user");

        String order_id = (String)dto.get("order_id");
        String task_id = (String)dto.get("task_id");
        String reportBackDate = (String)dto.get("reportBackDate");
       
        //构建variables
        Map<String, Object> variables=new HashMap<String, Object>();
        //deptLeaderApproved 要对应leave.bpmn中的activiti:formProperty id
        variables.put("reportBackDate", reportBackDate);
        
        //设置任务完成
        ActivitiKit.getTaskService().complete(task_id, variables);
        
        renderText("ok");
    }
    
    //返回tasks json
    public void taskList() {
        Record login_user = getAttr("user");
        
        TaskService taskService = ActivitiKit.getTaskService();
        
        String userId = login_user.get("id").toString();
        //已签收的任务
        List<Task> doingTasks = taskService.createTaskQuery().taskAssignee(userId).list();
        //等待签收的任务
        List<Task> waitingTasks = taskService.createTaskQuery().taskCandidateUser(userId).list();

        //合并两种任务
        List<Task> allTasks = new ArrayList<Task>();
        allTasks.addAll(doingTasks);
        allTasks.addAll(waitingTasks);
        
        List<Record> allTasksRec = new ArrayList<Record>();
        for (Task task : allTasks) {
            Record rec = new Record();
            rec.set("id", task.getId());
            rec.set("Name", task.getName());
            rec.set("Description", task.getDescription());
            Record userRec = Db.findFirst("select * from t_rbac_user where id=?", task.getAssignee());
            if(userRec!=null)
                rec.set("Assignee", userRec.get("name"));
            rec.set("Owner", task.getOwner());
            rec.set("TaskDefinitionKey", task.getTaskDefinitionKey());
            rec.set("CreateTime", task.getCreateTime());
            allTasksRec.add(rec);
        }
        
        Map<String,Object> map = new HashMap<String,Object>();

        String templateFolder = PropKit.get("ui_folder");
        if("/template/layui".equals(templateFolder)){
            map.put("code", 0);
            map.put("count", allTasksRec.size());
            map.put("data", allTasksRec);
        }else {
            map.put("draw", 1);
            map.put("recordsTotal", allTasksRec.size());
            map.put("recordsFiltered", allTasksRec.size());
            map.put("data", allTasksRec);
        }
        renderJson(map); 
    }
    
    @Before(Tx.class)
    public void submit(){
        String order_id_key = getPara("order_id");
        Record order = Db.findById("t_leave", order_id_key);

        IdentityService identityService = ActivitiKit.getIdentityService();
        RuntimeService runtimeService = ActivitiKit.getRuntimeService();
       
        //这里会自动把用户ID 保存到activiti:initiator中
        identityService.setAuthenticatedUserId(order.get("user_id").toString());
        
        //启动流程,由于startEvent没有变量,variables就是一个空对象
        Map<String, Object> variables = new HashMap<String, Object>();
        ProcessInstance processInstance = runtimeService.startProcessInstanceByKey("leave", order_id_key, variables);
        //实体业务表记录流程ID, 建立双向关系
        String processInstanceId = processInstance.getId();
        order.set("process_instace_id", processInstanceId);
        Db.update("t_leave", order);
        
        renderText("ok");
    }
    
    @Before(Tx.class)
    public void save(){
        String jsonStr=getPara("params");
        Gson gson = new Gson();  
        Map<String, ?> dto= gson.fromJson(jsonStr, HashMap.class); 
        Record login_user = getAttr("user");

        String order_id = (String)dto.get("order_id");
        String user_id = (String)dto.get("user_id");
        String start_time = (String)dto.get("start_time");
        String end_time = (String)dto.get("end_time");
        String reason = (String)dto.get("reason");
        
        Record order = new Record();
        if(StrKit.notBlank(order_id)){
            order = Db.findById("t_leave", order_id);
            order.set("user_id", user_id);
            order.set("start_time", start_time);
            order.set("end_time", end_time);
            order.set("reason", reason);
            
            Db.update("t_leave", order);
        } else {
            order.set("user_id", user_id);
            order.set("start_time", start_time);
            order.set("end_time", end_time);
            order.set("reason", reason);
            order.set("apply_time", new Date());
            
            Db.save("t_leave",order);
        }
        
        renderJson(order);
    }
    
    public void print(){
        Record login_user = getAttr("user");
        String id = getPara("id");
        Record order = Db.findFirst("select l.*, user.name user_name from t_leave l left join t_rbac_user user on l.user_id=user.id where l.id=?",id);

        setAttr("order", order);
        render("leaveFormPrint.html");
    }

}