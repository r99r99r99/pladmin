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
		    exporterCsvFilename: '设备列表',
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
			 url:'showDevices.do',
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
    var ModalInstanceCtrl = function ($scope, $modalInstance,$http,ngDialog) {
    	$http.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded;charset=utf-8';  
    	$http.defaults.headers.post['Accept'] = 'application/json, text/javascript, */*; q=0.01';  
    	$http.defaults.headers.post['X-Requested-With'] = 'XMLHttpRequest'; 
    	
    	//为菜单列表添加数据
    	if(mtype == 2){
	    	$scope.m = pub;
    	}
    	var dp = $scope.m;
   	 	$http({
	   		 method:'POST',
				 url:'getIndicatorList4Tree.do',
				 params:dp,
				 headers: { 'Content-Type': 'application/json; charset=UTF-8'}
				 })
				 .success(function(response){
					 $scope.data = response;
	   	 }); 	
   	 $scope.selectOnly1Or2 = function(item, selectedItems) {
 	    if (selectedItems  !== undefined && selectedItems.length >= 40) {
 	      return false;
 	    } else {
 	      return true;
 	    }
 	};
    	$scope.save = function(){
    		var ids = "0";
    		angular.forEach($scope.indicators, function ( item ) {
    			ids = ids +","+item.id;
    	      });
    		$scope.m.indicatorIds = ids;
    		var param = $scope.m;
    		//如果执行修改操作时
    		if(mtype==2){
    			 $http({
        	   		 method:'POST',
        				 url:'saveDeviceChange.do',
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
       				 url:'saveNewDevice.do',
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