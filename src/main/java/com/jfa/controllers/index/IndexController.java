package com.jfa.controllers.index;

import com.jfa.interceptor.SetAttrLoginUserInterceptor;
import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.activerecord.Sqls;
import com.jfinal.plugin.ehcache.CacheKit;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;

//shiro注释, 要求必须登录才能访问
@RequiresAuthentication
//全局拦截器, 每次都将user做为基本属性放到request中, 方便Controller取用, 也方便在页面中显示user_name
@Before(SetAttrLoginUserInterceptor.class)
public class IndexController extends Controller {
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

	public void logout() {
		if(!currentUser.isAuthenticated()){
			redirect("/login");
			return;
		}
		
		
		Record userRec = Db.findFirst("select * from t_rbac_user where name=?", currentUser.getPrincipal());
		Session oldSession = CacheKit.get("userSessionCache", userRec.get("id"));
		if(oldSession!=null) {
			CacheKit.remove("userSessionCache", userRec.get("id"));
		}
		
		currentUser.logout();
		redirect("/login");
	}
}





