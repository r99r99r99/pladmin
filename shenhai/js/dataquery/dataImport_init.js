var myApp = angular.module('myApp',['ui.grid', 'ui.grid.exporter','ui.grid.pagination',
                                    'ui.grid.resizeColumns','ui.grid.selection'
                                    ,'ngDialog','ui.bootstrap','ui.grid.edit','multi-select-tree','ui.grid.importer']); 
var row;
var col;

myApp.controller('customersCtrl',function($scope,$http,ngDialog,$modal){
	
	//添加一下内容防止输出乱码
	$http.defaults.headers.post['Content-Type'] = 'application/json;charset=utf-8';  
	$http.defaults.headers.post['Accept'] = 'application/json, text/javascript, */*; q=0.01';  
	$http.defaults.headers.post['X-Requested-With'] = 'XMLHttpRequest';
	$scope.data=[];
	//初始化参数
	 $scope.u={}; 
	//初始化站点列表
	$http({
		 method:'POST',
		 url:'getStationByUser.do',
		 params:''})
		 .success(function(response){
			 $scope.stationList = response;
			 $scope.u.stationId = $scope.stationList[0].id;
			 $scope.changeStation();
	});
	
	//根据站点初始化设备列表
	$scope.changeStation=function(){
		var param={id:$scope.u.stationId};
		$http({
			 method:'POST',
			 url:'getDevices4Station.do',
			 params:param})
			 .success(function(response){
				 $scope.deviceList = response;
				 $scope.u.deviceId = $scope.deviceList[0].id;
				 $scope.changeDevice();
		});
	};
	
	//根据站点以及设备,在表格中展现参数列表
	$scope.changeDevice=function(){
		$scope.data=[];
		$(".btn-primary").attr('disabled',"true");
		var param=$scope.u;
		$http({
			 method:'POST',
			 url:'showColsByStationDevice.do',
			 params:param})
			 .success(function(response){
				 $(".btn-primary").removeAttr("disabled"); 
				  row = response.rows;
				  col = response.cols;
				  $scope.gridOptions.columnDefs = col;
				  $scope.gridOptions.data = row;
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
		    data: 'data',
		    importerDataAddCallback: function ( grid, newObjects ) {
		        $scope.data = $scope.data.concat( newObjects );
		    },
		    onRegisterApi: function(gridApi){
		      $scope.gridApi = gridApi;
		      gridApi.edit.on.afterCellEdit($scope,function(rowEntity, colDef, newValue, oldValue){
		    	
		    	
		      });
		    }
		  };
	
	
	//新增一行
	$scope.addRow = function(){
		var newData = {};
		for(var m in col){
			var co = col[m].field;
			newData[co]="";
		}
		//$scope.gridOptions.data.unshift(newData);
		$scope.data.unshift(newData)
	};
	
	$scope.clear=function(){
		$scope.data=[];
	};
	
   //保存表单信息
	$scope.save = function(){
		$(".btn-primary").attr('disabled',"true");
		var stationId = $scope.u.stationId;
		var deviceId = $scope.u.deviceId;
		var keepGoing =true;
		var startMarkers = new Array();
		angular.forEach($scope.data, function(dat){
			if(keepGoing){
				var msg = getErrorMsg(validateYYYYMMDDHHmmss(dat.collect_time),'日期','yyyy-MM-dd HH:mm:ss');
				if(msg!=null&&msg.length>0){
					alert(msg);
					keepGoing=false;
				}
				var collect_time = dat.collect_time;
				for(var key in dat){
					var singleRow = {
							stationId:stationId,
							deviceId:deviceId,
							collect_time:collect_time
					};
					if(key!='collect_time'&&key!='$$hashKey'){
						var value = dat[key];
						if(value==null||value==""){
							value = 0;
						}
						singleRow.indicatorCode=key;
						singleRow.data=value;
						console.log(singleRow);
						startMarkers.push(singleRow);
					}
				}
			}
		});
		if(!keepGoing){
			 $(".btn-primary").removeAttr("disabled"); 
			return;
		}
		var param = {
				importString:startMarkers
		};
		$http({
			 method:'POST',
			 url:'saveImportData.do',
			 params:param}) 
			 .success(function(response){
				 $(".btn-primary").removeAttr("disabled"); 
				 alert(response);
		 });
	};
});
