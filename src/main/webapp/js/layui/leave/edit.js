
	layui.use(['jquery', 'form', 'laydate', 'layedit'], function(){
		var form = layui.form, $=layui.$, laydate=layui.laydate,layedit = layui.layedit;
		
		$('#sidebar_leave').addClass('layui-nav-itemed');
		
		//执行一个laydate实例
		laydate.render({
			elem: '#start_time' //指定元素
		});
		//执行一个laydate实例
		laydate.render({
			elem: '#end_time' //指定元素
		});

		//创建一个编辑器
		var editIndex = layedit.build('LAY_demo_editor');
	 
//		//自定义验证规则
//		form.verify({
//			user_name: function(value){
//				if(/(.+){6,12}$/.test(value)){
//					return '标题至少得5个字符啊';
//				}
//			}
//		});
		
//		  //监听提交
//		  form.on('submit()', function(data){
//		    layer.alert(JSON.stringify(data.field), {
//		      title: '最终的提交信息'
//		    })
//		    return false;
//		  });

		/**
		* 业务逻辑处理
		*/
		$("#saveBtn").click(function(){
			var order = {};
			
			$("#orderForm input,select").each(function(){
				var name = $(this).attr("name");
				order[name] = $(this).val();
			});
			order["reason"] = $('#reason').val();
		
			$.post("/leave/save",{params:JSON.stringify(order)},function(data){
				if(data.id > 0){
					layer.msg('保存成功', {icon: 1});
					$('#order_id').val(data.id);

					var stateObj = { foo: "create" }; 
					history.pushState(stateObj, "edit", "edit?id="+data.id);
				}else{
					layer.msg('保存失败', {icon: 2});
				}
			}).fail(function(){
				layer.msg('后台出错', {icon: 2});
			});
		});
		

		$("#submitBtn").click(function(){
			var order_id = $("#order_id").val();
			if(!order_id > 0)
				layer.msg('要先保存单据哦', {icon: 2});
			
			$.post("/leave/submit",{order_id:order_id},function(data){
				if(data == 'ok'){
					layer.msg('提交成功', {icon: 1});
					
				}
			}).fail(function(){
				layer.msg('后台出错', {icon: 2});
			});
		});
	});