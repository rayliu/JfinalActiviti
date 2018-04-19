package com.jfa.controllers.group;

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
public class GroupController extends Controller{

	private Log logger = Log.getLog(LeaveController.class);
	Subject currentUser = SecurityUtils.getSubject();
	
	//返回group list页面
	public void index(){
		redirect("group/list");
	}
	
	public void list(){
		render("groupList.html");
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
			 String sql="SELECT * FROM t_rbac_group";
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
			render("groupForm.html");
		}
		
		//返回edit页面
		public void edit(){
			 Record login_user = getAttr("user");
		        String id = getPara("id");
		        Record order = Db.findFirst("select * from t_rbac_group where id=?",id);
		        setAttr("order", order);
		        render("groupForm.html");
		}
		
		@Before(Tx.class)
		public void save(){
			String jsonStr =getPara("params");
			Gson gson = new Gson();
			Map<String, ?> dto= gson.fromJson(jsonStr, HashMap.class); 
			Record login_user = getAttr("user");
			  
			  String order_id = (String)dto.get("order_id");
			  String name = (String)dto.get("name");
			  String desc = (String)dto.get("desc");
			  
			  Record order = new Record();
			  if(StrKit.notBlank(order_id)){
		            order = Db.findById("t_rbac_group", order_id);
		            order.set("name", name);
		            order.set("desc",desc);
		            Db.update("t_rbac_group", order);
		        } else {
		        	order.set("name", name);
		            order.set("desc",desc);
		            Db.save("t_rbac_group",order);
		        }
			  renderJson(order);
		}
		
		
		
}
