$(function(){
	layui.use(['jquery', 'form', 'laydate', 'layedit'], function(){
		var form = layui.form, $=layui.$, laydate=layui.laydate,layedit = layui.layedit;
		$('#sidebar_leave').addClass('layui-nav-itemed');

		//创建一个编辑器
		var editIndex = layedit.build('LAY_demo_editor');
		
		  //监听提交
		form.on('submit()',function(data){
		  var order={};
		  order.order_id = $("#order_id").val();
		  order.name = $("#name").val();
		  order.type = $("#type").val();
		  order.menu_id = $("#menu").val();
		  order.element_id = $("#element").val();
		  order.operation_id = $("#operation").val();
		  
		  $.post("/permission/save",{params:JSON.stringify(order)},function(data){
			  if(data.id>0){
				  layer.msg('保存成功',{icon:1});
				  var stateObj = { foo : "create"};
				  setTimeout(function(){
					  location.href="/permission/list";
				  },1000);
			  }else{
				  layer.msg('保存失败',{icon:2});
			  }
		  }).fail(function(){
			  layer.msg('后台出错',{icon:2});
		  	});
		  });
	});
	
	layui.use('form', function(){
		  var form = layui.form;
		  form.on('select(type)', function(data){
			  if("MENU"==data.value){
				  $("#menu").show();
				  $("#menu").attr("lay-verify","required");
				  $("#element").hide();
				  $("#operation").hide();
				  $("#element").attr("lay-verify","");
				  $("#operation").attr("lay-verify","");
			  }else if("ELEMENT"==data.value){
				  $("#element").show();
				  $("#element").attr("lay-verify","required");
				  $("#menu").hide();
				  $("#operation").hide();
				  $("#menu").attr("lay-verify","");
				  $("#operation").attr("lay-verify","");
			  }else if("OPERATION"==data.value){
				  $("#operation").show();
				  $("#operation").attr("lay-verify","required");
				  $("#menu").hide();
				  $("#element").hide();
				  $("#menu").attr("lay-verify","");
				  $("#element").attr("lay-verify","");
			  }
		});  
	});
});
