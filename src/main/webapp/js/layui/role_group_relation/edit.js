	layui.use(['jquery', 'form', 'laydate', 'layedit'], function(){
		var form = layui.form, $ = layui.$, laydate = layui.laydate,layedit = layui.layedit;
		
		$('#sidebar_leave').addClass('layui-nav-itemed');		
		
		form.on('submit()',function(data){
			var order = {};
			var groupfrom_list = [];
			$("#orderForm input,select").each(function(){
				var name = $(this).attr("name");
				if("group_id" == name){
					var checked = $(this).prop("checked");
					if(checked){
						groupfrom_list.push($(this).val());
					}
				}else{
					order[name] = $(this).val();
				}
			});
			order.groupfrom_list = groupfrom_list;
			$.post("/role_group_relation/save",{params:JSON.stringify(order)},function(data){
				if(data){
					layer.msg('保存成功',{icon:1});
				}
			});
		});
		
		form.on('select(level)',function(data){
			var role_id = data.value;
			var id = data.value;
			location.href="/role_group_relation/edit?role_id="+role_id+"&&id="+id;
		});

});