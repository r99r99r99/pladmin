var myApp = angular.module('myApp',['ng.ueditor','ngDialog','ui.bootstrap']); 
var picid;
var stationId;
var stationNam;
var typeId;
var typeName;
myApp.controller('customersCtrl',function($scope,$http,$modal){
	
	
	//添加一下内容防止输出乱码
	$http.defaults.headers.post['Content-Type'] = 'application/json;charset=utf-8';  
	$http.defaults.headers.post['Accept'] = 'application/json, text/javascript, */*; q=0.01';  
	$http.defaults.headers.post['X-Requested-With'] = 'XMLHttpRequest';  
	
	
	$scope.uploadimgs = []//上传图片合集放的是file对象
	
	$scope.bimg = {};
	
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
			 $scope.getTypeList();
			 
	     });
	
	$scope.getTypeList = function(){
		var typeparam ={parentCode:'0021'};
    	$http({
	   		 method:'POST',
				 url:'getPublicList.do',
				 params:typeparam,
				 headers: { 'Content-Type': 'application/json; charset=UTF-8'}
				 })
				 .success(function(response){
					 /*response.unshift({
						 classId:0,
						 value:'所有类型'
					 });*/
					 $scope.typelist = response;
					 $scope.u.type = $scope.typelist[0].classId;
					 $scope.query();
	   	 }); 
	};
	
	
	$scope.showimage=function(id){
		
		//根据ID,获得该条记录的具体信息
		var param = {
				id:id
		};
		$http({
	   		 method:'POST',
				 url:'getStationPicModelById.do',
				 params:param,
				 headers: { 'Content-Type': 'application/json; charset=UTF-8'}
				 })
				 .success(function(response){
					 $scope.bimg = response;
					 
	   	 }); 
	}
	$scope.query=function(){
		var airContent = new Array();
		var param = $scope.u;
		$http({
	   		 method:'POST',
				 url:'getStationPicListByStationType.do',
				 params:param,
				 headers: { 'Content-Type': 'application/json; charset=UTF-8'}
				 })
				 .success(function(response){
					 $scope.picList = response;
				 }); 
	
	};
	
	//删除图片
	$scope.delePic=function(){
		if(confirm("确定删除该图片?")){
			var param = $scope.bimg;
			$http({
		   		 method:'POST',
					 url:'deleStationPic.do',
					 params:param,
					 headers: { 'Content-Type': 'application/json; charset=UTF-8'}
					 })
					 .success(function(response){
						alert(response);
						 $('#show-modal').modal('hide');
				    	 $scope.query();
					 }); 
		}
	};
	
	//保存图片记录信息
	$scope.savePic=function(){
		console.log("保存方法");
		$("#myFile").fileinput("upload");
	};
	
	//点击图片上传按钮
	$scope.save=function(){
		var modalInstance = $modal.open({  
            templateUrl: 'uploadTmpl.html',  
            controller: ModalUploadCtrl
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
	//弹出图片上传页面
	var ModalUploadCtrl = function ($scope, $modalInstance,$http,ngDialog) {
	    	$http.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded;charset=utf-8';  
	    	$http.defaults.headers.post['Accept'] = 'application/json, text/javascript, */*; q=0.01';  
	    	$http.defaults.headers.post['X-Requested-With'] = 'XMLHttpRequest'; 
	    	
	    	 
	    	
	};
	
	
	  //弹出页面打开后的操作
    var ModalInstanceCtrl = function ($scope, $modalInstance,$http,ngDialog) {
    	$http.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded;charset=utf-8';  
    	$http.defaults.headers.post['Accept'] = 'application/json, text/javascript, */*; q=0.01';  
    	$http.defaults.headers.post['X-Requested-With'] = 'XMLHttpRequest'; 
    	
    	
    };
    
    $("#myFile").fileinput({
    	language: 'zh', //设置语言
        theme: 'fa',
        uploadUrl: 'saveStationPics.do', // you must set a valid URL here else you will get an error
        allowedFileExtensions: ['jpg', 'png', 'gif'],
        showUpload: false, //是否显示上传按钮
        showRemove :false, //显示移除按钮
        showCaption: true,//是否显示标题
        uploadAsync: false, //是否为异步上传
        browseClass: "btn btn-info", //按钮样式
        dropZoneEnabled: true,//是否显示拖拽区域
        removeFromPreviewOnError:true,                 //当文件不符合规则，就不显示预览
        //minImageWidth: 150, //图片的最小宽度
        //minImageHeight: 150,//图片的最小高度
        //maxImageWidth: 150,//图片的最大宽度
        //maxImageHeight: 150,//图片的最大高度
        maxFileSize: 2048,//单位为kb，如果为0表示不限制文件大小
        maxFileCount: 5, //表示允许同时上传的最大文件个数
        minFileCount: 1,
        enctype: 'multipart/form-data',
        validateInitialCount: true,
        uploadExtraData: function(previewId, index) {   //额外参数 返回json数组  
    		return $scope.u;
        },
        previewFileIcon: "<i class='glyphicon glyphicon-king'></i>",
        msgFilesTooMany: "选择上传的文件数量({n}) 超过允许的最大数值{m}！",
        fileActionSettings : {
            showUpload: false,
            //showRemove: false
           showZoom:false
        }
    });
    
  //同步上传成功结果处理
    $("#myFile").on("filebatchuploadsuccess", function (event, data, previewId, index) {
    	console.log(data);
    	alert(data.response.message);
    	 $('#img-modal').modal('hide');
    	 $scope.query();
    });
});

