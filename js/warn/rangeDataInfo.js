var myApp = angular.module('myApp',['ui.grid', 'ui.grid.exporter','ui.grid.pagination',
                                    'ui.grid.resizeColumns','ui.grid.selection'
                                    ,'ngDialog','ui.bootstrap','multi-select-tree']); 

var row;
var col;
var error;
var mtype;
myApp.controller('customersCtrl',function($scope,$http,ngDialog,$modal,$timeout){
	
	//添加一下内容防止输出乱码
	$http.defaults.headers.post['Content-Type'] = 'application/json;charset=utf-8';  
	$http.defaults.headers.post['Accept'] = 'application/json, text/javascript, */*; q=0.01';  
	$http.defaults.headers.post['X-Requested-With'] = 'XMLHttpRequest';  
	$scope.u={};
	//生成站点列表
	var sData = "";
	$http({
		 method:'POST',
		 url:'getStationByUser.do',
		 params:sData})
		 .success(function(response){
			 $scope.stationList = response;
			 $scope.stationList.unshift({id:0,title:'全部站点'});
			 $scope.u.stationId=$scope.stationList[0].id;
			 
			 $scope.query=function(){
				 $(".btn-primary").attr('disabled',"true");
			    	var pData = $scope.u; 
			    	$http({
			    		 method:'POST',
						 url:'showRangeData.do',
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
				
	});
	
	//开始分页信息
	$scope.gridOptions = {
			enableRowSelection:true,
			rowTemplate: "<div ng-dblclick=\"grid.appScope.onDblClick(row)\" ng-repeat=\"(colRenderIndex, col) in colContainer.renderedColumns track by col.colDef.name\" class=\"ui-grid-cell\" ng-class=\"{ 'ui-grid-row-header-cell': col.isRowHeader }\" ui-grid-cell ></div>",
			appScopeProvider: { 
		          onDblClick : function(row) {
		        	  mtype = 2;  //2 代表编辑对话框
		        	  error = row.entity;
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
		    exporterCsvFilename: '预警告警配置列表',
		    exporterCsvLinkElement: angular.element(document.querySelectorAll(".custom-csv-link-location")),
		    onRegisterApi: function(gridApi){
		      $scope.gridApi = gridApi;
		      gridApi.selection.on.rowSelectionChanged($scope,function(row){
		    	  error = row.entity;
		      });
		    }
		  };
    
	    
    //点击新增按钮,弹出新增对话框
    $scope.addUser = function(){
    	mtype = 1;  //1 代表新增对话框
    	$scope.showEdit();
    };
    
    //删除代码
    
  //删除选中的水质等级
    $scope.dele = function(){
    	var id = error.id;
		if(id==null){
			alert("请选择要删除的错误数据配置");
			return;
		}
		if(confirm("确定要删除选中的记录吗?")){
			$(".btn-primary").attr('disabled',"true");
			var dData ={id:id}; 
			$http({
		   		 method:'POST',
					 url:'deleRangeData.do',
					 params:dData,
					 headers: { 'Content-Type': 'application/json; charset=UTF-8'}
					 })
					 .success(function(response){
						 $(".btn-primary").removeAttr("disabled");
				    	 alert(response);
				    	 $scope.query();
		   	});
		}
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
    	$scope.error ={};
    	$scope.errors = {};
    	//获得有效的站点列表
    	if(mtype==2){
    		$scope.error=error;
    	}
    	
    	//得到权限下的参数列表
    	var mData = "";
    	$http({
    		 method:'POST',
    		 url:'getStationByUser.do',
    		 params:mData})
    		 .success(function(response){
    			$scope.error.stationList = response;
    			if(mtype==1){
    				$scope.error.stationId = $scope.error.stationList[0].id;
    			}
    			$scope.changeStation();
    	});
    	//根据站点权限获得设备列表
    	$scope.changeStation = function(){
    		var dDate={
    				id:$scope.error.stationId
    		};
    		$http({
       		 method:'POST',
       		 url:'getDevices4Station.do',
       		 params:dDate})
       		 .success(function(response){
	       			$scope.errors.deviceIdList = response;
	       			if(mtype==1){
	       				$scope.error.deviceId = $scope.errors.deviceIdList[0].id;
	       			}
	       			$scope.changeDevice();
       		 });
    		
    	};
    	
    	//根据设备获得设备下的参数列表
    	$scope.changeDevice = function(){
    		var dDate={
    				id:$scope.error.deviceId
    		};
    		$http({
       		 method:'POST',
       		 url:'getIndicatorsByDevice.do',
       		 params:dDate})
       		 .success(function(response){
       			 	console.log(response);
	       			$scope.errors.indicatorList = response;
	       			if(mtype==1){
	       				$scope.error.indicatorCode = $scope.errors.indicatorList[0].code;
	       			}
       		 });
    	};
    	

    	$scope.save = function(){
    		var saveparam = $scope.error;
    		//如果执行修改操作时
    		if(mtype==2){
    			 $http({
        	   		 method:'POST',
        				 url:'updateRangeData.do',
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
       				 url:'saveNewRangeData.do',
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

