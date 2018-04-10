package com.jfa.controllers.workflow.util;

import org.activiti.engine.FormService;
import org.activiti.engine.HistoryService;
import org.activiti.engine.IdentityService;
import org.activiti.engine.ProcessEngine;
import org.activiti.engine.ProcessEngineConfiguration;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;

import com.jfinal.plugin.activerecord.DbKit;

public class ActivitiKit {
    private static ProcessEngine processEngine = null;
    
    private ActivitiKit() {}
    
    public static ProcessEngine getProcessEngine(){
        
        if(processEngine == null){
            //读取数据库配置 resource/activiti.cfg.xml, 创建流程引擎
            //这个效率很低!! 
           
            /* 官网也建议用自己环境的DataSource, 参见 3.3. Database configuration
             * Our benchmarks have shown that the MyBatis connection pool is not the most efficient 
             * or resilient when dealing with a lot of concurrent requests. 
             * As such, it is advised to us a javax.sql.DataSource implementation and inject it 
             * into the process engine configuration (For example DBCP, C3P0, Hikari, Tomcat Connection Pool, etc.)
             */
            //processEngine = ProcessEngines.getDefaultProcessEngine();
            
            //创建一个空的流程引擎, 将Jfinal的DataSource设置进去
            ProcessEngineConfiguration processEngineConfiguration = 
                    ProcessEngineConfiguration.createStandaloneProcessEngineConfiguration();
            processEngineConfiguration.setDataSource(DbKit.getConfig().getDataSource());
            processEngine = processEngineConfiguration.buildProcessEngine();
        }
        return processEngine;
    }
    
    public static RepositoryService getRepositoryService(){
        processEngine = getProcessEngine();
        return processEngine.getRepositoryService();
    }
    
    public static IdentityService getIdentityService(){
        processEngine = getProcessEngine();
        return processEngine.getIdentityService();
    }
    
    public static RuntimeService getRuntimeService(){
        processEngine = getProcessEngine();
        return processEngine.getRuntimeService();
    }
    
    public static TaskService getTaskService(){
        processEngine = getProcessEngine();
        return processEngine.getTaskService();
    }
    
    public static FormService getFormService(){
        processEngine = getProcessEngine();
        return processEngine.getFormService();
    }
    
    public static HistoryService getHistoryService(){
        processEngine = getProcessEngine();
        return processEngine.getHistoryService();
    }
}
