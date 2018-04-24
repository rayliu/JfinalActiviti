$(function(){
	layui.use(['jquery','table'], function(){
		var table = layui.table, $=layui.$;
		$('#sidebar_leave').addClass('layui-nav-itemed');
		table.render({
			elem: '#menu_table'
			,url:'/perm_role/menuList'
			,width: 380
			//,cellMinWidth: 80 //全局定义常规单元格的最小宽度，layui 2.2.1 新增
			,cols: [[
					{width:60,
						templet: function(full){
							return '<input type="checkbox" lay-skin="primary" id="'+full.id+'"/>';
						}	
					},
					{field:'name', title: '菜单'}
			]]
		});
	});

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
			var menuIds = [];
			$($(".menu:checked")).each(function(){
				var id = $(this).attr("id");
				menuIds.push(id);
			});
			var pageIds = [];
			$($(".page:checked")).each(function(){
				var id = $(this).attr("id");
				pageIds.push(id);
			});
			var operationIds = [];
			$($(".operation:checked")).each(function(){
				var id = $(this).attr("id");
				operationIds.push(id);
			});
			var order={};
			order["menuIds"] = menuIds;
			order["pageIds"] = pageIds;
			order["operationIds"] = operationIds;
			order["group_id"] = $("#group_id").val();
			order["role_id"] = $("#role_id").val();
	 		$.post("/perm_role/save",{params:JSON.stringify(order)},function(data){
	  			if(data.result){
		  			layer.msg('保存成功',{icon:1});
		  			var stateObj = { foo : "create"};
					history.pushState(stateObj,"edit","edit?id="+data.id);
					setTimeout(function(){
						location.href="/perm_role";
					},1000);
	  			}else{
		  			layer.msg('保存失败',{icon:2});
	  			}
	 		}).fail(function(){
	  			layer.msg('后台出错',{icon:2});
	 		});
	 	});
	});
	
	$($("#allCheckBox_menu").parent()).on("click",".layui-form-checkbox",function(){
		Method("menu");
	});
	
	$($("#allCheckBox_element").parent()).on("click",".layui-form-checkbox",function(){
		Method("element");
	});
	
	$($("#allCheckBox_operation").parent()).on("click",".layui-form-checkbox",function(){
		Method("operation");
	});
	
	var Method = function(param){
		if($("#allCheckBox_"+param).prop("checked")){
			$($("."+param).parent().find(".layui-form-checkbox")).addClass("layui-form-checked");
			$("."+param).prop("checked",true);
		}else{
			$($("."+param).parent().find(".layui-form-checkbox")). removeClass("layui-form-checked");
			$("."+param).prop("checked",false);
		}
	}
});
