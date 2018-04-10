# JinalActiviti 项目启动步骤

- 将项目导入 eclipse。推荐使用 Eclipse IDE for Java EE Developers

- 修改 /src/main/resources/jfinal_config.txt 文件，填入正确的数据库连接用户名、密码

- 执行db_script/db.sql, 此脚本已包含一个DEMO流程示例数据

- 打开 com.jfa.config.JfinalActivitiConfig 文件，右键单击该文件并选择 Debug As ---> Java Application。
        其它启动项目的方式见 《JFinal手册》。除此之外，项目还可以与其它普通java web 项目一样使用 tomcat
   jetty 等 web server 来启动，启动方式与非jfinal项目完全一样。

- maven 项目还可以在控制台通过  mvn jetty:run 来启动

- 打开浏览器输入  localhost:8080 即可查看运行效果

注意： 请确保您安装了 JavaSE 1.7 或更高版本，tomcat下运行项目需要先删除 jetty-server-xxx.jar，否则会有冲突



# JFinalActiviti 项目特点
已将Activiti初始化整合到JFinal中, 直接使用同一个DB DataSource, 速度和效率都显著提升.





