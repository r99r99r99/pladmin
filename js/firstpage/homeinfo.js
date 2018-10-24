var myApp = angular.module('myApp',['ngDialog','ui.bootstrap']); 
var map;
var popup;
var popupclick;
var element;
var elementclick;
var intervalId ;
var stationintervalId ;
var vectorLayer;
var stat;
var lay;
myApp.controller('customersCtrl',function($scope,$http,ngDialog,$modal,$timeout){
	//添加一下内容防止输出乱码
	$http.defaults.headers.post['Content-Type'] = 'application/json;charset=utf-8';  
	$http.defaults.headers.post['Accept'] = 'application/json, text/javascript, */*; q=0.01';  
	$http.defaults.headers.post['X-Requested-With'] = 'XMLHttpRequest';
	
	var pData="";
	$http({
		 method:'POST',
		 url:'getStationByUser.do',
		 params:pData})
		 .success(function(stations){
			 //var startMarkers = new Array();
			//初始化站点列表
			 var airContent = new Array();
		     $scope.stations = stations;
				var coor = ol.proj.transform([121.03638, 41.0718], 'EPSG:4326', 'EPSG:3857');  
				var projection = new ol.proj.Projection({
					code: 'EPSG:3857',
					units: 'm',
					axisOrientation: 'neu',
					global: false
				});
			    var resolutions = [];
			    for(var i=0; i<19; i++){
			        resolutions[i] = Math.pow(2, 18-i);
			    }
			    var tilegrid  = new ol.tilegrid.TileGrid({
			        origin: [0,0],
			        resolutions: resolutions
			    });
			    var baidu_source = new ol.source.TileImage({
			        projection: projection,
			        tileGrid: tilegrid,
			        tileUrlFunction: function(tileCoord, pixelRatio, proj){
			            if(!tileCoord){
			                return "";
			            }
			            var z = tileCoord[0];
			            var x = tileCoord[1];
			            var y = tileCoord[2];

			            if(x<0){
			                x = "M"+(-x);
			            }
			            if(y<0){
			                y = "M"+(-y);
			            }

			            return "http://online3.map.bdimg.com/onlinelabel/?qt=tile&x="+x+"&y="+y+"&z="+z+"&styles=pl&udt=20151021&scaler=1&p=1";
			        }
			    });
			    var baidu_layer = new ol.layer.Tile({
			        source: baidu_source
			    });
			    //显示鼠标的位置
			    var mousePositionControl = new ol.control.MousePosition({
			        className: 'custom-mouse-position',
			        target: document.getElementById('location'),
			        coordinateFormat: ol.coordinate.createStringXY(5),
			        undefinedHTML: '&nbsp;'
			      });
			    map = new ol.Map({
			    	controls: ol.control.defaults({
				           attribution: false
				         }).extend([mousePositionControl]),
			        target: 'map',
			        layers: [baidu_layer],
			        view: new ol.View({
			            center:  coor,
			            zoom:  8
			        })
			    });
			    
			  //点击站点后的弹出框
			    element= document.getElementById('popup');
			    lay = document.getElementById("stationLayers");   //地图下方展示的实时数据,水质等级等
		     	
				
				$scope.updateStationStatus();
		 });
	
	
	//展示出站点的列表
	$scope.showlayersControl=function(){
   	 var lay = document.getElementById("layersControl");
   	 if(lay.style.display=="block"){
   		 lay.style.display="none"
   	 }else{
   		 lay.style.display="block";
   	 }
    };
   
  //展开站点详情列表
    $scope.showStationDetail=function(station){
    	if(stat!=null){ //将原来的选中的div恢复到初始状态
    		stat.style.backgroundColor = "#f5f5f5";
    	}
    	stat = document.getElementById(station.id);
    	if(stat!=null){ //将原来的选中的div恢复到初始状态
    		stat.style.backgroundColor = "#EAE7E7";
    	}
    	
    	//stat.style.backgroundColor = "#e5f5ff";
    	 $scope.showLastData(station);
    	 $scope.showDomain(station);
    	 	var lay = document.getElementById("stationLayers");
       		 lay.style.display="block";
       		 var slay = document.getElementById("domainLayers");
       		 slay.style.display="block";
       		$(elementclick).popover('destroy');
       		
       		//展示该站点的复选框
       		element = document.getElementById('popup');
       		$(element).popover('destroy');
       		var coordinates = ol.proj.transform([station.latitude, station.longitude], 'EPSG:4326', 'EPSG:3857');
       		popup = null;
       		popup = new ol.Overlay({
				element: element,
				positioning: 'bottom-center',
				stopEvent: false,
				offset: [99, -200]
			});
       		
       		popup.setPosition(coordinates);
			
			$(element).popover({
				'placement': 'right',
				'html': true,
				'content': station.title 
						  +'<br/>'
						  +station.detail
						  +'<img class="media-object img-responsive-media"    src="'+station.pic+'">'
			});
			$(element).popover('show');
			map.addOverlay(popup);
			var view = map.getView();
			view.setCenter(coordinates);
			
			
     };
     
     //关闭站点详情列表
     $scope.closeStationLayers=function(){
     	var lay = document.getElementById("stationLayers");
     	lay.style.display="none";
     	var slay = document.getElementById("domainLayers");
     	slay.style.display="none";
     	$(element).popover('destroy');
     }
     
     //得到站点的功能区
     $scope.showDomain=function(station){
    	 console.log("111111");
    	 var sparams = {
    			 id:station.id
    	 }
    	 $http({
 			 method:'POST',
 			 url:'getDomainResultsByStation.do',
 			 params:sparams})
 			 .success(function(response){
 				 $scope.domainResults = response;
 			 })
     };
     
     //得到站点的实时数据
     $scope.showLastData=function(station){
    	 var sparams = {
    			 stationId:station.id
    	 }
    	//获得当前站点的水质评价模板
 		/*$http({
 			 method:'POST',
 			 url:'getMouldByStation.do',
 			 params:sparams})
 			 .success(function(response){
 				$("#htmlVariable").html("");
				$("#htmlVariable").html(response.mould);
				 
 		});*/
    	 $scope.showStatLine(station);
    	 var pData={
    			 stationId:station.id
    	 };
    		$http({
    			 method:'POST',
    			 url:'getDatas4Firstpage.do',
    			 params:pData})
    			 .success(function(res){
    				 //开始处理实时滚动数据部分
    				 var lastData = res.Datas;
    				 var airContent = new Array();
 					/*airContent.push('<div id="up_zzjs">');
 					airContent.push('<div id="marqueebox">');*/
 					airContent.push('<table class="table table-striped table-bordered table-hover">');
 					for(var p in lastData){
 						var rdata = lastData[p].MetaDatas;
 						var pointNum = lastData[p].pointNum;
 						for(var m in rdata){
 							airContent.push('<tr>');
 							airContent.push('<td style="width:25%"><strong>');
 							airContent.push(lastData[p].deviceName);
 							airContent.push('</strong></td>');
 							airContent.push('<td style="width:35%"><strong>');
 							airContent.push(lastData[p].lastTime);
 							airContent.push('</strong></td>');
 							airContent.push('<td style="width:20%"><strong>');
 							airContent.push(rdata[m].indicatorTitle);
 							airContent.push('</strong></td>');
 							airContent.push('<td style="width:25%"><strong>');
 							if(rdata[m].unitName.length<1){
 								airContent.push((rdata[m].mdata).toFixed(pointNum));
 							}else{
 								airContent.push('<span>'+(rdata[m].mdata).toFixed(pointNum)+'</span>('+rdata[m].unitName+')');
 							}
 							airContent.push('</strong></td>');
 							airContent.push('</td>');
 							
 						}
 					}
 					airContent.push('</table>');
 					$("#marqueebox").html("");
 					$("#marqueebox").html(airContent.join(""));
 					//开始滚动任务
 					startmarquee(20,20,1500);
 					
 					//开始处理水质等级部分
 					var waterStandard = res.waterStandard;
 					 if(waterStandard.standard_grade==1){
							$("#gradeImg").attr('src',"page-images/1grade.png");
						}
						if(waterStandard.standard_grade==2){
							$("#gradeImg").attr('src',"page-images/2grade.png");
						}
						if(waterStandard.standard_grade==3){
							$("#gradeImg").attr('src',"page-images/3grade.png");
						}
						if(waterStandard.standard_grade==4){
							$("#gradeImg").attr('src',"page-images/4grade.png");
						}
						if(waterStandard.standard_grade==5){
							$("#gradeImg").attr('src',"page-images/5grade.png");
						}
						if(waterStandard.standard_grade==6){
							$("#gradeImg").attr('src',"page-images/6grade.png");
						}
						$scope.stand = waterStandard;
    			 }); 
    	
     };
     
   //定时更新站点的状态信息
   $scope.updateStationStatusintervalId=function(){
	   stationintervalId = setInterval(function() {
		   $scope.updateStationStatus();
		}, "6000"); //每隔6s刷新数据  
   }
   $scope.updateStationStatus=function(){
	   //更新地图上站点的图标以及状态
	   var mData = "";
	   $http({
			 method:'POST',
			 url:'getStationStatusList.do',
			 params:mData})
			 .success(function(stations){
				 map.removeLayer(vectorLayer);
				 var startMarkers = new Array();
				   angular.forEach(stations, function(station){
				    	 var startMarker = new ol.Feature({
				    		stationId:station.stationId,
				 	        type: station.ifConnIcon,
				 	        rainfall: 500,
				 	        geometry: new ol.geom.Point(ol.proj.transform([station.latitude,station.longitude], 'EPSG:4326', 'EPSG:3857'))
				      		//geometry: new ol.geom.Point([res.latitude,res.longitude])
				    	 });
				    	 startMarkers.push(startMarker);
				     });
				   
				   vectorLayer = new ol.layer.Vector({
				        source: new ol.source.Vector({
				          features: startMarkers
				        }),
				        style: function(feature) {
					        var icon = 	 new ol.style.Style({
						          		image: new ol.style.Icon({
							            anchor: [0.5, 46],
							           anchorXUnits: 'fraction',
							           anchorYUnits: 'pixels',
							            src: 'images/station/icon/'+feature.get('type')
							            //	src: feature.get('type')
							          })
					        })
					        return icon;
				        }
				 }); 
				   
					map.on('click', function(evt) {
						var feature = map.forEachFeatureAtPixel(evt.pixel,
								function(feature) {
							return feature;
						});
						if (feature) {
							//获得点击的站点的id
							var spam={
									id:feature.H.stationId
							};
							 $http({
					 			 method:'POST',
					 			 url:'getStationById.do',
					 			 params:spam})
					 			 .success(function(response){
					 				$scope.showStationDetail(response);
					 			 })
					 			 
						} else {  //当点击地图的空白区域时,关闭所有弹出框
							$scope.closeStationLayers();
						}
					});
					map.addLayer(vectorLayer);  
			 });
	     
   }
   $scope.updateStationStatusintervalId();
   
   //获得站点的水质等级趋势  
   $scope.showStatLine=function(station){
	   var nowDate = new Date();  //获取当前的时间
	   //初始化开始时间和结束时间
	   var send = nowDate.getTime() - 1000*60*60*24*30*1;  //初始化结束时间为当前时间的一个月前
	   var sbegin = send - 1000*60*60*24*7; //初始化开始时间为结束时间的一周前
	   var kend = new Date(send);   //初始化的结束实际那
	   var kbegin = new Date(sbegin);  //初始化的开始时间
	   var yeare = kend.getYear()+1900;
	   var yearb = kbegin.getYear()+1900;
	   var monthe = kend.getMonth() + 1;
	   var monthb = kbegin.getMonth() + 1;
	   var daye = kend.getDate();
	   var dayb = kbegin.getDate();
	   if(monthb<10){
		   monthb = '0'+monthb;
		}
		if(dayb<10){
			dayb = '0'+dayb;
		}
		if(monthe<10){
			monthe = '0'+monthe;
		}
		if(daye<10){
			daye = '0'+daye;
		}
	   var begin = yearb+'-'+monthb+'-'+dayb;
	   var end = yeare+'-'+monthe+'-'+daye;
	   $scope.upd(station,begin,end);
	   clearInterval(intervalId);
	   intervalId = setInterval(function() {
			var ybeginDate = new Date(begin);
			var yendDate = new Date(end);
			var ybegin = ybeginDate.getTime()+1000*60*60*24*7;
			var yend = yendDate.getTime()+1000*60*60*24*7;
			var ybeg = new Date(ybegin);
			var yen = new Date(yend);
			var ybyear = ybeg.getYear()+1900;
			var yeyear = yen.getYear()+1900;
			var ybmonth = ybeg.getMonth() + 1;
			var yemonth = yen.getMonth() + 1;
			var ybday = ybeg.getDate();
			var yeday = yen.getDate();
			if(ybmonth<10){
				ybmonth = '0'+ybmonth;
			}
			if(ybday<10){
				ybday = '0'+ybday;
			}
			if(yemonth<10){
				yemonth = '0'+yemonth;
			}
			if(yeday<10){
				yeday = '0'+yeday;
			}
			begin = ybyear+'-'+ybmonth+'-'+ybday;
			end = yeyear+'-'+yemonth+'-'+yeday;
			$scope.upd(station,begin,end);
			if(yen>nowDate){
				begin = yearb+'-'+monthb+'-'+dayb;
				end = yeare+'-'+monthe+'-'+daye;
			}
		}, "6000"); //每隔6s刷新数据  
   };
   
   
   //从后台读取折线图数据
   $scope.upd=function(station,beginDate,endDate){
	   var collectType = 3;
	   var sparams={
			    stationId:station.id,
				statType:3,
				beginDate:beginDate,
				endDate:endDate
		};
	   $http({
			 method:'POST',
			 url:'showStat4First.do',
			 params:sparams})
			 .success(function(res){
				 loadChart(res);
			 });
   };
});

