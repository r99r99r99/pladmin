
var myApp = angular.module('myApp',['ng.ueditor']); 

myApp.controller('customersCtrl',function($scope,$http){
	
	
	//添加一下内容防止输出乱码
	$http.defaults.headers.post['Content-Type'] = 'application/json;charset=utf-8';  
	$http.defaults.headers.post['Accept'] = 'application/json, text/javascript, */*; q=0.01';  
	$http.defaults.headers.post['X-Requested-With'] = 'XMLHttpRequest';  
	
	var sData = "";
	$http({
		 method:'POST',
		 url:'getStationByUser.do',
		 params:sData})
		 .success(function(response){
			 $scope.stationList = response;
			 $scope.u = {
				stationId:$scope.stationList[0].id	 
			 };
			 $scope.query();
	     });
	
	$scope.query=function(){
		var qparams = {
				stationId:$scope.u.stationId
		};
		$http({
			 method:'POST',
			 url:'showStationInfo.do',
			 params:qparams})
			 .success(function(response){
				 $scope.u.infomation = response.infomation;
		     });
	};
	$scope.save = function(){
		
		console.log($scope.u);
	};
	$scope.config = {
            //这里可以选择自己需要的工具按钮名称,此处仅选择如下五个
            toolbars:[['FullScreen', 'Source', 'Undo', 'Redo','Bold','test','simpleupload']],
            //focus时自动清空初始化时的内容
            autoClearinitialContent:true,
            //关闭字数统计
            wordCount:false,
            //关闭elementPath
            elementPathEnabled:false
      };
	UE.Editor.prototype._bkGetActionUrl = UE.Editor.prototype.getActionUrl;
	UE.Editor.prototype.getActionUrl = function(action) {
        //这里很重要，很重要，很重要，要和配置中的imageActionName值一样
        if (action == 'imageUpload') {
	        //这里调用后端我们写的图片上传接口
	        return 'http://localhost:8080/liaoheocean/imageUpload.do';
	    }else{
	         return this._bkGetActionUrl.call(this, action);
	    }
	};
});


