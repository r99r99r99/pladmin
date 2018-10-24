var myApp = angular.module('myApp',['ui.grid', 'ui.grid.exporter','ui.grid.pagination',
                                    'ui.grid.resizeColumns','ui.grid.selection'
                                    ,'ngDialog','ngAnimate','ui.bootstrap','multi-select-tree']); 

var row;
var col;
var pub;
var mtype;

myApp.controller('customersCtrl',function($scope,$http,ngDialog,$modal,$timeout, $log){
	
	//添加一下内容防止输出乱码
	$http.defaults.headers.post['Content-Type'] = 'application/json;charset=utf-8';  
	$http.defaults.headers.post['Accept'] = 'application/json, text/javascript, */*; q=0.01';  
	$http.defaults.headers.post['X-Requested-With'] = 'XMLHttpRequest';  
	//初始化页面,获得站点的列表
	var dparam="";
	var sparam={
			parentCode:'0010'
	};
	//获得站点列表
	$http({
		 method:'POST',
		 url:'getStationByUser.do',
		 params:dparam})
		 .success(function(response){
			 $scope.stationList = response;
			 $scope.stationList.unshift({id:0,title:'全部'});
			 $scope.stationId = $scope.stationList[0].id;
	});
	//获得模板类型的列表
	$http({
		 method:'POST',
		 url:'getPublicList.do',
		 params:sparam})
		 .success(function(response){
			 $scope.typeList = response;
			 $scope.typeList.unshift({classId:0,value:'全部'});
			 $scope.type=$scope.typeList[0].classId;
	});
	
	
	
	//根据站点查询出需要发送短信的人员列表
	//开始分页信息
	$scope.gridOptions = {
			enableRowSelection:true,
			rowTemplate: "<div ng-dblclick=\"grid.appScope.onDblClick(row)\" ng-repeat=\"(colRenderIndex, col) in colContainer.renderedColumns track by col.colDef.name\" class=\"ui-grid-cell\" ng-class=\"{ 'ui-grid-row-header-cell': col.isRowHeader }\" ui-grid-cell ></div>",
			appScopeProvider: { 
		          onDblClick : function(row) {
		        	  mtype = 2;  //2 代表编辑对话框
		          	pub = row.entity;
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
		    exporterCsvFilename: '站点模板配置列表',
		    exporterCsvLinkElement: angular.element(document.querySelectorAll(".custom-csv-link-location")),
		    onRegisterApi: function(gridApi){
		      $scope.gridApi = gridApi;
		      gridApi.selection.on.rowSelectionChanged($scope,function(row){
		    	  firstpage = row.entity;
		      });
		    }
		  };
	
	
	$scope.showUser=function(){
		$(".btn-primary").attr('disabled',"true");
		sparam={
				stationId:$scope.stationId,
				type:$scope.type
		};
		$http({
			 method:'POST',
			 url:'showSmsMouldList.do',
			 params:sparam})
			 .success(function(response){
				 $(".btn-primary").removeAttr("disabled");
				 row = response.rows;
				  col = response.cols;
				  $scope.gridOptions.columnDefs = col;
				  $scope.gridOptions.data = row;
			 });
	};
    //点击新增按钮,弹出新增对话框
    $scope.addUser = function(){
    	mtype = 1;  //1 代表新增对话框
    	$scope.showEdit();
    };
   
	 $scope.showUser();
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
        	 $scope.showUser();
             console.log(result);  
        }, function (reason) {  
            console.log(reason);//点击空白区域，总会输出backdrop click，点击取消，则会暑促cancel  
        });
      
    };
    var ModalInstanceCtrl = function ($scope, $modalInstance,$http,ngDialog, $log) {
    	$http.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded;charset=utf-8';  
    	//$http.defaults.headers.post['Acc ept'] = 'application/json, text/javascript, */*; q=0.01';  
    	$http.defaults.headers.post['X-Requested-With'] = 'XMLHttpRequest'; 
    	$scope.mytime = new Date();
    	$scope.ismeridian = true;
    	//初始化得到站点列表
    	var dparam="";
    	var sparam={
    			parentCode:'0010'
    	};
    	//获得站点列表
    	$http({
    		 method:'POST',
    		 url:'getStationByUser.do',
    		 params:dparam})
    		 .success(function(response){
    			 $scope.stationList = response;
    			 $scope.stationList.unshift({id:0,title:'默认站点'});
    			 if(mtype==1){
    				 $scope.stationId = $scope.stationList[0].id;
    			 }else{
    				 $scope.stationId = pub.stationId;
    			 }
    	});
    	//获得模板类型的列表
    	$http({
    		 method:'POST',
    		 url:'getPublicList.do',
    		 params:sparam})
    		 .success(function(response){
    			 $scope.typeList = response;
    			 if(mtype==1){
    				 $scope.type=$scope.typeList[0].classId;
    			 }else{
    				 $scope.type=pub.type;
    			 }
    	});
    	if(mtype==1){
    		
    	}else{
    		$scope.id = pub.id;
    		$scope.mould = pub.mould;
    	}
    	
    	
    	$scope.save=function(){
    		var param = {
    				id:$scope.id,
    				stationId:$scope.stationId,
    				type:$scope.type,
    				mould:$scope.mould
    		};
    		//如果执行修改操作时
    		if(mtype==2){
    			 $http({
        	   		 method:'POST',
        				 url:'saveSmsMouldChange.do',
        				 params:param,
        				 headers: { 'Content-Type': 'application/json; charset=UTF-8'}
        				 })
        				 .success(function(response){
    				    	 $modalInstance.close(response);
        	   	     }); 	
    		}
    		if(mtype==1){
    			$http({
       	   		 method:'POST',
       				 url:'saveNewSmsMould.do',
       				 params:param,
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

