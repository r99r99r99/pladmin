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
	<link rel="stylesheet" href="${ctx }/resources/angular-select-tree/angular-multi-select-tree-0.1.0.css" />
	<script type="text/javascript" src="${ctx }/resources/angular-select-tree/angular-multi-select-tree-0.1.0.js"></script>
	<script type="text/javascript" src="${ctx }/resources/angular-select-tree/angular-multi-select-tree-0.1.0.tpl.js"></script>
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
							    <input type="text" class="form-control" ng-model="u.code" />  
						    </div>
						 </li>
					    <!-- <li><label>参数类型</label>   -->
					    <li><label>状态</label>
						    <div class="vocation">
							    <select  ng-model="u.isactive" class="form-control"
	                              ng-change="query()" 
								  ng-options="option.value as option.name for option in activelist">
								 </select>
						    </div>
					    </li>
					    <li><label>&nbsp;</label><input name="" type="button" class="btn btn-primary" ng-click="query()" value="查询"/></li>
					    <li><label>&nbsp;</label><input name="" type="button" class="btn btn-primary" ng-click="addUser()" value="新增"/></li>
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
<script type="text/javascript" src="${ctx }/shenhai/js/station/stationInfo.js"></script>
<script type="text/ng-template" id="popupTmpl.html">  
<div class="page-content" style="">
    <div class="modal-header"> 
            <h4>
	   {{station.title}}
	    </h4> 
    </div> 
    <div class="modal-body"> 
		<form class="form-horizontal" role="form" name="myForm"  novalidate>
			<input type="hidden" id="form-field-1" ng-model="type.id" />
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> code </label>

				<div class="col-sm-5">
						<input type="text" ng-model="station.code" name="code"  placeholder="code" class="form-control" maxlength="10" required />
						<span style="color:red" ng-show=" myForm.code.$invalid">
						<span ng-show="myForm.code.$error.required">code是必须的。</span>
						</span>
				</div>
			</div>
			<div class="space-4"></div>

			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 站点名称 </label>

				<div class="col-sm-5">
						<input type="text" id="form-field-1" ng-model="station.title" name="name" class="form-control" maxlength="10" required/>
						<span style="color:red" ng-show="myForm.name.$invalid">
						<span ng-show="myForm.name.$error.required">站点名称是必须的。</span>
						</span>
				</div>
			</div>
			<div class="space-4"></div>


			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 维度 </label>

				<div class="col-sm-5">
							 <input type="number" id="form-field-1" ng-model="station.latitude" name="latitude" class="form-control"/>
				</div>
			</div>
			<div class="space-4"></div>

			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 经度 </label>

				<div class="col-sm-5">
							 <input type="number" id="form-field-1" ng-model="station.longitude" name="longitude" class="form-control"/>
				</div>
			</div>
			<div class="space-4"></div>

			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 站点地址 </label>

				<div class="col-sm-5">
							 <input type="text" id="form-field-1" ng-model="station.station_gateway" name="station_gateway" class="form-control"/>
				</div>
			</div>
			<div class="space-4"></div>
	
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 站点类型 </label>

				<div class="col-sm-5">
							 <select id="selectError" ng-model="station.stationtype_id" class="form-control"
                              ng-change="changeOption()"  
							  ng-options="option.id as option.name for option in stationtypelist">
							 </select>
				</div>
			</div>
			<div class="space-4"></div>


			<div class="form-group" id="pdiv">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 站点地区 </label>
				<input type="hidden" ng-model="station.region_id" />
				<div class="col-sm-5">
						<multi-select-tree data-input-model="data" multi-select="false" ng-model="region"
                                   data-output-model="region" data-default-label="请选择地区名称."
                                   data-callback="selectOnly1Or2(item, selectedItems)"
								   data-switch-view-callback="switchViewCallback(scopeObj)"
                                   data-select-only-leafs="false"
                                   data-switch-view="false">
						</multi-select-tree>
				</div>
			</div>
			<div class="space-4"></div>

			<div class="form-group" id="pdiv">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 所属单位 </label>
				<input type="hidden" ng-model="station.companyId" />
				<div class="col-sm-5">
						<multi-select-tree data-input-model="comdata" multi-select="false" ng-model="companyId"
                                   data-output-model="companyId" data-default-label="请选择所属单位."
                                   data-callback="selectOnly1Or2(item, selectedItems)"
								   data-switch-view-callback="switchViewCallback(scopeObj)"
                                   data-select-only-leafs="false"
                                   data-switch-view="false">
						</multi-select-tree>
				</div>
			</div>
			<div class="space-4"></div>

			<div class="form-group" id="pdiv">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 包含设备 </label>
				<input type="hidden" ng-model="station.deviceIds" />
				<div class="col-sm-5">
						<multi-select-tree data-input-model="deviceList" multi-select="true" ng-model="device"
                                   data-output-model="k.devices" data-default-label="请选择包含设备."
                                   data-callback="selectOnly1Or2(item, selectedItems)"
								   data-switch-view-callback="switchViewCallback(scopeObj)"
                                   data-select-only-leafs="true"
                                   data-switch-view="false">
						</multi-select-tree>
				</div>
			</div>
			<div class="space-4"></div>
			
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 站点描述 </label>

				<div class="col-sm-5">
						<div class="input-group">
							 <textarea class="form-control" ng-model="station.brief" id="form-field-8" maxlength="50" placeholder="" rows=3 cols=20></textarea>
						</div>
				</div>
			</div>
			<div class="space-4"></div>

			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 站点细节 </label>

				<div class="col-sm-5">
						<div class="input-group">
							 <textarea class="form-control" ng-model="station.detail" id="form-field-8" maxlength="50" placeholder="" rows=3 cols=20></textarea>
						</div>
				</div>
			</div>
			<div class="space-4"></div>


			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 状态 </label>

				<div class="col-sm-5">
							 <select id="selectError" ng-model="station.isactive" class="form-control"
                              ng-change="changeOption()" 
							  ng-options="option.value as option.name for option in isactivelist">
							 </select>
				</div>
			</div>
			<div class="space-4"></div>

			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 水质类型 </label>

				<div class="col-sm-5">
							 <select id="selectError" ng-model="station.waterType" class="form-control"
                              ng-change="changeOption()" 
							  ng-options="option.classId as option.value for option in waterTypelist">
							 </select>
				</div>
			</div>
			<div class="space-4"></div>

			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 排序编码 </label>

				<div class="col-sm-5">
							 <input type="text" id="form-field-1" ng-model="station.orderCode" name="orderCode" class="form-control"/>
				</div>
			</div>
			<div class="space-4"></div>
			
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 短信 </label>

				<div class="col-sm-5">
							 <select id="selectError" ng-model="station.ifsms" class="form-control"
							  ng-options="option.value as option.name for option in ifSmslist">
							 </select>
				</div>
			</div>
			<div class="space-4"></div>

			<div class="clearfix form-actions">
				<div class="col-md-offset-3 col-md-9">
					<button class="btn btn-info" type="button" ng-click="save()" 
						ng-disabled="myForm.code.$invalid||
                                     myForm.name.$invalid">
						<i class="icon-ok bigger-110"></i>
							保存
					</button>

					&nbsp; &nbsp; &nbsp;

					<button class="btn btn-info" type="button" ng-click="maketable()" >
						<i class="icon-ok bigger-110"></i>
							生成元数据表
					</button>
				</div>
			</div>
			
		</form>	
    </div>
</div>
</script> 
</body>
</body>
</html>
	