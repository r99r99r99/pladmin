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
	</style>
</head>
<body ng-app="myApp" ng-controller="customersCtrl" class="sticky-header left-side-collapsed">
			
		<script src="${ctx}/resources/common/js/common.js" type="text/javascript"></script>
		<script src="${ctx }/resources/My97DatePicker/WdatePicker.js"></script>
		<%@ include file="../common/header.jsp" %>
	<section>
		<%@ include file="../common/left.jsp" %>
		

		<!-- main content start-->
		<div id="main-content">
			<div class="container">
				<div class="row">
			<div id="content" class="col-lg-12">
			<div id="col-sm-12">
				<div class="page-header1" id="breadcrumbs">
						<script type="text/javascript">
							try{ace.settings.check('breadcrumbs' , 'fixed')}catch(e){}
						</script>
						
						<ul class="breadcrumb">
							<li>
								<a href="#">${currMenu.pMenuName }</a>
							</li>

							<li>
								<a href="${ctx }/passSettingInfo.do">密码修改</a>
							</li>
						</ul><!-- .breadcrumb -->
					</div>
					<div class="container-fluid">
					<div class="page-content" style="">
						<div class="page-header">
								<strong>
									{{user.realName}}
									<i class="icon-double-angle-right"></i>
								</strong>
						</div><!-- /.page-header -->
						
						<div class="row">
						<div class="col-xs-10">
							<form class="form-horizontal" role="form" name="myForm"  novalidate>
								<input type="hidden" id="form-field-1" ng-model="user.id" />
					
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 原密码 </label>
					
									<div class="col-sm-9">
											<input type="password" id="form-field-1" ng-model="user.password" name="oldPass" class="form-control ng-pristine ng-valid ng-touched" required/>
											<span style="color:red" ng-show="myForm.oldPass.$invalid">
											<span ng-show="myForm.oldPass.$error.required">请输入原密码</span>
											</span>
									</div>
								</div>
								<div class="space-4"></div>
					
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 新密码 </label>
					
									<div class="col-sm-9">
											<input type="password" id="form-field-1" ng-model="user.newPass" name="newPass" class="form-control ng-pristine ng-valid ng-touched" required/>
											<span style="color:red" ng-show="myForm.newPass.$invalid">
											<span ng-show="myForm.newPass.$error.required">请输入新密码</span>
											</span>
									</div>
								</div>
								<div class="space-4"></div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 新密码确认 </label>
					
									<div class="col-sm-9">
											<input type="password" id="form-field-1" ng-model="user.confimPass" name="confimPass" class="form-control ng-pristine ng-valid ng-touched" required/>
											<span style="color:red" ng-show="myForm.confimPass.$invalid">
											<span ng-show="myForm.confimPass.$error.required">请确认新密码</span>
											</span>
									</div>
								</div>
								<div class="space-4"></div>
					
					
								<div class="clearfix form-actions">
									<div class="col-md-offset-3 col-md-9">
										<button class="btn btn-primary" type="button" ng-click="save()" 
											ng-disabled="myForm.oldPass.$invalid||
					                                     myForm.newPass.$invalid||
					                                     myForm.confimPass.$invalid">
												保存
										</button>
									</div>
								</div>
							</form>	
						</div>
						<div>
					</div>
				</div>	
				</div></div></div>
			</div>
			 <!--body wrapper end-->
		</div>
		
        <!--footer section start--> 
        <!--footer section end-->
      <!-- main content end-->
	</section>
<script src="${ctx }/shenhai/js/user/passSettingInfo.js"></script>
<link rel="stylesheet" href="${ctx }/resources/angular-select-tree/angular-multi-select-tree-0.1.0.css" />
		<script type="text/javascript" src="${ctx }/resources/angular-select-tree/angular-multi-select-tree-0.1.0.js"></script>
		<script type="text/javascript" src="${ctx }/resources/angular-select-tree/angular-multi-select-tree-0.1.0.tpl.js"></script>	
</body>
</html>
