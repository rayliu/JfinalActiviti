package com.jfa.config;

import com.github.jieblog.plugin.shiro.core.ShiroInterceptor;
import com.github.jieblog.plugin.shiro.core.ShiroPlugin;
import com.jfa.controllers.codeGen.CodeGenerateController;
import com.jfa.controllers.group.GroupController;
import com.jfa.controllers.index.IndexController;
import com.jfa.controllers.leave.LeaveController;
import com.jfa.controllers.login.LoginController;


import com.jfa.controllers.menu.MenuController;
import com.jfa.controllers.operation.OperationController;
import com.jfa.controllers.pageElement.PageElementController;
import com.jfa.controllers.perm_role.Perm_RoleController;
import com.jfa.controllers.permission.PermissionController;
import com.jfa.controllers.relation.Role_Group_RelationController;
import com.jfa.controllers.relation.User_Group_RelationController;
import com.jfa.controllers.relation.User_Role_RelationController;
import com.jfa.controllers.role.RoleController;
import com.jfa.controllers.user.UserController;
import com.jfa.controllers.workflow.WorkflowController;
import com.jfinal.config.Constants;
import com.jfinal.config.Handlers;
import com.jfinal.config.Interceptors;
import com.jfinal.config.JFinalConfig;
import com.jfinal.config.Plugins;
import com.jfinal.config.Routes;
import com.jfinal.core.JFinal;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.ActiveRecordPlugin;
import com.jfinal.plugin.druid.DruidPlugin;
import com.jfinal.plugin.ehcache.EhCachePlugin;
import com.jfinal.template.Engine;
import com.shuyan.wxl.routes.AutoBindRoutes;

/**
 * 
 * 
 * API引导式配置
 */
public class JfinalActivitiConfig extends JFinalConfig {
    /**
     * 供Shiro插件使用 。
     */
    private Engine engine;
    /**
     * 运行此 main 方法可以启动项目，此main方法可以放置在任意的Class类定义中，不一定要放于此
     * 
     * 使用本方法启动过第一次以后，会在开发工具的 debug、run config 中自动生成
     * 一条启动配置，可对该自动生成的配置再添加额外的配置项，例如 VM argument 可配置为：
     * -XX:PermSize=64M -XX:MaxPermSize=256M
     */
    public static void main(String[] args) {
        /**
         * 特别注意：Eclipse 之下建议的启动方式
         */
        //JFinal.start("src/main/webapp", 8080, "/", 5);
        
        /**
         * 特别注意：IDEA 之下建议的启动方式，仅比 eclipse 之下少了最后一个参数
         */
        JFinal.start("src/main/webapp", 8080, "/");
    }
    
    /**
     * 配置常量
     */
    public void configConstant(Constants me) {
        // 加载少量必要配置，随后可用PropKit.get(...)获取值
        PropKit.use("JFinalActiviti.properties");
        me.setDevMode(PropKit.getBoolean("devMode", false));

        String templateFolder = PropKit.get("ui_folder");

        //没有权限时跳转到login
        me.setError401View(templateFolder+"/common/err/err401.html");//401 authenticate err
        me.setError403View(templateFolder+"/common/err/err403.html");// authorization err

        //内部出错跳转到对应的提示页面，需要考虑提供更详细的信息。
        me.setError404View(templateFolder+"/common/err/err404.html");
        me.setError500View(templateFolder+"/common/err/err500.html");
    }
    
    /**
     * 配置路由
     */
    public void configRoute(Routes me) {
        String templateFolder = PropKit.get("ui_folder");

        //注意! 这里写的是JFinal系统级别的controller, 如非必要不要改动
        me.add("/", IndexController.class, templateFolder+"/index");   // 第三个参数为该Controller的视图存放路径
        me.add("/login", LoginController.class, templateFolder+"/login");
//      me.add("/sys", SysController.class, templateFolder+"/sys");
        me.add("/generate", CodeGenerateController.class, templateFolder+"/generate");

        me.add("/workflow", WorkflowController.class, templateFolder+"/workflow");
        me.add("/menu", MenuController.class, templateFolder+"/menu");
        //RBAC 控制
        me.add("/user", UserController.class, templateFolder+"/user");
        me.add("/role", RoleController.class, templateFolder+"/role");
        me.add("/group", GroupController.class, templateFolder+"/group");
        me.add("/user_group_relation", User_Group_RelationController.class, templateFolder+"/user_group_relation");
        me.add("/role_group_relation", Role_Group_RelationController.class, templateFolder+"/role_group_relation");
        me.add("/user_role_relation", User_Role_RelationController.class, templateFolder+"/user_role_relation");
        me.add("/page_element", PageElementController.class, templateFolder+"/page_element");
        me.add("/operation", OperationController.class, templateFolder+"/operation");
        me.add("/permission", PermissionController.class, templateFolder+"/permission");
        me.add("/perm_role", Perm_RoleController.class, templateFolder+"/perm_role");
		
      //------这里开始是业务类的Controller, 会自动扫描加载
        // 默认这里是按表名生成URL path, 实际上应该做适当修改. 请在controller的注释中修改
        me.add(new AutoBindRoutes("com.jfa.controllers", templateFolder));

        //me.add("/leave", LeaveController.class, templateFolder+"/leave");
    }
    
    public void configEngine(Engine me) {
        // 加载Shiro插件, 需要用这个engine
        this.engine = me;
        me.setDevMode(true);//热加载

        String templateFolder = PropKit.get("ui_folder");
        me.addSharedFunction(templateFolder+"/common/_layout.html");
        me.addSharedMethod(new com.jfa.util.SharedUtil());
        //me.addSharedFunction(templateFolder+"/common/_sys_layout.html");
        //me.addSharedFunction("/common/_paginate.html");
    }
    
    /**
     * 配置插件
     */
    public void configPlugin(Plugins me) {
        // 加载Shiro插件, 加载后给后台java写注解用
        //TODO: 这里的ShiroPlugin for 3.3 版本是有问题的(注解了但是没有起作用,晕), JFinal作者已承诺3.4将解决这个问题
        //http://www.jfinal.com/share/714
        ShiroPlugin shiroPlugin = new ShiroPlugin(engine);

        shiroPlugin.setLoginUrl("/login");//登陆url：未验证成功跳转
        shiroPlugin.setSuccessUrl("/");//登陆成功url：验证成功自动跳转
        shiroPlugin.setUnauthorizedUrl("/noPermission");//授权url：未授权成功自动跳转
        me.add(shiroPlugin);

        me.add(new EhCachePlugin());

        // 配置 druid 数据库连接池插件
        DruidPlugin druidPlugin = new DruidPlugin(PropKit.get("jdbcUrl"), PropKit.get("user"), PropKit.get("password").trim());
        me.add(druidPlugin);
        
        // 配置ActiveRecord插件
        ActiveRecordPlugin arp = new ActiveRecordPlugin(druidPlugin);
        arp.setShowSql(true);

        // 所有映射在 MappingKit 中自动化搞定
        //_MappingKit.mapping(arp);
        me.add(arp);
    }
    
    public static DruidPlugin createDruidPlugin() {
        return new DruidPlugin(PropKit.get("jdbcUrl"), PropKit.get("user"), PropKit.get("password").trim());
    }
    
    /**
     * 配置全局拦截器
     */
    public void configInterceptor(Interceptors me) {
        me.add(new ShiroInterceptor());
    }
    
    /**
     * 配置处理器
     */
    public void configHandler(Handlers me) {
        
    }
}
