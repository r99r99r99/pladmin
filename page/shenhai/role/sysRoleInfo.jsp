<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html >
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<head>
	<meta charset="utf-8" />
	<title>${system.systemName }</title>
	<meta name="keywords" content="入海污染源" />
</style>
</head>
<body ng-app="myApp" ng-controller="customersCtrl" >
	<%@ include file="../common/header.jsp" %>
	<!-- PAGE -->
	<section id="page">
	<%@ include file="../common/left.jsp" %>
	<div id="main-content">
		<div class="container">
				<div class="row">
					<div id="content" class="col-lg-12">
						<!-- PAGE HEADER-->
						<div class="row">
							<div class="col-sm-12">
								<div class="page-header">
									<!-- STYLER -->
									
									<!-- /STYLER -->
									<!-- BREADCRUMBS -->
									<ul class="breadcrumb">
										<li>
											<i class="fa fa-home"></i>
											<a href="#">${currMenu.pMenuName }</a>
										</li>
										<li>
											<a href="#">${currMenu.cMenuName }</a>
										</li>
									</ul>
								</div>
							</div>
						</div>
						<!-- /PAGE HEADER -->
						
						<form  role="form" name="myForm2" novalidate>
						<ul class="seachform">
						<li><label>权限类型</label>
						    <div class="vocation">
							    <select  ng-model="type" class="form-control"
	                              ng-change="query()" 
								  ng-options="option.classId as option.value for option in publicList">
								 </select>
						    </div>
					    </li>
					    <li><label>&nbsp;</label><input name="" type="button" class="btn btn-primary" ng-click="query()" value="查询"/></li>
					    <li><label>&nbsp;</label><input name="" type="button" class="btn btn-primary" ng-click="addRole()" value="新增"/></li>
					    <li><label>&nbsp;</label><input name="" type="button" class="btn btn-primary" ng-click="editRole()" value="编辑"/></li>
					    <li><label>&nbsp;</label><input name="" type="button" class="btn btn-primary" ng-click="deleRole()" value="删除"/></li>
					    <li><label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					                     </label><input name="" type="button" class="btn btn-primary" onclick="saveRoleMenuUser()" value="保存"/></li>
					    </ul>
					    </form>
						<div class="row">
				    	<div class="col-md-3">
				    		<div ui-grid="gridOptions" class="gridStylerole" ui-grid-selection style="width:100%"></div>
				    	</div>
				    	<div class="col-md-3">
				    		<div class="box border green" style="height:700px">
				    			<div class="box-title">
				    				<h4>人员列表</h4>
				    			</div>
				    			<div class="box-body" style="background-color: #F5F6F6">
				    				<ul id="tree" class="ztree" style="height:100%; overflow-x :auto; overflow-y :no"></ul>
				    			</div>
				    		</div>
				    	</div>
				    	<div class="col-md-3">
				    		<div class="box border green" style="height:700px">
				    			<div class="box-title">
				    				<h4>{{title}}</h4>
				    			</div>
				    			<div class="box-body" style="background-color: #F5F6F6">
				    				<ul id="mtree" class="ztree" style="height:100%; overflow-x :auto; overflow-y :no"></ul>
				    			</div>
				    		</div>
				    	</div>
				    	<div class="clearfix"> </div>
				    </div>	
				</div>
			</div>
	</div>		
	</section>
