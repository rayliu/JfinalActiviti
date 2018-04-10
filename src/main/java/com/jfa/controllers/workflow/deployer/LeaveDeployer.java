package com.jfa.controllers.workflow.deployer;


import org.activiti.engine.ProcessEngine;
import org.activiti.engine.ProcessEngines;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.repository.Deployment;
import org.activiti.engine.repository.ProcessDefinition;

import static org.activiti.engine.ProcessEngines.getDefaultProcessEngine;

/**
 * 执行main, 部署指定的leave流程
 *
 * Created by rayliu on 2018/4/6.
 */
public class LeaveDeployer {

    public static void main(String[] args) {
        //读取数据库配置 resource/activiti.cfg.xml, 独立创建流程引擎
        ProcessEngine processEngine = ProcessEngines.getDefaultProcessEngine();

        //部署流程定义文件.
        RepositoryService repositoryService = processEngine.getRepositoryService();
        Deployment deployment = repositoryService.createDeployment()
                .addClasspathResource("flow/leave.bpmn").deploy();

        //获取刚刚返回的模型, 验证其已部署成功.
        ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery()
                .deploymentId(deployment.getId()).singleResult();
        System.out.println(
                "Found process definition ["
                        + processDefinition.getName() + "] with id ["
                        + processDefinition.getId() + "]");
    }
}
