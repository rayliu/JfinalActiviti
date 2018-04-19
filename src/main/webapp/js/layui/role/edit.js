	layui.use(['jquery', 'form', 'laydate', 'layedit'], function(){
		var form = layui.form, $=layui.$, laydate=layui.laydate,layedit = layui.layedit;
		
		$('#sidebar_leave').addClass('layui-nav-itemed');
		
		/*//执行一个laydate实例
		laydate.render({
			elem: '#start_time' //指定元素
		});
		//执行一个laydate实例
		laydate.render({
			elem: '#end_time' //指定元素
		});*/

		//创建一个编辑器
		var editIndex = layedit.build('LAY_demo_editor');
		
		  //监听提交
		form.on('submit()',function(data){
		  var order={};
		  $("#orderForm input").each(function(){
			 var name = $(this).attr("name");
			 order[name]=$(this).val();
		  });
		  $.post("/role/save",{params:JSON.stringify(order)},function(data){
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
		
		
		
		$("#addgroup").click(function(){
			var order_id = $("#order_id").val();
			var code = $("#code").val();
			var name=$("#name").val();
			if(code=="" || code==null){
				layer.msg('角色编码不能为空',{icon:2});
				$("#code").focus();
				return false;
			}else if(name=="" || name==null){
				layer.msg('角色名称不能为空',{icon:2});
				$("#name").focus();
				return false;
			}else{
				$.post("/role/check",{order_id:order_id,code:code,name:name},function(data){
					if(data!=null){
						location.href ="/role_group_relation/edit?id="+order_id+"&&role_id="+order_id;
					}else{
						 layer.msg('请先保存用户',{icon:2});
					}
				})
			}
		});
		
	});