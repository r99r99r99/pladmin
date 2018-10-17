var myApp = angular.module('myApp',['ui.grid', 'ui.grid.exporter','ui.grid.pagination',
                                    'ui.grid.resizeColumns','ui.grid.selection'
                                    ,'ngDialog','ui.bootstrap','ui.grid.edit','multi-select-tree','ui.grid.importer']); 
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
		 url:'manualDataImport_info.do',
		 params:stationParam})
		 .success(function(response){
			 $scope.u=response;
			 $scope.stationList = response.stations;
			 $scope.u.stationId = $scope.stationList[0].id;
			 setTimeout(function (){
					$scope.query();
			 }, 1000);
	     });
	
	$scope.selectOnly1Or2 = function(item, selectedItems){
		 setTimeout(function (){
				$scope.query();
		 }, 300);
	};
	
	//开始分页信息
	$scope.gridOptions = {
			enableRowSelection:true,
			rowTemplate: "<div ng-dblclick=\"grid.appScope.onDblClick(row)\" ng-repeat=\"(colRenderIndex, col) in colContainer.renderedColumns track by col.colDef.name\" class=\"ui-grid-cell\" ng-class=\"{ 'ui-grid-row-header-cell': col.isRowHeader }\" ui-grid-cell ></div>",
			appScopeProvider: { 
		          onDblClick : function(row) {
		        	 pub = row.entity;
		          }
		    },
		    multiSelect:false,	
		    modifierKeysToMultiSelect :false,
		    noUnselect:true,
		    enableRowSelection: true,
		    enableRowHeaderSelection:false,
		    headerRowHeight: 50,
			enableColumnResizing:true,
		    enableGridMenu: true,
		    enableSelectAll: true,
		    exporterCsvFilename: '综合查询',
		    importerDataAddCallback: function ( grid, newObjects ) {
		    	angular.forEach(newObjects, function(newObject){
		    		console.log(newObject);
		    		$scope.gridOptions.data.push(newObject);
		    	});
		       // $scope.data = $scope.data.concat( newObjects );
		        
		    },
		    exporterCsvLinkElement: angular.element(document.querySelectorAll(".custom-csv-link-location")),
		    onRegisterApi: function(gridApi){
		      $scope.gridApi = gridApi;
		      gridApi.edit.on.afterCellEdit($scope,function(rowEntity, colDef, newValue, oldValue){
		    	
		    	//$scope.save(rowEntity, newValue, oldValue);
		      });
		      gridApi.selection.on.rowSelectionChanged($scope,function(row){
		    	  pub = row.entity;
		      });
		    }
		  };

	$scope.save = function(){
		var param={
				stationId:$scope.u.stationId,
				indicatorCode:$scope.u.indicatorCode,
				dataText:JSON.stringify($scope.gridOptions.data)
		};
		$(".btn-primary").attr('disabled',"true");
  		$http({
	   		 method:'POST',
				 url:'saveManualDataList.do',
				 params:param,
				 headers: { 'Content-Type': 'application/json; charset=UTF-8'}
				 })
				 .success(function(response){
			    	 alert(response);
			    	 $(".btn-primary").removeAttr("disabled"); 
			    	 $scope.query();
	   	     }); 	
		
	};
	$scope.addRow = function(){
		var myDate = getNowFormatDate();
		$scope.gridOptions.data.unshift({
			id:0,
			collectTime:myDate,
			data:0
		});
	};
	
	$scope.deleRow=function(){
		if(pub==null){
			alert("请选择要删除的记录");
			return ;
		}
		if($scope.u.indicator==null||$scope.u.indicator==""){
			$(".btn-primary").removeAttr("disabled");
			alert("请选择参数");
			return ;
		}
		if(confirm("是否删除该记录")){
			var param = {
					stationId:$scope.u.stationId,
					indicatorCode:$scope.u.indicatorCode,
					collectTime:pub.collectTime,
					data:pub.data
					
			};
			 $http({
				 method:'POST',
				 url:'deleManualData.do',
				 params:param}) 
				 .success(function(response){
					 alert(response);
					 $scope.query();
			 });
		}
	};
	$scope.query = function(){
		pub = null;
		$(".btn-primary").attr('disabled',"true");
		if($scope.u.indicator==null||$scope.u.indicator==""){
			$(".btn-primary").removeAttr("disabled");
			alert("请选择参数");
			return ;
		}
		 $scope.u.indicatorCode = $scope.u.indicator[0].id;
		 var endDate = $('#endDate').val();
		 var startDate = $('#startDate').val();
		 if(ifBeginLaterEnd(startDate,endDate)){
				$(".btn-primary").removeAttr("disabled");
				return;
		};
		var queryParam = {
				stationId:$scope.u.stationId,
				indicatorCode:$scope.u.indicatorCode,
				beginDate:startDate,
				endDate:endDate
		};
		 $http({
			 method:'POST',
			 url:'showManualDataList.do',
			 params:queryParam}) 
			 .success(function(response){
				 console.log(response);
				 $(".btn-primary").removeAttr("disabled"); 
				 $scope.gridOptions.data = response.rows;
				  $scope.gridOptions.columnDefs = response.cols;
		 });
	};
   
});