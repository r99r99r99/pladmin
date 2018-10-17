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
	<script src="${ctx}/resources/common/js/common.js" type="text/javascript"></script>
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
						<form  role="form" name="myForm2" novalidate>
						<ul class="seachform">
					    <li><label>站点</label>
						    <div class="vocation">
							    <select  ng-model="u.wpId" class="form-control"
	                              ng-change="query()" 
								  ng-options="option.id as option.title for option in stationList">
								 </select>
						    </div>
					    </li>
					    <li><label>&nbsp;</label><input name="" type="button" class="btn btn-primary" ng-click="query()" value="查询"/></li>
					    <li><label>&nbsp;</label><input name="" type="button" class="btn btn-primary" ng-click="addUser()" value="新增"/></li>
					    <li><label>&nbsp;</label><input name="" type="button" class="btn btn-primary" ng-click="dele()" value="删除"/></li>
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
	</section>
<script src="${ctx }/shenhai/js/firstpage/firstPageShowInfo.js"></script>	
<script type="text/ng-template" id="popupTmpl.html">  

<div class="page-content" style="">
    <div class="modal-header"> 
            <h4>
	    {{user.realName}}
	    </h4> 
    </div> 
    <div class="modal-body"> 
		<form class="form-horizontal" role="form" name="myForm"  novalidate>
			<input type="hidden" id="form-field-1" ng-model="id" />
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 站点 </label>

				<div class="col-sm-5">
							 <select id="selectError" ng-model="wpId" class="form-control" name="wpId"
                              ng-change="changeStation()" 
							  ng-options="option.id as option.title for option in stationList" required>
							 </select>
							 <span style="color:red" ng-show=" myForm.wpId.$invalid">
								<span ng-show="myForm.wpId.$error.required">请选择站点。</span>
							 </span>
				</div>
			</div>
			<div class="space-4"></div>

			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 设备 </label>

				<div class="col-sm-5">
							 <select id="selectError" ng-model="deviceId" class="form-control" name="deviceId"
                              ng-change="changeDevice()" 
							  ng-options="option.id as option.name for option in deviceIdList" required>
							 </select>
							  <span style="color:red" ng-show=" myForm.deviceId.$invalid">
								<span ng-show="myForm.deviceId.$error.required">请选择设备。</span>
							  </span>
				</div>
			</div>
			<div class="space-4"></div>

			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 参数 </label>

				<div class="col-sm-5">
							 <select id="selectError" ng-model="indicatorId" class="form-control" name="indicatorId"
                              ng-change="changeOption()" 
							  ng-options="option.id as option.title for option in indicatorList" required>
							 </select>
							  <span style="color:red" ng-show=" myForm.indicatorId.$invalid">
								<span ng-show="myForm.indicatorId.$error.required">请选择参数。</span>
							 </span>
				</div>
			</div>
			<div class="space-4"></div>

			<div class="clearfix form-actions">
				<div class="col-md-offset-3 col-md-9">
					<button class="btn btn-info" type="button" ng-click="save()" 
						ng-disabled="myForm.wpId.$invalid||
									 myForm.indicatorId.$invalid||
									 myForm.deviceId.$invalid">
							保存
					</button>
				</div>
			</div>
			
		</form>	
    </div>
</div>

</script> 
</body>
</html>
	