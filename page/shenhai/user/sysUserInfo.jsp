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
	<%@ include file="../common/header.jsp" %>
	<script src="${ctx }/shenhai/resources/My97DatePicker/WdatePicker.js"></script>
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
							    <input type="text" class="form-control" ng-model="u.userName" >
						    </div>
						 </li>
					    <!-- <li><label>参数类型</label>   -->
					    <li><label class="control-label">状态</label>
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
	</div>		
	</section>
<script src="${ctx }/shenhai/js/user/sysUserInfo.js"></script>
<script type="text/ng-template" id="popupTmpl.html">  
<div class="page-content" style="">

	<div class="modal-header"> 
            <h3>{{user.realName}}</h3> 
    </div> 

		
	<div class="modal-body"> 
		<form class="form-horizontal" role="form" name="myForm"  novalidate>
			<input type="hidden" id="form-field-1" ng-model="user.id" />
			<input type="hidden" id="form-field-1" ng-model="user.companyId" />
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 用户名 </label>

				<div class="col-sm-5">
						<input type="text" ng-model="user.userName" name="userName"  placeholder="用户名" class="form-control" required />
						<span style="color:red" ng-show=" myForm.userName.$invalid">
						<span ng-show="myForm.userName.$error.required">用户名是必须的。</span>
						</span>
				</div>
			</div>
			<div class="space-4"></div>

			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 姓名 </label>

				<div class="col-sm-5">
						<input type="text" id="form-field-1" ng-model="user.realName" name="realName" class="form-control" required/>
						<span style="color:red" ng-show="myForm.realName.$invalid">
						<span ng-show="myForm.realName.$error.required">用户姓名是必须的。</span>
						</span>
				</div>
			</div>
			<div class="space-4"></div>

			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 手机 </label>

				<div class="col-sm-5">
						<input type="text" id="form-field-1" ng-model="user.telephone" name="telephone"  class="form-control" 
                          ng-pattern="/^[1][3-8]\d{9}$/" />
						<span ng-hide='myForm.telephone.$pristine || myForm.telephone.$valid' ng-show='myForm.telephone.$invalid'><span style="color:red">手机号码不正确.</span></span>
				</div>
			</div>
			<div class="space-4"></div>

			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 电话 </label>

				<div class="col-sm-5">
						<input type="text" id="form-field-1" ng-model="user.phone" name="phone"  ng-pattern="/^((\d{11})|(\d{7,8})|(\d{4}|\d{3})-(\d{7,8}))$/" class="form-control" />
						<span ng-hide='myForm.phone.$pristine || myForm.phone.$valid' ng-show='myForm.phone.$invalid'><span style="color:red">电话号码不正确.</span></span>
				</div>
			</div>
			<div class="space-4"></div>

			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 生日 </label>

				<div class="col-sm-5">
						<input  ng-model="user.birthday"  type="text" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" onchange="timeChange()" class="timeput" >
				</div>
			</div>
			<div class="space-4"></div>

			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> e-mail </label>

				<div class="col-sm-5">
						<input type="email" id="form-field-1" ng-model="user.email" name="email" class="form-control" />
						<span ng-hide='myForm.email.$pristine || myForm.email.$valid' ng-show='myForm.email.$invalid'><span style="color:red">Email不正确.</span></span>
				</div>
			</div>
			<div class="space-4"></div>

			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 状态 </label>

				<div class="col-sm-5">
							 <select id="selectError" ng-model="user.isactive" class="form-control"
                              ng-change="changeOption()" 
							  ng-options="option.value as option.name for option in isactivelist">
							 </select>
				</div>
			</div>
			<div class="space-4"></div>

			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 职业 </label>

				<div class="col-sm-5">
							 <select id="selectError" ng-model="user.positionId" class="form-control"
                              ng-change="changeOption()" 
							  ng-options="option.id as option.name for option in positionList">
							 </select>
				</div>
			</div>
			<div class="space-4"></div>

			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 公司 </label>

				<div class="col-sm-5">
						<multi-select-tree data-input-model="pcodelist" multi-select="false" ng-model="device"
                                   data-output-model="device" data-default-label="请选择所在单位."
                                   data-callback="selectOnly1Or2(item, selectedItems)"
								   data-switch-view-callback="switchViewCallback(scopeObj)"
                                   data-select-only-leafs="true"
                                   data-switch-view="false">
						</multi-select-tree>
				</div>
			</div>
			<div class="space-4"></div>

			<div class="clearfix form-actions">
				<div class="col-md-offset-3 col-md-9">
					<button class="btn btn-primary" type="button" ng-click="save()" 
						ng-disabled="myForm.userName.$invalid||
                                     myForm.realName.$invalid">
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
	