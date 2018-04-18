package com.jfa.controllers.codeGen;

import com.jfa.interceptor.SetAttrLoginUserInterceptor;
import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.kit.PropKit;
import com.jfinal.kit.StrKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.apache.shiro.subject.Subject;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

//shiro注释, 要求必须登录才能访问
//@RequiresAuthentication
//全局拦截器, 每次都将user做为基本属性放到request中, 方便Controller取用, 也方便在页面中显示user_name
//@Before(SetAttrLoginUserInterceptor.class)
public class CodeGenerateController extends Controller {
	Subject currentUser = SecurityUtils.getSubject();

	public void index() {
		if(!currentUser.isAuthenticated()){
			redirect("/login");
			return;
		}
		Record order = new Record();
		order.set("task_count", 1);
		order.set("proccess_count", 2);
		order.set("user_count", 3);
		order.set("err_count", 4);
		setAttr("order", order);

		render("index.html");
	}

	public void tableList() throws Exception{
		render("tableList.html");
	}

	public void getTableList() throws Exception{

		String sLimit = "";
		String condition = " ";

		if (getPara("limit") != null && getPara("page") != null) {
			int limit = getParaToInt("limit");
			int page=getParaToInt("page")-1;
			sLimit = " limit " + limit*page + ", " + limit;
		}
		String sql="SELECT TABLE_NAME as tableName,TABLE_COMMENT as tableComment from information_schema.`TABLES`" +
				"  where TABLE_SCHEMA='jfinal_activiti' and TABLE_NAME like 't_%' ";
		List<Record> orderList = Db.find(sql+sLimit);

		String sqlTotal = "select count(1) total from (" + sql + ") B";
		Record rec = Db.findFirst(sqlTotal);
		Map<String,Object> map = new HashMap<String,Object>();

		map.put("code", 0);
		map.put("count", rec.get("total"));
		map.put("data", orderList);

		renderJson(map);
	}

	public void gen() throws Exception{
		String tableName = getPara();
		setAttr("tableName", tableName);
		render("gen.html");
	}

	//页面点击 生成代码
	public void genSubmit() throws Exception{
		String tableName = getPara("tableName");
		String type = getPara("type");
		String packagePath = getPara("packagePath");
		String className = getPara("className");
		String pageShowType=getPara("pageShowType");

		//GenVO vo = new GenVO(tableName, type,);
		GeneratorHelperService generatorHelperService = new GeneratorHelperService();
		boolean success = generatorHelperService.oneTable("jfinal_activiti", tableName);

		renderText("ok");
	}
	/*
		根据表名生成controller和list, edit页面
	 */
	public void table() throws Exception{
		String tableName = getPara("table_name");
		if(StrKit.isBlank(tableName)){
			renderText("fail: param no table_name!");
			return;
		}
		GeneratorHelperService generatorHelperService = new GeneratorHelperService();
		boolean success = generatorHelperService.oneTable("jfinal_activiti", tableName);
		//success==true ? "success" : "fail";
		renderText(success? "success" : "fail");
	}
}





