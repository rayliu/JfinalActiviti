	layui.use(['jquery', 'form', 'laydate', 'layedit'], function(){
		var form = layui.form, $ = layui.$, laydate = layui.laydate,layedit = layui.layedit;
		
		$('#sidebar_leave').addClass('layui-nav-itemed');
		
		//监听提交
		form.on('submit()',function(data){
			var order={};
			$("#orderForm input,select").each(function(){
				var name = $(this).attr("name");
				order[name]=$(this).val();
			});
			$.post("/group/save",{params:JSON.stringify(order)},function(data){
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
		
});