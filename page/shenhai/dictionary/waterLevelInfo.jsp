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
						<div style="word-wrap:break-word; overflow:hidden;">
						<ul class="seachform">
						<li><label>模糊查询</label>
						    <div class="vocation">
							    <input type="text" class="form-control" ng-model="u.item" placeholder="按照code或者名称查询" >
						    </div>
						 </li>
					    <!-- <li><label>参数类型</label>   -->
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
	</section>
<script src="${ctx }/shenhai/js/dictionary/waterLevelInfo.js"></script>
<script type="text/ng-template" id="popupTmpl.html">
<div class="page-content" style="">
    <div class="modal-header"> 
            <h4>
	    {{group.item}}
	    </h4> 
    </div> 
    <div class="modal-body"> 
		<form class="form-horizontal" role="form" name="myForm"  novalidate>
			<input type="hidden" id="form-field-1" ng-model="group.id" />
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 参数 </label>

				<div class="col-sm-5">
							 <select id="selectError" ng-model="group.item" name="item" class="form-control"
                              ng-change="changeOption()" 
							  ng-options="option.code as option.title for option in indicatorlist" required>
							 </select>
						<span style="color:red" ng-show="myForm.item.$invalid">
						<span ng-show="myForm.item.$error.required">参数是必须的。</span>
						</span>
				</div>
			</div>
			<div class="space-4"></div>

			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 分组 </label>

				<div class="col-sm-5">
							 <select id="selectError" ng-model="group.waterType" class="form-control" name ="waterType"
                              ng-change="getLevelList()" 
							  ng-options="option.classId as option.value for option in typelist" required>
							 </select>
						<span style="color:red" ng-show="myForm.waterType.$invalid">
						<span ng-show="myForm.waterType.$error.required">分组是必须的。</span>
						</span>
				</div>
			</div>
			<div class="space-4"></div>

			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 水质等级 </label>

				<div class="col-sm-5">
							 <select id="selectError" ng-model="group.standardId" class="form-control" name ="standardId"
                              ng-change="changeOption()" 
							  ng-options="option.classId as option.className for option in levelList" required>
							 </select>
						<span style="color:red" ng-show="myForm.standardId.$invalid">
						<span ng-show="myForm.standardId.$error.required">水质等级是必须的。</span>
						</span>
				</div>
			</div>
			<div class="space-4"></div>

			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 上限 </label>

				<div class="col-sm-5">
						<input type="number" id="form-field-1" ng-model="group.max_value" name="max_value" class="form-control" required/>
						<span style="color:red" ng-show="myForm.max_value.$invalid">
						<span ng-show="myForm.max_value.$error.required">等级上限是必须的。</span>
						</span>
				</div>
			</div>
			<div class="space-4"></div>

			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 上限计算方式 </label>

				<div class="col-sm-5">
							 <select id="selectError" ng-model="group.max" class="form-control" name ="max"
							  ng-options="option.id as option.value for option in maxlist" required>
							 </select>
						<span style="color:red" ng-show="myForm.max.$invalid">
						<span ng-show="myForm.max.$error.required">上限计算是必须的。</span>
						</span>
				</div>
			</div>
			<div class="space-4"></div>

			
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 下限 </label>

				<div class="col-sm-5">
						<input type="number" id="form-field-1" ng-model="group.min_value" name="min_value" class="form-control" required/>
						<span style="color:red" ng-show="myForm.min_value.$invalid">
						<span ng-show="myForm.min_value.$error.required">等级下限是必须的。</span>
						</span>
				</div>
			</div>
			<div class="space-4"></div>

			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 下限计算方式 </label>

				<div class="col-sm-5">
							 <select id="selectError" ng-model="group.min" class="form-control" name ="min"
							  ng-options="option.id as option.value for option in minlist" required>
							 </select>
						<span style="color:red" ng-show="myForm.min.$invalid">
						<span ng-show="myForm.min.$error.required">下限计算是必须的。</span>
						</span>
				</div>
			</div>
			<div class="space-4"></div>

			
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 备注 </label>

				<div class="col-sm-5">
							 <textarea class="form-control" ng-model="group.remarks" id="form-field-8" placeholder="" rows=3 cols=20></textarea>
				</div>
			</div>
			<div class="space-4"></div>


			<div class="clearfix form-actions">
				<div class="col-md-offset-3 col-md-9">
					<button class="btn btn-primary" type="button" ng-click="save()" 
						ng-disabled="myForm.min_value.$invalid||
									 myForm.waterType.$invalid||
									 myForm.standardId.$invalid||
									 myForm.min.$invalid||
									 myForm.max.$invalid||
									 myForm.item.$invalid||
                                     myForm.max_value.$invalid">
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
	