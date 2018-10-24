var myApp = angular.module('myApp',['ui.grid', 'ui.grid.exporter','ui.grid.pagination',
                                    'ui.grid.resizeColumns','ui.grid.selection'
                                    ,'ngDialog','ui.bootstrap','multi-select-tree']); 
var row;
var col;
var pub;
var mtype;
var station;
myApp.controller('customersCtrl',function($scope,$http,ngDialog,$modal){
	
	//添加一下内容防止输出乱码
	$http.defaults.headers.post['Content-Type'] = 'application/json;charset=utf-8';  
	$http.defaults.headers.post['Accept'] = 'application/json, text/javascript, */*; q=0.01';  
	$http.defaults.headers.post['X-Requested-With'] = 'XMLHttpRequest';
    $scope.u={};
	//$scope.title = "";
	//查询条件初始化
	var stationParam = "";
	$http({
		 method:'POST',
		 url:'dataChange_info.do',
		 params:stationParam})
		 .success(function(response){
			 $scope.u=response;
	     });
	
	
	//开始分页信息
	$scope.gridOptions = {
			enableRowSelection:true,
			rowTemplate: "<div ng-dblclick=\"grid.appScope.onDblClick(row)\" ng-repeat=\"(colRenderIndex, col) in colContainer.renderedColumns track by col.colDef.name\" class=\"ui-grid-cell\" ng-class=\"{ 'ui-grid-row-header-cell': col.isRowHeader }\" ui-grid-cell ></div>",
			appScopeProvider: { 
		          onDblClick : function(row) {
		        	 
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
		    exporterCsvFilename: '综合查询',
		    exporterCsvLinkElement: angular.element(document.querySelectorAll(".custom-csv-link-location")),
		  };

	$scope.query = function(){
		 var endDate = $('#endDate').val();
		 var startDate = $('#startDate').val();
		 if(ifBeginLaterEnd(startDate,endDate)){
				$(".btn-primary").removeAttr("disabled");
				return;
		};
		var indicatorIds = "";
		
		angular.forEach($scope.u.indicatorIds, function ( item ) {
			indicatorIds = item.id;
	    });
		var queryParam = {
				stationId:$scope.u.stationId,
				indicatorIds:indicatorIds,
				beginDate:startDate,
				endDate:endDate
		};
		$(".btn-primary").attr('disabled',"true");
		 $http({
			 method:'POST',
			 url:'showdataChangeLog.do',
			 params:queryParam}) 
			 .success(function(response){
				 $(".btn-primary").removeAttr("disabled"); 
				  row = response.page.rows;
				  col = response.page.cols;
				  $scope.gridOptions.columnDefs = col;
				  $scope.gridOptions.data = row;
		 });
	};
   
	setTimeout(function (){
		$scope.query();
	}, 1000);
});