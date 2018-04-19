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
		
		
		form.on('submit()',function(data){
			var order={};
			var rolefrom_list=[];
			$("#orderForm input,select").each(function(){
				var name=$(this).attr("name");
				if("role_id"==name){
					var checked=$(this).prop("checked");
					if(checked){
						rolefrom_list.push($(this).val());
					}
				}else{
					order[name]=$(this).val();
				}
			});
			order.rolefrom_list = rolefrom_list;
			$.post("/user_role_relation/save",{params:JSON.stringify(order)},function(data){
				if(data){
					layer.msg('保存成功',{icon:1});
				}
			});
		});
		
		form.on('select(level)',function(data){
			var user_id=data.value;
			var id = data.value;
					location.href="/user_group_relation/edit?id="+id+"&&user_id="+user_id;
		});
		

	});