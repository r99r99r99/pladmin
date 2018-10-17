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
										三亚河水质在线监测系统
										<small>
											<i class="icon-double-angle-right"></i>
											（海南.三亚）
										</small>
									</h1>
								</div>
								<div class="row">
									<div class="col-xs-12">
										<div class="widget-box">
											<div class="widget-header widget-header-flat">
												<h4>监测参数</h4>
											</div>
										</div>
										<div class="widget-body">
											<div class="widget-main">
												<h2>
													 &nbsp&nbsp&nbsp根据水质在线监测仪器设备配置标准、现场状况、使用期限以及个别原材料的采购周期的要求，
													 该站的监测参数选取如下：
													 <ul>
													 	<li>水质参数：水温、溶解氧、浊度、电导率、pH、盐度、流速、水位、硝酸盐、亚硝酸盐、氨氮、总磷、总氮</li>
													 </ul>
												</h2>
											</div>
										</div>
									</div>
								</div>
								<hr>
								<div class="row">
									<!-- <div class="col-xs-4">
									</div> -->
									<div class="col-xs-8">
										<div class="widget-box">
											<div class="widget-header widget-header-flat header-color-yle">
												<h4>EXO</h4>
											</div>
										</div>
										<div class="widget-body">
											<div class="widget-main">
												<div class="row">
													<div class="col-xs-6">
														<p style="font-size:16px;">
															<i class="icon-circle green"></i>
															作为一种智能、野外应用的水质监测平台。EXO具备非常广阔的水环境监测
															能力，可以从容应对如河流、湖泊、海洋、河口和地下水等多种水环境监测需求。
														</p>
														<p style="font-size:16px;">
															<i class="icon-circle green"></i>
															高效率的电源管理、坚固的结构、稳定的传感器性能和不需要化学药剂的防
															玷污系统，使EXO可以在维护间隔长达12周的情况下提供准确可靠的数据。
														</p>
														<p style="font-size:16px;">
															<i class="icon-circle green"></i>
															带有GPS功能和气压计的手持器、智能探头和不需电缆的操作使采样更加简单快捷。
														</p>
														<p style="font-size:16px;">
															<i class="icon-circle green"></i>
															在EXO平台内您将会发现众多革新设计使产品在进行水质测量和数据传输时
															更坚固耐用、更准确、更方便。
														</p>
													</div>
													<div class="col-xs-6">
														<img alt="" src="${ctx }/images/station/device/exo.jpg" width="70%">
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
				</div>
			</div>

	<script src="${ctx }/liaohe/js/station/stationShow_init.js"></script>
</body>
</html>
