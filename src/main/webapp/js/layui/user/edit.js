layui.use(['jquery', 'form', 'laydate', 'layedit'], function(){
	var form = layui.form, $ = layui.$, laydate = layui.laydate,layedit = layui.layedit;
		
	$('#sidebar_leave').addClass('layui-nav-itemed');
	
	//自定义验证规则
	form.verify({
		 pass: [/(.+){6,12}$/, '密码必须6到12位']
	});
		  
	//监听提交
	form.on('submit()',function(data){
		
		  var order = {};
		  
		  $("#orderForm input").each(function(){
			 var name = $(this).attr("name");
			 order[name] = $(this).val();
		  });
		  
		  $.post("/user/save",{params:JSON.stringify(order)},function(data){
			  if(data.id>0){
				  layer.msg('保存成功',{icon:1});
				  var stateObj = { foo : "create"};
				  history.pushState(stateObj,"edit","edit?id="+data.id);
			  }else{
				  layer.msg('保存失败',{icon:2});
			  }
		  }).fail(function(){
			  layer.msg('后台出错',{icon:2});
		  	});
	});
		
	//为当前用户新增用户组
	$("#addgroup").click(function(){
		
			var order_id = $("#order_id").val();
			var name = $("#name").val();
			var password = $("#password").val();
			
			if(name == null || name == ""){
				layer.msg('用户名不能为空',{icon:2});
				$("#name").focus();
				return false;
			}else if(password == null || password == ""){
				layer.msg('密码不能为空',{icon:2});
				$("#password").focus();
				return false;
			}else{
				$.post("/user/check",{name:name,password:password,order_id:order_id},function(data){
					if(data != null){
						location.href = "/user_group_relation/edit?id="+order_id+"&&user_id="+order_id;
					}else{
						layer.msg('请先保存用户',{icon:2});
					} 
				});
			}
	});
		
	//为当前用户新增角色
	$("#addrole").click(function(){
		
			var order_id = $("#order_id").val();
			var name = $("#name").val();
			var password = $("#password").val();
			
			$.post("/user/check",{name:name,password:password,order_id:order_id},function(data){
				if(data != null){
					location.href = "/user_role_relation/edit?id="+order_id+"&&user_id="+order_id;
				}else{
					layer.msg('请先保存用户',{icon:2});
				} 
			});
	});

});