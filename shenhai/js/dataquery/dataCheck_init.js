var myApp = angular.module('myApp',['ui.grid', 'ui.grid.exporter','ui.grid.pagination',
                                    'ui.grid.resizeColumns','ui.grid.selection','ngTouch'
                                    ,'ngDialog','ui.bootstrap','multi-select-tree']); 
var row;
var col;
var pub;
var mtype;
var stationId;
var deviceId;
var indicatorCode;
var inputString;
myApp.controller('customersCtrl',function($scope,$http,ngDialog,$modal,uiGridConstants){
	
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
	$scope.selections = [];
	//开始分页信息
	$scope.gridOptions = {
			enableRowSelection:true,
			rowTemplate: "<div ng-dblclick=\"grid.appScope.onDblClick(row)\" ng-repeat=\"(colRenderIndex, col) in colContainer.renderedColumns track by col.colDef.name\" class=\"ui-grid-cell\" ng-class=\"{ 'ui-grid-row-header-cell': col.isRowHeader }\" ui-grid-cell ></div>",
			appScopeProvider: { 
		          onDblClick : function(row) {
		        	mtype = 2;  //2 代表修改原有的
		          	station = row.entity;
		          	inputString = row.entity.tableName+"#"+row.entity.id;
		          	$scope.showEdit();
		          }
		    },
		    enableSelectAll: true,
		    multiSelect:true,
		    modifierKeysToMultiSelect :false,
		    enableRowHeaderSelection:true,
		    headerRowHeight: 50,
		    paginationPageSizes: [25, 50, 100],
			paginationPageSize: 25,
			enableColumnResizing:true,
		    enableGridMenu: true,
		    exporterCsvFilename: '预警告警信息',
		    exporterCsvLinkElement: angular.element(document.querySelectorAll(".custom-csv-link-location")),
		    onRegisterApi: function(gridApi){
		      $scope.gridApi = gridApi;
		      gridApi.selection.on.rowSelectionChanged($scope,function(row){
		    	  $scope.SelectedProduct = row.entity; 
		    	  warn = row.entity;
		      });
		      gridApi.selection.on.rowSelectionChangedBatch($scope,function(rows){
		    	  
		      });
		    }
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
		$(".btn-primary").attr('disabled',"true");
		 $http({
			 method:'POST',
			 url:'showMetaDataListByStationIndicator.do',
			 params:queryParam}) 
			 .success(function(response){
				 $scope.u.stationId = response.stationId;
				 $scope.u.deviceId = response.device.id;
				 $scope.u.indicatorCode = response.indicator.code;
				 stationId = $scope.u.stationId;
				 deviceId = $scope.u.deviceId;
				 indicatorCode = $scope.u.indicatorCode;
				 $(".btn-primary").removeAttr("disabled"); 
				  row = response.page.rows;
				  col = response.page.cols;
				  $scope.gridOptions.columnDefs = col;
				  $scope.gridOptions.data = row;
		 });
	};
	
   //得到选中的记录
   $scope.getSelectedRows = function() {
	        $scope.mySelectedRows = $scope.gridApi.selection.getSelectedRows();
   };
   $scope.check=function(){
	   $scope.getSelectedRows();
	   if($scope.mySelectedRows==null){
		   alert("请选择要标记的记录");
		   return;
	   }
	   inputString = "";
	   for(var i in $scope.mySelectedRows){
		   if(i>0){
			   inputString = inputString+",";  
		   }
		   var row = $scope.mySelectedRows[i];
		   inputString = inputString + row.tableName+"#"+row.id;
	   }
	    mtype = 1;
	   	$scope.showEdit();
   }
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
   
	setTimeout(function (){
		$scope.query();
	}, 1000);
	
	 //弹出页面打开后的操作
    var ModalInstanceCtrl = function ($scope, $modalInstance,$http,ngDialog) {
    	$http.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded;charset=utf-8';  
    	//$http.defaults.headers.post['Acc ept'] = 'application/json, text/javascript, */*; q=0.01';  
    	$http.defaults.headers.post['X-Requested-With'] = 'XMLHttpRequest'; 
    	
    	$scope.m={};
    	//初始化操作状态列表
    	$scope.isactiveList=[{
    		id:0,title:'异常数据'
    	},{
    		id:1,title:'正常数据'
    	}];
    	
    	$scope.m.isactive = 1;
    	$scope.m.inputString = inputString;
    	
    	if(mtype==2){
    		$scope.m.isactive = station.isactive;
    		$scope.m.remark = station.remark;
    	}
    	//执行保存操作
    	$scope.save = function(){
    		var saveparam = $scope.m;
    		$http({
   	   		     method:'POST',
   				 url:'saveDataCheckResult.do',
   				 params:saveparam,
   				 headers: { 'Content-Type': 'application/json; charset=UTF-8'}
   				 })
   				 .success(function(response){
				    	 $modalInstance.close(response);
   			     }); 	
    	};
    };	
});