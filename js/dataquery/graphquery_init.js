
var myApp = angular.module('myApp',['ngDialog','ui.bootstrap','multi-select-tree']); 
var row;
var col;
var pub;
var mtype;
var station;
var myyChart;
var myyChart2;
var myyChart3;
myApp.controller('customersCtrl',function($scope,$http,ngDialog,$modal){
	
	//添加一下内容防止输出乱码
	$http.defaults.headers.post['Content-Type'] = 'application/json;charset=utf-8';  
	$http.defaults.headers.post['Accept'] = 'application/json, text/javascript, */*; q=0.01';  
	$http.defaults.headers.post['X-Requested-With'] = 'XMLHttpRequest';
    
	//$scope.title = "";
	//查询条件初始化
	var stationParam = "";
	$http({
		 method:'POST',
		 url:'graphquery_init.do',
		 params:stationParam})
		 .success(function(response){
			 $scope.u=response;
	     });
	
	
	$scope.query = function(){
		var endDate = $('#endDate').val();
		 var startDate = $('#startDate').val();
		 if(ifBeginLaterEnd(startDate,endDate)){
				$(".btn-primary").removeAttr("disabled");
				return;
		};
		$scope.u.beginDate = startDate;
		$scope.u.endDate = endDate;
		if($scope.u.indicatorIds==null||$scope.u.indicatorIds==""){
			alert("请选择参数");
			return ;
		}
		var indicatorIds = "0#0";
		var i = 0;
		angular.forEach($scope.u.indicatorIds, function ( item ) {
			indicatorIds = indicatorIds +","+item.id;
			i = i + 1;
	    });
		if(i>3){
			alert("最多支持三个参数同时比较,请重试");
			return ;
		}
		$(".btn-primary").attr('disabled',"true");
		var queryParam = {
				indicatorIds:indicatorIds,
				beginDate:$scope.u.beginDate,
				endDate:$scope.u.endDate
		};
		 $http({
			 method:'POST',
			 url:'graphShow4echarts.do',
			 params:queryParam}) 
			 .success(function(response){
				 $(".btn-primary").removeAttr("disabled");
				 showData(response);
		 });
		
	};
   
	setTimeout(function (){
		$scope.query();
	}, 1000);
});


function showData(res){
	var yaxs = [];
	var yax = 0;
	var series = new Array();
	$.each(res, function (i, dataset) {
		var result = dataset.result;
		var dataList = dataset.data;
		var list = dataList;
		var servie = {
				name: result.title,
	            type: 'spline',
	            yAxis: yax,
	            tooltip: {
	                valueSuffix: ' '+result.unitName
	            },
	            unit:result.unitName,
	            cropThreshold:100000,//设置能够缩放的 
		        // Define the data points. All series have a dummy year
		        // of 1970/71 in order to be compared on the same x axis. Note
		        // that in JavaScript, months start at 0 for January, 1 for February etc.
		        data:list
		    };
		var yaxi = { // Primary yAxis
		        labels: {
		            format: '{value}'+result.unitName,
		            style: {
		                color: Highcharts.getOptions().colors[yax]
		            }
		        },
		        title: {
		            text: result.title,
		            style: {
		                color: Highcharts.getOptions().colors[yax]
		            }
		        }
		    };
		if(yax>0){
			yaxi.opposite = true;
		}
		
		yax = yax + 1;
		yaxs.push(yaxi);
		
		series.push(servie);
	});
	var chart = Highcharts.chart('container', {
		 plotOptions:{
	            series:{
	                turboThreshold:1000000//set it to a larger threshold, it is by default to 1000
	            },
	            spline: {
		            marker: {
		                enabled: true
		            }
		        }
		 },
	    chart: {
	        type: 'spline',
	        zoomType: 'xy',   //鼠标缩放方式 
	           marginLeft: 40, // Keep all charts left aligned
	           spacingTop: 20,
	           spacingBottom: 20,
	           backgroundColor: '#ffffff'
	    },
	    title: {
	    	 text: '综合趋势参数对比',
	         align: 'center',
	         margin: 0,
	         x: 30
	    },
	    credits: {   //版权信息
	           enabled: false
	    },
	    legend: {  //图例说明
            layout: 'vertical',
            align: 'left',
            x: 80,
            verticalAlign: 'top',
            y: 55,
            floating: true,
            backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF'
        },
	    xAxis: {
	        type: 'datetime',
	        dateTimeLabelFormats:{
	        	second: '%m-%d %H:%M:%S',
	        	minute: '%m-%d %H:%M',
	        	hour: '%m-%d %H',
	        	day: '20%y-%m-%d',
	        	week: '%e. %m',
	        	month: '20%y-%m',
	        	year: '20%Y'
	        },
	        crosshair: true,
	        title: {
	            text: null
	        }
	    },
	    yAxis:yaxs,
	    tooltip: {
	    	shared: true,
	        headerFormat: '<b>{point.x:20%y-%m-%d %H:%M}</b><br>',
	        pointFormatter:function(){
	        	 return '<span style="color: '+ this.series.color + '">\u25CF</span> '+
	             this.series.name+': <b>'+ this.y +'</b>'+this.series.userOptions.unit+'<br/>'
	        }
	    },
	    series: series
	});
}