<script type="text/ng-template" id="popupTmpl.html">  
<div class="page-content" style="">
	<div class="page-header">
			<strong>
				{{role.name}}
				<i class="icon-double-angle-right"></i>
			</strong>
	</div><!-- /.page-header -->
	
	<div class="row">
	<div class="col-xs-12">
		<form class="form-horizontal" role="form" name="myForm"  novalidate>
			<input type="hidden" id="form-field-1" ng-model="role.id" />
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 权限名称 </label>

				<div class="col-sm-5">
						<input type="text" ng-model="role.name" name="userName"  placeholder="权限名称" class="form-control" required />
						<span style="color:red" ng-show=" myForm.userName.$invalid">
						<span ng-show="myForm.userName.$error.required">权限名称是必须的。</span>
						</span>
				</div>
			</div>
			<div class="space-4"></div>

			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 备注 </label>

				<div class="col-sm-5">
						<input type="text" id="form-field-1" ng-model="role.remark" name="realName" class="form-control"/>
						</span>
				</div>
			</div>
			<div class="space-4"></div>

			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 状态 </label>

				<div class="col-sm-5">
							 <select id="selectError" ng-model="role.isactive" class="form-control"
                              ng-change="changeOption()" 
							  ng-options="option.value as option.name for option in isactivelist">
							 </select>
				</div>
			</div>
			<div class="space-4"></div>
		
			
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 权限类型 </label>

				<div class="col-sm-5">
							 <select id="selectError" ng-model="role.type" class="form-control" readonly
                              ng-change="changeOption()" 
							  ng-options="option.classId as option.value for option in cpublicList">
							 </select>
				</div>
			</div>
			<div class="space-4"></div>

			<div class="clearfix form-actions">
				<div class="col-md-offset-3 col-md-9">
					<button class="btn btn-primary" type="button" ng-click="save()" 
						ng-disabled="myForm.userName.$invalid">
							保存
					</button>

				</div>
			</div>
		</form>	
	</div>
	<div>
</div>
</script>
		<link rel="stylesheet" href="${ctx }/shenhai/resources/zTree/css/zTreeStyle/zTreeStyle.css" type="text/css">
		<script type="text/javascript" src="${ctx }/shenhai/resources/zTree/js/jquery.ztree.core-3.5.js"></script>
		<script type="text/javascript" src="${ctx }/shenhai/resources/zTree/js/jquery.ztree.excheck-3.5.js"></script>
		
