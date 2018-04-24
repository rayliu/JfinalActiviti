package com.jfa.controllers.perm_role;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfa.interceptor.SetAttrLoginUserInterceptor;
import com.jfinal.kit.PropKit;
import com.jfinal.kit.StrKit;

import org.apache.commons.lang3.BooleanUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.apache.shiro.subject.Subject;

import com.google.gson.Gson;
import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.log.Log;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.activerecord.tx.Tx;


//shiro注释, 要求必须登录才能访问
@RequiresAuthentication
@Before(SetAttrLoginUserInterceptor.class)
public class Perm_RoleController extends Controller {
    private Log logger = Log.getLog(Perm_RoleController.class);
    Subject currentUser = SecurityUtils.getSubject();

    //返回leave list页面
    public void index() {
        redirect("/perm_role/list");
    }

    public void list() {
        render("list.html");
    }

    //返回list页面所需的json
    public void getList(){
        String sLimit = "";
        String condition = " ";

        if (getPara("limit") != null && getPara("page") != null) {
            int limit = getParaToInt("limit");
            int page=getParaToInt("page")-1;
            sLimit = " limit " + limit*page + ", " + limit;
        }
        Record login_user = getAttr("user");
        String sql="SELECT trrpr.*,trr.code role_code,trr.name role_name,trp.name permission_name FROM t_rbac_ref_perm_role trrpr"
        		+ " LEFT JOIN  t_rbac_role trr ON trr.id = trrpr.role_id"
        		+ " LEFT JOIN t_rbac_permission trp ON trp.id = trrpr.permission_id";
        List<Record> orderList = Db.find(sql+condition+" order by trr.id desc "+sLimit);

        String sqlTotal = "select count(1) total from (" + sql + ") B";
        Record rec = Db.findFirst(sqlTotal);

        Map<String,Object> map = new HashMap<String,Object>();
        map.put("code", 0);
        map.put("count", rec.get("total"));
        map.put("data", orderList);

        renderJson(map);
    }

    //返回edit页面
    public void edit() {
        Record login_user = getAttr("user");
        String role_id= getPara("role_id");
        
        Record order = Db.findFirst("select * from t_rbac_ref_perm_role  where role_id=?", role_id);
        setAttr("order", order);
        
        List<Record> group = Db.find("select * from t_rbac_group");
        setAttr("group",group);
        
        List<Record> role = Db.find("select * from t_rbac_role");
        setAttr("role",role);
        
        List<Record> menuList = Db.find("select * from t_rbac_permission where type='MENU'");
        setAttr("menuList",menuList);
        List<Record> elementList = Db.find("select * from t_rbac_permission where type='ELEMENT'");
        setAttr("elementList",elementList);
        List<Record> operationList = Db.find("select * from t_rbac_permission where type='OPERATION'");
        setAttr("operationList",operationList);
    	
        render("edit.html");
    }

    @Before(Tx.class)
    public void save(){
        String jsonStr=getPara("params");
        Gson gson = new Gson();
        Map<String, ?> dto= gson.fromJson(jsonStr, HashMap.class);
        Record login_user = getAttr("user");

        String group_id = (String)dto.get("group_id");
        String role_id = (String)dto.get("role_id");
        List<String> menuIds = (ArrayList<String>) dto.get("menuIds");
        List<String> pageIds = (ArrayList<String>) dto.get("pageIds");
        List<String> operationIds = (ArrayList<String>) dto.get("operationIds");
        boolean result = false;
        Db.delete("delete from t_rbac_ref_perm_role where role_id = ?",role_id);
        for(int i = 0;i<menuIds.size();i++){
        	Record re = new Record();
    		re.set("role_id", role_id);
    		re.set("permission_id", menuIds.get(i));
    		result = Db.save("t_rbac_ref_perm_role",re);
    	}
		for(int i = 0;i<pageIds.size();i++){
			Record re = new Record();
			re.set("role_id", role_id);
    		re.set("permission_id", pageIds.get(i));
    		result = Db.save("t_rbac_ref_perm_role",re);
		}
		for(int i = 0;i<operationIds.size();i++){
			Record re = new Record();
			re.set("role_id", role_id);
    		re.set("permission_id", operationIds.get(i));
    		result = Db.save("t_rbac_ref_perm_role",re);
		}
		
        renderJson("{\"result\":"+result+"}");
    }
    
