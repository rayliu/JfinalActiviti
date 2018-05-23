package com.jfa.controllers.role;

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
public class RoleController extends Controller{

	private Log logger = Log.getLog(LeaveController.class);
	Subject currentUser = SecurityUtils.getSubject();
	
	//返回role list 页面
	public void index(){
		redirect("/role/list");
	}
	
	public void list(){
		render("roleList.html");
	}
	
	//返回list页面所需要的json
	public void getList(){
		String sLimit = "";
		String condition = "";
		String pageIndex = getPara("draw");
		if (getPara("start") != null && getPara("length") != null) {
            sLimit = " LIMIT " + getPara("start") + ", " + getPara("length");
        }
		
		Record login_user = getAttr("user");
		 String sql="SELECT trr.*,GROUP_CONCAT(trg.name) group_name FROM t_rbac_role trr"
		 		+ " LEFT JOIN t_rbac_group_role tgr ON tgr.role_id = trr.id"
		 		+ " LEFT JOIN t_rbac_group trg ON trg.id = tgr.group_id "
		 		+ " WHERE trr.is_delete=0"
		 		+ " GROUP BY trr.id";
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
		render("roleForm.html");
	}
	
	public void edit(){
		Record login_user = getAttr("user");
        String id = getPara("id");
        Record order = Db.findFirst("select * from t_rbac_role where id=?",id);
        setAttr("order", order);
        render("roleForm.html");
	}
	
	@Before(Tx.class)
	public void save(){
		String jsonStr = getPara("params");
		Gson gson = new Gson();
		Map<String, ?> dto = gson.fromJson(jsonStr, HashMap.class); 
		Record login_user = getAttr("user");
		  
		  String order_id = (String)dto.get("order_id");
		  String code = (String)dto.get("code");
		  String name = (String)dto.get("name");
		  String remark =(String)dto.get("remark");
		  
		  Record order = new Record();
		  if(StrKit.notBlank(order_id)){
	            order = Db.findById("t_rbac_role", order_id);
	            order.set("code", code);
	            order.set("name", name);
	            order.set("remark",remark);
	            
	            Db.update("t_rbac_role", order);
	        } else {
	        	order.set("code", code);
	            order.set("name", name);
	            order.set("remark",remark);
	            
	            Db.save("t_rbac_role",order);
	        }
		  renderJson(order);
	}
	
	public void check(){
		String order_id = getPara("order_id");
		String code = getPara("code");
		String name = getPara("name");
		
		Record order = new 	Record();
		order = null;
		if(StrKit.notBlank(name) && StrKit.notBlank(code)){
			order=Db.findFirst("select * from t_rbac_role where `name`=? and `code`=?",name,code);
		}
		renderJson(order); 	
	}
	
	public void delete(){
		String id = getPara("id");
		Record re = Db.findById("t_rbac_role", id);
		Boolean result = false;
		if(re != null){
			re.set("is_delete", 1);
			result = Db.update("t_rbac_role",re);
		}
		renderJson("{\"result\":"+result+"}");
	}
	
}