package com.jfa.controllers.OrganizeStructure;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfa.interceptor.SetAttrLoginUserInterceptor;
import com.jfa.util.MD5Util;
import com.jfinal.kit.PropKit;
import com.jfinal.kit.StrKit;
import com.shuyan.wxl.annotation.JAction;

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


//shiro注解, 要求必须登录才能访问
@RequiresAuthentication
@Before(SetAttrLoginUserInterceptor.class)
//JAction注解, 无需在config中再配置
@JAction(value = "/organize_structure",viewPath = "/organize_structure")
public class OrganizeStructure extends Controller {
    private Log logger = Log.getLog(OrganizeStructure.class);
    Subject currentUser = SecurityUtils.getSubject();

    //返回leave list页面
    public void index() {
        redirect("/organize_structure/edit");
    }

    //返回edit页面
    public void edit() {
        Record login_user = getAttr("user");
        //String id = getPara("id");
        List<Record> group1_list = Db.find("select * from t_rbac_group where parent_id is null");
        for(int i = 0;i<group1_list.size();i++){
        	List<Record> group2_list = Db.find("select * from t_rbac_group where parent_id = ?",group1_list.get(i).get("id"));
        	group1_list.get(i).set("group2_list", group2_list);
            for(int j = 0;j<group2_list.size();j++){
            	List<Record> group3_list = Db.find("select * from t_rbac_group where parent_id = ?",group2_list.get(j).get("id"));
            	group2_list.get(j).set("group3_list", group3_list);
            	for(int k=0;k<group3_list.size();k++){
            		List<Record> group4_list = Db.find("select * from t_rbac_group where parent_id=?",group3_list.get(k).get("id"));
            		group3_list.get(k).set("group4_list", group4_list);
            	}
            }
        }
        setAttr("group1_list", group1_list);
        render("edit.html");
    }
    
    public void groupinfo(){
    		String id=getPara("id");
    		List<Record> groupinfo=Db.find("select * from t_rbac_group where parent_id=?",id);
    		renderJson(groupinfo);
    }

    @Before(Tx.class)
    public void updateName(){
    	String group_id = getPara("group_id");
    	String group_name = getPara("group_name");
    	Record group = new Record();
    	boolean result = false;
    	if(StrKit.notBlank(group_id)){
    		group = Db.findById("t_rbac_group", group_id);
    		group.set("name", group_name);
    		result = Db.update("t_rbac_group",group);
    	}
    	renderJson("{\"result\":"+result+"}");
    }
    
    @Before(Tx.class)
    public void createGroup(){
    	String group_id = getPara("group_id");
    	String group_name = getPara("group_name");
    	Record group = new Record();
    	boolean result = false;
    	if(StrKit.notBlank(group_id)){
    		group.set("name", group_name);
    		group.set("parent_id", group_id);
    		result = Db.save("t_rbac_group",group);
    	}
    	renderJson("{\"result\":"+result+"}");
    }
  
    public void userInfo(){
    	String sLimit = "";
        String condition = " ";

        if (getPara("limit") != null && getPara("page") != null) {
            int limit = getParaToInt("limit");
            int page=getParaToInt("page")-1;
            sLimit = " limit " + limit*page + ", " + limit;
        }
        
    	String id = getPara("id");
    	String sql = "select tru.*,trg.name group_name from t_rbac_ref_group_user trrgu"
    			+ " left join t_rbac_user tru on tru.id = trrgu.user_id"
    			+ " left join t_rbac_group trg on trg.id = trrgu.group_id"
    			+ " where trrgu.group_id = "+id;
    	List<Record> orderList = Db.find(sql+condition+" order by id desc "+sLimit);
    	
    	String sqlTotal = "select count(1) total from (" + sql + ") B";
        Record rec = Db.findFirst(sqlTotal);

        Map<String,Object> map = new HashMap<String,Object>();
        map.put("code", 0);
        map.put("count", rec.get("total"));
        map.put("data", orderList);

        renderJson(map);
    }
    
    @Before(Tx.class)
    public void addUser(){
    	String josnStr = getPara("params");
    	Gson gson = new Gson();
    	Map<String,Object> dto = gson.fromJson(josnStr,HashMap.class);
    	String group_id = (String)dto.get("group_id");
    	String name = (String)dto.get("name");
    	String password =  MD5Util.encode("SHA1",(String)dto.get("password"));
    	String cn_name = (String)dto.get("cn_name");
    	String mobile = (String)dto.get("mobile");
    	
    	Record user = new Record();
    	user.set("name", name);
    	user.set("password", password);
    	user.set("cn_name", cn_name);
    	user.set("mobile", mobile);
    	boolean user_result = Db.save("t_rbac_user", user);
    	boolean result = false;
    	if(user_result){
    		Record re = new Record();
    		re.set("group_id", group_id);
    		re.set("user_id", user.get("id"));
    		result = Db.save("t_rbac_ref_group_user", re);
    	}
    	renderJson("{\"result\":"+result+"}");
    }
    
    @Before(Tx.class)
	public void deleteUser(){
		String id = getPara("id");
		
		boolean user_result = false;
		int result = Db.delete("delete from t_rbac_ref_group_user where user_id = ?", id);
		if(result>0){
			Record user = Db.findById("t_rbac_user", id);
			user_result = Db.delete("t_rbac_user",user);
		}
		renderJson("{\"result\":"+user_result+"}");
	}
    
}