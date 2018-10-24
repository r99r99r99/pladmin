
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
    //统计口径
	$scope.typeList = [{
        title: '按日',
        id: 1
    }, {
    	title: '按周',
        id: 2
    }, {
    	title: '按月',
        id: 3
    }];
	//统计单位
	$scope.unitList = [{
        title: '按吨',
        id: 't'
    }, {
    	title: '按千克',
        id: 'kg'
    }, {
    	title: '按克',
        id: 'g'
    }];
	//查询条件初始化
	var stationParam = "";
	$http({
		 method:'POST',
		 url:'pollutant_init.do',
		 params:stationParam})
		 .success(function(response){
			 console.log(response);
			  $scope.u = response;
	     });
	
	
	//开始分页信息
	$scope.gridOptions = {
			enableRowSelection:true,
			rowTemplate: "<div ng-dblclick=\"grid.appScope.onDblClick(row)\" ng-repeat=\"(colRenderIndex, col) in colContainer.renderedColumns track by col.colDef.name\" class=\"ui-grid-cell\" ng-class=\"{ 'ui-grid-row-header-cell': col.isRowHeader }\" ui-grid-cell ></div>",
			appScopeProvider: { 
		          onDblClick : function(row) {
		        	  mtype = 2;  //2 代表编辑对话框
		          	  station = row.entity;
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
		    exporterCsvFilename: '入海污染量',
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
		 var beginDate = document.getElementById("startDate").value;
		 var endDate = document.getElementById("endDate").value;
		 if($scope.u.indicatorIds==null||$scope.u.indicatorIds==""){
				alert("请选择参数");
				return ;
		}
		 var indicatorIds = "0#0";
			
		angular.forEach($scope.u.indicatorIds, function ( item ) {
				indicatorIds = indicatorIds +","+item.id;
		});
		
		var queryParam = {
				indicatorIds:indicatorIds,
				beginDate:beginDate,
				endDate:endDate,
				type:$scope.u.type,
				unit:$scope.u.unit
		};
		$http({
			 method:'POST',
			 url:'showPollutantInfo.do',
			 params:queryParam}) 
			 .success(function(response){
				  $(".btn-primary").removeAttr("disabled"); 
				  row = response.rows;
				  col = response.cols;
				  $scope.gridOptions.columnDefs = col;
				  $scope.gridOptions.data = row;
		 });
		
	 };
	 setTimeout(function (){
			$scope.query();
		}, 1000);
});