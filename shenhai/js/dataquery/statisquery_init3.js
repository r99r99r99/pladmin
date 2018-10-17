var myApp = angular.module('myApp',['highcharts-ng','ngDialog']); 
myApp.controller('customersCtrl',function($scope,$http,ngDialog,$timeout){
	//添加一下内容防止输出乱码
	$http.defaults.headers.post['Content-Type'] = 'application/json;charset=utf-8';  
	$http.defaults.headers.post['Accept'] = 'application/json, text/javascript, */*; q=0.01';  
	$http.defaults.headers.post['X-Requested-With'] = 'XMLHttpRequest';
	//初始化统计口径列表
	$scope.activelist = [{
        name: '按月统计',
        value: 1
    }, {
        name: '按周统计',
        value: 2
    }, {
        name: '按日统计',
        value: 3
    }];
	
	$scope.collectType = 3;
	
	$scope.queryData = function(){
		$(".btn-primary").attr('disabled',"true");
		var endDate = $('#endDate').val();
		var startDate = $('#startDate').val();
		if(ifBeginLaterEnd(startDate,endDate)){
			$(".btn-primary").removeAttr("disabled");
			return;
		};
		var collectType = $scope.collectType;
		var stationId = $('#stationId').val();
		var zparams={
				endDate:endDate,
				beginDate:startDate,
				statType:collectType,
		};
		$http({
			 method:'POST',
			 url:'showStat.do',
			 params:zparams})
			 .success(function(res){
				 	$(".btn-primary").removeAttr("disabled");
				 	var headerHeight=$("#header").outerHeight();
					var windowHeight=$(window).outerHeight(); 
				 	$("#oneCharts").css({ height: (windowHeight-headerHeight*2)/2});
					$("#lineCharts").css({ height: (windowHeight-headerHeight*2)/2});
					$scope.loadCharts(res);
					$scope.createTable(res,'queryContainer','','');
			 });
	};
	
	$scope.queryData();
	$scope.loadCharts = function(data){
		var piedata = data.datas;
		console.log(piedata);
		//生成饼状图
		$scope.piechartConfig= {
				//设置标题
				title: {
					text: '',
		            align: 'right',
		            x: -80,
		            verticalAlign: 'bottom',
		            y: -80
		        },
				//去掉版权
				credits:{
					enabled:false
				},
				options: {
					chart: {
						type: 'pie',
						zoomType: 'x'
					}
				},
				//当鼠标滑过时显示的文字,没有实现
				tooltip: {
					animation:true,
					formatter: function () {
						return 'The value for <b>' + this.x +
						'</b> is <b>' + this.y + '</b>';
					}
				},
				series: [{
					data: piedata,
					//隐藏底部的series1
					showInLegend: false
				}]
		};
		
		//生成折线图
		$scope.chartConfig = {
				//设置标题
				title: {
					text: '',
		            align: 'right',
		            x: -80,
		            verticalAlign: 'bottom',
		            y: -80
		        },
				//去掉版权
				credits:{
					enabled:false
				},
				options: {
					chart: {
						type: 'line',
						zoomType: 'x'
					}
				},
				//当鼠标滑过时显示的文字,没有实现
				tooltip: {
					formatter: function () {
						return 'The value for <b>' + this.x +
						'</b> is <b>' + this.y + '</b>';
					}
				},
				series: [{
					data: data.ydatas,
					//隐藏底部的series1
					showInLegend: false
				}],
				xAxis: {
					categories:data.xtimes
				},
				exporting: {
		            filename: 'custom-file-name'
		        },
				yAxis:{
					max:6,
					//设置纵坐标标题
					title:{
						enabled:false
					},
					labels:{
						formatter: function () {
							var result = "";
							if(this.value==1){
								result = "一类";
							}else if(this.value==2){
								result = "二类";
							}else if(this.value==3){
								result = "三类";
							}else if(this.value==4){
								result = "四类";
							}else if(this.value==5){
								result = "五类";
							}else if(this.value==6){
								result = "劣五类";
							}
							
		                    return result;
		                }
					}
				}
		};
	};
	//编辑表格信息
	$scope.createTable = function(result,id,title,flag){
		resultData = result;
		var dtime = "天数";
		//console.debug(resultData.tableContents);
		if(result.statType=='1'){
			dtime = "月份数";
		}else if(result.statType=='2'){
			
		}
		var htmlStr = new Array();
		htmlStr.push('<h4 style="text-align: center;"><strong>水质等级统计</strong></h4>');
		htmlStr.push('<table class="table table-striped" style="width: 100%">');
		htmlStr.push("<thead>");
		htmlStr.push("<tr class='info'>");
		htmlStr.push("<th>水质等级</th>");
		htmlStr.push("<th>天数</th>");
		htmlStr.push("<th>首要污染物</th>");
		htmlStr.push("<th>占比</th>");
		htmlStr.push("</tr>");
		htmlStr.push("</thead>");
		
		for(var i in result.datas){
			
			htmlStr.push("<tr>");
				htmlStr.push("<td>"+result.datas[i].name+"</td>");
				htmlStr.push("<td>"+result.datas[i].y+"</td>");
				htmlStr.push("<td>"+result.datas[i].firstThing+"</td>");
				htmlStr.push("<td>"+Math.round(100*result.datas[i].y/result.datas[i].statcount)+"%"+"</td>");
			htmlStr.push("</tr>");
		}
		htmlStr.push("</table>");
		
		$("#"+id).html(htmlStr.join(""));
	}
});

function excelData(){
    //通过开始时间结束时间导出EXCEL
	var startDate = $('#startDate').val();
	var endDate = $('#endDate').val();
	var url='${ctx}/exportDataStand.do'+'?startDate='+startDate+'&endDate='+endDate;
	window.open(url, "下载Excel", "height=100,width=400,top=0,left=0,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no");
}