</body>
<script type="text/javascript" charset="UTF-8">
var myApp = angular.module('myApp',['ngDialog','ui.bootstrap','ui.grid','ui.grid.resizeColumns','ui.grid.selection']);
var row;
var col;
var role;
var mtype;
myApp.controller('customersCtrl',function($scope,$http,ngDialog,$modal){
	//添加一下内容防止输出乱码
	$http.defaults.headers.post['Content-Type'] = 'application/json;charset=utf-8';  
	$http.defaults.headers.post['Accept'] = 'application/json, text/javascript, */*; q=0.01';  
	$http.defaults.headers.post['X-Requested-With'] = 'XMLHttpRequest'; 
	$scope.title = "列表";
	//定义选中的角色
	$scope.mySelections = []; //获得当前选中的行
	//初始化角色类型
	var par = '0003';
	var param = {parentCode:par}; 
	
	$http({
   		 method:'POST',
			 url:'${ctx}/getPublicList.do',
			 params:param})
			 .success(function(response){
				  $scope.publicList = response;
   	});
	$scope.type = 1;
	
	//开始分页信息
	$scope.gridOptions = {
			enableRowSelection:true,
			rowTemplate: "<div ng-dblclick=\"grid.appScope.onDblClick(row)\" ng-repeat=\"(colRenderIndex, col) in colContainer.renderedColumns track by col.colDef.name\" class=\"ui-grid-cell\" ng-class=\"{ 'ui-grid-row-header-cell': col.isRowHeader }\" ui-grid-cell ></div>",
			multiSelect:false,
		    modifierKeysToMultiSelect :false,
		    noUnselect:true,
		    enableRowSelection: true,
		    enableRowHeaderSelection:false,
			appScopeProvider: { 
		          onDblClick : function(row) {

		      		//console.log($scope.mySelections);
		      		var queryParam = new Object();
		      		roleid = row.entity.id;
		      		queryParam.id = roleid;
		      		
		      		mtype = row.entity.type;  //获得当前角色的类型
		      		
		      		//给人员树赋值
		      		var t = $("#tree");
		      		$.ajax({
		      	        url: '${ctx}/getUsers4ZTree.do', //url  action是方法的名称
		      	        data: queryParam,
		      	        type: 'POST',
		      	        dataType: "json", //可以是text，如果用text，返回的结果为字符串；如果需要json格式的，可是设置为json
		      	        ContentType: "application/json; charset=utf-8",
		      	        success: function(data) {
		      	            //zNodes = data;
		      	        	t = $.fn.zTree.init(t, setting, data);
		      	        },
		      	        error: function(msg) {
		      	            alert("失败");
		      	        }
		      		}); 
		      		
		      		var m = $("#mtree");
		      		if(mtype==1){  //如果当前角色为菜单角色
		      			$scope.title = "菜单列表";
		      			//给菜单树赋值
		      			$.ajax({
		      		        url: '${ctx}/getMenus4Tree.do', //url  action是方法的名称
		      		        data: queryParam,
		      		        type: 'POST',
		      		        dataType: "json", //可以是text，如果用text，返回的结果为字符串；如果需要json格式的，可是设置为json
		      		        ContentType: "application/json; charset=utf-8",
		      		        success: function(data) {
		      		            //zNodes = data;
		      		        	m = $.fn.zTree.init(m, setting, data);
		      		        },
		      		        error: function(msg) {
		      		            alert("失败");
		      		        }
		      			});  
		      		}else if (mtype==2){  //如果当前角色为站点角色
		      			$scope.title = "站点列表";
		      			//给菜单树赋值
		      			$.ajax({
		      		        url: '${ctx}/getStationList4ZTree.do', //url  action是方法的名称
		      		        data: queryParam,
		      		        type: 'POST',
		      		        dataType: "json", //可以是text，如果用text，返回的结果为字符串；如果需要json格式的，可是设置为json
		      		        ContentType: "application/json; charset=utf-8",
		      		        success: function(data) {
		      		            //zNodes = data;
		      		        	m = $.fn.zTree.init(m, setting, data);
		      		        },
		      		        error: function(msg) {
		      		            alert("失败");
		      		        }
		      			});  
		      		}else if(mtype==3){  //如果当前角色为首页角色
		      			$scope.title = "菜单列表";
		      			//给菜单树赋值
		      			$.ajax({
		      		        url: '${ctx}/getFirstMenus4Tree.do', //url  action是方法的名称
		      		        data: queryParam,
		      		        type: 'POST',
		      		        dataType: "json", //可以是text，如果用text，返回的结果为字符串；如果需要json格式的，可是设置为json
		      		        ContentType: "application/json; charset=utf-8",
		      		        success: function(data) {
		      		            //zNodes = data;
		      		        	m = $.fn.zTree.init(m, rodioSetting, data);
		      		        },
		      		        error: function(msg) {
		      		            alert("失败");
		      		        }
		      			});  
		      		}
		          }
		    },
		    headerRowHeight: 50,
			enableColumnResizing:true,
		    enableGridMenu: false,
		    enableSelectAll: true,
		    exporterCsvFilename: '人员管理.csv',
		    getRowIdentity:function(row){
		    	console.log(row);
		    },
		    onRegisterApi: function(gridApi){
		      $scope.gridApi = gridApi;
		      gridApi.selection.on.rowSelectionChanged($scope,function(row){
		    	  role = row.entity;
		          console.log(role);
		        });
		    }
		  };
	$scope.query=function(){
		$(".btn btn-primary").attr('disabled',"true");
		var type = $scope.type;
		var pData = {type:type}; 
		$http({
			 method:'POST',
			 url:'${ctx}/getRoleList.do',
			 params:pData})
			 .success(function(response){
				 $(".btn btn-primary").removeAttr("disabled"); 
				 row = response.rows;
				 col = response.cols;
				 $scope.gridOptions.columnDefs = col;
				 $scope.gridOptions.data = row;
				 //清空所选的人员列表和菜单列表
				 var t = $("#tree");
				 t = $.fn.zTree.init(t, setting, "");
				 var m = $("#mtree");
				 m = $.fn.zTree.init(m, setting, "");
		     });
	};
	$scope.query();
	var methodtype ;
	//新增,弹出编辑框
	$scope.addRole = function(){
		methodtype = 1;
		$scope.showEdit();
	};
	
	//编辑,弹出编辑框
	$scope.editRole = function(){
		methodtype = 2;
		if(role==null){
			alert("请选中要编辑的角色");
			return;
		}
		$scope.showEdit();
	};
	
	$scope.showEdit = function(){
		var modalInstance = $modal.open({  
            templateUrl: 'popupTmpl.html',  
            controller: ModalInstanceCtrl
        });  
    	modalInstance.opened.then(function(){//模态窗口打开之后执行的函数  
            console.log('modal is opened');  
        });  
        modalInstance.result.then(function (result) { 
        	 alert(result);
        	 $scope.query();
             console.log(result);  
        }, function (reason) {  
            console.log(reason);//点击空白区域，总会输出backdrop click，点击取消，则会暑促cancel  
        });
	};
	
	$scope.deleRole = function(){
		if(roleid==null||roleid<1){
			alert("请先双击要删除的角色");
			return ;
		}
		if(confirm("确定要删除该角色以及权限吗?删除后不可恢复")){
			$(".btn btn-primary").attr('disabled',"true");
			var queryParam = new Object();
			queryParam.id = roleid;
			$http({
				 method:'POST',
				 url:'${ctx}/deleRole.do',
				 params:queryParam})
				 .success(function(response){
					 $(".btn btn-primary").removeAttr("disabled"); 
					  alert(response);
					  $scope.query();
			     });
		}
	}
	
	var ModalInstanceCtrl = function ($scope, $modalInstance,$http) {
		$http.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded;charset=utf-8';  
    	$http.defaults.headers.post['Accept'] = 'application/json, text/javascript, */*; q=0.01';  
    	$http.defaults.headers.post['X-Requested-With'] = 'XMLHttpRequest';  
    	
    	//生成状态列表
    	$scope.isactivelist = [{
            name: '启用',
            value: 1
        }, {
            name: '禁用',
            value: 0
        }];
    	
    	//获得角色类型列表
    	var par = '0003';
    	var cparam = {parentCode:par}; 
    	$http({
       		 method:'POST',
    			 url:'${ctx}/getPublicList.do',
    			 params:cparam})
    			 .success(function(response){
    				  $scope.cpublicList = response;
       	});
    	//如果是新增,初始化
    	if(methodtype==1){
    		$scope.role = {type:1,isactive:1};
    	}
    	//如果是编辑,初始化
    	if(methodtype==2){
    		$scope.role = role;
    	}
    	
    	//提交操作
    	$scope.save = function(){
    		var param = $scope.role;
    		//新增操作时
    		if(methodtype==1){
    			$http({
       	   		 method:'POST',
       				 url:'${ctx}/saveAddRole.do',
       				 params:param,
       				 headers: { 'Content-Type': 'application/json; charset=UTF-8'}
       				 })
       				 .success(function(response){
   				    	 $modalInstance.close(response);
       	   	     }); 	
    		}
    		
    		//编辑操作时
    		if(methodtype==2){
    			$http({
          	   		 method:'POST',
          				 url:'${ctx}/saveEditRole.do',
          				 params:param,
          				 headers: { 'Content-Type': 'application/json; charset=UTF-8'}
          				 })
          				 .success(function(response){
      				    	 $modalInstance.close(response);
          	   	     }); 
    		};
    		
    	};
    	
	};
	
});
//以下开始jquery代码
var zTree;
var setting = { 
		check: {
			enable: true
		},
		view: {
			dblClickExpand: false,
			showLine: true,
			selectedMulti: false
		},
		data: {
			simpleData: {
				enable:true,
				idKey: "id",
				pIdKey: "pId",
				rootPId: ""
			}
		}
    };
