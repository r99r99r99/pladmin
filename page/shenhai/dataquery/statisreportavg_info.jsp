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
	        
	        .chartsLine {
				width: 100%;
				display:inline;
				float:left; 
			}
			.oneCharts {
				width: 100%;
				height:80%;
				display:inline;
				float:left; 
			}
			.twoCharts {
				width: 50%;
				height:80%;
				display:inline;
				float:left; 
			}
			.threeCharts {
				width: 50%;
				height:80%;
				display:inline;
				float:left; 
			}
	</style>
	
</style>
</head>
<body ng-app="myApp" ng-controller="customersCtrl" >
	<script src="${ctx}/resources/common/js/common.js" type="text/javascript"></script>
	<script src="${ctx }/resources/My97DatePicker/WdatePicker.js"></script>
		
	<%@ include file="../common/header.jsp" %>
		<script src="${ctx}/resources/highcharts-ng/highcharts-ng.js" type="text/javascript"></script>
		<script src="${ctx}/resources/highcharts-ng/highstock.src.js"></script>
		<script src="${ctx}/resources/highcharts-ng/exporting.js"></script>
		<script src="${ctx}/resources/common/js/common.js" type="text/javascript"></script>
	<!-- PAGE -->
	<section id="page">
	<%@ include file="../common/left.jsp" %>
	<div id="main-content">
		<div class="container">
				<div class="row">
					<div id="content" class="col-lg-12">
						<!-- PAGE HEADER-->
						<div class="row">
							<div class="col-sm-12">
								<div class="page-header">
									<!-- STYLER -->
									
									<!-- /STYLER -->
									<!-- BREADCRUMBS -->
									<ul class="breadcrumb">
										<li>
											<i class="fa fa-home"></i>
											<a href="#">${currMenu.pMenuName }</a>
										</li>
										<li>
											<a href="#">${currMenu.cMenuName }</a>
										</li>
									</ul>
								</div>
							</div>
						</div>
						<!-- /PAGE HEADER -->
						<div style="word-wrap:break-word; overflow:hidden;">
					<ul class="seachform">
					<input type="hidden" ng-model="u.stationId" />
					<li><label>参数:</label>
					    <div class="vocation">
						    <multi-select-tree data-input-model="u.indicatorTree" multi-select="false" ng-model="indicator"
                                   data-output-model="u.indicatorIds" data-default-label="请选择监测参数."
                                   data-callback="selectOnly1Or2(item, selectedItems)"
								   data-switch-view-callback="switchViewCallback(scopeObj)"
                                   data-select-only-leafs="true"
                                   data-switch-view="false">
							</multi-select-tree>
					    </div>
				    </li>
				    <li><label>统计类型:</label>
					    <div class="vocation">
						    <multi-select-tree data-input-model="u.statTypeTree" multi-select="true" ng-model="indicator"
                                   data-output-model="u.statTypes" data-default-label="请选择统计类型."
								   data-switch-view-callback="switchViewCallback(scopeObj)"
                                   data-select-only-leafs="true"
                                   data-switch-view="false">
							</multi-select-tree>
					    </div>
				    </li>
				    <li><label>统计口径:</label>
					    <div class="vocation">
						    <select id="selectError" ng-model="u.collectType" class="col-xs-10 col-sm-12 scinput"  name="collectType"
                              ng-change="query()" 	
							  ng-options="option.classId as option.value for option in typelist" required>
							 </select>
					    </div>
				    </li>
				    <li><label>开始时间:</label>
				    <div class="vocation">
				    	<input name="startDate" ng-model="u.beginDate" id="startDate" placeholder="开始时间"  type="text" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="timeput" >
			        </div>
				    </li>
				    <li><label>结束时间:</label>
				    <div class="vocation">
				    	<input name="endDate" ng-model="u.endDate" id="endDate" placeholder="开始时间" value="${endDate }" type="text" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="timeput" >
			        </div>
				    </li>
				    <li><label>&nbsp;</label><input name="" type="button" class="btn btn-primary" ng-click="query()" value="查询"/></li>
				    </ul>
				    </div>
					<div class="container-fluid">
						<div class="span5">
							<div  ui-grid="gridOptions" ui-grid-selection ui-grid-pagination ui-grid-exporter class="gridStyle2" ></div>
						</div>
						<div class="span5">
							<div id="container"></div>
						</div>
					</div>
			</div>
	</div>		
	</section>
<script src="${ctx }/shenhai/js/dataquery/statisreportavg_info.js"></script>	
</body>
</html>
	