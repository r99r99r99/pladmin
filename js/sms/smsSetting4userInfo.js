var myApp = angular.module('myApp',['ngDialog','ngAnimate','ui.bootstrap','multi-select-tree']); 

var row;
var col;
var pub;
var mtype;

myApp.controller('customersCtrl',function($scope,$http,ngDialog,$modal,$timeout, $log){
	
	//添加一下内容防止输出乱码
	$http.defaults.headers.post['Content-Type'] = 'application/json;charset=utf-8';  
	$http.defaults.headers.post['Accept'] = 'application/json, text/javascript, */*; q=0.01';  
	$http.defaults.headers.post['X-Requested-With'] = 'XMLHttpRequest';  
	$scope.activelist = [{
        name: '接收',
        value: 1
    }, {
        name: '不接收',
        value: 0
    }];
	//根据人员初始化
	var sparam="";
	$http({
		 method:'POST',
		 url:'getSmsSetting4User.do',
		 params:sparam})
		 .success(function(response){
			  $scope.sms=response;
	});
	
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
 				 url:'saveSmsSetting4User.do',
 				 params:param,
 				 headers: { 'Content-Type': 'application/json; charset=UTF-8'}
 				 })
 				 .success(function(response){
 					alert(response);
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
});

