$(function(){
	layui.use(['jquery','table'], function(){
		var table = layui.table, $ = layui.$;
		$('#sidebar_leave').addClass('layui-nav-itemed');
		table.render({
			elem : '#eeda_table'
			,url : '/organize_structure/userInfo?id='+$("#group_id").val()
			,width : 800
			,text : {
				none:'暂无相关数据'
			}
			//,cellMinWidth: 80 //全局定义常规单元格的最小宽度，layui 2.2.1 新增
			,cols: [[
							{field : 'cn_name', title : '姓名'},
							{field : 'name', title : '账号'},
							{field : 'group_name', title : '部门'},
							{ title : '操作',width : 120,
								templet : function(full){
									return '<input type="button" class="layui-btn layui-btn-xs" lay-event="edit" value="编辑"/>'
											+'<input type="button" class="layui-btn layui-btn-danger layui-btn-xs" lay-event="delete" value="删除"/>';
								}
							 }
			         ]]
			});
	});
	
	//架构树单击事件
	$(".structManage").on("click",".click",function(){
		var self = $(this);
		var id = self.children("span").attr("id");
		$(".click").css("background-color","");
		self.css("background-color","#d9e3ec");
		
		if(id != $("#group_id").val()){
			//单击不同的部门，将单击的部门名称回填到右边
			$(".con_head_title").text(self.children("span").text());
			$("#group_id").val(id);
			
			//单击不同的部门，异步重载table
			var table = layui.table;
			table.reload('eeda_table', { url: '/organize_structure/userInfo',where: {id:$("#group_id").val()}});
		}else{
			//单击部门，如果部门id与右边的id相同，就隐藏
			if("block" == self.children("ul").css("display")){
				self.parent().children("ul").css("display","none");
			}else if("block" == self.next("ul").css("display")){
				self.parent().children("ul").css("display","none");
			}else{
				self.parent().children("ul").css("display","block");
			}
			
			var id = self.children("span").attr("id");
			if(self.parent().children("ul").html() == ""){
				$.post("/organize_structure/groupinfo",{id:id},function(data){
					if(data){
						for(var i=0;i<data.length;i++){
							var group_id = data[i].id;
							var value = data[i].name;
							appendMethod(group_id,value);
						}
					}else{
						layer.msg('后台出错',{icon:2});
					}
				});
			}
		}
	});
		
	//修改部门名称
	$("#updateGroupName").click(function(){
		var group_id = $("#group_id").val();
		
		layer.prompt({title: '请输入部门名称', formType:0,value:$(".con_head_title").text()}, function(value,index){
			layer.close(index);
		  
			$.post("/organize_structure/updateName",{group_id:group_id,group_name:value},function(data){
				if(data.result){
					layer.msg('修改成功',{icon:1});
					$("#"+$("#group_id").val()).text(value);
					$(".con_head_title").text(value);
				}else{
					layer.msg('修改失败',{icon:2});
				}
			});
		  
		});
	});
		
	//删除部门
	$("#deleteGroup").click(function(){
		var group_id = $("#group_id").val();
		layer.confirm('确定删除该部门吗？',{title:'提示'}, function(){
			$.post("/organize_structure/deleteGroup",{id:group_id},function(data){
				if(data.result){
					layer.msg('删除成功',{icon:1});
					window.location.href = "/organize_structure/edit";
				}else{
					layer.msg('删除失败',{icon:2});
				}
			}).fail(function(){
	  			layer.msg('后台出错',{icon:2});
	 		});;
		});
	});
	
	//新建子部门
	$("#createGroup").click(function(){
		var group_id = $("#group_id").val();
		
		layer.prompt({title: '请输入新建的部门名称', formType:0}, function(value,index){
			layer.close(index);
			
			$.post("/organize_structure/createGroup",{group_id:group_id,group_name:value},function(data){
				if(data.result){
					layer.msg('新建成功',{icon:1});
					appendMethod(group_id,value);
				}else{
					layer.msg('新建失败',{icon:2});
				}
			});
		  
		});
	});
		
	//新建子部门时追加hmtl显示,达到实时显示
	var appendMethod = function(group_id,value){
		var html = '<li>'
				 + '	<div class="organization" title="'+value+'">'
			  	 + '		<div class="click">'
				 + '			<i class="layui-icon">&#xe623;</i><i class="layui-icon">&#xe7a0;</i><span id="'+group_id+'">'+value+'</span>'
				 + '		</div>'
				 + '		<ul class="" style="margin-left:7%;display:none;"></ul>'
			     + '	</div>'
				 + '</li>'
		$("#"+$("#group_id").val()).parent().parent().children("ul").append(html);
	}
	
	//单击添加成员弹窗
	$("#createUser").click(function(){
		addUserPage("添加成员","","","","","");
	});
	
	//table监听，table里的单击事件都在里面
	layui.use('table', function(){
		var table = layui.table;
		//监听工具条
		table.on('tool(test)', function(obj){
			var data = obj.data;
			if(obj.event === 'edit'){
				addUserPage("编辑成员",data.id,data.cn_name,data.name,data.password,data.mobile);
			} else if(obj.event === 'delete'){
				layer.confirm('确定删除该成员吗？',{title:'提示'}, function(){
					$.post("/organize_structure/deleteUser",{id:data.id},function(data){
						if(data.result){
							layer.msg('删除成功',{icon:1});
							obj.del();
						}else{
							layer.msg('删除失败',{icon:2});
						}
					}).fail(function(){
			  			layer.msg('后台出错',{icon:2});
			 		});;
				});
			}
		});
	});

	//添加和编辑成员弹窗的html
	var addUserPage = function(title,user_id,cn_name,name,password,mobile){
		//页面层
		layer.open({
		  type: 1,
		  area: ['600px', '500px'], //宽高
		  title:title,
		  content: $("#editHtml").html()
		});
		var group_id = $("#group_id").val();
		$(".layui-layer-page input[name='user_id']").val(user_id);
		$(".layui-layer-page input[name='name']").val(name);
		$(".layui-layer-page input[name='password']").val(password);
		$(".layui-layer-page input[name='cn_name']").val(cn_name);
		$(".layui-layer-page input[name='mobile']").val(mobile);
		$(".layui-layer-page select[name='group_id']").val(group_id);
		if("编辑成员"==title){
			$(".layui-layer-page input[name='password']").attr("disabled",true);
			$(".layui-layer-page input[name='password']").attr("type","password");
			$(".layui-layer-page input[name='password']").css("background-color","#ccc");
		}
	}
	
	layui.use(['jquery', 'form', 'laydate', 'layedit'], function(){
		var form = layui.form, $ = layui.$, laydate = layui.laydate,layedit = layui.layedit;
		
		$('#sidebar_leave').addClass('layui-nav-itemed');
	
		//创建一个编辑器
		var editIndex = layedit.build('LAY_demo_editor');
		
		  //监听提交
		form.on('submit()',function(data){
			var order = {};
			$($(this).parent().parent()).find("input,select").each(function(){
				order[$(this).attr("name")] = $(this).val();
			});
			
			$.post("/organize_structure/addUser",{params:JSON.stringify(order)},function(data){
	  			if(data.result){
		  			layer.msg('保存成功',{icon:1});
		  			var table = layui.table;
					table.reload('eeda_table', { url: '/organize_structure/userInfo',where: {id:$("#group_id").val()}});
					setTimeout(function(){
						layer.closeAll("page");
					},1000);
	  			}else{
		  			layer.msg('保存失败',{icon:2});
	  			}
	 		}).fail(function(){
	  			layer.msg('后台出错',{icon:2});
	 		});
	 	});
	});

	$("body").on("click",".cancelBtn",function(){
		layer.closeAll();
	});
	
});