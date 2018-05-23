package com.jfa.controllers.relation;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.apache.shiro.subject.Subject;

import com.google.gson.Gson;
import com.jfa.controllers.leave.LeaveController;
import com.jfa.interceptor.SetAttrLoginUserInterceptor;
import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.kit.StrKit;
import com.jfinal.log.Log;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.activerecord.tx.Tx;


@RequiresAuthentication
@Before(SetAttrLoginUserInterceptor.class)
public class User_Role_RelationController extends Controller{
	
	private Log logger = Log.getLog(LeaveController.class);
	Subject currentUser = SecurityUtils.getSubject();
	
	public void index(){
		redirect("/user_role_relation/edit");
	}
	
	
	public void edit(){
		String sLimit = "";
		String condition = "";
		String pageIndex = getPara("draw");
		if (getPara("start") != null && getPara("length") != null) {
            sLimit = " LIMIT " + getPara("start") + ", " + getPara("length");
        }
		
		Record login_user = getAttr("user");
		
		String sql = "SELECT * FROM t_rbac_user where is_delete=0";
		List<Record> user = Db.find(sql+condition+" order by id desc");
		setAttr("users",user);
		 
		String group_sql = "SELECT * FROM t_rbac_role where is_delete=0";
		List<Record> role = Db.find(group_sql+condition+" order by id desc");
		setAttr("role",role);
		 
		String id = getPara("id");
		Record check = Db.findFirst("select * from t_rbac_user where id=?",id);
		setAttr("check",check);
		
		String user_id = getPara("user_id");
		if(StrKit.notBlank(user_id)){
			List<Record> user_role = Db.find("SELECT role_id FROM t_rbac_ref_user_role WHERE user_id=?",user_id);
			setAttr("user_role",user_role);
		}
		 
		render("user_rolelist.html");
	}
	
	@Before(Tx.class)
	public void save(){
		String jsonStr = getPara("params");
		Gson gson = new Gson();
		Map<String, ?> dto = gson.fromJson(jsonStr, HashMap.class); 
		Record login_user = getAttr("user");
		
		String user_id = (String)dto.get("user_id");
		List<String> rolefrom_list = (List<String>)dto.get("rolefrom_list");
		
		Record record = new Record();
		if(rolefrom_list.size()>0){
			Record re = Db.findFirst("select *from t_rbac_ref_user_role where user_id=?", user_id);
			if(re != null){
				Db.delete("delete from t_rbac_ref_user_role where user_id = ?",user_id);
			}
			for(int i=0;i<rolefrom_list.size();i++){
				record.set("user_id", user_id);
				record.set("role_id", (String)rolefrom_list.get(i));
				Db.save("t_rbac_ref_user_role", record);
			}
		}else{
			Db.delete("delete from t_rbac_ref_user_role where user_id = ?",user_id);
		}
		renderJson(record);
	}
	
}