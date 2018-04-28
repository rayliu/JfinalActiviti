package com.jfa.util;

import java.util.ArrayList;

import com.jfinal.kit.StrKit;
import com.jfinal.plugin.activerecord.Record;

public class SharedUtil {
	public boolean elementContains (ArrayList<Record> elementList,String code){
		for(int i = 0;i<elementList.size();i++){
			Record element = elementList.get(i);
			if(element!=null){
				if(StrKit.notBlank(code)){
					if(code.equals(element.get("code"))){
						return true;
					}
				}
			}
		}
		return false;
	}
	
	public static String elementSql(String id){
		return elementSql(id,"");
	}
	
	public static String elementSql(String id,String conditions){
		String element_sql = "";
		if("1".equals(id)){
			element_sql = "SELECT * FROM t_rbac_page_element trpe where trpe.is_delete = '0'"+conditions;
		}else{
			element_sql = "SELECT trpe.* FROM t_rbac_page_element trpe"
					+ " LEFT JOIN t_rbac_ref_perm_element trrpe on trrpe.page_element_id = trpe.id"
					+ " LEFT JOIN t_rbac_permission trp on trp.id = trrpe.permission_id"
					+ " LEFT JOIN t_rbac_ref_perm_role trrpr on trrpr.permission_id = trp.id"
					+ " LEFT JOIN t_rbac_role trr on trr.id = trrpr.role_id"
					+ " LEFT JOIN t_rbac_ref_user_role trrur on trrur.role_id = trr.id"
					+ " where trpe.is_delete = '0' and trrur.user_id = "+id+conditions;
		}
		return element_sql;
	}
	
	public static String menuSql(String id){
		return menuSql(id,"");
	}
	
	public static String menuSql(String id,String conditions){
		String menu_sql = "";
		if("1".equals(id)){
			menu_sql = "SELECT * FROM t_rbac_menu trm where trm.is_delete = '0' "+conditions;
		}else{
			menu_sql = "select trm.* from t_rbac_menu trm"
					+ " LEFT JOIN t_rbac_ref_perm_menu trrpm on trrpm.menu_id = trm.id"
					+ " LEFT JOIN t_rbac_permission trp on trp.id = trrpm.permission_id"
					+ " LEFT JOIN t_rbac_ref_perm_role trrpr on trrpr.permission_id = trp.id"
					+ " LEFT JOIN t_rbac_role trr on trr.id = trrpr.role_id"
					+ " LEFT JOIN t_rbac_ref_user_role trrur on trrur.role_id = trr.id"
					+ " LEFT JOIN t_rbac_user tru on tru.id = trrur.user_id"
					+ " where trm.is_delete = '0' and tru.id = "+id+conditions+" group by trm.id ";
		}
		
		return menu_sql;
	}
}
