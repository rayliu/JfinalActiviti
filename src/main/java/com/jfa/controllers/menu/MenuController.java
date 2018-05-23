package com.jfa.controllers.menu;

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

import com.alibaba.druid.util.StringUtils;
import com.google.gson.Gson;
import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.log.Log;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.activerecord.tx.Tx;

import freemarker.template.utility.StringUtil;


//shiro注释, 要求必须登录才能访问
@RequiresAuthentication
@Before(SetAttrLoginUserInterceptor.class)
public class MenuController extends Controller {
    private Log logger = Log.getLog(MenuController.class);
    Subject currentUser = SecurityUtils.getSubject();

    //返回leave list页面
    public void index() {
        redirect("/t_rbac_menu/list");
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
        String sql = " select * from t_rbac_menu where is_delete = '0'";
        List<Record> orderList = Db.find(sql+condition+" order by sort_no  "+sLimit);

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
        Record order = Db.findFirst("select * from t_rbac_menu  where id=?", id);
        
        setAttr("order", order);
        render("edit.html");
    }

    @Before(Tx.class)
    public void save(){
        String jsonStr=getPara("params");
        Gson gson = new Gson();
        Map<String, ?> dto= gson.fromJson(jsonStr, HashMap.class);
        Record login_user = getAttr("user");

        String id = (String)dto.get("id");
        String name = (String)dto.get("name");
        String url = (String)dto.get("url");
        String parent_id = (String)dto.get("parent_id");
        String seq = (String)dto.get("seq");

        Record order = new Record();
        if(StrKit.notBlank(id)){
            order = Db.findById("t_rbac_menu", id);
                if(StrKit.notBlank(id)){
                    order.set("id", id);
                }
                if(StrKit.notBlank(name)){
                    order.set("name", name);
                }
                if(StrKit.notBlank(url)){
                    order.set("url", url);
                }
                if(StrKit.notBlank(parent_id)){
                    order.set("parent_id", parent_id);
                }
                if(StrKit.notBlank(seq)){
                    order.set("seq", seq);
                }

            Db.update("t_rbac_menu", order);
        } else {
                if(StrKit.notBlank(id)){
                    order.set("id", id);
                }
                if(StrKit.notBlank(name)){
                    order.set("name", name);
                }
                if(StrKit.notBlank(url)){
                    order.set("url", url);
                }
                if(StrKit.notBlank(parent_id)){
                    order.set("parent_id", parent_id);
                }
                if(StrKit.notBlank(seq)){
                    order.set("seq", seq);
                }

            Db.save("t_rbac_menu",order);
        }
        renderJson(order);
    }
    
    public void delete(){
    	String id = getPara("id");
    	boolean result = false;
    	if(StrKit.notBlank(id)){
    		Record re = Db.findById("t_rbac_menu", id);
    		re.set("is_delete", "1");
    		result = Db.update("t_rbac_menu",re);
    	}
    	renderJson("{\"result\":"+result+"}");
    }
    
    public  void updateSort_no(){
    	String id = getPara("id");
    	String sort_no = getPara("sort_no");
    	Record re = Db.findById("t_rbac_menu", id);
		Boolean result = false;
		if(re != null){
			re.set("sort_no",sort_no);
			result = Db.update("t_rbac_menu",re);
		}
		renderJson("{\"result\":"+result+"}");
    }

}