var myApp = angular.module('myApp',['ngDialog','ui.bootstrap','ui.grid','ui.grid.resizeColumns','ui.grid.selection']);
var row;
var col;
var pub;
var mtype;
var level; //定义层级
var levelType; 
myApp.controller('customersCtrl',function($scope,$http,ngDialog,$modal){
	//添加一下内容防止输出乱码
	$http.defaults.headers.post['Content-Type'] = 'application/json;charset=utf-8';  
	$http.defaults.headers.post['Accept'] = 'application/json, text/javascript, */*; q=0.01';  
	$http.defaults.headers.post['X-Requested-With'] = 'XMLHttpRequest'; 
	$scope.u={};
	//定义选中的角色
	$scope.mySelections = []; //获得当前选中的行
	//初始化角色类型
	var par = '0004';
	var param = {parentCode:par}; 
	
	$http({
   		 method:'POST',
			 url:'getPublicList.do',
			 params:param})
			 .success(function(response){
				  $scope.isList = response;
				  $scope.isList.unshift({classId:2,value:'全部'});
				  $scope.u.isactive = $scope.isList[0].classId;
				  $scope.query();
   	});
	//左侧功能区列表
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
		        	  level = {};
		        	  pub = row.entity;
		        	  $scope.showDetail();
		          }
		    },
		    headerRowHeight: 50,
			enableColumnResizing:true,
		    enableGridMenu: false,
		    enableSelectAll: true,
		    exporterCsvFilename: '功能区管理.csv',
		    getRowIdentity:function(row){
		    	console.log(row);
		    },
		    onRegisterApi: function(gridApi){
		      $scope.gridApi = gridApi;
		      gridApi.selection.on.rowSelectionChanged($scope,function(row){
		    	  level = {};
		    	  pub = row.entity;
		    	  $scope.showDetail();
		      });
		    }
		  };
	
	//功能区的层级
	$scope.gridOptions2 = {
			enableRowSelection:true,
			rowTemplate: "<div ng-dblclick=\"grid.appScope.onDblClick(row)\" ng-repeat=\"(colRenderIndex, col) in colContainer.renderedColumns track by col.colDef.name\" class=\"ui-grid-cell\" ng-class=\"{ 'ui-grid-row-header-cell': col.isRowHeader }\" ui-grid-cell ></div>",
			multiSelect:false,
		    modifierKeysToMultiSelect :false,
		    noUnselect:true,
		    enableRowSelection: true,
		    enableRowHeaderSelection:false,
			appScopeProvider: { 
		          onDblClick : function(row) {
		        	 level = row.entity;
		        	 levelType = 2;  //2为编辑
		        	 $scope.editLevel();
		          }
		    },
		    headerRowHeight: 50,
			enableColumnResizing:true,
		    enableGridMenu: false,
		    enableSelectAll: true,
		    getRowIdentity:function(row){
		    },
		    onRegisterApi: function(gridApi){
		    	gridApi.selection.on.rowSelectionChanged($scope,function(row){
		    		level = row.entity;
			      });
		    }
		  };
	
	$scope.showLevelList = function(){
		 var levelParam = {domainId:pub.id};
	  	  $http({
			 method:'POST',
			 url:'showLevelListByDomain.do',
			 params:levelParam})  
			 .success(function(response){
				 $scope.gridOptions2.data = response.rows;
				 $scope.gridOptions2.columnDefs = response.cols;
		     });
	};
	
	$scope.showDetail=function(){
		 //展现站点列表树
  	  var queryParam = {id:pub.id};
  	  $.ajax({
		        url: 'getStationTreeByDomain.do', //url  action是方法的名称
		        data: queryParam,
		        type: 'POST',
		        dataType: "json", //可以是text，如果用text，返回的结果为字符串；如果需要json格式的，可是设置为json
		        ContentType: "application/json; charset=utf-8",
		        success: function(data) {
		            //zNodes = data;
		        	var t = $("#tree");
		        	t = $.fn.zTree.init(t, setting, data);
		        },
		        error: function(msg) {
		            alert("失败");
		        }
			}); 
  	  
  	$scope.showLevelList();
  	  
	};
	
	
	$scope.query=function(){
		$(".btn-primary").attr('disabled',"true");
		var pData = $scope.u; 
		$http({
			 method:'POST',
			 url:'showDomainList.do',
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
		     });
	};
	
	//新增,弹出编辑框
	$scope.addRole = function(){
		methodtype=1
		$scope.showEdit();
	};
	
	//编辑,弹出编辑框
	$scope.editRole = function(){
		methodtype = 2;
		if(pub==null){
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
	$scope.addLevel = function(){
		levelType = 1;//1代表新增
		$scope.editLevel();
	};
	$scope.editLevel = function(){
		if(pub==null){
			alert("请选中功能区");
			return;
		}
		level.domainId = pub.id;
		var modalInstance = $modal.open({  
            templateUrl: 'level.html',  
            controller: LevelCtrl
        });  
    	modalInstance.opened.then(function(){//模态窗口打开之后执行的函数  
            console.log('modal is opened');  
        });  
        modalInstance.result.then(function (result) { 
        	 alert(result);
        	 $scope.showLevelList();
             console.log(result);  
        }, function (reason) {  
            console.log(reason);//点击空白区域，总会输出backdrop click，点击取消，则会暑促cancel  
        });
	};
	
	$scope.deleRole = function(){
		if(pub==null){
			alert("请先选择要删除的功能区");
			return ;
		}
		if(confirm("确定要停用该功能区")){
			$(".btn-primary").attr('disabled',"true");
			var queryParam = {id:pub.id}
			$http({
				 method:'POST',
				 url:'deleDomain.do',
				 params:queryParam})
				 .success(function(response){
					 $(".btn-primary").removeAttr("disabled"); 
					  alert(response);
					  $scope.query();
			     });
		}
	}
	
	$scope.deleLevel = function(){
		console.log(level);
		if(level==null||level.id==null){
			alert("请先选择要删除的层级");
			return ;
		}
		if(confirm("确定要停用该层级")){
			$(".btn-primary").attr('disabled',"true");
			var queryParam = {id:level.id}
			$http({
				 method:'POST',
				 url:'deleDomainLevel.do',
				 params:queryParam})
				 .success(function(response){
					 $(".btn-primary").removeAttr("disabled"); 
					  alert(response);
					  $scope.showLevelList();
			     });
		}
	}
	
	var LevelCtrl = function ($scope, $modalInstance,$http) {
		$http.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded;charset=utf-8';  
    	$http.defaults.headers.post['Accept'] = 'application/json, text/javascript, */*; q=0.01';  
    	$http.defaults.headers.post['X-Requested-With'] = 'XMLHttpRequest';  
    	//初始化参数
    	$scope.level = {};
    	$scope.level = level;
    	$scope.savelevel=function(){
    		var levelParam = $scope.level;
    		//新增操作时
    		if(levelType==1){
    			$http({
       	   		 method:'POST',
       				 url:'saveNewDomainLevel.do',
       				 params:levelParam,
       				 headers: { 'Content-Type': 'application/json; charset=UTF-8'}
       				 })
       				 .success(function(response){
   				    	 $modalInstance.close(response);
       	   	     }); 	
    		}
    		
    		//修改操作
    		if(levelType==2){
    			$http({
       	   		 method:'POST',
       				 url:'updateDomainLevel.do',
       				 params:levelParam,
       				 headers: { 'Content-Type': 'application/json; charset=UTF-8'}
       				 })
       				 .success(function(response){
   				    	 $modalInstance.close(response);
       	   	     }); 	
    		}
    	};
	};
	var ModalInstanceCtrl = function ($scope, $modalInstance,$http) {
		$http.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded;charset=utf-8';  
    	$http.defaults.headers.post['Accept'] = 'application/json, text/javascript, */*; q=0.01';  
    	$http.defaults.headers.post['X-Requested-With'] = 'XMLHttpRequest';  
    	$scope.m={};
    	//获得启用状态
    	var par = '0004';
    	var cparam = {parentCode:par}; 
    	$http({
       		 method:'POST',
    			 url:'getPublicList.do',
    			 params:cparam})
    			 .success(function(response){
    				  $scope.isactivelist = response;
    				  if(methodtype==2){
    					  $scope.m = pub;
    				  }else if(methodtype==1){
    					  $scope.m.isactive=$scope.isactivelist[0].classId;
    				  }
       	});
    	
    	//提交操作
    	$scope.save = function(){
    		var param = $scope.m;
    		//新增操作时
    		if(methodtype==1){
    			$http({
       	   		 method:'POST',
       				 url:'saveNewDomain.do',
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
          				 url:'saveChangeDomain.do',
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
	if(pub==null){
		alert("请选择功能区");
		return ;
	}
	//获得人员列表
	var treeObj = $.fn.zTree.getZTreeObj("tree");
	var nodes = treeObj.getCheckedNodes(true);
	var stationIds = "0";
	for(x in nodes){
		stationIds = stationIds + "," + nodes[x].id;
	}
	if(stationIds == "0"){
		alert("请选择站点列表");
		return ;
	}
	
	
	$(".btn-primary").attr('disabled',"true");
	var queryParam ={
			id:pub.id,
			stationIds:stationIds
	};
	$.ajax({
        url: 'saveDomainStationIndicator.do', //url  action是方法的名称
        data: queryParam,
        type: 'POST',
        dataType: "json", //可以是text，如果用text，返回的结果为字符串；如果需要json格式的，可是设置为json
        ContentType: "application/json; charset=utf-8",
        success: function(data) {
        	 $(".btn-primary").removeAttr("disabled"); 
            //zNodes = data;
        	alert(data);
        },
        error: function(msg) {
        	 $(".btn-primary").removeAttr("disabled"); 
            alert(msg);
        }
	}); 
	
}