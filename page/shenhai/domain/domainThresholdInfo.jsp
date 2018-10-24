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
</style>
</head>
<body ng-app="myApp" ng-controller="customersCtrl" >
	<script src="${ctx }/shenhai/resources/common/js/common.js" type="text/javascript"></script>
	<script src="${ctx }/shenhai/resources/My97DatePicker/WdatePicker.js"></script>

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
						
						<form  role="form" name="myForm2" novalidate>
						<ul class="seachform">
						<li><label>功能区</label>
						    <div class="vocation">
							    <select  ng-model="u.domainId" class="form-control"
	                              ng-change="query()" 
								  ng-options="option.id as option.name for option in domainList">
								 </select>
						    </div>
					    </li>
					    <li><label>&nbsp;</label><input name="" type="button" class="btn btn-primary" ng-click="query()" value="查询"/></li>
					    <li><label>&nbsp;</label><input name="" type="button" class="btn btn-primary" ng-click="addUser()" value="新增"/></li>
					    </ul>
					    </form>
						<div class="container-fluid">
							<div class="row-fluid">
								<div class="span5">
									<div  ui-grid="gridOptions" ui-grid-selection ui-grid-pagination ui-grid-exporter class="gridStyle" ></div>
								</div>
							</div>
						</div>	
				</div>
			</div>
	</div>		
	</section>
<script type="text/ng-template" id="popupTmpl.html">  
<div class="page-content" style="">
	<div class="page-header">
			<strong>
				{{role.name}}
				<i class="icon-double-angle-right"></i>
			</strong>
	</div><!-- /.page-header -->
	
	<div class="row">
	<div class="col-xs-12">
		<form class="form-horizontal" role="form" name="myForm"  novalidate>
	
			<input type="hidden" id="form-field-1" ng-model="m.domainId" />
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 监测参数 </label>
				<input type="hidden" ng-model="m.indicatorIds" />
				<div class="col-sm-5">
						<multi-select-tree data-input-model="data" multi-select="false" ng-model="region"
                                   data-output-model="indicators" data-default-label="请选择监测参数."
                                   data-callback="selectOnly1Or2(item, selectedItems)"
								   data-switch-view-callback="switchViewCallback(scopeObj)"
                                   data-select-only-leafs="true"
                                   data-switch-view="false">
						</multi-select-tree>
				</div>
			</div>
			<div class="space-4"></div>
			<div class="form-group">
				<div  ui-grid="gridOptions2" ui-grid-selection ui-grid-pagination ui-grid-exporter ui-grid-edit ui-grid-row-edit ui-grid-cellNav class="gridStyle3" ></div>
			</div>
			<div class="space-4"></div>
			

			<div class="clearfix form-actions">
				<div class="col-md-offset-3 col-md-9">
					<button class="btn btn-primary" type="button" ng-click="saveThres()" 
						ng-disabled="myForm.name.$invalid
									||myForm.code.$invalid
									||myForm.isactive.$invalid">
							保存
					</button>
					&nbsp;&nbsp;&nbsp;
					<button class="btn btn-primary" type="button" ng-click="deleThres()" 
						ng-disabled="myForm.name.$invalid
									||myForm.code.$invalid
									||myForm.isactive.$invalid">
							删除
					</button>

				</div>
			</div>
		</form>	
	</div>
	<div>
</div>
</script>
		<script src="${ctx }/shenhai/js/domain/domainThresholdInfo.js"></script>
		
</body>
</html>
	