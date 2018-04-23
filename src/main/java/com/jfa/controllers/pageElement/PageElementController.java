package com.jfa.controllers.pageElement;

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
public class PageElementController extends Controller {
    private Log logger = Log.getLog(PageElementController.class);
    Subject currentUser = SecurityUtils.getSubject();

    //返回leave list页面
    public void index() {
        redirect("/page_element/list");
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
        String sql=" select * from t_rbac_page_element where is_delete = '0'";
        List<Record> orderList = Db.find(sql+condition+" order by id desc "+sLimit);

        String sqlTotal = "select count(1) total from (" + sql + ") B";
        Record rec = Db.findFirst(sqlTotal);

        Map<String,Object> map = new HashMap<String,Object>();
        map.put("code", 0);
        map.put("count", rec.get("total"));
        map.put("data", orderList);

        renderJson(map);
    }

    //返回create页面
    public void create() {
        Record login_user = getAttr("user");

        Record order = new Record();
        order.set("user_id", login_user.get("id"));
        order.set("user_name", login_user.get("name"));
        setAttr("order", order);
        render("edit.html");
    }

    //返回edit页面
    public void edit() {
        Record login_user = getAttr("user");
        String id = getPara("id");
        Record order = Db.findById("t_rbac_page_element",id);
        setAttr("order", order);
        render("edit.html");
    }

    @Before(Tx.class)
    public void save(){
        String jsonStr = getPara("params");
        Gson gson = new Gson();
        Map<String, ?> dto= gson.fromJson(jsonStr, HashMap.class);
        Record login_user = getAttr("user");

        String id = (String)dto.get("order_id");
        String name = (String)dto.get("name");
        String code = (String)dto.get("code");

        Record order = new Record();
        if(StrKit.notBlank(id)){
            order = Db.findById("t_rbac_page_element", id);
        	order.set("name", name);
            order.set("code", code);
            Db.update("t_rbac_page_element", order);
        } else {
        	order.set("name", name);
            order.set("code", code);
            Db.save("t_rbac_page_element",order);
        }

        renderJson(order);
    }
    
    public void delete(){
		String id = getPara("id");
		Boolean result = false;
		if(StrKit.notBlank(id)){
			Record re = Db.findById("t_rbac_page_element", id);
			re.set("is_delete", 1);
			result = Db.update("t_rbac_page_element",re);
		}
		renderJson("{\"result\":"+result+"}");
	}



}