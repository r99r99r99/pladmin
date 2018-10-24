var myApp = angular.module('myApp',['ui.grid', 'ui.grid.exporter','ui.grid.pagination',
                                    'ui.grid.resizeColumns','ui.grid.selection'
                                    ,'ngDialog','ui.bootstrap','multi-select-tree']); 
var row;
var col;
var pub;
var mtype;
myApp.controller('customersCtrl',function($scope,$http,ngDialog,$modal){
	
	//添加一下内容防止输出乱码
	$http.defaults.headers.post['Content-Type'] = 'application/json;charset=utf-8';  
	$http.defaults.headers.post['Accept'] = 'application/json, text/javascript, */*; q=0.01';  
	$http.defaults.headers.post['X-Requested-With'] = 'XMLHttpRequest';  
	
	
	//生成状态列表
	$scope.activelist = [{
        name: '全部',
        value: 2
    }, {
        name: '启用',
        value: 1
    }, {
        name: '禁用',
        value: 0
    }];
	//得到有效的参数组的结合
	var groupDate = {isactive:1};
	$http({
		 method:'POST',
		 url:'getIndicatorGroups.do',
		 params:groupDate})
		 .success(function(response){
			$scope.indicatorGroupList = response; 
			$scope.indicatorGroupList.unshift({id:0,title:'全部'});
	});
	
	//初始化查询条件
	$scope.u = {isactive:2,groupId:0};
	//开始分页信息
	$scope.gridOptions = {
			enableRowSelection:true,
			rowTemplate: "<div ng-dblclick=\"grid.appScope.onDblClick(row)\" ng-repeat=\"(colRenderIndex, col) in colContainer.renderedColumns track by col.colDef.name\" class=\"ui-grid-cell\" ng-class=\"{ 'ui-grid-row-header-cell': col.isRowHeader }\" ui-grid-cell ></div>",
			appScopeProvider: { 
		          onDblClick : function(row) {
		        	  mtype = 2;  //2 代表编辑对话框
		            	pub = row.entity;
		          	  $scope.showEdit();
		          }
		    },
		    multiSelect:false,
		    modifierKeysToMultiSelect :false,
		    noUnselect:true,
		    enableRowSelection: true,
		    enableRowHeaderSelection:false,
		    headerRowHeight: 50,
		    paginationPageSizes: [25, 50, 100],
			paginationPageSize: 25,
			enableColumnResizing:true,
		    enableGridMenu: true,
		    enableSelectAll: true,
		    exporterCsvFilename: '参数列表',
		    exporterCsvLinkElement: angular.element(document.querySelectorAll(".custom-csv-link-location")),
		    onRegisterApi: function(gridApi){
		      $scope.gridApi = gridApi;
		      gridApi.selection.on.rowSelectionChanged($scope,function(row){
		    	  firstpage = row.entity;
		      });
		    }
		  };
	//分页信息结束
    $scope.query=function(){
    	$(".btn-primary").attr('disabled',"true");
    	var pData = $scope.u; 
    	$http({
    		 method:'POST',
			 url:'showIndicators.do',
			 params:pData})
			 .success(function(response){
				 $(".btn-primary").removeAttr("disabled"); 
				 row = response.rows;
				  col = response.cols;
				  $scope.gridOptions.columnDefs = col;
				  $scope.gridOptions.data = row;
    	     });
    };
	$scope.query();
	
    //点击新增按钮,弹出新增对话框
    $scope.addUser = function(){
    	mtype = 1;  //1 代表新增对话框
    	$scope.showEdit();
    };
    
    //弹出编辑框
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
    
    //弹出页面打开后的操作
    var ModalInstanceCtrl = function ($scope, $modalInstance,$http) {
    	$http.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded;charset=utf-8';  
    	$http.defaults.headers.post['Accept'] = 'application/json, text/javascript, */*; q=0.01';  
    	$http.defaults.headers.post['X-Requested-With'] = 'XMLHttpRequest'; 
    	
    	$scope.m = {isactive:1};
    	if(mtype == 2){
	    	$scope.m = pub;
    	}
    	//生成状态列表
    	$scope.isactivelist = [{
            name: '启用',
            value: 1
        }, {
            name: '禁用',
            value: 0
        }];
    	//获得分组列表
    	var groupDate = {isactive:1};
    	$http({
    		 method:'POST',
    		 url:'getIndicatorGroups.do',
    		 params:groupDate})
    		 .success(function(response){
    			$scope.groupList = response; 
    			//$scope.groupList.unshift({id:0,title:'全部'});
    			if(mtype==1){
    				$scope.m.groupId = $scope.groupList[0].id;
    			}
    	});
    	//获得单位列表
    	$http({
   		 method:'POST',
   		 url:'getUnitList.do',
   		 params:groupDate})
   		 .success(function(response){
   			$scope.unitList = response; 
   			//$scope.groupList.unshift({id:0,title:'全部'});
   			if(mtype==1){
   				$scope.m.unitId = $scope.unitList[0].id;
   			}
   	});
    	
    	var unitParam = {
    			id:$scope.m.unitId
    	};
    	$http({
      		 method:'POST',
      		 url:'getUnitList4Tree.do',
      		 params:unitParam})
      		 .success(function(response){
      			$scope.unitIdList = response;
      	});
    	
    	$scope.save = function(){
    		var unitId = "";
    		angular.forEach($scope.units, function ( item ) {
    			unitId = item.id;
    	      });
    		if(unitId==null||unitId==""){
    			alert("请选择关联单位");
    			return;
    		}
    		var param = $scope.m;
    		//如果执行修改操作时
    		if(mtype==2){
    			 $http({
        	   		 method:'POST',
        				 url:'saveIndicaotrChange.do',
        				 params:param,
        				 headers: { 'Content-Type': 'application/json; charset=UTF-8'}
        				 })
        				 .success(function(response){
    				    	 $modalInstance.close(response);
        	   	     }); 	
    		}
    		if(mtype==1){
    			$http({
       	   		 method:'POST',
       				 url:'saveNewIndicator.do',
       				 params:param,
       				 headers: { 'Content-Type': 'application/json; charset=UTF-8'}
       				 })
       				 .success(function(response){
   				    	 $modalInstance.close(response);
       	   	     }); 		
    		}
    		return;
    	};
    };  
});