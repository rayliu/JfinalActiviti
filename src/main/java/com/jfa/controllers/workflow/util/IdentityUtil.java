package com.jfa.controllers.workflow.util;

import org.activiti.engine.IdentityService;
import org.activiti.engine.ProcessEngine;
import org.activiti.engine.ProcessEngines;
import org.activiti.engine.identity.User;


/**
 * 本Util类用于快速添加activiti中所需的user, group, membership
 * 
 * ACT_ID_GROUP 身份信息-组信息
   ACT_ID_INFO  身份信息-组信息
   ACT_ID_MEMBERSHIP 身份信息-用户和组关系的中间表
   ACT_ID_USER 身份信息-用户信息
   
 * @author ray liu
 *
 */
public class IdentityUtil {
    static ProcessEngine processEngine = null;
    public static void main(String[] args) {
        //读取数据库配置 resource/activiti.cfg.xml, 创建流程引擎
        processEngine = ProcessEngines.getDefaultProcessEngine();

        String pName = processEngine.getName();
        String ver = ProcessEngine.VERSION;
        System.out.println("ProcessEngine [" + pName + "] Version: [" + ver + "]");
        
        buildGroup("deptLeader", "部门领导");
        buildGroup("hr", "人事部门");
        createUser("1", "Ray", "Liu", "ray.liu@eeda123.com");

        processEngine.getIdentityService().createMembership("1", "deptLeader");
        processEngine.getIdentityService().createMembership("1", "hr");
        
        //之前已经有一个leave task 启动了, 现在查看是否有Ray做为审批者的task
//        Task task = ts.createTaskQuery().taskCandidateUser("Ray").singleResult();
//        
//        if(task!=null){//签收任务, 其他人不能再签收此任务
//            System.out.println("Ray have task to take!");
//            //ts.claim(task.getId(), "Ray");
//        }else{
//            System.out.println("Ray no task!");
//        }
    }

    private static void createUser(String userId, String firstName, String lastName, String email) {
        IdentityService is = processEngine.getIdentityService();
        //检查用户是否已存在
        User userInDb = is.createUserQuery().userId(userId).singleResult();
        if(userInDb==null){
            //创建一个用户
            User user = is.newUser(userId);
            user.setFirstName(firstName);
            user.setLastName(lastName);
            user.setEmail(email);
            //user.setPassword("123456");
            //保存用户到数据库
            is.saveUser(user);
            //删除用户
            //is.deleteUser("Ray");
        }
    }

    private static void buildGroup(String groupId, String groupName) {
        //创建并保存group
        IdentityService is= processEngine.getIdentityService();
        org.activiti.engine.identity.Group groupInDb =is.createGroupQuery().groupId(groupId).singleResult();
        
        if(groupInDb==null){
            org.activiti.engine.identity.Group group = is.newGroup(groupId);
            group.setName(groupName);
            group.setType("assignment");
            is.saveGroup(group);
        }
    }

}
