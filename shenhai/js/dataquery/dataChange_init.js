var myApp = angular.module('myApp',['ui.grid', 'ui.grid.exporter','ui.grid.pagination',
                                    'ui.grid.resizeColumns','ui.grid.selection'
                                    ,'ngDialog','ui.bootstrap','ui.grid.edit','multi-select-tree']); 
var row;
var col;
var pub;
var mtype;
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
			 $scope.stationList = response.stations;
			 $scope.u.stationId = $scope.stationList[0].id;
			 $scope.updateStationStatus();
	     });
	
	
	$scope.updateStationStatus=function(){
	 	$(".scbtn").attr('disabled',"true");
		//根据站点得到下属的参数的列表
		var dparam = {
				id:$scope.u.stationId
		};
		$http({
			 method:'POST',
			 url:'getIndicators4StationDevice4Show.do',
			 params:dparam}) 
			 .success(function(response){
				 $scope.u.indicators= response;
				 setTimeout(function (){
						$scope.query();
				 }, 1000);
		 });
	};

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
		    onRegisterApi: function(gridApi){
		      $scope.gridApi = gridApi;
		      gridApi.edit.on.afterCellEdit($scope,function(rowEntity, colDef, newValue, oldValue){
		    	$scope.save(rowEntity,colDef, newValue, oldValue);
		      });
		    }
		  };

	$scope.save = function(rowEntity,colDef,newValue,oldValue){
		var collect_time = rowEntity.collect_time;
		if(collect_time==""){
			alert("请填写采集时间");
			return ;
		}
		if(confirm("是否确认修改")){
			//判断修改内容,是数值还是备注
			if(colDef.field=="data"){
				var param={
						id:rowEntity.id,
						stationId:$scope.u.stationId,
						deviceId:$scope.u.deviceId,
						indicatorCode:$scope.u.indicatorCode,
						collect_time:rowEntity.collect_time,
						newData:newValue,
						oldData:oldValue
				};
				$http({
					 method:'POST',
					 url:'saveChangeData.do',
					 params:param}) 
					 .success(function(response){
						 alert(response);
						 console.log(response);
				 });
			}/*else if(colDef.field="markCode"){
				var param={
						id:rowEntity.id,
						stationId:$scope.u.stationId,
						deviceId:$scope.u.deviceId,
						indicatorCode:$scope.u.indicatorCode,
						collect_time:rowEntity.collect_time,
						mark_code:newValue
				};
				$http({
					 method:'POST',
					 url:'saveChangeMark.do',
					 params:param}) 
					 .success(function(response){
						 alert(response);
						 console.log(response);
				 });
			}*/
		}
		
	};
	$scope.addRow = function(){
		$scope.gridOptions.data.unshift({
			id:0,
			collect_time:'',
			data:0
		});
	};
	$scope.query = function(){
		 var endDate = $('#endDate').val();
		 var startDate = $('#startDate').val();
		 if(ifBeginLaterEnd(startDate,endDate)){
				$(".btn-primary").removeAttr("disabled");
				return;
		};
		if($scope.u.indicatorIds==null||$scope.u.indicatorIds==""){
			alert("请选择参数");
			return ;
		}
		var indicatorIds = "0#0";
		
		angular.forEach($scope.u.indicatorIds, function ( item ) {
			indicatorIds = indicatorIds +","+item.id;
	    });
		var queryParam = {
				stationId:$scope.u.stationId,
				indicatorIds:indicatorIds,
				beginDate:startDate,
				endDate:endDate
		};
		console.log(queryParam);
		$(".btn-primary").attr('disabled',"true");
		 $http({
			 method:'POST',
			 url:'showDataChangeInfo.do',
			 params:queryParam}) 
			 .success(function(response){
				 $scope.u.stationId = response.stationId;
				 $scope.u.deviceId = response.device.id;
				 $scope.u.indicatorCode = response.indicator.code;
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