package com.jfa.controllers.permission;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfa.interceptor.SetAttrLoginUserInterceptor;
import com.jfa.util.SharedUtil;
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
public class PermissionController extends Controller {
    private Log logger = Log.getLog(PermissionController.class);
    Subject currentUser = SecurityUtils.getSubject();

    //返回leave list页面
    public void index() {
        redirect("/permission/list");
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
        String sql=" select * from t_rbac_permission where is_delete=0";
        List<Record> orderList = Db.find(sql+condition+" order by id desc "+sLimit);

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
        String id = getPara("id");
        
        Record order = Db.findFirst("select * from t_rbac_permission  where id=?", id);
        if(order!=null){
        	if("MENU".equals(order.get("type"))){
            	Record re = Db.findFirst("select * from t_rbac_ref_perm_menu where permission_id = ?",id);
            	order.set("menu_id", re.get("menu_id"));
            }else if("ELEMENT".equals(order.get("type"))){
            	Record re = Db.findFirst("select * from t_rbac_ref_perm_element where permission_id = ?",id);
            	order.set("element_id", re.get("page_element_id"));
            }else if("OPERATION".equals(order.get("type"))){
            	Record re = Db.findFirst("select * from t_rbac_ref_perm_operation where permission_id = ?",id);
            	order.set("operation_id", re.get("operation_id"));
            }
        }
        setAttr("order", order);
        
        List<Record> menuList = Db.find(SharedUtil.menuSql(login_user.getStr("id")));
        setAttr("menuList",menuList);
        List<Record> elementList = Db.find(SharedUtil.elementSql(login_user.getStr("id")));
        setAttr("elementList",elementList);
        List<Record> operationList = Db.find("select * from t_rbac_operation");
        setAttr("operationList",operationList);
        
        render("edit.html");
    }

    @Before(Tx.class)
    public void save(){
        String jsonStr=getPara("params");
        Gson gson = new Gson();
        Map<String, ?> dto= gson.fromJson(jsonStr, HashMap.class);
        Record login_user = getAttr("user");

        String id = (String)dto.get("order_id");
        String name = (String)dto.get("name");
        String type = (String)dto.get("type");
        String menu_id = (String)dto.get("menu_id");
        String element_id = (String)dto.get("element_id");
        String operation_id = (String)dto.get("operation_id");

        Record order = new Record();
        if(StrKit.notBlank(id)){
            order = Db.findById("t_rbac_permission", id);
            Db.delete("delete from t_rbac_ref_perm_menu where permission_id = ?",id);
            Db.delete("delete from t_rbac_ref_perm_element where permission_id = ?",id);
            Db.delete("delete from t_rbac_ref_perm_operation where permission_id = ?",id);
            order.set("name", name);
            order.set("type", type);
            Db.update("t_rbac_permission", order);
        } else {
            order.set("name", name);
            order.set("type", type);
            Db.save("t_rbac_permission",order);
        }
        if("MENU".equals(type)){
        	Record re = new Record();
        	re.set("menu_id", menu_id);
        	re.set("permission_id", order.get("id"));
        	Db.save("t_rbac_ref_perm_menu", re);
        }else if("ELEMENT".equals(type)){
        	Record re = new Record();
        	re.set("page_element_id", element_id);
        	re.set("permission_id", order.get("id"));
        	Db.save("t_rbac_ref_perm_element", re);
        }else if("OPERATION".equals(type)){
        	Record re = new Record();
        	re.set("operation_id", operation_id);
        	re.set("permission_id", order.get("id"));
        	Db.save("t_rbac_ref_perm_operation", re);
        }

        renderJson(order);
    }

    public void delete(){
		String id= getPara("id");
		Record re=Db.findById("t_rbac_permission", id);
		Boolean result = false;
		if(re!=null){
			re.set("is_delete", 1);
			result = Db.update("t_rbac_permission",re);
		}
		renderJson("{\"result\":"+result+"}");
	}

}