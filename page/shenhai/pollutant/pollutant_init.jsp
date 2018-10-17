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

</head>
<body ng-app="myApp" ng-controller="customersCtrl" >

		<script src="${ctx }/resources/My97DatePicker/WdatePicker.js"></script>
		
	<%@ include file="../common/header.jsp" %>
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
						<input type="hidden" ng-model="u.title" />
						<li><label>统计参数:</label>
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
					    <li><label>统计口径:</label>
						    <div class="vocation">
							    <select  ng-model="u.type" class="form-control"
	                              ng-change="query()" 
								  ng-options="option.id as option.title for option in typeList">
								 </select>
						    </div>
					    </li>
					    <li><label>统计单位:</label>
						    <div class="vocation">
							    <select  ng-model="u.unit" class="form-control"
	                              ng-change="query()" 
								  ng-options="option.id as option.title for option in unitList">
								 </select>
						    </div>
					    </li>
					    <li><label>开始时间:</label>
					    <div class="vocation">
					    	<input name="startDate" ng-model="u.beginDate" id="startDate" placeholder="开始时间"  type="text" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" onchange="timeChange()" class="form-control" >
				        </div>
					    </li>
					    <li><label>结束时间:</label>
					    <div class="vocation">
					    	<input name="endDate" ng-model="u.endDate" id="endDate" placeholder="结束时间" value="${endDate }" type="text" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" onchange="timeChange()" class="form-control" >
				        </div>
					    </li>
					    <li><label>&nbsp;</label><input name="" type="button" class="btn btn-primary" ng-click="query()" value="查询"/></li>
					    </ul>
					    </div>
						<div class="container-fluid">
						<div class="row-fluid">
							<div class="span5">
								<div  ui-grid="gridOptions" ui-grid-selection ui-grid-pagination ui-grid-exporter class="gridStyle" ></div>
							</div>
						</div>
					</div>
			</div>
	</div>		
	</section>
<script type="text/javascript" src="${ctx }/shenhai/js/pollutant/pollutant_init.js"></script>	
</body>
</html>
	