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
		<link rel="stylesheet" href="${ctx }/resources/zTree/css/zTreeStyle/zTreeStyle.css" type="text/css">
		<script type="text/javascript" src="${ctx }/resources/zTree/js/jquery.ztree.core-3.5.js"></script>
		<script type="text/javascript" src="${ctx }/resources/zTree/js/jquery.ztree.excheck-3.5.js"></script>
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
					<li><label>权限类型</label>
					    <div class="vocation">
						    <select  ng-model="type" class="form-control"
                              ng-change="query()" 
							  ng-options="option.classId as option.value for option in publicList">
							 </select>
					    </div>
				    </li>
				    <li><label>&nbsp;</label><input name="" type="button" class="btn btn-primary" ng-click="query()" value="查询"/></li>
				    <li><label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				                     </label><input name="" type="button" class="btn btn-primary" onclick="saveRoleMenuUser()" value="保存"/></li>
				    </ul>
				    </form>
				    
				    <div class="col_1">
				    	<div class="col-md-3 ">
				    		<div ui-grid="gridOptions" class="gridStylerole" ui-grid-selection style="width:100%"></div>
				    	</div>
				    	<div class="col-md-3">
				    		<div class="box border green" style="height:700px">
				    			<div class="box-title">
				    				<h4>人员列表</h4>
				    			</div>
				    			<div class="box-body" style="background-color: #F5F6F6">
				    				<ul id="tree" class="ztree" style="height:100%; overflow-x :auto; overflow-y :no"></ul>
				    			</div>
				    		</div>
				    	</div>
				    	<div class="clearfix"> </div>
				    </div>
						
			</div>
	</div>		
	</section>
<script src="${ctx }/shenhai/js/sms/smsStationInfo.js"></script>
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
			<input type="hidden" id="form-field-1" ng-model="role.id" />
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 权限名称 </label>

				<div class="col-sm-9">
						<input type="text" ng-model="role.name" name="userName"  placeholder="权限名称" class="col-xs-10 col-sm-5" required />
						<span style="color:red" ng-show=" myForm.userName.$invalid">
						<span ng-show="myForm.userName.$error.required">权限名称是必须的。</span>
						</span>
				</div>
			</div>
			<div class="space-4"></div>

			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 备注 </label>

				<div class="col-sm-9">
						<input type="text" id="form-field-1" ng-model="role.remark" name="realName" class="col-xs-10 col-sm-5"/>
						</span>
				</div>
			</div>
			<div class="space-4"></div>

			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 状态 </label>

				<div class="col-sm-9">
						<div class="input-group">
							 <select id="selectError" ng-model="role.isactive" class="form-control"
                              ng-change="changeOption()" 
							  ng-options="option.value as option.name for option in isactivelist">
							 </select>
						</div>
				</div>
			</div>
			<div class="space-4"></div>
		
			
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 权限类型 </label>

				<div class="col-sm-9">
						<div class="input-group">
							 <select id="selectError" ng-model="role.type" class="form-control" readonly
                              ng-change="changeOption()" 
							  ng-options="option.classId as option.value for option in cpublicList">
							 </select>
						</div>
				</div>
			</div>
			<div class="space-4"></div>

			<div class="clearfix form-actions">
				<div class="col-md-offset-3 col-md-9">
					<button class="btn btn-primary" type="button" ng-click="save()" 
						ng-disabled="myForm.userName.$invalid">
							保存
					</button>

				</div>
			</div>
		</form>	
	</div>
	<div>
</div>
</script>
</body>
</html>
	