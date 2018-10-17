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
        .modal-width{
           width:400px;}
        .header{
        	 padding-left: 0px;
			 padding-right: 0px;
        }
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
		.row-fluid .span6{width:48.93617021276595%;*width:48.88297872340425%;}
		.row-fluid .span4{width:31.914893617021278%;*width:31.861702127659576%;}
</style>
</head>
<body ng-app="myApp" ng-controller="customersCtrl" >
	<script src="${ctx}/resources/common/js/common.js" type="text/javascript"></script>
	<script src="${ctx }/resources/My97DatePicker/WdatePicker.js"></script>

	<%@ include file="../common/header.jsp" %>
		<script src="${ctx }/resources/My97DatePicker/WdatePicker.js"></script>
		<script src="${ctx}/resources/highcharts-ng/highcharts-ng.js" type="text/javascript"></script>
		<script src="${ctx}/resources/highcharts-ng/highstock.src.js"></script>
		<script src="${ctx}/resources/highcharts-ng/exporting.js"></script>
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
						<li><label>统计口径</label>
						  <div class="vocation">
							  <select  ng-model="collectType" class="form-control"
		                              ng-change="queryData()" 
									  ng-options="option.value as option.name for option in activelist">
								</select>
							</div>
					    </li>
					     <li><label>开始时间:</label>
					    <div class="vocation">
					    	<input name="startDate" id="startDate" placeholder="开始时间" value="${beginDate }" type="text" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" onchange="timeChange()" class="timeput" >
				        </div>
					    </li>
					    <li><label>结束时间:</label>
					    <div class="vocation">
					    	<input name="endDate" id="endDate" placeholder="结束时间" type="text" value="${endDate}" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" onchange="timeChange()"  class="timeput" />
				        </div>
					    </li>
					    
					    <li><label>&nbsp;</label><input name="" type="button" class="btn btn-primary" ng-click="queryData()" value="查询"/></li>
					    <!-- <li><label>&nbsp;</label><input name="" type="button" class="btn btn-primary" ng-click="exportData()" value="生成日报"/></li> -->
					    </ul>
					    </div>
						<div class="container-fluid" style="background-color: #FFFFFF">
								<div class="row-fluid">
									<div class="span6 chartsLine">
									
										<div id="piecontainer"></div>
										
									</div>
									<div class="span4 chartsLine">
										<div id="queryContainer" class="queryContainer"></div>		
									</div>
								</div>
							<div class="row-fluid">
									<div class="span12 chartsLine">
										<div id="linecontainer"></div>
									</div>
							</div>
		               </div>
			</div>
	</div>		
	</section>
<script src="${ctx }/shenhai/js/dataquery/statisquery_init.js"></script>
<script type="text/ng-template" id="popupTmpl.html">  
<div class="page-content" style="">
	<div class="page-header">
			<strong>
				{{m.name}}
				<i class="icon-double-angle-right"></i>
				<input type="button" value="打印" ng-click="print()" />
			</strong>
	</div><!-- /.page-header -->
	
	<div class="row">
	<div class="col-xs-12" id="printArea">
		谁谁谁水水水水
	</div>
	<div>
</div>			
</script> 
</body>
</html>
	