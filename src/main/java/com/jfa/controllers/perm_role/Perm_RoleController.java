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

    //返回create页面
    public void create() {
        Record login_user = getAttr("user");

        Record order = new Record();
        order.set("user_id", login_user.get("id"));
        order.set("user_name", login_user.get("name"));
        setAttr("order", order);
        List<Record> role =Db.find("select * from t_rbac_role");
        setAttr("role",role);
        
        List<Record> permission =Db.find("select * from t_rbac_permission");
        setAttr("permission",permission);
        
        render("edit.html");
    }

    //返回edit页面
    public void edit() {
        Record login_user = getAttr("user");
        String permission_id= getPara("permission_id");
        String role_id= getPara("role_id");
        Record order = Db.findFirst("select * from t_rbac_ref_perm_role  where role_id=?", role_id);
        setAttr("order", order);
        
        List<Record> role =Db.find("select * from t_rbac_role");
        setAttr("role",role);
        
        List<Record> permission =Db.find("select * from t_rbac_permission");
        setAttr("permission",permission);
        
        
        render("edit.html");
    }

    @Before(Tx.class)
    public void save(){
        String jsonStr=getPara("params");
        Gson gson = new Gson();
        Map<String, ?> dto= gson.fromJson(jsonStr, HashMap.class);
        Record login_user = getAttr("user");

        String order_id = (String)dto.get("order_id");
            String role_id = (String)dto.get("role_id");
            String permission_id = (String)dto.get("permission_id");

        Record order = new Record();
        if(StrKit.notBlank(order_id)){
        	order=Db.findById("t_rbac_ref_perm_role",order_id);
                if(StrKit.notBlank(role_id)){
                    order.set("role_id", role_id);
                }
                if(StrKit.notBlank(permission_id)){
                    order.set("permission_id", permission_id);
                }

            Db.update("t_rbac_ref_perm_role", order);
        } else {
                if(StrKit.notBlank(role_id)){
                	order.set("role_id", role_id);
                }
                if(StrKit.notBlank(permission_id)){
                	order.set("permission_id", permission_id);
                }

            Db.save("t_rbac_ref_perm_role",order);
        }

        renderJson(order);
    }



}