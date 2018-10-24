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
					    <li><label>站点</label>
						    <div class="vocation">
							    <select  ng-model="u.wpId" class="form-control"
	                              ng-change="query()" 
								  ng-options="option.id as option.title for option in stationList">
								 </select>
						    </div>
					    </li>
					    <li><label>类型</label>
						    <div class="vocation">
							    <select  ng-model="u.type" class="form-control"
	                              ng-change="query()" 
								  ng-options="option.classId as option.value for option in typeList">
								 </select>
						    </div>
					    </li>
					     <li><label>操作状态</label>
						    <div class="vocation">
							    <select  ng-model="u.operate" class="form-control"
	                              ng-change="query()" 
								  ng-options="option.id as option.value for option in operateList">
								 </select>
						    </div>
					    </li>
					     <li><label>开始时间:</label>
					    <div class="vocation">
					    	<input name="startDate" ng-model="u.beginDate" id="startDate" placeholder="开始时间"  type="text" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" onchange="timeChange()" class="timeput" >
				        </div>
					    </li>
					    <li><label>结束时间:</label>
					    <div class="vocation">
					    	<input name="endDate" ng-model="u.endDate" id="endDate" placeholder="开始时间" value="${endDate }" type="text" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" onchange="timeChange()" class="timeput" >
				        </div>
					    </li>
					    <li><label>&nbsp;</label><input name="" type="button" class="btn btn-primary" ng-click="query()" value="查询"/></li>
					    <li><label>&nbsp;</label><input name="" type="button" class="btn btn-primary" ng-click="update()" value="处理"/></li>
					    </ul>
					    </div>
						<div class="container-fluid" >
						<div class="row-fluid">
							<div class="span5">
								<div  ui-grid="gridOptions" ui-grid-selection ui-grid-pagination ui-grid-exporter class="gridStyle" ></div>
							</div>
						</div>
				</div>
			</div>
	</div>		
	</section>
<script src="${ctx }/shenhai/js/warn/warnValueInfo.js"></script>
<script type="text/ng-template" id="popupTmpl.html"> 
<div class="page-content" style="">
    <div class="modal-header"> 
            <h4>
	    {{type.name}}
	    </h4> 
    </div> 
    <div class="modal-body"> 
		<form class="form-horizontal" role="form" name="myForm"  novalidate>
			<input type="hidden" id="form-field-1" ng-model="warn.id" />
			<input type="hidden" id="form-field-1" ng-model="warn.ids" />
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 操作状态 </label>

				<div class="col-sm-5">
							 <select id="selectError" ng-model="warn.operate" class="form-control" name="wpId"
                              ng-change="changeStation()" 
							  ng-options="option.id as option.title for option in operaList" required>
							 </select>
				</div>
			</div>
			<div class="space-4"></div>

			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 备注 </label>

				<div class="col-sm-5">
						<textarea class="form-control" ng-model="warn.flag" id="form-field-8" placeholder="" rows=3 cols=20></textarea>
				</div>
			</div>
			<div class="space-4"></div>


			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 说明 </label>

				<div class="col-sm-5">
						<textarea class="form-control" ng-model="warn.remark" id="form-field-8" placeholder="" rows=3 cols=20></textarea>
				</div>
			</div>
			<div class="space-4"></div>


			<div class="clearfix form-actions">
				<div class="col-md-offset-3 col-md-9">
					<button class="btn btn-primary" type="button" ng-click="save()" 
						ng-disabled="myForm.wpId.$invalid||
									 myForm.indicatorCode.$invalid">
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
</div>
</script> 
</body>
</html>
	