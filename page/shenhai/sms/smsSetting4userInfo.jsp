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
			
		<script src="${ctx }/shenhai/resources/common/js/common.js" type="text/javascript"></script>
		<script src="${ctx }/shenhai/resources/My97DatePicker/WdatePicker.js"></script>
	<section>
		<%@ include file="../common/left.jsp" %>
		<link rel="stylesheet" href="${ctx }/shenhai/resources/angular-select-tree/angular-multi-select-tree-0.1.0.css" />
		<script type="text/javascript" src="${ctx }/shenhai/resources/angular-select-tree/angular-multi-select-tree-0.1.0.js"></script>
		<script type="text/javascript" src="${ctx }/shenhai/resources/angular-select-tree/angular-multi-select-tree-0.1.0.tpl.js"></script>

		<!-- main content start-->
		<div class="main-content">
			<%@ include file="../common/header.jsp" %>
			<div id="page-wrapper">
				<div class="breadcrumbs" id="breadcrumbs">
						<script type="text/javascript">
							try{ace.settings.check('breadcrumbs' , 'fixed')}catch(e){}
						</script>
						
						<ul class="breadcrumb">
							<li>
								<i class="glyphicon glyphicon-home"></i>
								<a href="#">${currMenu.pMenuName }</a>
							</li>

							<li>
								<a href="#">${currMenu.cMenuName }</a>
							</li>
						</ul><!-- .breadcrumb -->
					</div>
					<div class="container-fluid">
					<div id="editdiv" class="page-content" style="">
						<div class="page-header">
						</div><!-- /.page-header -->
						
						<div class="row">
						<div class="col-xs-12"  id ="ppdiv">
							<form class="form-horizontal" role="form" name="myForm"  novalidate>
							   <input type="hidden" ngmodel="sms.userId">
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 工作日 </label>
					
									<div class="col-sm-9">
											周一<input type="checkbox" ng-model="sms.mon" ng-true-value="1" ng-false-value="0" />
											周二<input type="checkbox" ng-model="sms.tues" ng-true-value="1" ng-false-value="0" />
											周三<input type="checkbox" ng-model="sms.wed" ng-true-value="1" ng-false-value="0" />
											周四<input type="checkbox" ng-model="sms.thur" ng-true-value="1" ng-false-value="0" />
											周五<input type="checkbox" ng-model="sms.fri" ng-true-value="1" ng-false-value="0" />
											周六<input type="checkbox" ng-model="sms.satur" ng-true-value="1" ng-false-value="0" />
											周天<input type="checkbox" ng-model="sms.sun" ng-true-value="1" ng-false-value="0" />
									</div>
								</div>
								<div class="space-4"></div>
					
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 间隔发送时间(小时) </label>
					
									<div class="col-sm-9">
											<input type="number" id="form-field-1" ng-model="sms.betweenTime" name="betweenTime" class="col-xs-10 col-sm-5" />
									</div>
								</div>
								<div class="space-4"></div>
					
								
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 是否接收短信 </label>
					
									<div class="col-sm-9">
											<select  ng-model="sms.isactive" class="form-control"
					                              ng-change="query()" 
												  ng-options="option.value as option.name for option in activelist">
											</select>
									</div>
								</div>
								<div class="space-4"></div>
					
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 上午发送时间 </label>
					
									<div class="col-sm-9">
										<div class="input-group">
											<input type="text" id="form-field-1" ng-model="sms.ambegin" name="ambegin" class="col-xs-6 col-sm-3" />
											<input type="text" id="form-field-1" ng-model="sms.amend" name="amend" class="col-xs-6 col-sm-3" />
										</div>
							`		</div>
								</div>
								<div class="space-4"></div>
					
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 下午发送时间 </label>
					
									<div class="col-sm-9">
											<div class="input-group">
												 <input type="text" id="form-field-1" ng-model="sms.pmbegin" name="pmbegin" class="col-xs-6 col-sm-3" />
												 <input type="text" id="form-field-1" ng-model="sms.pmend" name="pmend" class="col-xs-6 col-sm-3" />
											</div>
									</div>
								</div>
								<div class="space-4"></div>
					
								<div class="clearfix form-actions">
									<div class="col-md-offset-3 col-md-9">
										<button class="btn btn-primary" type="button" ng-click="save()" 
											ng-disabled="myForm.code.$invalid||
					                                     myForm.name.$invalid">
												保存
										</button>
					
										&nbsp; &nbsp; &nbsp;
										<button class="btn btn-primary" type="reset">
												重置
										</button>
									</div>
								</div>
								
							</form>	
						</div>
						<div>
					</div>	
				</div>
			</div>
			 <!--body wrapper end-->
		</div>
		
        <!--footer section start--> 
			<%@ include file="../common/footer.jsp" %>
        <!--footer section end-->
      <!-- main content end-->
	</section>
<script src="${ctx }/shenhai/js/sms/smsSetting4userInfo.js"></script>	
</body>
</html>
