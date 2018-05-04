package com.jfa.controllers.report;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.h2.fulltext.IndexInfo;

import com.google.gson.Gson;
import com.jfa.interceptor.SetAttrLoginUserInterceptor;
import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.kit.PropKit;
import com.jfinal.kit.StrKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.activerecord.tx.Tx;

@Before(SetAttrLoginUserInterceptor.class)
public class ReportController extends Controller{
	
	private static final Object[] String = null;
	Subject currentUser = SecurityUtils.getSubject();
	private String projectPath = System.getProperty("user.dir");
	
	public void index() {
		if(!currentUser.isAuthenticated()){
			redirect("/login");
			return;
		}
		Record order = new Record();
		order.set("task_count", 1);
		order.set("proccess_count", 2);
		order.set("user_count", 3);
		order.set("err_count", 4);
		setAttr("order", order);

		redirect("/report/list");
	}
	
	public void list(){
		 render("reportList.html");
	}
	
	public void getList(){
		String sLimit = "";
		String condition = " ";

		if (getPara("limit") != null && getPara("page") != null) {
			int limit = getParaToInt("limit");
			int page=getParaToInt("page")-1;
			sLimit = " limit " + limit*page + ", " + limit;
		}
		String sql = "select * from t_rbac_report_sql where is_delete =0";
		
		List<Record> orderList = Db.find(sql+sLimit);
		
		String sqlTotal = "select count(1) total from (" + sql + ") B";
		Record rec = Db.findFirst(sqlTotal);
		Map<String,Object> map = new HashMap<String,Object>();

		map.put("code", 0);
		map.put("count", rec.get("total"));
		map.put("data", orderList);

		renderJson(map);
		
	}
	
	public void add(){
		render("reportFrom.html");
	}
	
	public void edit(){
		Record login_user = getAttr("user");
		String id=getPara("id");
		Record order=Db.findFirst("select * from t_rbac_report_sql where id=?",id);
		setAttr("order",order);
		render("reportFrom.html");
		}
	
	@Before(Tx.class)
	public void save(){
		String jsonStr=getPara("params");
        Gson gson = new Gson();
        Map<String, ?> dto= gson.fromJson(jsonStr, HashMap.class);
        Record login_user = getAttr("user");
        
        String order_id = (String)dto.get("order_id");
        String report_name = (String)dto.get("report_name");
        String sql = (String)dto.get("sql");
        String remark=(String)dto.get("remark");
       
        //效验填写的sql是否有语法错误
        List<Record> check=Db.find(sql);
        
        Record order= new Record();
        if(StrKit.notBlank(order_id)){
        	order=Db.findById("t_rbac_report_sql", order_id);
        	order.set("report_name",report_name);
        	order.set("sql", sql);
        	order.set("remark", remark);
        	Db.update("t_rbac_report_sql",order);
        	
        	//更新报表管理url的信息
        	String findUrl="/report/searchReport?id="+order_id+"&&Y=true";
        	 Record info= new Record();
        	 info=Db.findFirst("select * from t_rbac_menu where url='"+findUrl+"'");
        	 info.set("name", report_name);
        	 Db.update("t_rbac_menu",info);
        	 
        }else{
        	order.set("report_name",report_name);
        	order.set("sql", sql);
        	order.set("remark", remark);
        	order.set("create_name",login_user.get("name"));
        	order.set("create_by",login_user.getLong("id"));
        	order.set("create_time", new Date());
        	Db.save("t_rbac_report_sql",order);
        	
        	
        	Record user= Db.findFirst("select * from t_rbac_report_sql where remark='"+remark+"' and create_name = '"+login_user.get("name")+"'");
          	String id=user.getStr("id");
          	
          	//新增报表的同时在menu表新增当前报表的url信息
          	 Record menu= new Record();
          	 menu.set("name", report_name);
          	 menu.set("url","/report/searchReport?id="+id+"&&Y=true");
          	 menu.set("parent_id","41");
          	 menu.set("seq","3");
          	 Db.save("t_rbac_menu", menu);
        	 
        }
  
        renderJson(order);
	}
	
	public void delete(){
		String id= getPara("id");
		Record re=Db.findById("t_rbac_report_sql", id);
		Boolean result = false;
		if(re!=null){
			re.set("is_delete", 1);
			result = Db.update("t_rbac_report_sql",re);
		}
		renderJson("{\"result\":"+result+"}");
	}
	
	
	public void searchReport(){
		String jsonStr=getPara("params");
		String check=getPara("Y");
		if(check==null){
			 int i=jsonStr.length();
			  int count=0;
			  List<Integer> subStr= new ArrayList<Integer>();
			  
			  for(int a=0;a<i;a++){
				  char charStr =jsonStr.charAt(a);
				  if(charStr=='"'){
					  if(count==0){
						  subStr.add(a+1);
						  count++;
					  }else{
						  subStr.add(a);
						  count=0;
					  }
					  
				  }
			  }
			  List<String> strFin =new ArrayList<String>();
			  for(int z=0;z<subStr.size();z++){
				  int startInt = subStr.get(z);
				  if(z!=subStr.size()-1){
					  int endInt = subStr.get(z+1);
					  String cur = jsonStr.substring(startInt,endInt);
					  strFin.add(cur);
					  z++;
				  }
			  }
			  
			  String id= getPara("id");
			
			setAttr("id",id);
			setAttr("strFin",strFin);
		}else{
			String id=getPara("id");
			Record info =Db.findById("t_rbac_report_sql",id);
			String sql=info.getStr("sql");
			sql = sql.replace(" ", "");
			String[] array =sql.split("as'");
			int in=sql.indexOf("as'");
			if(in==-1){
				array= sql.split("as\"");
			}
		
			List<String> strFin =new ArrayList<String>();
			for(int i=1;i<array.length;i++){
				String str =array[i];
				if(in!=-1){
					String title = str.substring(0,str.indexOf("'"));
					strFin.add(title);
				}else{
					String title = str.substring(0,str.indexOf('"'));
					strFin.add(title);
				}
				
			}
			
			setAttr("id",id);
			setAttr("strFin",strFin);
			
		}
		 
		render("reportInfo.html");
	}
	
	
	public void getInfoList(){
		String sLimit = "";
		String condition = " ";
		 String pageIndex = getPara("draw");
		 
		String id=getPara("id");
		 if (getPara("start") != null && getPara("length") != null) {
	            sLimit = " LIMIT " + getPara("start") + ", " + getPara("length");
	        }
		
		 Record re=Db.findById("t_rbac_report_sql", id);
		  String sql=re.getStr("sql");
		  List<Record> orderList = Db.find(sql);
		
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
	
}
