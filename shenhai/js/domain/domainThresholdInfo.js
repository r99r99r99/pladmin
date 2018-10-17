var myApp = angular.module('myApp',['ui.grid', 'ui.grid.exporter','ui.grid.pagination',
								    'ui.grid.resizeColumns','ui.grid.selection'
								    ,'ngDialog','ui.bootstrap','multi-select-tree','ui.grid.edit']);
var row;
var col;
var thres;
var domainId ;
myApp.controller('customersCtrl',function($scope,$http,ngDialog,$modal){
	//添加一下内容防止输出乱码
	$http.defaults.headers.post['Content-Type'] = 'application/json;charset=utf-8';  
	$http.defaults.headers.post['Accept'] = 'application/json, text/javascript, */*; q=0.01';  
	$http.defaults.headers.post['X-Requested-With'] = 'XMLHttpRequest'; 
	$scope.u={};
	//初始化功能区列表
	var sData = {
			isactive:2
	};
	$http({
		 method:'POST',
		 url:'getDomainList.do',
		 params:sData})
		 .success(function(response){
			 $scope.domainList = response;
			 $scope.u.domainId = $scope.domainList[0].id;
			 $scope.query();
		 });
	
	
	
	//左侧功能区列表
	$scope.gridOptions = {
			enableRowSelection:true,
			rowTemplate: "<div ng-dblclick=\"grid.appScope.onDblClick(row)\" ng-repeat=\"(colRenderIndex, col) in colContainer.renderedColumns track by col.colDef.name\" class=\"ui-grid-cell\" ng-class=\"{ 'ui-grid-row-header-cell': col.isRowHeader }\" ui-grid-cell ></div>",
			appScopeProvider: { 
		          onDblClick : function(row) {
		        	  mtype = 2;  //2 代表编辑对话框
		        	  thres = row.entity;
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
		    exporterCsvFilename: '阈值设置',
		    exporterCsvLinkElement: angular.element(document.querySelectorAll(".custom-csv-link-location")),
		    onRegisterApi: function(gridApi){
		      $scope.gridApi = gridApi;
		      gridApi.selection.on.rowSelectionChanged($scope,function(row){
		    	  firstpage = row.entity;
		      });
		    }
		  };
	//点击新增按钮,弹出新增对话框
    $scope.addUser = function(){
    	mtype = 1;  //1 代表新增对话框
    	$scope.showEdit();
    };
    
	$scope.query=function(){
		$(".btn-primary").attr('disabled',"true");
		var pData = $scope.u; 
		$http({
			 method:'POST',
			 url:'getThresholdListByDomain.do',
			 params:pData})
			 .success(function(response){
				 $(".btn-primary").removeAttr("disabled"); 
				 $scope.gridOptions.columnDefs = response.cols;
				 $scope.gridOptions.data = response.rows;
		     });
	};
	
	 //弹出编辑框
    $scope.showEdit = function(){
    	domainId = $scope.u.domainId;
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
    	$http.defaults.headers.post['Accept'] = 'application/json, text/javascript, */*; q=0.01';  
    	$http.defaults.headers.post['X-Requested-With'] = 'XMLHttpRequest'; 
    	var t;
    	//初始化得到参数列表
    	$scope.m = {};
    	if(mtype==2){
    		$scope.m.indicatorCode = thres.indicatorCode;
    	}
    	$scope.m.domainId = domainId;
    	var pb = {
    			code:$scope.m.indicatorCode
    	};
   	 	$http({
	   		 method:'POST',
				 url:'getAllIndicatorListTree4Single.do',
				 params:pb,
				 headers: { 'Content-Type': 'application/json; charset=UTF-8'}
				 })
				 .success(function(response){
					 $scope.data = response;
						setTimeout(function (){
							$scope.queryThre();
						}, 300);
	   	 }); 	
	   	 $scope.selectOnly1Or2 = function(item, selectedItems) {
	   		setTimeout(function (){
				$scope.queryThre();
			}, 300);
	  	};
	  	
	  	$scope.gridOptions2 = {
				enableRowSelection:true,
				rowTemplate: "<div ng-dblclick=\"grid.appScope.onDblClick(row)\" ng-repeat=\"(colRenderIndex, col) in colContainer.renderedColumns track by col.colDef.name\" class=\"ui-grid-cell\" ng-class=\"{ 'ui-grid-row-header-cell': col.isRowHeader }\" ui-grid-cell ></div>",
				appScopeProvider: { 
			          onDblClick : function(row) {
			        	  t = row.entity;
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
			    exporterCsvFilename: '阈值设置',
			    exporterCsvLinkElement: angular.element(document.querySelectorAll(".custom-csv-link-location")),
			    onRegisterApi: function(gridApi){
			    	  $scope.gridApi = gridApi;
				      gridApi.selection.on.rowSelectionChanged($scope,function(row){
				    	  t = row.entity;
				      });
			    }
			  };
	  	
	  	//查询阈值
	  	$scope.queryThre=function(){
	  		$(".btn-primary").attr('disabled',"true");
	  		var indicatorCode;
	  		angular.forEach($scope.indicators, function ( item ) {
	  			indicatorCode = item.id;
    	      });
	  		$scope.m.indicatorCode = indicatorCode;
	  		var sp = $scope.m;
	  		$http({
				 method:'POST',
				 url:'showThresholdListByDomainIndicator.do',
				 params:sp})
				 .success(function(response){
					 $(".btn-primary").removeAttr("disabled");
					 $scope.gridOptions2.columnDefs = [
						 { displayName: 'id',field:'id',visible:true , width: '*' },
						 { displayName: 'levelId',field:'levelId',visible:true , width: '*' },
						 { displayName: '层级',field:'levelName',visible:true , width: '*' },
						 { displayName: '下限计算方式',field:'mincal',visible:true , width: '*',
							 editableCellTemplate: 'ui-grid/dropdownEditor', cellFilter: 'minGender', editDropdownValueLabel: 'gender', editDropdownOptionsArray: [
							      { id: 1, gender: '>=' },
							      { id: 2, gender: '>' }
							    ] },
						 { displayName: '下限值',field:'min',visible:true , width: '*' },
						 { displayName: '上限计算方式',field:'maxcal',visible:true , width: '*' ,
							 editableCellTemplate: 'ui-grid/dropdownEditor', cellFilter: 'maxGender', editDropdownValueLabel: 'gender', editDropdownOptionsArray: [
							      { id: 1, gender: '<=' },
							      { id: 2, gender: '<' }
							    ] },
						 { displayName: '上限值',field:'max',visible:true , width: '*' }
					 ];
					 $scope.gridOptions2.data = response.rows;
			     });
	  	};
	  	//删除功能区阈值设置
	  	$scope.deleThres=function(){
	  		$(".btn-primary").attr('disabled',"true");
	  		$http({
				 method:'POST',
				 url:'deleDomainThreshold.do',
				 params:t})
				 .success(function(response){
					 $(".btn-primary").removeAttr("disabled"); 
					 alert(response                                   );
					 $scope.queryThre();
			     });
	  	};
	  	
	  	//保存阈值设置
	  	$scope.saveThres=function(){
	  		var pam = {
	  				domainId:$scope.m.domainId,
	  				indicatorCode:$scope.m.indicatorCode,
	  				dataText:JSON.stringify($scope.gridOptions2.data)
	  		};
	  		
	  		$(".btn-primary").attr('disabled',"true");
	  		$http({
   	   		 method:'POST',
   				 url:'saveDomainThreshold.do',
   				 params:pam,
   				 headers: { 'Content-Type': 'application/json; charset=UTF-8'}
   				 })
   				 .success(function(response){
				    	 $modalInstance.close(response);
   	   	     }); 	
	  		
	  	};
    };
})
.filter('minGender', function() {
    	  var genderHash = {
    			    1: '>=',
    			    2: '>'
    			  };
    			 
    			  return function(input) {
    			    if (!input){
    			      return '';
    			    } else {
    			      return genderHash[input];
    			    }
    			  };
})
.filter('maxGender', function() {
    	  var genderHash = {
    			    1: '<=',
    			    2: '<'
    			  };
    			 
    			  return function(input) {
    			    if (!input){
    			      return '';
    			    } else {
    			      return genderHash[input];
    			    }
    			  };
});