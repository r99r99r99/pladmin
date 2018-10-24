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
	<script src="${ctx }/shenhai/resources/common/js/common.js" type="text/javascript"></script>
	<script src="${ctx }/shenhai/resources/My97DatePicker/WdatePicker.js"></script>

	<%@ include file="../common/header.jsp" %>
		<script type="text/javascript" src="${ctx }/shenhai/resources/ueditor/ueditor.config.js"></script>
		<!-- <script type="text/javascript" src="http://ueditor.baidu.com/ueditor/ueditor.config.js"></script> -->
		<script type="text/javascript" src="${ctx }/shenhai/resources/ueditor/ueditor.all.js"></script>
  		<script type="text/javascript" src="${ctx }/shenhai/resources/ueditor/angular-ueditor.js"></script>
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
						<li><label>站点列表:</label>
						    <div class="vocation">
							    <select  ng-model="u.stationId" class="form-control" 
	                              ng-change="query()" 
								  ng-options="option.id as option.title for option in stationList">
								 </select>
						    </div>
					    </li>
					    <li><label>&nbsp;</label><input name="" type="button" class="btn btn-primary" ng-click="query()" value="查询"/></li>
					    <li><label>&nbsp;</label><input name="" type="button" class="btn btn-primary" ng-click="save()" value="保存"/></li>
					    <!-- <li><div ta-bind ng-model="u.mould"></div></li> -->
					    </ul>
					    </div>
						<div class="container-fluid">
						<div class="row-fluid">
							<div class="col-sm-12">
								<div id="cont" style="margin-bottom:1.25rem" config="config" class="ueditor" ng-model="u.infomation" ></div>
							</div>
						</div>
					</div>
			</div>
	</div>		
	</section>
<script src="${ctx }/shenhai/js/station/stationInfo_init.js"></script>	

</body>
</html>
	