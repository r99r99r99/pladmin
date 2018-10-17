jQuery(function($) {
				$('.date-picker').datepicker({autoclose:true}).next().on(ace.click_event, function(){
					$(this).prev().focus();
				});
			});

var myApp = angular.module('myApp',['ui.grid', 'ui.grid.exporter','ui.grid.pagination',
                                    'ui.grid.resizeColumns','ui.grid.selection',
                                    'ngDialog','ui.bootstrap','multi-select-tree']);  
var row;
var col;
var pub;
var mtype;
myApp.controller('customersCtrl',function($scope,$http,ngDialog,$modal,$timeout){
	
	//添加一下内容防止输出乱码
	$http.defaults.headers.post['Content-Type'] = 'application/json;charset=utf-8';  
	$http.defaults.headers.post['Accept'] = 'application/json, text/javascript, */*; q=0.01';  
	$http.defaults.headers.post['X-Requested-With'] = 'XMLHttpRequest';  
	
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
		    exporterCsvFilename: '功能区划列表',
		    exporterCsvLinkElement: angular.element(document.querySelectorAll(".custom-csv-link-location")),
		    onRegisterApi: function(gridApi){
		      $scope.gridApi = gridApi;
		      gridApi.selection.on.rowSelectionChanged($scope,function(row){
		    	  pub = row.entity;
		      });
		    }
		  };
	
    $scope.query=function(){
    	$(".btn-primary").attr('disabled',"true");
    	var pData = $scope.u; 
    	$http({
    		 method:'POST',
			 url:'getgCompanyList.do',
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
	
	//删除功能
	$scope.dele=function(){
		var id = "0";
		if(pub!=null){
			id =  pub.id;
		}
		console.log(id);
		if(id=="0"){
			alert("请选择要删除的功能区划");
			return;
		}
		if(confirm("确定要删除选中的记录吗?")){
			$(".btn-primary").attr('disabled',"true");
			$scope.u = {id:id};
			var pData = $scope.u; 
			 $http({
		   		 method:'POST',
					 url:'deleCompany.do',
					 params:pData,
					 headers: { 'Content-Type': 'application/json; charset=UTF-8'}
					 })
					 .success(function(response){
						 $(".btn-primary").removeAttr("disabled"); 
				    	 alert(response);
				    	 $scope.query();
		   	});
		}
	};
	
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
    var ModalInstanceCtrl = function ($scope, $modalInstance,$http) {
    	$http.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded;charset=utf-8';  
    	$http.defaults.headers.post['Accept'] = 'application/json, text/javascript, */*; q=0.01';  
    	$http.defaults.headers.post['X-Requested-With'] = 'XMLHttpRequest'; 
    	
    	//得到当前公司的父类树
    	$scope.showTree = function(){
    		$http({
   	   		 method:'POST',
   				 url:'showCompanyTree4Pcode.do',
   				 params:sparam,
   				 headers: { 'Content-Type': 'application/json; charset=UTF-8'}
   				 })
   				 .success(function(response){
				    	 $scope.pcodelist = response;
   	   	     });
    	};
    	$scope.isactivelist = [{
            name: '启用',
            value: 1
        }, {
            name: '禁用',
            value: 0
        }];
    	
    	var sparam = "";
    	if(mtype == 2){
	    	$scope.m = pub;
	    	sparam = {
	    			code:pub.code,
	    			pcode:pub.pcode
	    	};
	    	$scope.showTree();
    	}else{
    		$scope.m={
    				isactive:$scope.isactivelist[0].value
    		};
    		sparam={
    				code:"",
    				pcode:""
    		};
    		$scope.showTree();
    	}
    	
    	

    	$scope.save = function(){
    		
    		var dataItem = "";
    		angular.forEach($scope.device, function ( item ) {
    			dataItem =item.id;
    	    });
    		$scope.m.pcode = dataItem;
    		
    		var param = $scope.m;
    		//如果执行修改操作时
    		if(mtype==2){
    			 $http({
        	   		 method:'POST',
        				 url:'saveCompanyChange.do',
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
       				 url:'saveNewCompany.do',
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