var rodioSetting = { 
		check: {
			enable: true,
			chkStyle: "radio",
			radioType: "all"
		},
		view: {
			dblClickExpand: false,
			showLine: true,
			selectedMulti: false
		},
		data: {
			simpleData: {
				enable:true,
				idKey: "id",
				pIdKey: "pId",
				rootPId: ""
			}
		}
    };
var zNodes = [
              {"id":1,"pId":0,"name":"中国"},
              {"id":4,"pId":1,"name":"河北省"},
              {"id":30,"pId":4,"name":"河北昌黎黄金海岸国家级自然保护区","ifNode":1},
              {"id":7,"pId":1,"name":"辽宁省"},
              {"id":113,"pId":7,"name":"盘锦市"},
              {"id":29,"pId":113,"name":"盘锦鸳鸯沟国家级海洋公园","ifNode":1},
              {"id":16,"pId":1,"name":"山东省"},
              {"id":12,"pId":207,"name":"四十里湾生态保护区","ifNode":1},
              {"id":207,"pId":16,"name":"烟台市"},
              {"id":211,"pId":16,"name":"威海市"},
              {"id":32,"pId":211,"name":"小石岛国家级海洋特别保护区","ifNode":1}
            ];	
var treeNodes = [   
                 {"id":1, "pId":0, "name":"test1"},   
                 {"id":11, "pId":1, "name":"test11"},   
                 {"id":12, "pId":1, "name":"test12"},   
                 {"id":111, "pId":11, "name":"test111"},   
             ];   
            
