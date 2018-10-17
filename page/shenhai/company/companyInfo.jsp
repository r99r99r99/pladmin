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
						
						<div style="word-wrap:break-word; overflow:hidden;">
						<ul class="seachform">
						<li><label>模糊查询</label>
						    <div class="vocation">
							    <input type="text" class="form-control" ng-model="u.code" placeholder="按照code或者名称查询" >
						    </div>
						 </li>
					    <li><label>&nbsp;</label><input name="" type="button" class="btn btn-primary" ng-click="query()" value="查询"/></li>
					    <li><label>&nbsp;</label><input name="" type="button" class="btn btn-primary" ng-click="addUser()" value="新增"/></li>
					    <li><label>&nbsp;</label><input name="" type="button" class="btn btn-primary" ng-click="dele()" value="删除"/></li>
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
	</div>		
	</section>
<script src="${ctx }/shenhai/js/company/companyInfo.js"></script>
<script type="text/ng-template" id="popupTmpl.html"> 
<div class="page-content" style="">
	<div class="modal-header"> 
            <h3>
				{{m.name}}
			</h3> 
    </div> 
	<div class="modal-body"> 
			<form class="form-horizontal" role="form" name="myForm"  novalidate>
			<input type="hidden" id="form-field-1" ng-model="m.id" />
			<input type="hidden" id="form-field-1" ng-model="m.pcode" />
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> code </label>

				<div class="col-sm-5">
						<input type="text" ng-model="m.code" name="code"  class="form-control" required />
						<span style="color:red" ng-show=" myForm.code.$invalid">
						<span ng-show="myForm.code.$error.required">code是必须的。</span>
						</span>
				</div>
			</div>
			<div class="space-4"></div>

			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> pcode </label>

				<div class="col-sm-5">
						<multi-select-tree data-input-model="pcodelist" multi-select="false" ng-model="device"
                                   data-output-model="device" data-default-label="请选择上级功能区划."
                                   data-callback="selectOnly1Or2(item, selectedItems)"
								   data-switch-view-callback="switchViewCallback(scopeObj)"
                                   data-select-only-leafs="true"
                                   data-switch-view="false">
						</multi-select-tree>
				</div>
			</div>
			<div class="space-4"></div>

			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> name </label>

				<div class="col-sm-5">
						<input type="text" ng-model="m.name" name="name"   class="form-control" required />
						<span style="color:red" ng-show=" myForm.name.$invalid">
						<span ng-show="myForm.name.$error.required">name是必须的。</span>
						</span>
				</div>
			</div>
			<div class="space-4"></div>

			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> shortName </label>

				<div class="col-sm-5">
						<input type="text" ng-model="m.shortName" name="shortName"   class="form-control" required />
						<span style="color:red" ng-show=" myForm.shortName.$invalid">
						<span ng-show="myForm.shortName.$error.required">shortName是必须的。</span>
						</span>
				</div>
			</div>
			<div class="space-4"></div>

			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 状态 </label>

				<div class="col-sm-5">
							 <select id="selectError" ng-model="m.isactive" class="form-control"
                              ng-change="changeOption()" 
							  ng-options="option.value as option.name for option in isactivelist">
							 </select>
				</div>
			</div>
			<div class="space-4"></div>


			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> orderCode </label>

				<div class="col-sm-5">
						<input type="text" ng-model="m.orderCode" name="orderCode"   class="form-control" />
 						</span>
				</div>
			</div>
			<div class="space-4"></div>

			<div class="clearfix form-actions">
				<div class="col-md-offset-3 col-md-9">
					<button class="btn btn-primary" type="button" ng-click="save()" 
						ng-disabled="myForm.code.$invalid||
                                     myForm.pcode.$invalid||
                                     myForm.name.$invalid||
                                     myForm.shortName.$invalid">
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
	