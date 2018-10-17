
var myApp = angular.module('myApp',['ui.grid', 'ui.grid.exporter','ui.grid.pagination',
                                    'ui.grid.resizeColumns','ui.grid.selection'
                                    ,,'ngDialog','ui.bootstrap','multi-select-tree']); 
var row;
var col;
var pub;
var mtype;
var station;
myApp.controller('customersCtrl',function($scope,$http,ngDialog,$modal){
	
	//添加一下内容防止输出乱码
	$http.defaults.headers.post['Content-Type'] = 'application/json;charset=utf-8';  
	$http.defaults.headers.post['Accept'] = 'application/json, text/javascript, */*; q=0.01';  
	$http.defaults.headers.post['X-Requested-With'] = 'XMLHttpRequest';
	
	//查询条件初始化
	var sData = "";
	$http({
		 method:'POST',
		 url:'init_sysMap.do',
		 params:sData})
		 .success(function(response){
			 $scope.m = response;
	});
	
	$scope.save=function(){
		var param = $scope.m;
		$http({
			 method:'POST',
			 url:'saveMapConfig.do',
			 params:param})
			 .success(function(response){
				 alert(response);
		});
	};
});