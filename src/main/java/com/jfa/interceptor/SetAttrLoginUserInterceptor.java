package com.jfa.interceptor;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.ehcache.CacheKit;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;

import com.jfinal.aop.Interceptor;
import com.jfinal.aop.Invocation;
import com.jfinal.core.Controller;
import com.jfinal.log.Log;

public class SetAttrLoginUserInterceptor implements Interceptor{
	private Log logger = Log.getLog(SetAttrLoginUserInterceptor.class);

	public void intercept(Invocation ai) {
		Subject currentUser = SecurityUtils.getSubject();
		//TODO:这里是shiroPlugin 3.3的临时处理, 发现没登录跳转到login
		if(currentUser.isAuthenticated()){
			Controller controller = ai.getController();
			Record user = Db.findFirst("select * from t_rbac_user where name=?",currentUser.getPrincipal());
			ai.getController().setAttr("user", user);
			
			String condition = "";
			if(1==user.getInt("id")){
				condition = "";
			}else{
				condition = " tru.id = '"+user.get("id")+"' and ";
			}
			List<Record> parentMenuList = Db.find("SELECT trm.* FROM t_rbac_menu trm"
					+ " LEFT JOIN t_rbac_ref_perm_menu trrpm on trrpm.menu_id = trm.id"
					+ " LEFT JOIN t_rbac_permission trp on trp.id = trrpm.permission_id"
					+ " LEFT JOIN t_rbac_ref_perm_role trrpr on trrpr.permission_id = trp.id"
					+ " LEFT JOIN t_rbac_role trr on trr.id = trrpr.role_id"
					+ " LEFT JOIN t_rbac_ref_user_role trrur on trrur.role_id = trr.id"
					+ " LEFT JOIN t_rbac_user tru on tru.id = trrur.user_id"
					+ " where "+condition+" trm.seq='1'");
			for(int i = 0;i<parentMenuList.size();i++){
				List<Record> menuList = Db.find("select trm.* from t_rbac_menu trm"
						+ " LEFT JOIN t_rbac_ref_perm_menu trrpm on trrpm.menu_id = trm.id"
						+ " LEFT JOIN t_rbac_permission trp on trp.id = trrpm.permission_id"
						+ " LEFT JOIN t_rbac_ref_perm_role trrpr on trrpr.permission_id = trp.id"
						+ " LEFT JOIN t_rbac_role trr on trr.id = trrpr.role_id"
						+ " LEFT JOIN t_rbac_ref_user_role trrur on trrur.role_id = trr.id"
						+ " LEFT JOIN t_rbac_user tru on tru.id = trrur.user_id"
						+ " where "+condition+" trm.seq = '2' and trm.parent_id = ?",parentMenuList.get(i).get("id"));
				for(int j = 0;j<menuList.size();j++){
					List<Record> menuItemList = Db.find("select trm.* from t_rbac_menu trm"
							+ " LEFT JOIN t_rbac_ref_perm_menu trrpm on trrpm.menu_id = trm.id"
							+ " LEFT JOIN t_rbac_permission trp on trp.id = trrpm.permission_id"
							+ " LEFT JOIN t_rbac_ref_perm_role trrpr on trrpr.permission_id = trp.id"
							+ " LEFT JOIN t_rbac_role trr on trr.id = trrpr.role_id"
							+ " LEFT JOIN t_rbac_ref_user_role trrur on trrur.role_id = trr.id"
							+ " LEFT JOIN t_rbac_user tru on tru.id = trrur.user_id"
							+ " where "+condition+" trm.seq = '3' and trm.parent_id = ?",menuList.get(j).get("id"));
					menuList.get(j).set("menuItemList", menuItemList);
				}
				parentMenuList.get(i).set("menuList", menuList);
			}
			ai.getController().setAttr("parentMenuList", parentMenuList);
			
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
