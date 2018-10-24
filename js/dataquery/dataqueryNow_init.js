var myApp = angular.module('myApp',[]); 
myApp.controller('customersCtrl',function($scope,$http,$timeout){
	//添加一下内容防止输出乱码
	$http.defaults.headers.post['Content-Type'] = 'application/json;charset=utf-8';  
	$http.defaults.headers.post['Accept'] = 'application/json, text/javascript, */*; q=0.01';  
	$http.defaults.headers.post['X-Requested-With'] = 'XMLHttpRequest';
	
	
	
	detail();
	 var updateClock = function(){
		 $timeout(function(){
			 updateClock();

			 detail();
			 $scope.showStand();
		 },600000);
	};
	updateClock();
	
	$(function() {
		//初始化菜单树高度
		//初始化站点
		(function() {
	
		})();
	
	});
	function detail() {
		var airContent = new Array();
		var firContent = new Array();
		var warnContent = new Array();
		var sysContent = new Array();
		var polluContent = new Array(); 
		var mainContent = new Array();
		var standard = '';
		getJSON(
				'getlastdataNow.do?',
				{},
				false,
				function(res) {
					
					//开始编写实时数据部分
					var lastData = res.Datas;
					for(var p in lastData){
							/* airContent.push('<div class="widget-header " >'); */
						var lastTime = lastData[p].lastTime;
						var pointNum = lastData[p].pointNum;
						if(lastTime == null){
							lastTime = ' ';
						}
						airContent.push('<div class="col-xs-12 col-sm-6 ">');	
						airContent.push('<div class="panel panel-info">');
						airContent.push('<div class="panel-heading">');
						airContent.push('<h5 class="bigger lighter">');
						airContent.push('<i class="icon-table"></i>');
						airContent.push(lastData[p].deviceName+'  更新时间：'+lastTime);
						airContent.push('</h5>');
						airContent.push('</div>');
						airContent.push('<table class="table table-striped table-bordered table-hover">');
						airContent.push('<tbody>');
						var rdata = lastData[p].MetaDatas;
						var n = 0;
						for(var m in rdata){
							if(m%2==0){
								airContent.push('<tr>');
								if(rdata[m].unitName.length<1){
									airContent.push('<td style="width: 50%">'+rdata[m].indicatorTitle+':<span >'
								               +(rdata[m].mdata).toFixed(pointNum)+'</span></td>');
								}else{
									airContent.push('<td style="width: 50%">'+rdata[m].indicatorTitle+':<span >'
								               +(rdata[m].mdata).toFixed(pointNum)+'</span>('+rdata[m].unitName+')</td>');
								}
								
							}else{
								if(rdata[m].unitName.length<1){
									airContent.push('<td  >'+rdata[m].indicatorTitle+':<span >'
								               +(rdata[m].mdata).toFixed(pointNum)+'</span></td>');
								}else{
									airContent.push('<td  >'+rdata[m].indicatorTitle+':<span ">'
								               +(rdata[m].mdata).toFixed(pointNum)+'</span>('+rdata[m].unitName+')</td>');
								}
								airContent.push('</tr>');
							}
							n = m;
					     }
						if(n>0&&n%2==0){
							airContent.push('<td  ><span style="font-size:15px;"></span></td>');
							airContent.push('</tr>');
						}
						airContent.push('</tbody>');
						airContent.push('</table>');
						airContent.push('</div>');
						airContent.push('</div>');
					}
		});
		$("#datashow").html(airContent.join(""));
		
	}
	
});