    public void menuList(){
    	Record user = Db.findFirst("select * from t_rbac_user where name=?",currentUser.getPrincipal());
    	String condition = "";
		if(1==user.getInt("id")){
			condition = "";
		}else{
			condition = " and tru.id = '"+user.get("id")+"'";
		}
    	String sql = "SELECT trm.* FROM t_rbac_menu trm"
				+ " LEFT JOIN t_rbac_ref_perm_menu trrpm on trrpm.menu_id = trm.id"
				+ " LEFT JOIN t_rbac_permission trp on trp.id = trrpm.permission_id"
				+ " LEFT JOIN t_rbac_ref_perm_role trrpr on trrpr.permission_id = trp.id"
				+ " LEFT JOIN t_rbac_role trr on trr.id = trrpr.role_id"
				+ " LEFT JOIN t_rbac_ref_user_role trrur on trrur.role_id = trr.id"
				+ " LEFT JOIN t_rbac_user tru on tru.id = trrur.user_id"
				+ " where 1=1 ";
    	List<Record> orderList = Db.find(sql+condition+" order by trr.id desc ");
    	String sqlTotal = "select count(1) total from (" + sql + ") B";
    	Record rec = Db.findFirst(sqlTotal);

    	Map<String,Object> map = new HashMap<String,Object>();
    	map.put("code", 0);
    	map.put("count", rec.get("total"));
    	map.put("data", orderList);
    	renderJson(map);
    }
    
    public void pageList(){
		Record user = Db.findFirst("select * from t_rbac_user where name=?",currentUser.getPrincipal());
		String condition = "";
			if(1==user.getInt("id")){
				condition = "";
			}else{
				condition = " and tru.id = '"+user.get("id")+"'";
			}
		String sql = "SELECT trm.* FROM t_rbac_menu trm"
					+ " LEFT JOIN t_rbac_ref_perm_menu trrpm on trrpm.menu_id = trm.id"
					+ " LEFT JOIN t_rbac_permission trp on trp.id = trrpm.permission_id"
					+ " LEFT JOIN t_rbac_ref_perm_role trrpr on trrpr.permission_id = trp.id"
					+ " LEFT JOIN t_rbac_role trr on trr.id = trrpr.role_id"
					+ " LEFT JOIN t_rbac_ref_user_role trrur on trrur.role_id = trr.id"
					+ " LEFT JOIN t_rbac_user tru on tru.id = trrur.user_id"
					+ " where 1=1 ";
		List<Record> orderList = Db.find(sql+condition+" order by trr.id desc ");
		String sqlTotal = "select count(1) total from (" + sql + ") B";
		Record rec = Db.findFirst(sqlTotal);

	   	Map<String,Object> map = new HashMap<String,Object>();
	   	map.put("code", 0);
	   	map.put("count", rec.get("total"));
	   	map.put("data", orderList);
	   	renderJson(map);
   }
    
    public void operationList(){
		Record user = Db.findFirst("select * from t_rbac_user where name=?",currentUser.getPrincipal());
		String condition = "";
		if(1==user.getInt("id")){
			condition = "";
		}else{
			condition = " and tru.id = '"+user.get("id")+"'";
		}
      	String sql = "SELECT trm.* FROM t_rbac_menu trm"
   				+ " LEFT JOIN t_rbac_ref_perm_menu trrpm on trrpm.menu_id = trm.id"
   				+ " LEFT JOIN t_rbac_permission trp on trp.id = trrpm.permission_id"
   				+ " LEFT JOIN t_rbac_ref_perm_role trrpr on trrpr.permission_id = trp.id"
   				+ " LEFT JOIN t_rbac_role trr on trr.id = trrpr.role_id"
   				+ " LEFT JOIN t_rbac_ref_user_role trrur on trrur.role_id = trr.id"
   				+ " LEFT JOIN t_rbac_user tru on tru.id = trrur.user_id"
   				+ " where 1=1 ";
      	List<Record> orderList = Db.find(sql+condition+" order by trr.id desc ");
      	String sqlTotal = "select count(1) total from (" + sql + ") B";
      	Record rec = Db.findFirst(sqlTotal);

      	Map<String,Object> map = new HashMap<String,Object>();
      	map.put("code", 0);
      	map.put("count", rec.get("total"));
      	map.put("data", orderList);
      	renderJson(map);
	}

}