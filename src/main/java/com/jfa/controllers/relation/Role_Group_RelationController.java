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
import com.jfinal.log.Log;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.activerecord.tx.Tx;

@RequiresAuthentication
@Before(SetAttrLoginUserInterceptor.class)
public class Role_Group_RelationController extends Controller{
	
	private Log logger = Log.getLog(LeaveController.class);
	Subject currentUser = SecurityUtils.getSubject();
	
	public void index(){
		redirect("/role_group_relation/edit");
	}
	
	public void edit(){
		String sLimit="";
		String condition="";
		String pageIndex = getPara("draw");
		if (getPara("start") != null && getPara("length") != null) {
            sLimit = " LIMIT " + getPara("start") + ", " + getPara("length");
        }
		
		Record login_user = getAttr("user");
		
		 String sql="SELECT * FROM t_rbac_role";
		 List<Record> role = Db.find(sql+condition+" order by id desc");
		 setAttr("role",role);
		 
		 String group_sql="SELECT * FROM t_rbac_group";
		 List<Record> group = Db.find(group_sql+condition+" order by id desc");
		 setAttr("group",group);
		 
		 
		 String id=getPara("id");
			Record check=Db.findFirst("select * from t_rbac_role where id=?",id);
			setAttr("check",check);
			
			String role_id=getPara("role_id");
			if(role_id!=null&&role_id!=""){
				List<Record> role_group=Db.find("SELECT group_id FROM t_rbac_group_role WHERE role_id=?",role_id);
				 setAttr("role_group",role_group);
			}
		 
		render("role_grouplist.html");
	}
	
	@Before(Tx.class)
	public void save(){
		String jsonStr = getPara("params");
		Gson gson = new Gson();
		Map<String, ?> dto= gson.fromJson(jsonStr, HashMap.class); 
		Record login_user = getAttr("user");
		
		String role_id=(String)dto.get("role_id");
		List<String> groupfrom_list =(List<String>)dto.get("groupfrom_list");
		
		Record record = new Record();
		if(groupfrom_list.size()>0){
			Record re=Db.findFirst("select *from t_rbac_group_role where role_id=?", role_id);
			if(re!=null){
				Db.delete("delete from t_rbac_group_role where role_id = ?",role_id);
			}
			for(int i=0;i<groupfrom_list.size();i++){
				record.set("role_id", role_id);
				record.set("group_id", (String)groupfrom_list.get(i));
				Db.save("t_rbac_group_role", record);
			}
		}
		renderJson(record);
		
	}

}
