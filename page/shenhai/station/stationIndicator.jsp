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

</head>
<body ng-app="myApp" ng-controller="customersCtrl" >
	<script src="${ctx}/resources/common/js/common.js" type="text/javascript"></script>
	<script src="${ctx }/resources/My97DatePicker/WdatePicker.js"></script>

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
						<div style="word-wrap:break-word; overflow:hidden;">
					<ul class="seachform">
					<li><label>模糊查询</label>
					    <div class="vocation">
						    <input type="text" ng-model="code"/>
					    </div>
				    </li>
				    <li><label>&nbsp;</label><input name="" type="button" class="btn btn-primary" ng-click="query()" value="查询"/></li>
				    <li><label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				                     </label><input name="" type="button" class="btn btn-primary" onclick="saveRoleMenuUser()" value="保存"/></li>
				    </ul>
				    </div>
				    
				    <div class="col_1">
				    	<div class="col-md-3 ">
				    		<div ui-grid="gridOptions" class="gridStylerole" ui-grid-selection style="width:100%"></div>
				    	</div>
				    	<div class="col-md-3">
				    		<div class="box border green" style="height:700px">
				    			<div class="box-title">
				    				<h4>设备参数列表</h4>
				    			</div>
				    			<div class="box-body" style="background-color: #F5F6F6">
				    				<ul id="tree" class="ztree" style="height:100%; overflow-x :auto; overflow-y :no"></ul>
				    			</div>
				    		</div>
				    	</div>
				    	<div class="clearfix"> </div>
				    </div>
			</div>
	</div>		
	</section>
		<link rel="stylesheet" href="${ctx }/resources/zTree/css/zTreeStyle/zTreeStyle.css" type="text/css">
		<script type="text/javascript" src="${ctx }/resources/zTree/js/jquery.ztree.core-3.5.js"></script>
		<script type="text/javascript" src="${ctx }/resources/zTree/js/jquery.ztree.excheck-3.5.js"></script>
<script type="text/javascript" charset="UTF-8">
var myApp = angular.module('myApp',['ngDialog','ui.bootstrap','ui.grid','ui.grid.resizeColumns','ui.grid.selection']);
var row;
var col;
var station;
var mtype;
myApp.controller('customersCtrl',function($scope,$http,ngDialog,$modal){
	//添加一下内容防止输出乱码
	$http.defaults.headers.post['Content-Type'] = 'application/json;charset=utf-8';  
	$http.defaults.headers.post['Accept'] = 'application/json, text/javascript, */*; q=0.01';  
	$http.defaults.headers.post['X-Requested-With'] = 'XMLHttpRequest';  
	//定义选中的角色
	$scope.mySelections = []; //获得当前选中的行
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
		      		station = row.entity;
		      		queryParam = {
		      				stationId:station.id
		      		};
		      		
		      		
		      		var t = $("#tree");
		      		$.ajax({
		      	        url: '${ctx}/getDeiviceIndicatorsByStation.do', //url  action是方法的名称
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
		    	  /* role = row.entity;
		          console.log(role); */
		        });
		    }
		  };
	$scope.query=function(){
		$(".btn btn-primary").attr('disabled',"true");
		var pData = {stationName:$scope.code}; 
		$http({
			 method:'POST',
			 url:'${ctx}/getStation4DeviceIndicator.do',
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
		     });
	};
	$scope.query();
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

function saveRoleMenuUser(){
	if(station==null||station.id<1){
		alert("请选择站点");
		return ;
	}
	//获得设备参数列表
	var indicatorIds = "0#0";
	var treeObj = $.fn.zTree.getZTreeObj("tree");
	var nodes = treeObj.getCheckedNodes(true);
	for(x in nodes){
		var iscontaintest = nodes[x].id.indexOf("#")==-1?false:true;
		if(iscontaintest){
			indicatorIds = indicatorIds + "," + nodes[x].id;
		}
	}
	if(indicatorIds == "0#0"){
		alert("请选择有效的参数列表");
		return ;
	}
	var queryParam = new Object();
	queryParam.stationId = station.id;
	queryParam.indicatorIds = indicatorIds;
	$(".btn btn-primary").attr('disabled',"true");
	$.ajax({
        url: '${ctx}/saveStationDeviceIndicator.do', //url  action是方法的名称
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
	
	return;
}
</script>
</body>
</html>
	