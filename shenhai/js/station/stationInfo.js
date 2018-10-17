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
	
	//生成状态列表
	$scope.activelist = [{
        name: '全部',
        value: 2
    }, {
        name: '启用',
        value: 1
    }, {
        name: '禁用',
        value: 0
    }];
	
	//初始化查询条件
	$scope.u = {isactive:2};
	
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
		    exporterCsvFilename: '站点管理',
		    exporterCsvLinkElement: angular.element(document.querySelectorAll(".custom-csv-link-location")),
		    onRegisterApi: function(gridApi){
		      $scope.gridApi = gridApi;
		      gridApi.selection.on.rowSelectionChanged($scope,function(row){
		    	  firstpage = row.entity;
		      });
		    }
		  };
	
    $scope.query=function(){
    	$(".btn-primary").attr('disabled',"true");
    	var pData = $scope.u; 
    	$http({
    		 method:'POST',
			 url:'showStationList.do',
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
    	$scope.k = {};
    	$scope.ifSmslist = [{
            name: '启用',
            value: 1
        }, {
            name: '禁用',
            value: 0
        }];
    	
    	
    	var stationtypelist ;
    	$scope.station={};
    	if(mtype==1){
    		$scope.station["ifsms"] = $scope.ifSmslist[0].value;
    	}
    	//查询站点类型列表
    	var param ;
    	var par = "";
    	$http({
	   		 method:'POST',
				 url:'getAllStationTypeList.do',
				 params:par,
				 headers: { 'Content-Type': 'application/json; charset=UTF-8'}
				 })
				 .success(function(response){
					 $scope.stationtypelist = response;
					 
					 if(mtype == 1){
						 $scope.station["stationtype_id"] = $scope.stationtypelist[0].id;
					 }
	   	 }); 
    	
    	if(mtype == 1){
    		param = "";
    		comparam = "";
    	}else{
    		param = {region_id:station.region_id};
    		comparam = {companyId:station.companyId};
    	}
    	
    	//查询水质类型列表并初始化
    	var typeparam ={parentCode:'0005'};
    	$http({
	   		 method:'POST',
				 url:'getPublicList.do',
				 params:typeparam,
				 headers: { 'Content-Type': 'application/json; charset=UTF-8'}
				 })
				 .success(function(response){
					 $scope.waterTypelist = response;
					 
					 if(mtype == 1){
						 $scope.station["waterType"] = $scope.waterTypelist[0].classId;
				    }
	   	 }); 
    	//为地区列表添加数据
    	 $http({
	   		 method:'POST',
				 url:'geRegionList.do',
				 params:param,
				 headers: { 'Content-Type': 'application/json; charset=UTF-8'}
				 })
				 .success(function(response){
					 $scope.data = response;
	   	 }); 
    	 //为所在单位列表添加数据
    	 $http({
	   		 method:'POST',
				 url:'geCompanyListByStation.do',
				 params:comparam,
				 headers: { 'Content-Type': 'application/json; charset=UTF-8'}
				 })
				 .success(function(response){
					 $scope.comdata = response;
					 console.log($scope.comdata);
	   	 }); 
    	 
    	 
    	 //为站点包含设备添加数据
    	 var statpam ;
    	 
    	 if(mtype == 1){
    		 statpam = {id:0};
    	 }else{
    		 statpam = {id:station.id};
    	 };
    	 $http({
	   		 method:'POST',
				 url:'getDeviceListByStation.do',
				 params:statpam,
				 headers: { 'Content-Type': 'application/json; charset=UTF-8'}
				 })
				 .success(function(response){
					 $scope.deviceList = response;
	   	 }); 

  	  
    	//生成状态列表
    	$scope.isactivelist = [{
            name: '启用',
            value: 1
        }, {
            name: '禁用',
            value: 0
        }];
    	
    	 $scope.station["isactive"] = 1;
    	
    	if(mtype == 2){
	    	$scope.station = station;
	    	$scope.isactive = station.isactive;
	    	$scope.waterType = station.waterType;
    	}
    	
    	$scope.changeOption = function(){
    		console.log($scope.isactive);
    	};
    	
    	$scope.maketable = function(){
    		var makeparam = {
    				id:$scope.station.id
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
    		if($scope.region==null||$scope.region.length<1){
    			alert("请选择站点所在地区");
    			return;
    		}
    		//添加设备列表
    		var deviceIds = "0";
    		angular.forEach($scope.k.devices, function ( item ) {
    			deviceIds = deviceIds +","+item.id;
    	      });
    		$scope.station.deviceIds = deviceIds;
    		$scope.station.region_id = $scope.region[0].id;
    		$scope.station.companyId = $scope.companyId[0].id;
    		var saveparam = $scope.station;
    		//如果执行修改操作时
    		if(mtype==2){
    			 $http({
        	   		 method:'POST',
        				 url:'saveStaionChange.do',
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
       				 url:'saveNewStation.do',
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

