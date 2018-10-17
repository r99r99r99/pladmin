var myApp = angular.module('myApp',['ui.grid', 'ui.grid.exporter','ui.grid.pagination',
                                    'ui.grid.resizeColumns','ui.grid.selection'
                                    ,'ngDialog','ui.bootstrap']); 
var row;
var col;
var pub;
var mtype;
var station;
myApp.controller('customersCtrl',function($scope,$http,ngDialog,$modal,i18nService){
	
	//添加一下内容防止输出乱码
	$http.defaults.headers.post['Content-Type'] = 'application/json;charset=utf-8';  
	$http.defaults.headers.post['Accept'] = 'application/json, text/javascript, */*; q=0.01';  
	$http.defaults.headers.post['X-Requested-With'] = 'XMLHttpRequest';
    
	//$scope.title = "";
	//查询条件初始化
	var stationParam = "";
	$http({
		 method:'POST',
		 url:'systemQuery_info.do',
		 params:stationParam})
		 .success(function(response){
			  $scope.u = response;
			  //根据获得的STATION,查询出当前站点包含的设备列表
			  
			  var deviceParam = {id:$scope.u.stationId};
				$http({
					 method:'POST',
					 url:'getDevices4Station4System.do',
					 params:deviceParam})
					 .success(function(response){
						 $scope.deviceList = response;
						 $scope.u.deviceId = $scope.deviceList[0].id;
						 $scope.query();
						 
					 });
			  
	     });
	
	
	//开始分页信息
	$scope.gridOptions = {
			enableRowSelection:true,
			rowTemplate: "<div ng-dblclick=\"grid.appScope.onDblClick(row)\" ng-repeat=\"(colRenderIndex, col) in colContainer.renderedColumns track by col.colDef.name\" class=\"ui-grid-cell\" ng-class=\"{ 'ui-grid-row-header-cell': col.isRowHeader }\" ui-grid-cell ></div>",
			appScopeProvider: { 
		          onDblClick : function(row) {
		        	  mtype = 2;  //2 代表编辑对话框
		          	  station = row.entity;
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
		    exporterCsvFilename: '系统数据',
		    exporterCsvLinkElement: angular.element(document.querySelectorAll(".custom-csv-link-location")),
		    onRegisterApi: function(gridApi){
		      $scope.gridApi = gridApi;
		      gridApi.selection.on.rowSelectionChanged($scope,function(row){
		    	  firstpage = row.entity;
		      });
		    }
		  };
	//查询数据
	 $scope.query = function(){
		 var endDate = $('#endDate').val();
		 var startDate = $('#startDate').val();
		 if(ifBeginLaterEnd(startDate,endDate)){
				$(".btn-primary").removeAttr("disabled");
				return;
		};
		 $(".btn-primary").attr('disabled',"true");
		 $scope.u.beginDate = startDate;
		 $scope.u.endDate = endDate;
		 var queryParam = $scope.u;
		 
		 $http({
			 method:'POST',
			 url:'showSystemQueryInfo.do',
			 params:queryParam}) 
			 .success(function(response){
				  $(".btn-primary").removeAttr("disabled"); 
				  row = response.rows;
				  col = response.cols;
				  $scope.gridOptions.columnDefs = col;
				  $scope.gridOptions.data = row;
		 });
	 };
   
});