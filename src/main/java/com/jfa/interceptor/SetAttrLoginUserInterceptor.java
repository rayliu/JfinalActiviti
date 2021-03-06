package com.jfa.interceptor;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.jfa.util.SharedUtil;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.ehcache.CacheKit;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;

import com.jfinal.aop.Interceptor;
import com.jfinal.aop.Invocation;
import com.jfinal.core.Controller;
import com.jfinal.kit.StrKit;
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
			
			Session session = currentUser.getSession();
			String parentMenu_id = ai.getController().getPara("parentMenu_id");
			
			Object parentMenu_id_object = session.getAttribute("parentMenu_id");
			int parentMenu_id_int = Integer.parseInt(parentMenu_id_object==null?"1":parentMenu_id_object.toString());
			
			if(StrKit.notBlank(parentMenu_id)){
				parentMenu_id_int = Integer.valueOf(parentMenu_id);
				session.setAttribute("parentMenu_id", parentMenu_id_int);
			}
			
			List<Record> parentMenuList = new ArrayList<Record>();
			if(session.getAttribute("parentMenuList")!=null){
				parentMenuList = (List<Record>) session.getAttribute("parentMenuList");
			}else{
				//菜单权限list
				String parentMenuConditions = " and trm.seq='1'";
				parentMenuList = Db.find(SharedUtil.menuSql(user.getStr("id"),parentMenuConditions));
				for(int i = 0;i<parentMenuList.size();i++){
					String menuConditions = " and trm.seq='2' and trm.parent_id = "+parentMenuList.get(i).get("id");
					
					List<Record> menuList = Db.find(SharedUtil.menuSql(user.getStr("id"),menuConditions));
					for(int j = 0;j<menuList.size();j++){
						String menuItemConditions = " and trm.seq='3' and trm.parent_id = "+menuList.get(j).get("id");
						
						List<Record> menuItemList = Db.find(SharedUtil.menuSql(user.getStr("id"),menuItemConditions));
						menuList.get(j).set("menuItemList", menuItemList);
					}
					parentMenuList.get(i).set("menuList", menuList);
				}
				session.setAttribute("parentMenuList", parentMenuList);
			}
			
			
			String element_sql = "";
			//页面元素权限list
			if(1==user.getInt("id")){
				element_sql = "SELECT * FROM t_rbac_page_element trpe where trpe.is_delete = '0'";
			}else{
				element_sql = "SELECT trpe.* FROM t_rbac_page_element trpe"
						+ " LEFT JOIN t_rbac_ref_perm_element trrpe on trrpe.page_element_id = trpe.id"
						+ " LEFT JOIN t_rbac_permission trp on trp.id = trrpe.permission_id"
						+ " LEFT JOIN t_rbac_ref_perm_role trrpr on trrpr.permission_id = trp.id"
						+ " LEFT JOIN t_rbac_role trr on trr.id = trrpr.role_id"
						+ " LEFT JOIN t_rbac_ref_user_role trrur on trrur.role_id = trr.id"
						+ " where trpe.is_delete = '0' and trrur.user_id = "+user.getStr("id");;
			}
			List<Record> elementList = Db.find(element_sql+" group by trpe.id");
			String operation_sql = "";
			//页面元素权限list
			if(1==user.getInt("id")){
				operation_sql = "SELECT * FROM t_rbac_operation tro where tro.is_delete = '0'";
			}else{
				operation_sql = "SELECT tro.* FROM t_rbac_operation tro"
						+ " LEFT JOIN t_rbac_ref_perm_operation trrpo on trrpo.operation_id = tro.id"
						+ " LEFT JOIN t_rbac_permission trp on trp.id = trrpo.permission_id"
						+ " LEFT JOIN t_rbac_ref_perm_role trrpr on trrpr.permission_id = trp.id"
						+ " LEFT JOIN t_rbac_role trr on trr.id = trrpr.role_id"
						+ " LEFT JOIN t_rbac_ref_user_role trrur on trrur.role_id = trr.id"
						+ " where tro.is_delete = '0' and trrur.user_id = "+user.getStr("id");;
			}
			List<Record> operationList = Db.find(operation_sql+" group by tro.id");
			
			ai.getController().setAttr("parentMenuList", parentMenuList);
			ai.getController().setAttr("parentMenu_id", parentMenu_id_int);
			ai.getController().setAttr("elementList", elementList);
			ai.getController().setAttr("operationList", operationList);
			//判断是否唯一登录
			logger.debug("session id:"+session.getId());
			if(session.getAttribute("kick_out")!=null && (Boolean)session.getAttribute("kick_out")){
				session.stop();
				ai.getController().redirect("/login?kick_out=Y");
				return;
			}

			ai.invoke();
		}else{
			ai.getController().redirect("/login");
		}

	}
}
