package com.jfa.config;

import com.github.jieblog.plugin.shiro.core.ShiroPlugin;
import com.jfa.controllers.codeGen.CodeGenerateController;
import com.jfa.controllers.index.IndexController;
import com.jfa.controllers.leave.LeaveController;
import com.jfa.controllers.login.LoginController;


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
    }
    
    /**
     * 配置路由
     */
    public void configRoute(Routes me) {
        String templateFolder = PropKit.get("ui_folder");
        me.add("/", IndexController.class, templateFolder+"/index");   // 第三个参数为该Controller的视图存放路径
        me.add("/login", LoginController.class, templateFolder+"/login");
//      me.add("/sys", SysController.class, templateFolder+"/sys");
        me.add("/generate", CodeGenerateController.class, templateFolder+"/generate");
        me.add("/leave", LeaveController.class, templateFolder+"/leave");
        me.add("/workflow", WorkflowController.class, templateFolder+"/workflow");

        //注意:自动生成代码后的配置, 这里是按表名生成的, 实际上应该做适当修改.
//      me.add("/t_rbac_menu", t_rbac_menuController.class, templateFolder+"/t_rbac_menu");
    }
    
    public void configEngine(Engine me) {
        // 加载Shiro插件, 需要用这个engine
        this.engine = me;
        me.setDevMode(true);//热加载

        String templateFolder = PropKit.get("ui_folder");
        me.addSharedFunction(templateFolder+"/common/_layout.html");
        //me.addSharedFunction(templateFolder+"/common/_sys_layout.html");
        //me.addSharedFunction("/common/_paginate.html");
    }
    
    /**
     * 配置插件
     */
    public void configPlugin(Plugins me) {
        // 加载Shiro插件, 加载后给后台java写注解用
        me.add(new ShiroPlugin(engine));

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
        
    }
    
    /**
     * 配置处理器
     */
    public void configHandler(Handlers me) {
        
    }
}
