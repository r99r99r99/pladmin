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
	//定义选中的角色
	$scope.mySelections = []; //获得当前选中的行
	//初始化角色类型
	var par = '0010';
	var param = {parentCode:par}; 
	
	$http({
   		 method:'POST',
			 url:'getPublicList.do',
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
		      		queryParam.stationId = roleid;
		      		queryParam.type = $scope.type;
		      		mtype = $scope.type;  //获得当前角色的类型
		      		
		      		//给人员树赋值
		      		var t = $("#tree");
		      		$.ajax({
		      	        url: 'getUsers4StationSms.do', //url  action是方法的名称
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
		    exporterCsvFilename: '人员管理',
		    getRowIdentity:function(row){
		    	console.log(row);
		    },
		    onRegisterApi: function(gridApi){
		      $scope.gridApi = gridApi;
		      gridApi.selection.on.rowSelectionChanged($scope,function(row){
		    	  role = row.entity;
		        });
		    }
		  };
	$scope.query=function(){
		$(".btn-primary").attr('disabled',"true");
		var type = $scope.type;
		var pData = {type:type}; 
		$http({
			 method:'POST',
			 url:'showStationList4Sms.do',
			 params:pData})
			 .success(function(response){
				 $(".btn-primary").removeAttr("disabled"); 
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
			$(".btn-primary").attr('disabled',"true");
			var queryParam = new Object();
			queryParam.id = roleid;
			$http({
				 method:'POST',
				 url:'${ctx}/deleRole.do',
				 params:queryParam})
				 .success(function(response){
					 $(".btn-primary").removeAttr("disabled"); 
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


function saveRoleMenuUser(){
	//alert(111);
	if(roleid==null||roleid<1){
		alert("请选择站点");
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
	$(".btn-primary").attr('disabled',"true");
	
	var queryParam = new Object();
	queryParam.stationId = roleid;
	queryParam.userIds = userIds;
	queryParam.type = mtype;
	
	$.ajax({
        url: 'saveSmsStationSetting.do', //url  action是方法的名称
        data: queryParam,
        type: 'POST',
        dataType: "json", //可以是text，如果用text，返回的结果为字符串；如果需要json格式的，可是设置为json
        ContentType: "application/json; charset=utf-8",
        success: function(data) {
        	 $(".btn-primary").removeAttr("disabled"); 
            //zNodes = data;
        	alert(data.message);
        },
        error: function(msg) {
        	 $(".btn-primary").removeAttr("disabled"); 
            alert(msg);
        }
	});
}