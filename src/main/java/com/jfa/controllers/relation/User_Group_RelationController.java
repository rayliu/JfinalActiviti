package com.jfa.controllers.relation;

import java.util.ArrayList;
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
import com.jfinal.log.Log;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.activerecord.tx.Tx;

@RequiresAuthentication
@Before(SetAttrLoginUserInterceptor.class)
public class User_Group_RelationController extends Controller{
	private Log logger = Log.getLog(LeaveController.class);
	Subject currentUser = SecurityUtils.getSubject();
	
	public void index(){
		redirect("/user_group_relation/edit");
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
		 
		 String group_sql = "SELECT * FROM t_rbac_group where is_delete=0";
		 List<Record> group = Db.find(group_sql+condition+" order by id desc");
		 setAttr("group",group);
		 
		String id = getPara("id");
		Record check = Db.findFirst("select * from t_rbac_user where id=?",id);
		setAttr("check",check);
		
		String user_id = getPara("user_id");
		if(user_id != null && user_id != ""){
			List<Record> user_group = Db.find("SELECT group_id FROM t_rbac_ref_group_user WHERE user_id=?",user_id);
			setAttr("user_groups",user_group);
		}
		render("user_grouplist.html");
	}
	
	@Before(Tx.class)
	public void save(){
		String jsonStr = getPara("params");
		Gson gson = new Gson();
		Map<String, ?> dto = gson.fromJson(jsonStr, HashMap.class); 
		Record login_user = getAttr("user");
		
		String user_id = (String)dto.get("user_id");
		List<String> groupfrom_list = (List<String>)dto.get("groupfrom_list");
		
		Record record = new Record();
		if(groupfrom_list.size()>0){
			Record re=Db.findFirst("select *from t_rbac_ref_group_user where user_id=?", user_id);
			if(re != null){
				Db.delete("delete from t_rbac_ref_group_user where user_id = ?",user_id);
			}
			for(int i=0;i<groupfrom_list.size();i++){
				record.set("user_id", user_id);
				record.set("group_id", (String)groupfrom_list.get(i));
				Db.save("t_rbac_ref_group_user", record);
			}
		}else{
			Db.delete("delete from t_rbac_ref_group_user where user_id = ?",user_id);
		}
		renderJson(record);
	}

}