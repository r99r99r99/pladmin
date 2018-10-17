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
var coor;
var stationList ;
var url_i,format,version,tiled_i,styles_i,transparent,layers,code;

var maxLevel ;
var sclist;
myApp.controller('customersCtrl',function($scope,$http,ngDialog,$modal,$timeout){
	//添加一下内容防止输出乱码
	$http.defaults.headers.post['Content-Type'] = 'application/json;charset=utf-8';  
	$http.defaults.headers.post['Accept'] = 'application/json, text/javascript, */*; q=0.01';  
	$http.defaults.headers.post['X-Requested-With'] = 'XMLHttpRequest';
	//读取站点的列表
	$scope.getStationsByUser=function(){
		$http({
			method:'POST',
			url:'getStationByUser.do',
			params:''})
			.success(function(stations){
				//初始化站点列表
				var airContent = new Array();
				$scope.stations = stations;
				
				$scope.updateStationStatus();
			});
	};
	//读取地图的配置信息,并根据配置信息加载地图
	$scope.getMapConfig=function(){
	var mapData = "";
		$http({
			 method:'POST',
			 url:'getMapConfigure.do',
			 params:mapData})
			 .success(function(response){
				 url_i=response.url;
				 format=response.format;
				 version=response.version;
				 tiled_i=response.tiled;
				 styles_i=response.styles;
				 transparent=response.transparent;
				 layers=response.layers;
				 code=response.code;
				 mzoom=response.initZoom;
				 maxz=response.maxZoom;
				 minz=response.minZoom;
				 $scope.showMap();
			 });
	};
	$scope.showMap=function(){
		var projection = new ol.proj.Projection({
			code: 'EPSG:4326',
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
	    
	    //百度地图
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
	    //谷歌地图
	    var googleMapLayer = new ol.layer.Tile({  
            source: new ol.source.XYZ({  
                url: 'http://www.google.cn/maps/vt/pb=!1m4!1m3!1i{z}!2i{x}!3i{y}!2m3!1e0!2sm!3i380072576!3m8!2szh-CN!3scn!5e1105!12m4!1e68!2m2!1sset!2sRoadmap!4e0!5m1!1e0'  
            })  
        });  
	    ///自定义地图
	    var format = 'image/png';
	  
	    var tiled = new ol.layer.Tile({
	         visible: true,
	         source: new ol.source.TileWMS({
	           url: url_i,
	           
	           params: {'FORMAT': format, 
	                    'VERSION': version,
	                    tiled: tiled_i,
	                 STYLES: styles_i,
	                 transparent:transparent,
	                 LAYERS: layers
	           }
	         })
	       });
	    
	    ////必应地图 begin////
	   // var attribution = new ol.Attribution({  
	   //     html: '? <a href="http://www.chinaonmap.com/map/index.html">���ͼ</a>'  
	   // }); 
	   /* var layers=[];  
	    layers.push(  
	            new ol.layer.Tile({  
	                source: new ol.source.XYZ({  
	                   // attributions: [attribution],  
	                    url: "http://t2.tianditu.com/DataServer?T=vec_w&x={x}&y={y}&l={z}"  
	                })  
	            })  
	           );  
	      layers.push(new ol.layer.Tile({  
	                source: new ol.source.XYZ({  
	                    url: "http://t2.tianditu.com/DataServer?T=cva_w&x={x}&y={y}&l={z}"  
	                })  
	            }));  */
	      ////必应地图 end////
	    //显示鼠标的位置
	    var mousePositionControl = new ol.control.MousePosition({
	    	projection:'EPSG:4326',
		    className: 'custom-mouse-position',
		    target: document.getElementById('location'),
		    coordinateFormat: ol.coordinate.toStringHDMS,
		    undefinedHTML: '&nbsp;'
	      });
	    map = new ol.Map({
	    	controls: ol.control.defaults({
		           attribution: false
		         }).extend([mousePositionControl]),
	        target: 'map',
	        layers: [tiled],
	        view: new ol.View({
	        	projection:ol.proj.Projection({  
	        	    code:code
	        	}) , 
	        	zoom: mzoom,  
	            minZoom: minz,  
	            maxZoom: maxz
	        })
	    });
	    
	  //点击站点后的弹出框
	    element= document.getElementById('popup');
	    lay = document.getElementById("stationLayers");   //地图下方展示的实时数据,水质等级等
     	
		
	    $scope.getStationsByUser();
	};
	//获得当前SESSION中保持的站点信息
	$scope.getStation=function(){
		$http({
			method:'POST',
			url:'getStation.do',
			params:''})
			.success(function(station){
				console.log(station);
				coor = ol.proj.transform([station.longitude,station.latitude], 'EPSG:4326', 'EPSG:3857');
				console.log(coor);
				$scope.getMapConfig();
			});
	};
	
	$scope.getStation();
	//展示出站点的列表
	$scope.showlayersControl=function(){
   	 var lay = document.getElementById("layersControl");
   	var lo=document.getElementById("location");
   	 if(lay.style.display=="block"){
   		 lay.style.display="none"
   	 }else{
   		 lay.style.display="block";
   	 }
    };
   
  //展开站点详情列表
    $scope.showStationDetail=function(station){
    	var dp = {id:station.id};
    	$http({
   		 method:'POST',
   		 url:'getWaterStandardConfigListByStationId.do',
   		 params:dp})
   		 .success(function(res){
   			 	maxLevel = res.length;
   			 	sclist = res;
   		 });
    	
    	var ifconn = '未连接';
    	var distance = 0;
    	angular.forEach(stationList, function(st){
    		if(st.stationId==station.id){
    			console.log(station);
    			console.log(st);
    			station.longitude = st.longitude;
    			station.latitude = st.latitude;
    			if(st.ifConn!=null&&st.ifConn>0){
        			ifconn = '已连接';
        		}
    			distance = st.distance.toFixed(2);
    		}
    	});
    	
    	if(stat!=null){ //将原来的选中的div恢复到初始状态
    		stat.style.backgroundColor = "#f5f5f5";
    	}
    	stat = document.getElementById(station.id);
    	if(stat!=null){ //将原来的选中的div恢复到初始状态
    		stat.style.backgroundColor = "#EAE7E7";
    	}
    	
    	 $scope.showLastData(station);
 	 	var lay = document.getElementById("stationLayers");
    		 lay.style.display="block";
    		$(elementclick).popover('destroy');
    		
    		//展示该站点的复选框
    		element = document.getElementById('popup');
    		$(element).popover('destroy');
    		var coordinates = ol.proj.transform([station.longitude,station.latitude], 'EPSG:4326', code);
    		popup = null;
    		popup = new ol.Overlay({
				element: element,
				positioning: 'bottom-center',
				stopEvent: false,
				offset: [99, -120]
			});
    		
    		popup.setPosition(coordinates);
    		var jing = ol.coordinate.toStringHDMS([station.longitude,station.latitude],1);
    		console.log(coordinates);
    		console.log(jing);
			
			$(element).popover({
				'placement': 'right',
				'html': true,
				'content': station.title 
						  +'<br/>'
						  +'站点位置:'+jing+'<br/>'
						 // +'站点经度:'+station.longitude+'<br/>'
						  +'偏移距离:'+distance+'米<br/>'
						  +'网络状况:'+ifconn+'<br/>'
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
     	$(element).popover('destroy');
     }
     
     
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
    		$http({
    			 method:'POST',
    			 url:'getDatas4Firstpage.do',
    			 params:sparams})
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
 							if(rdata[m].unitName==null||rdata[m].unitName.length<1){
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
 					var srcpath = "page-images/watertype"+maxLevel+"/"+waterStandard.standard_grade+"grade.png";
 					$("#gradeImg").attr('src',srcpath);
					$scope.stand = waterStandard;
    			 }); 
    	
     };
     
   //定时更新站点的状态信息
   $scope.updateStationStatusintervalId=function(){
	   stationintervalId = setInterval(function() {
		   $scope.updateStationStatus();
		}, "600000"); //每隔1分刷新数据  
   }
   $scope.updateStationStatus=function(){
	   //更新地图上站点的图标以及状态
	   var mData = "";
	   $http({
			 method:'POST',
			 url:'getStationStatusList.do',
			 params:mData})
			 .success(function(stations){
				 console.log(stations);
				 stationList = stations;
				 map.removeLayer(vectorLayer);
				 var startMarkers = new Array();
				   angular.forEach(stations, function(station){
					   var lon = parseFloat(station.longitude) + 1000;
						var lat = parseFloat(station.latitude)+1000;
				    	 var startMarker = new ol.Feature({
				    		stationId:station.stationId,
				 	        type: station.ifConnIcon,
				 	        rainfall: 500,
				 	        geometry: new ol.geom.Point(ol.proj.transform([station.longitude,station.latitude], 'EPSG:4326', code))
				 	       //  geometry: new ol.geom.Point(ol.proj.transform(lport, 'EPSG:4326', code))
				      		//geometry: new ol.geom.Point([res.latitude,res.longitude])
				    	 });
				    	 startMarkers.push(startMarker);
				    	 
				    	 coor = ol.proj.transform([station.longitude,station.latitude], 'EPSG:4326', code);
				    	 var view = map.getView();
						 view.setCenter(coor);
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
/*							           anchor: [0.5, 46],
							           anchorXUnits: 'fraction',
							           anchorYUnits: 'pixels',
*/							            src: 'images/station/icon/'+feature.get('type')
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
		for(var k=0;k<sclist.length;k++){
	 		var config = sclist[k];
	 		if(this.value==config.classId){
	 			result = config.className;
	 		}
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
	max:maxLevel,
	//设置纵坐标标题
	title:{
		enabled:false
	},
	labels:{
		formatter: function () {
			var result = "";
			for(var k=0;k<sclist.length;k++){
		 		var config = sclist[k];
		 		if(this.value==config.classId){
		 			result = config.className;
		 		}
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

