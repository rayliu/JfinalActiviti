package com.jfa.interceptor;

import javax.servlet.http.HttpServletRequest;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

import com.jfinal.plugin.ehcache.CacheKit;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;

import com.jfinal.aop.Interceptor;
import com.jfinal.aop.Invocation;

import com.jfinal.log.Log;

public class SetAttrLoginUserInterceptor implements Interceptor{
	private Log logger = Log.getLog(SetAttrLoginUserInterceptor.class);

	public void intercept(Invocation ai) {
		Subject currentUser = SecurityUtils.getSubject();
		//TODO:这里是shiroPlugin 3.3的临时处理, 发现没登录跳转到login
		if(currentUser.isAuthenticated()){

			Record user = Db.findFirst("select * from t_rbac_user where name=?",currentUser.getPrincipal());
			ai.getController().setAttr("user", user);
			//判断是否唯一登录
			Session session=currentUser.getSession();
			logger.debug("session id:"+session.getId());
			if(session.getAttribute("kick_out")!=null && (Boolean)session.getAttribute("kick_out")){
				ai.getController().setAttr("kick_out", "Y");
				ai.getController().redirect("/login");
				return;
			}

			ai.invoke();
		}else{
			ai.getController().redirect("/login");
		}

	}
}