function loadChart(data){
	var dat = [];
    for(var p in data.xtimes){
    	dat.push({
            name:data.xtimes[p],
            //x: data.xtimes[p],
            y: data.ydatas[p].y
        });
    }
	var step = 1;
	var size = data.xtimes.length;
	if(size>7){
		step = Math.ceil(size/7);
	}
	$("#container").html("");
	$('<div class="chart"  class="span10" style="height: 200px; margin: 0 auto">>')
    .appendTo('#container')
    .highcharts({
	    	 chart: {
	             type: 'spline',
	             animation: Highcharts.svg, // don't animate in old IE
	             marginRight: 10,
	             backgroundColor: '#F5F6F6',
	             events: {
	                 load: function () {
	                     // set up the updating of the chart each second
	                     var series = this.series[0];
	                     setInterval(function () {
	                         var sdata=[{
	                        	 	name: '2016-09-01',
	                        		//color: '#FF00FF',
	                        		y: 5
	                         }];
	                        // series.addPoint([x, y], true, true);
	                         //series.addPoint(sdata, true, true);
	                     }, 5000);
	                 }
	             }
	         },
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
			animation:true,
			formatter: function () {
				var result = "";
				if(this.y==1){
					result = "一类";
				}else if(this.y==2){
					result = "二类";
				}else if(this.y==3){
					result = "三类";
				}else if(this.y==4){
					result = "四类";
				}
				return '' + this.x +
				'为<b>' + result + '</b><br/>首要污染物为因子<b>'+this.key+'</b>';
			}
		},
		series: [{
			data: data.ydatas,
			//隐藏底部的series1
			showInLegend: false
		}],
		xAxis: {
			//type: 'datetime',
            //tickPixelInterval: 150,
			categories:data.xtimes,
			labels: {
	           	 step:step
	        }
		},
		yAxis:{
			max:4,
			//设置纵坐标标题
			title:{
				enabled:false
			},
			//添加一条标示线
			plotLines:[{
		        color:'red',           //线的颜色，定义为红色
		        dashStyle:'solid',     //默认值，这里定义为实线
		        value:4,               //定义在那个值上显示标示线，这里是在x轴上刻度为3的值处垂直化一条线
		        width:2,              //标示线的宽度，2px
		        label:{
		            text:'',     //标签的内容
		            align:'right',                //标签的水平位置，水平居左,默认是水平居中center
		            x:10                         //标签相对于被定位的位置水平偏移的像素，重新定位，水平居左10px
		        }
		    }],
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
					}
					
                    return result;
                }
			}
		}
    });
};
function startmarquee(lh,speed,delay) {
	var p=false;
	var t;
	var o=document.getElementById("marqueebox");
	o.innerHTML+=o.innerHTML;
	o.style.marginTop=0;
	o.onmouseover=function(){p=true;}
	o.onmouseout=function(){p=false;}
	//欢迎来到站长特效网，我们的网址是www.zzjs.net，很好记，zz站长，js就是js特效，本站收集大量高质量js代码，还有许多广告代码下载。
	function start(){
	t=setInterval(scrolling,speed);
	if(!p) o.style.marginTop=parseInt(o.style.marginTop)-1+"px";
	}
	//欢迎来到站长特效网，我们的网址是www.zzjs.net，很好记，zz站长，js就是js特效，本站收集大量高质量js代码，还有许多广告代码下载。
	function scrolling(){
	if(parseInt(o.style.marginTop)%lh!=0){
	o.style.marginTop=parseInt(o.style.marginTop)-1+"px";
	if(Math.abs(parseInt(o.style.marginTop))>=o.scrollHeight/2) o.style.marginTop=0;
	}else{
	clearInterval(t);
	setTimeout(start,delay);
	}
	}//欢迎来到站长特效网，我们的网址是www.zzjs.net，很好记，zz站长，js就是js特效，本站收集大量高质量js代码，还有许多广告代码下载。
setTimeout(start,delay);
}//欢迎来到站长特效网，我们的网址是www.zzjs.net，很好记，zz站长，js就是js特效，本站收集大量高质量js代码，还有许多广告代码下载。

