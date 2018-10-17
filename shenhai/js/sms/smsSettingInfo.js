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
	var sparam="";
	
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
		    exporterCsvFilename: '首页实时数据',
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
		sparam=$scope.u;
		$http({
			 method:'POST',
			 url:'showUsers4SmsSetting.do',
			 params:sparam})
			 .success(function(response){
				 $(".btn-primary").removeAttr("disabled");
				 row = response.rows;
				  col = response.cols;
				  $scope.gridOptions.columnDefs = col;
				  $scope.gridOptions.data = row;
			 });
	};
	$scope.showUser();
	
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
    	console.log(pub);
    	$scope.mytime = new Date();
    	$scope.ismeridian = true;
    	var userId;
    	//生成状态列表
    	$scope.activelist = [{
            name: '接收',
            value: 1
        }, {
            name: '不接收',
            value: 0
        }];
    	
    	//初始化弹出页面
    	//初始化站点列表
    	var sparam = "";
    	$http({
	   		 method:'POST',
				 url:'getUsersByStation.do',
				 params:sparam,
				 headers: { 'Content-Type': 'application/json; charset=UTF-8'}
				 })
				 .success(function(response){
					 $scope.userList = response;
					 if(mtype==1){
						 $scope.sms={
								 userId:$scope.userList[0].id	 
						 };
					 }else if(mtype==2){
						 $scope.sms={
								 userId:pub.userId
						 };
					 }
					 $scope.infoUserSetting();
					 
		});
    	
    	
    	//根据人员初始化设置
    	$scope.infoUserSetting=function(){
    		
    		userId = $scope.sms.userId;
    		var suparam={
    				id:$scope.sms.userId
    		};
    		$http({
      	   		 method:'POST',
      				 url:'infoUserSetting.do',
      				 params:suparam,
      				 headers: { 'Content-Type': 'application/json; charset=UTF-8'}
      				 })
      				 .success(function(response){
      					 $scope.sms={
      							userId:userId,
      							mon:response.mon,
      							tues:response.tues,
      							wed:response.wed,
      							thur:response.thur,
      							fri:response.fri,
      							satur:response.satur,
      							sun:response.sun,
      							betweenTime:response.betweenTime,
      							pmbegin:response.pmbegin,
      							pmend:response.pmend,
      							ambegin:response.ambegin,
      							amend:response.amend,
      							isactive:response.isactive
      							
      					 };
      				 });
    	};
    	
    	$scope.save=function(){
    		var ambegin = $scope.sms.ambegin;
    		var amend = $scope.sms.amend;
    		var pmbegin = $scope.sms.pmbegin;
    		var pmend = $scope.sms.pmend;
    		if(!isTime(ambegin)){
    			return;
    		}
    		if(!isTime(amend)){
    			return;
    		}
    		if(!isTime(pmbegin)){
    			return;
    		}
    		if(!isTime(pmend)){
    			return;
    		}
    		var param = $scope.sms;
    		$http({
     	   		 method:'POST',
     				 url:'saveUserSetting.do',
     				 params:param,
     				 headers: { 'Content-Type': 'application/json; charset=UTF-8'}
     				 })
     				 .success(function(response){
     					$modalInstance.close(response);
     				 });
    	};
    	
    	function isTime(checktext){//time格式检查
    		  var   datetime;  
    		  var   hour,munite,second;  
    		  var   gfour,gfive;  
    		     datetime=checktext;
    		      hour=datetime.substring(0,2);
    		      gfour=datetime.substring(2,3);
    		      munite=datetime.substring(3,5);
    		      gfive=datetime.substring(5,6);
    		      second=datetime.substring(6,8);
    		      if(datetime.length==8&&(gfour==":")&&(gfive==":")&&(!isNaN(hour))&&(!isNaN(munite))&&(!isNaN(second)))
    		        {  
    		          if(hour>23){alert("小时必须在00和24之间!");return false;}
    		          if(munite>59){alert("分钟必须在00和60之间!");return false;}
    		          if(second>59){alert("秒必须在00和60之间!");return false;}
    		         }
    		      else
    		        {  
    		           alert("请输入日期!格式为(hh-mm-ss)   /n例(01:00:00)");
    		           return   false;  
    		         }  
    		return true;   
    	}
    	
    };
});

