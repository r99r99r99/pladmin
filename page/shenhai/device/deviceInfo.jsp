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
					<input type="hidden" ng-model="u.ids" />
					<li><label>模糊查询</label>
					    <div class="vocation">
						    <input type="text" class="form-control" ng-model="u.code" placeholder="按照code或者名称查询" >
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
	</section>
<script src="${ctx }/shenhai/js/device/deviceInfo.js"></script>
<script type="text/ng-template" id="popupTmpl.html"> 
<div class="page-content" style="">
    <div class="modal-header"> 
            <h4>
	    {{m.name}}
	    </h4> 
    </div> 
    <div class="modal-body"> 
		<form class="form-horizontal" role="form" name="myForm"  novalidate>
			<input type="hidden" id="form-field-1" ng-model="m.id" />
			<input type="hidden" id="form-field-1" ng-model="m.indicatorIds" />
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 设备名称 </label>

				<div class="col-sm-5">
						<input type="text" ng-model="m.name" name="name"  class="form-control" maxlength="10" required />
						<span style="color:red" ng-show=" myForm.name.$invalid">
						<span ng-show="myForm.name.$error.required">name是必须的。</span>
						</span>
				</div>
			</div>
			<div class="space-4"></div>

			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 设备编码 </label>

				<div class="col-sm-5">
						<input type="text" ng-model="m.code" name="code"   class="form-control" maxlength="30" required />
						<span style="color:red" ng-show=" myForm.code.$invalid">
						<span ng-show="myForm.code.$error.required">设备编码是必须的。</span>
						</span>
				</div>
			</div>
			<div class="space-4"></div>

			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> deviceModel </label>

				<div class="col-sm-5">
						<input type="text" ng-model="m.deviceModel" name="deviceModel" maxlength="10"   class="form-control"  />
				</div>
			</div>
			<div class="space-4"></div>

			<div class="form-group" id="pdiv">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 监测参数 </label>
				<input type="hidden" ng-model="m.indicatorIds" />
				<div class="col-sm-5">
						<multi-select-tree data-input-model="data" multi-select="true" ng-model="region"
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
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 介绍 </label>

				<div class="col-sm-5">
							 <textarea class="form-control" ng-model="m.brief" id="form-field-8" placeholder="" maxlength="50" rows=3 cols=20></textarea>
				</div>
			</div>
			<div class="space-4"></div>

			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 明细 </label>

				<div class="col-sm-5">
							 <textarea class="form-control" ng-model="m.detail" id="form-field-8" placeholder="" maxlength="50" rows=3 cols=20></textarea>
				</div>
			</div>
			<div class="space-4"></div>
			

			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 排序码 </label>

				<div class="col-sm-5">
						<input type="text" ng-model="m.orderCode" name="orderCode"  maxlength="10" class="form-control" />
				</div>
			</div>
			<div class="space-4"></div>

			
			<div class="clearfix form-actions">
				<div class="col-md-offset-3 col-md-9">
					<button class="btn btn-primary" type="button" ng-click="save()" 
						ng-disabled="myForm.code.$invalid||
                                     myForm.name.$invalid
									">
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
	