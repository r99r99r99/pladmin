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
						<div style="word-wrap:break-word; overflow:hidden;">
					<ul class="seachform">
				    <li><label>模糊查询</label>
					    <div class="vocation">
					    	<input type="text" class="form-control" ng-model="u.userName" >
					    </div>
				    </li>
				    <li><label>&nbsp;</label><input name="" type="button" class="btn btn-primary" ng-click="showUser()" value="查询"/></li>
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
<script src="${ctx }/shenhai/js/sms/smsSettingInfo.js"></script>
<script type="text/ng-template" id="popupTmpl.html">  
<div class="page-content" style="">
    <div class="modal-header"> 
            <h4>
	    {{type.name}}
	    </h4> 
    </div> 
    <div class="modal-body"> 
		<form class="form-horizontal" role="form" name="myForm"  novalidate>
			<input type="hidden" id="form-field-1" ng-model="sms.id" />

			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 人员 </label>

				<div class="col-sm-5">
						<select  ng-model="sms.userId" class="form-control" name="userId" id="userId"
                              ng-change="infoUserSetting()" 
							  ng-options="option.id as option.realName for option in userList">
						</select>
				</div>
			</div>
			<div class="space-4"></div>
			
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 工作日 </label>

				<div class="col-sm-5">
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

				<div class="col-sm-5">
						<input type="number" id="form-field-1" ng-model="sms.betweenTime" name="betweenTime" class="form-control" />
				</div>
			</div>
			<div class="space-4"></div>

			
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 是否接收短信 </label>

				<div class="col-sm-5">
						<select  ng-model="sms.isactive" class="form-control"
                              ng-change="query()" 
							  ng-options="option.value as option.name for option in activelist">
						</select>
				</div>
			</div>
			<div class="space-4"></div>

			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 上午发送时间 </label>

				<div class="col-sm-5">
						<input type="text" id="form-field-1" ng-model="sms.ambegin" name="ambegin" class="form-control" />
						<input type="text" id="form-field-1" ng-model="sms.amend" name="amend" class="form-control" />
		`		</div>
			</div>
			<div class="space-4"></div>

			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 下午发送时间 </label>

				<div class="col-sm-5">
							 <input type="text" id="form-field-1" ng-model="sms.pmbegin" name="pmbegin" class="form-control" />
							 <input type="text" id="form-field-1" ng-model="sms.pmend" name="pmend" class="form-control" />
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
				</div>
			</div>
			
		</form>	
    </div>
</div>
</script> 
</body>
</html>
	