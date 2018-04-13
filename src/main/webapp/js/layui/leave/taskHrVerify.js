
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

		/**
		 * 业务逻辑处理
		 */
		$("#saveBtn").click(function(){
			if(checkEmpty()){
				layer.msg('有必填项未填', {icon: 2});
				return;
			}
			var order = {};
			
			$("#orderForm input,select").each(function(){
				var name = $(this).attr("name");
				if("landform"==name){
					var checked = $(this).prop("checked");
					if(checked){
						landform_list.push($(this).val());
					}
				}else{
					order[name] = $(this).val();
				}
			});
			console.log(order);
			debugger;
			$.post("/leave/hrVerifySave",{params:JSON.stringify(order)},function(data){
				if(order){
					layer.msg('保存成功', {icon: 1});
					window.location.href="/leave/task";
				}
			});
		});
		
		//校验必填项
		var checkEmpty = function(){
			var result = false;
			$("#orderForm .c-red").each(function(){
				var value = $(this).parent().parent().find("input").val();
				if(value==""){
					result = true;
				}
			});
			return result;
		}
	});