var roleid;
function deleRole(){
	
	
}

function saveRoleMenuUser(){
	if(roleid==null||roleid<1){
		alert("请选择角色");
		return ;
	}
	//获得人员列表
	var treeObj = $.fn.zTree.getZTreeObj("tree");
	var nodes = treeObj.getCheckedNodes(true);
	var userIds = "0";
	for(x in nodes){
		userIds = userIds + "," + nodes[x].id;
	}
	if(userIds == "0"){
		alert("请选择人员列表");
		return ;
	}
	$(".btn btn-primary").attr('disabled',"true");
	if(mtype==1){//菜单权限保存
		//获得菜单列表
		var menutreeObj = $.fn.zTree.getZTreeObj("mtree");
		var menunodes = menutreeObj.getCheckedNodes(true);
		var menuIds = "0";
		for(x in menunodes){
			menuIds = menuIds + "," + menunodes[x].id;
		}
		if(menuIds == "0"){
			alert("请选择菜单列表");
			return ;
		}
		
		//开始保存
		var queryParam = new Object();
		queryParam.id = roleid;
		queryParam.userIds = userIds;
		queryParam.menuIds = menuIds;
		$.ajax({
	        url: '${ctx}/saveRoleUserMenu.do', //url  action是方法的名称
	        data: queryParam,
	        type: 'POST',
	        dataType: "json", //可以是text，如果用text，返回的结果为字符串；如果需要json格式的，可是设置为json
	        ContentType: "application/json; charset=utf-8",
	        success: function(data) {
	        	 $(".btn btn-primary").removeAttr("disabled"); 
	            //zNodes = data;
	        	alert(data);
	        },
	        error: function(msg) {
	        	 $(".btn btn-primary").removeAttr("disabled"); 
	            alert(msg);
	        }
		});  
	}else if (mtype==2){ //站点权限保存
		var menutreeObj = $.fn.zTree.getZTreeObj("mtree");
		var menunodes = menutreeObj.getCheckedNodes(true);
		var stationIds = "0";
		for(x in menunodes){
			stationIds = stationIds + "," + menunodes[x].id;
		}
		if(stationIds == "0"){
			alert("请选择站点列表");
			return ;
		}
		//开始保存
		var queryParam = new Object();
		queryParam.id = roleid;
		queryParam.userIds = userIds;
		queryParam.stationIds = stationIds;
		$.ajax({
	        url: '${ctx}/saveRoleUserStation.do', //url  action是方法的名称
	        data: queryParam,
	        type: 'POST',
	        dataType: "json", //可以是text，如果用text，返回的结果为字符串；如果需要json格式的，可是设置为json
	        ContentType: "application/json; charset=utf-8",
	        success: function(data) {
	        	 $(".btn btn-primary").removeAttr("disabled"); 
	            //zNodes = data;
	        	alert(data);
	        },
	        error: function(msg) {
	        	 $(".btn btn-primary").removeAttr("disabled"); 
	            alert(msg);
	        }
		});  
	}else if(mtype==3){
		var menutreeObj = $.fn.zTree.getZTreeObj("mtree");
		var menunodes = menutreeObj.getCheckedNodes(true);
		var menuId = "";
		for(x in menunodes){
			menuId =  menunodes[x].id;
		}
		/* if(menuId.length<1){
			alert("请选择首页的菜单");
			return;
		} */
		//开始保存首页菜单角色权限
		var queryParam = new Object();
		queryParam.id = roleid;
		queryParam.userIds = userIds;
		queryParam.menuIds = menuId;
		$.ajax({
	        url: '${ctx}/saveFirstMenuRole.do', //url  action是方法的名称
	        data: queryParam,
	        type: 'POST',
	        dataType: "json", //可以是text，如果用text，返回的结果为字符串；如果需要json格式的，可是设置为json
	        ContentType: "application/json; charset=utf-8",
	        success: function(data) {
	        	 $(".btn btn-primary").removeAttr("disabled"); 
	            //zNodes = data;
	        	alert(data);
	        },
	        error: function(msg) {
	        	 $(".btn btn-primary").removeAttr("disabled"); 
	            alert(msg);
	        }
		});
	}
}
</script>
</html>
	