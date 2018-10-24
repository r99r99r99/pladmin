var myApp = angular.module('myApp',['ui.grid', 'ui.grid.exporter','ui.grid.pagination',
                                    'ui.grid.resizeColumns','ui.grid.selection'
                                    ,'ngDialog','ui.bootstrap','multi-select-tree']); 

var row;
var col;
var station;
var mtype;
myApp.controller('customersCtrl',function($scope,$http,ngDialog,$modal,$timeout){
	
	//添加一下内容防止输出乱码
	$http.defaults.headers.post['Content-Type'] = 'application/json;charset=utf-8';  
	$http.defaults.headers.post['Accept'] = 'application/json, text/javascript, */*; q=0.01';  
	$http.defaults.headers.post['X-Requested-With'] = 'XMLHttpRequest';  
	
	
	//删除选中的站点配置
	$scope.dele = function(){
		if(!confirm("是否要删除该条数据")){
			return;
		}
		if(station==null){
			alert("请选择要删除的站点参数配置");
			return;
		}
		var dParam = station;
		$http({
			 method:'POST',
			 url:'deleStationComm.do',
			 params:dParam})
			 .success(function(response){
				 alert(response);
				 $scope.query();
		     });
	};
	
	//初始化查询条件
	var sData = "";
	$http({
		 method:'POST',
		 url:'getStationByUser.do',
		 params:sData})
		 .success(function(response){
			 $scope.stationList = response;
			 $scope.stationList.unshift({id:0,title:'全部站点'});
			 $scope.u = {
				stationId:$scope.stationList[0].id	 
			 };
			 $scope.query();
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
		    exporterCsvFilename: '站点配置',
		    exporterCsvLinkElement: angular.element(document.querySelectorAll(".custom-csv-link-location")),
		    onRegisterApi: function(gridApi){
		      $scope.gridApi = gridApi;
		      gridApi.selection.on.rowSelectionChanged($scope,function(row){
		    	  station = row.entity;
		      });
		    }
		  };
	//分页信息结束
    $scope.query=function(){
    	$(".btn-primary").attr('disabled',"true");
    	var pData = $scope.u; 
    	$http({
    		 method:'POST',
			 url:'showStationCommList.do',
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
    	//$http.defaults.headers.post['Acc ept'] = 'application/json, text/javascript, */*; q=0.01';  
    	$http.defaults.headers.post['X-Requested-With'] = 'XMLHttpRequest'; 
    	
    	//初始化查询条件
    	var mData = "";
    	$http({
    		 method:'POST',
    		 url:'getStationByUser.do',
    		 params:mData})
    		 .success(function(response){
    			 $scope.stationList = response;
    			 if(mtype==1){
    				 $scope.station={
    						 stationId:$scope.stationList[0].id,
    				 };
    			 }else if(mtype==2){
    				 $scope.station = station;
    			 }
    			 $scope.getDeviceList();
    			
    	});
    	//得到该站点下的设备列表
    	$scope.getDeviceList=function(){
    		var oData={
    				id:$scope.station.stationId
    		};
    		$http({
       		 method:'POST',
       		 url:'getDevices4Station.do',
       		 params:oData})
       		 .success(function(response){ 
       			 $scope.deviceList = response;
       			 if(mtype==1){
       				$scope.station.deviceId = $scope.deviceList[0].id;
       			 }else if(mtype==2){
       				$scope.station.deviceId = station.deviceId;
       			 }
       		 });
    	};
    	
    	$scope.selectOnly1Or2 = function(item, selectedItems) {
    	    if (selectedItems  !== undefined && selectedItems.length >= 40) {
    	      return false;
    	    } else {
    	      return true;
    	    }
    	};
    	$scope.changeOption = function(){
    		console.log($scope.isactive);
    	};
    	
    	$scope.maketable = function(){
    		var makeparam = {
    				id:$scope.station.stationId
    		};
    		$http({
   	   		 method:'POST',
   				 url:'makeMetaTable4Station.do',
   				 params:makeparam,
   				 headers: { 'Content-Type': 'application/json; charset=UTF-8'}
   				 })
   				 .success(function(response){
				    	 alert(response);
   	   	     }); 
    		
    	};

    	$scope.save = function(){
    		var dataItem = "";
    		angular.forEach($scope.device, function ( item ) {
    			dataItem = dataItem +","+item.id;
    	      });
    		dataItem = dataItem.substring(1);
    		$scope.station.dataItem = dataItem;
    		var saveparam = $scope.station;
    		console.log(saveparam);
    		//如果执行修改操作时
    		if(mtype==2){
    			 $http({
        	   		 method:'POST',
        				 url:'saveStationCommChange.do',
        				 params:saveparam,
        				 headers: { 'Content-Type': 'application/json; charset=UTF-8'}
        				 })
        				 .success(function(response){
    				    	 $modalInstance.close(response);
        	   	     }); 	
    		}
    		if(mtype==1){
    			$http({
       	   		 method:'POST',
       				 url:'saveNewStationComm.do',
       				 params:saveparam,
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

