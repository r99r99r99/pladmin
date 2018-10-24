var myApp = angular.module('myApp',['ng.ueditor','ngDialog','ui.bootstrap']); 
var picid;
myApp.controller('customersCtrl',function($scope,$http,$modal){
	
	
	//添加一下内容防止输出乱码
	$http.defaults.headers.post['Content-Type'] = 'application/json;charset=utf-8';  
	$http.defaults.headers.post['Accept'] = 'application/json, text/javascript, */*; q=0.01';  
	$http.defaults.headers.post['X-Requested-With'] = 'XMLHttpRequest';  
	
	$scope.albums=[{
		ALBUMNAME:"111",
		TYPE:"jpg"
	}];
	//初始化上传组件
	
	$scope.initFileInput= function() {
    	$scope.selectedPics = new Array();
    	$("#input-images").fileinput("clear");
    	$("#input-images").fileinput("destroy");
    	$("#input-images").fileinput({
            uploadUrl: "saveStationPics.do",
            allowedFileExtensions: ["jpg", "png", "gif"],
            resizePreference: 'height',
            maxFileCount: 10,
            uploadAsync: true, //默认异步上传
            showUpload: true, //是否显示上传按钮
            
            showRemove : true, //显示移除按钮
            showPreview : true, //是否显示预览
            showCaption: false,//是否显示标题
            browseClass: "btn btn-primary", //按钮样式     
            dropZoneEnabled: false,//是否显示拖拽区域
            enctype: 'multipart/form-data',
            validateInitialCount:true
            
        });
    	
    	//异步上传返回结果处理
    	$("#input-images").on("fileuploaded", function (event, data, previewId, index) {
    	        var response = data.response;
    	        alert(response.filePath);
    	       
    	    });
    	
    	$('#input-images').on('filepreupload', function(event, data, previewId, index) {
    		   var form = data.form, files = data.files, extra = data.extra,
    		    response = data.response, reader = data.reader;
    		});
        /*.on("filebatchselected", function(event, files) {
        	  $(this).fileinput("upload");
        })
        .on("fileuploaded", function(event, data) {
			 if(data.response){
				 console.log(data);
			  alert('处理成功');
			 }
		 });
*/	
	};
	
	$scope.initFileInput();
	
	$scope.savePic=function(){
		 $("#input-images").fileinput("upload");
		 
		/*var newPics = new Object();
    	newPics.pics = $scope.selectedPics;
    	$http({
            method : "POST",
            url : "<%=path%>" + "/album/saveAlbum",
            params : {"newPics": newPics},
        }).success(function(data, status, headers, config) {
        	
        }).error(function(data, status, headers, config) {
        });
    	*/
		/* //获取file的全部id  
        var uplist = $("input[name^=uploads]");  
        $scope.sendObj = new FormData();
        for (var i=0; i< uplist.length; i++){
        	console.log(uplist[i].value);
        	
        }
        console.log($scope.sendObj);
        var arrId = [];  
        for (var i=0; i< uplist.length; i++){  
            if(uplist[i].value){  
                arrId[i] = uplist[i].id;  
            }  
        }  
        console.log(arrId);*/
        
      /*  */
		/*var data = {};
		$.ajaxFileUpload({
		    url : 'saveStationPics.do',
		    secureuri : false,
		    data : data,//需要传递的数据 json格式
		    fileElementId :arrId,
		    dataType : 'text',
		    success : function(response) {
		         alert(response);
		    },
		    error : function(response) {
		    	
		    }
		});*/
		
	}
	
	
	
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
					 response.unshift({
						 classId:0,
						 value:'所有类型'
					 });
					 $scope.typelist = response;
					 $scope.u.type = $scope.typelist[0].classId;
					 $scope.query();
	   	 }); 
	};
	
	
	$scope.showimage=function(id){
	     picId = id;
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
					 console.log(response);
					 var picList = new Array();
					 picList.push({
						 id:1,
						 src:"getPicture.do?Path=1.png"
					 });
					 $scope.picList = picList;
				 }); 
	
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
	    	try {
				  $(".dropzone").dropzone({
				    paramName: "file", // The name that will be used to transfer the file
				    maxFilesize: 0.5, // MB
				  
					addRemoveLinks : true,
					dictResponseError: 'Error while uploading file!',
					
					//change the previewTemplate to use Bootstrap progress bars
					previewTemplate: "<div class=\"dz-preview dz-file-preview\">\n  <div class=\"dz-details\">\n    <div class=\"dz-filename\"><span data-dz-name></span></div>\n    <div class=\"dz-size\" data-dz-size></div>\n    <img data-dz-thumbnail />\n  </div>\n  <div class=\"progress progress-sm progress-striped active\"><div class=\"progress-bar progress-bar-success\" data-dz-uploadprogress></div></div>\n  <div class=\"dz-success-mark\"><span></span></div>\n  <div class=\"dz-error-mark\"><span></span></div>\n  <div class=\"dz-error-message\"><span data-dz-errormessage></span></div>\n</div>"
				  });
				} catch(e) {
				  alert('Dropzone.js does not support older browsers!');
				}
	    	
	};
	
	
	  //弹出页面打开后的操作
    var ModalInstanceCtrl = function ($scope, $modalInstance,$http,ngDialog) {
    	$http.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded;charset=utf-8';  
    	$http.defaults.headers.post['Accept'] = 'application/json, text/javascript, */*; q=0.01';  
    	$http.defaults.headers.post['X-Requested-With'] = 'XMLHttpRequest'; 
    	
    	
    };
});
