<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html >


<c:set var="ctx" value="${pageContext.request.contextPath}"/>
	<head>
		<meta charset="utf-8" />
		<title>${system.systemName }</title>
		<meta name="keywords" content="入海污染源" />
		
	</head>

	<body ng-app="myApp" ng-controller="customersCtrl">
		<%@ include file="../common/top.jsp" %>
		<%@ include file="../common/textAngular.jsp" %>
		
		<link rel="stylesheet" href="${ctx }/resources/angular-select-tree/angular-multi-select-tree-0.1.0.css" />
		<script type="text/javascript" src="${ctx }/resources/angular-select-tree/angular-multi-select-tree-0.1.0.js"></script>
		<script type="text/javascript" src="${ctx }/resources/angular-select-tree/angular-multi-select-tree-0.1.0.tpl.js"></script>
		
			
		<div class="main-container" id="main-container">
			<script type="text/javascript">
				try{ace.settings.check('main-container' , 'fixed')}catch(e){}
			</script>
			<div class="main-container-inner">
			<%@ include file="../common/leftMenu.jsp" %>

				<div class="main-content" >
					<div class="breadcrumbs" id="breadcrumbs">
						<script type="text/javascript">
							try{ace.settings.check('breadcrumbs' , 'fixed')}catch(e){}
						</script>
						
						<ul class="breadcrumb">
							<li>
								<i class="icon-home home-icon"></i>
								<a href="#">${currMenu.pMenuName }</a>
							</li>

							<li>
								<a href="#">${currMenu.cMenuName }</a>
							</li>
						</ul><!-- .breadcrumb -->
					</div>
					<div class="container-fluid">
					<div class="row-fluid">
						<div class="col-sm-12">
							<%-- ${infomation } --%>
							
							<div class="page-content">
								<div class="page-header">
									<h1>
										入海污染源岸基在线监测试点
										<small>
											<i class="icon-double-angle-right"></i>
											（辽宁.盘锦）
										</small>
									</h1>
								</div>
								<div class="row">
									<div class="col-xs-12">
										<div class="widget-box">
											<div class="widget-header widget-header-flat">
												<h4>整体介绍</h4>
											</div>
										</div>
										<div class="widget-body">
											<div class="widget-main">
												<h2>
													 &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp根据国家海洋局生态环境保护司“关于做好海洋生态环境在线监测相关技术支撑工作的通知”
													（海环字【2014】13号）要求，为积极推动入海污染源在线监测工作，开展入海污染源在线监测关键技术试点研究, 国家海洋环境监测中心会同
													国家海洋技术中心、国家海洋局海洋咨询中心、辽宁省海洋环境监测总站和盘锦市海洋环境监测预报中心站
													在辽河盘锦段开展入海污染源在线监测关键技术试点研究工作。
												</h2>
												<!-- <h2>
														&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp本次在线监测试点选址于辽河盘锦段（盘锦市大洼县新兴镇，N 41°07.183′， E 121°54.256′）,
														依托橡胶坝管理站站房建设辽河岸基在线监测系统，系统于2015年5月开始试运行，2016年7月
														通过验收。</br>
														&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp辽河岸基站的监测参数包括：水文气象参数（水位、流速、流向、气温、气压、湿度、风向、
														风速、降雨量等）；水质参数（pH、盐度、浊度、溶解氧、COD、石油类、硝酸盐、亚硝酸盐、
														氨氮、磷酸盐、总氮和总磷等）。
													</h2> -->
											</div>
										</div>
									</div>
								</div>
								<hr>
								<div class="row">
									<div class="col-sm-12">
										<div class="row">
											<div class="col-sm-4">
												<h2>
														&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp本次在线监测试点选址于辽河盘锦段（盘锦市大洼县新兴镇，N 41°07.183′， E 121°54.256′）,
														依托橡胶坝管理站站房建设辽河岸基在线监测系统，系统于2015年5月开始试运行，2016年7月
														通过验收。</br>
														&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp辽河岸基站的监测参数包括：水文气象参数（水位、流速、流向、气温、气压、湿度、风向、
														风速、降雨量等）；水质参数（pH、盐度、浊度、溶解氧、COD、石油类、硝酸盐、亚硝酸盐、
														氨氮、磷酸盐、总氮和总磷等）。
													</h2>
											</div>
											<div class="col-sm-8">
												<img alt="" src="${ctx }/images/station/map04.png" width="100%">
											</div>
										</div>
									</div>
								</div>
								<hr>
								<div class="row">
									<div class="col-sm-6">
										<div class="row">
											<div>
												<img alt="" src="${ctx }/images/station/zhandianhuanjing.jpg" width="90%">
											</div>
											<div>
												<img alt="" src="${ctx }/images/station/zhandianshebei.jpg" width="90%">
											</div>
										</div>
									</div>
									<div class="col-sm-6">
										<div class="row">
											<div>
												<img alt="" src="${ctx }/images/station/xitongzhengtijiagou.png" width="90%">
											</div>
											<div>
												<img alt="" src="${ctx }/images/station/yangpinfenxi.png" width="90%">
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>	
				</div>
				</div>
			</div>

	<script src="${ctx }/liaohe/js/station/stationShow_init.js"></script>
</body>
</html>
