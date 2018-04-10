package com.jfa.interceptor;

import javax.servlet.http.HttpServletRequest;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;

import com.jfinal.aop.Interceptor;
import com.jfinal.aop.Invocation;

import com.jfinal.log.Log;

public class SetAttrLoginUserInterceptor implements Interceptor{
	private Log logger = Log.getLog(SetAttrLoginUserInterceptor.class);

	public void intercept(Invocation ai) {
		Subject currentUser = SecurityUtils.getSubject();
		if(currentUser.isAuthenticated()){
			Record user = Db.findFirst("select * from t_user where name=?",currentUser.getPrincipal());
			ai.getController().setAttr("user", user);
		}else{
			ai.getController().redirect("/login");
		}
		ai.invoke();
	}
}
