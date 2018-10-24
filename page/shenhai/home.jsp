<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html >
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<head>
	<meta charset="utf-8" />
	<title>${system.systemName }</title>
	<meta name="keywords" content="入海污染源" />
	<style>
		#up_zzjs{border:1px solid #ccc;width:100%;height:100%;line-height:20px;overflow:hidden;}
		#up_zzjs p{color: black;position: static;font-weight:blod;}      
		
		#up_zzjs #up_li{list-style-type:none;margin:0;padding:0;margin-left:6px;}
		#up_zzjs #up_li a{font-size:12px; line-height:16px;}
</style>
</head>
<body ng-app="myApp" ng-controller="customersCtrl">
	<%@ include file="common/header.jsp" %>
	<!-- PAGE -->
	<section id="page">
	<%@ include file="common/left.jsp" %>
	<link href="<%=path %>/shenhai/css/map/openmap.css" rel="stylesheet"> 
	<link href="<%=path %>/shenhai/css/map/media.css" rel="stylesheet"> 
	
	<link rel="stylesheet" href="${ctx }/shenhai/resources/openlayersv3.20.1/css/ol.css" type="text/css">
	<script src="${ctx }/shenhai/resources/openlayersv3.20.1/build/ol.js" type="text/javascript"></script>
	<script src="${ctx }/shenhai/resources/highcharts-ng/highcharts-ng.js" type="text/javascript"></script>
	<script src="${ctx }/shenhai/resources/highcharts-ng/highstock.src.js"></script>
	
		<div id="main-content">
			<div class="container">
				<div class="row">
					<div id="content" class="col-lg-12">
						<!-- PAGE HEADER-->
						<div class="row">
							<div class="col-sm-12">
								<div class="page-header page-header-map">
									<!-- STYLER -->
									
									<!-- /STYLER -->
									<!-- BREADCRUMBS -->
									<ul class="breadcrumb">
										<li>
											<i class="fa fa-home"></i>
											<a href="#">首页</a>
										</li>
									</ul> 
								</div>
							</div>
						</div>
						<!-- /PAGE HEADER -->
						<div class="content-wrap">
							<div id="map" class="map">
								<div id="popup"></div>
								<div id="location" class="location1"></div>
								<div id="layerbox" class="layerbox usel" style="position:absolute;z-index:999;right: 0px; top: 10px; right: 20px">
									 
									 <div class="ui3-control-shadow" ng-click="showlayersControl();">
									 	<img class="ui3-control-icon" src="login/images/location 2.png" />
									 	<div class="ui3-control-span">&nbsp;&nbsp;站点列表</div>
									 </div>
				                </div>
				                
				             	
				             	<!--  地图左上的站点列表-->
				             	<div id='layersControl'> 
				             		<div class="box border blue noborder">
				             			<div class="box-title">
				             				站点列表
				             				<div class="tools">
				             					<a ng-click="showlayersControl();"><i class="fa fa-times"></i></a>
				             				</div>
				             			</div>
				             			
				             			<div class="box-body nopadding">
				             				<div ng-repeat="x in stations" id="{{x.id}}" name="station" class="well noborder-radius" style="cursor:pointer;"  
				             					ng-click="showStationDetail(this.x)">
				             					<div class="form-group">
					             					<label class="col-md-4 control-label">
					             						 <img class="media-object"  height="64px" width="64px"
						                                alt="64x64" ng-src="{{x.pic}}">
					             					</label>
					             					<div class="col-md-8">
					             						<h5>{{x.title}}</h5>
						                                <a>运行正常</a>
					             					</div>
				             					</div>
											</div>
				             			</div>
				             		</div>
								</div>
								
								
								<!-- 点击某个站点后,显示的站点的详细信息 -->
								<div id='stationLayers' class="box border red"> 
									<div class="box-title">
										<div class="tools"><a ng-click="closeStationLayers()"><i class="fa fa-times"></i></a></div>
									</div>
										<div class="col-xs-12 col-sm-4 well noborder"  style="height:220px;">
					             			<div id="up_zzjs">
												<div id="marqueebox"></div>
											</div> 
					             		</div>
					             		<div  class="col-xs-12 col-sm-3 well noborder" style="height:220px;">
					             			<div class="col-xs-6 col-sm-6 " style="margin: 0 auto;text-align:center;">
												<div >
													<img alt="" id="gradeImg" style="margin-top:20px;height:180px;text-align:center;" />
												</div>
											</div>
											<div class="col-xs-6 col-sm-6 " style="text-align:center">
												<h3><span style="color: inherit;">{{stand.levelValue}}</span>
												</h3>
												<%-- ${mould } --%>
												<!-- {{htmlVariable}} -->
												<!-- <div id="htmlVariable"></div> -->
											</div>
					             		</div>
					             		<div  class="col-xs-12 col-sm-5 nopadding well noborder">
					             				<div id="container" ></div>
					             		</div>
								</div>
								
								<!-- 显示功能区选项 -->
							</div>
						</div>
					</div>	
				</div>
			</div>
		</div>
	</section>
	<script src="${ctx }/shenhai/js/firstpage/homeinfoshan.js"></script>
</body>
</html>
	