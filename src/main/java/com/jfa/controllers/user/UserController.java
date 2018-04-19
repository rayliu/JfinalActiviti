package com.jfa.controllers.user;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.apache.shiro.subject.Subject;

import com.google.gson.Gson;
import com.jfa.controllers.leave.LeaveController;
import com.jfa.interceptor.SetAttrLoginUserInterceptor;
import com.jfa.util.MD5Util;
import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.kit.PropKit;
import com.jfinal.kit.StrKit;
import com.jfinal.log.Log;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.activerecord.tx.Tx;

@RequiresAuthentication
@Before(SetAttrLoginUserInterceptor.class)
public class UserController extends Controller{
	
	private Log logger = Log.getLog(LeaveController.class);
	Subject currentUser = SecurityUtils.getSubject();
	
	//返回user list页面
	public void index(){
		redirect("/user/list");
	}
	
	public void list(){
		render("userList.html");
	}
	
	//返回list页面所需的json
	public void getList(){
		String sLimit="";
		String condition="";
		String pageIndex = getPara("draw");
		if (getPara("start") != null && getPara("length") != null) {
            sLimit = " LIMIT " + getPara("start") + ", " + getPara("length");
        }
		
		Record login_user = getAttr("user");
		 String sql="SELECT tru.*,GROUP_CONCAT(trr.name) role_name,GROUP_CONCAT(trg.name) group_name FROM t_rbac_user tru"
		 		+ " LEFT JOIN t_rbac_ref_user_role trur ON trur.user_id = tru.id"
		 		+ " LEFT JOIN t_rbac_role trr ON trr.id = trur.role_id"
		 		+ " LEFT JOIN t_rbac_ref_group_user trrg ON trrg.user_id = tru.id "
		 		+ " LEFT JOIN t_rbac_group trg ON trg.id = trrg.group_id "
		 		+ " GROUP BY tru.id";
		 List<Record> orderList = Db.find(sql+condition+" order by id desc");
		 
		 String sqlTotal = "select count(1) total from (" + sql + ") B";
	     Record rec = Db.findFirst(sqlTotal);
	     Map<String,Object> map = new HashMap<String,Object>();
		
	     String templateFolder = PropKit.get("ui_folder");
	        if("/template/layui".equals(templateFolder)){
	            map.put("code", 0);
	            map.put("count", orderList.size());
	            map.put("data", orderList);
	        }else {
	            map.put("draw", pageIndex);
	            map.put("recordsTotal", rec.getLong("total"));
	            map.put("recordsFiltered", rec.getLong("total"));
	            map.put("data", orderList);
	        }
	        renderJson(map);
	    }
	
	//返回create页面
	public void create(){
		render("userForm.html");
	}
	
	//返回edit页面
	public void edit(){
		 	Record login_user = getAttr("user");
	        String id = getPara("id");
	        Record order = Db.findFirst("select * from t_rbac_user where id=?",id);
	        setAttr("order", order);
	        render("userForm.html");
	}
	
	@Before(Tx.class)
	public void save(){
		String jsonStr =getPara("params");
		Gson gson = new Gson();
		Map<String, ?> dto= gson.fromJson(jsonStr, HashMap.class); 
		Record login_user = getAttr("user");
		  
		  String order_id = (String)dto.get("order_id");
		  String name = (String)dto.get("name");
		  String password =MD5Util.encode("SHA1",(String)dto.get("password"));
		  String cn_name = (String)dto.get("cn_name");
		  String phone = (String)dto.get("phone");
		
		  
		  Record order = new Record();
		  if(StrKit.notBlank(order_id)){
	            order = Db.findById("t_rbac_user", order_id);
	            order.set("name", name);
	            order.set("password", password);
	            order.set("cn_name", cn_name);
	            order.set("password", password);
	            order.set("mobile",phone);
	            
	            Db.update("t_rbac_user", order);
	        } else {
	        	order.set("name", name);
	            order.set("password", password);
	            order.set("cn_name", cn_name);
	            order.set("password", password);
	            order.set("mobile",phone);
	            
	            Db.save("t_rbac_user",order);
	        }
		  renderJson(order);
	}
	
	public void check(){
		String order_id = getPara("order_id");
		String name=getPara("name");
		String password;
		if(order_id!=null&&order_id!=""){
			 password = getPara("password");
		}else{
			password=MD5Util.encode("SHA1",getPara("password"));
		}
		
		Record order= new 	Record();
		order=null;
		if(name!=null && name!=""&&password!=null&&password!=""){
			order=Db.findFirst("select * from t_rbac_user where `name`=? and `password`=?",name,password);
		}
		renderJson(order); 	
	}
	
	
	
	
	
}
