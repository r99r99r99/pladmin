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
						<div class="page-content" style="">
						    <div class="modal-header"> 
						            <h4>
							   			 地图编辑
							    	</h4> 
						    </div> 
						    <div class="modal-body"> 
								<form class="form-horizontal" role="form" name="myForm"  novalidate>
									<input type="hidden" id="form-field-1" ng-model="m.id" />
									<div class="form-group">
										<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> url </label>
						
										<div class="col-sm-5">
												<input type="text" id="form-field-1" ng-model="m.url" name="url" class="form-control" required/>
							
												<span style="color:red" ng-show=" myForm.url.$invalid">
												<span ng-show="myForm.url.$error.required">url是必须的。</span>
												</span>
										</div>
									</div>
									<div class="space-4"></div>
						
									<div class="form-group">
										<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 格式 </label>
						
										<div class="col-sm-5">
												<input type="text" id="form-field-1" ng-model="m.format" name="format" class="form-control" required/>
							
												<span style="color:red" ng-show=" myForm.format.$invalid">
												<span ng-show="myForm.format.$error.required">格式是必须的。</span>
												</span>
										</div>
									</div>
									<div class="space-4"></div>
						
									<div class="form-group">
										<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 版本 </label>
						
										<div class="col-sm-5">
												<input type="text" id="form-field-1" ng-model="m.version" name="version" class="form-control" required/>
							
												<span style="color:red" ng-show=" myForm.version.$invalid">
												<span ng-show="myForm.version.$error.required">版本是必须的。</span>
												</span>
										</div>
									</div>
									<div class="space-4"></div>
									<div class="form-group">
										<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> tiled </label>
						
										<div class="col-sm-5">
												<input type="text" id="form-field-1" ng-model="m.tiled" name="tiled" class="form-control" required/>
							
												<span style="color:red" ng-show=" myForm.tiled.$invalid">
												<span ng-show="myForm.tiled.$error.required">tiled是必须的。</span>
												</span>
										</div>
									</div>
									<div class="space-4"></div>
									<div class="form-group">
										<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> styles </label>
						
										<div class="col-sm-5">
												<input type="text" id="form-field-1" ng-model="m.styles" name="styles" class="form-control"/>
							
										</div>
									</div>
									<div class="space-4"></div>
									<div class="form-group">
										<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> transparent </label>
						
										<div class="col-sm-5">
												<input type="text" id="form-field-1" ng-model="m.transparent" name="transparent" class="form-control" required/>
							
												<span style="color:red" ng-show=" myForm.transparent.$invalid">
												<span ng-show="myForm.transparent.$error.required">transparent是必须的。</span>
												</span>
										</div>
									</div>
									<div class="space-4"></div>
									<div class="form-group">
										<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> layers </label>
						
										<div class="col-sm-5">
												<input type="text" id="form-field-1" ng-model="m.layers" name="layers" class="form-control" required/>
							
												<span style="color:red" ng-show=" myForm.layers.$invalid">
												<span ng-show="myForm.layers.$error.required">layers是必须的。</span>
												</span>
										</div>
									</div>
									<div class="space-4"></div>
									<div class="form-group">
										<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 地图坐标系 </label>
						
										<div class="col-sm-5">
												<input type="text" id="form-field-1" ng-model="m.code" name="code" class="form-control" required/>
							
												<span style="color:red" ng-show=" myForm.code.$invalid">
												<span ng-show="myForm.code.$error.required">地图坐标系是必须的。</span>
												</span>
										</div>
									</div>
									<div class="space-4"></div>
									<div class="form-group">
										<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 初始等级 </label>
						
										<div class="col-sm-5">
												<input type="number" id="form-field-1" ng-model="m.initZoom" name="initzoom" class="form-control" required/>
							
												<span style="color:red" ng-show=" myForm.initzoom.$invalid">
												<span ng-show="myForm.initzoom.$error.required">初始登记是必须的。</span>
												</span>
										</div>
									</div>
									<div class="space-4"></div>
									<div class="form-group">
										<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 最大等级 </label>
						
										<div class="col-sm-5">
												<input type="number" id="form-field-1" ng-model="m.maxZoom" name="maxzoom" class="form-control" required/>
							
												<span style="color:red" ng-show=" myForm.maxzoom.$invalid">
												<span ng-show="myForm.maxzoom.$error.required">最大等级是必须的。</span>
												</span>
										</div>
									</div>
									<div class="space-4"></div>
									<div class="form-group">
										<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 最小等级 </label>
						
										<div class="col-sm-5">
												<input type="number" id="form-field-1" ng-model="m.minZoom" name="minzoom" class="form-control" required/>
							
												<span style="color:red" ng-show=" myForm.minzoom.$invalid">
												<span ng-show="myForm.minzoom.$error.required">最小等级是必须的。</span>
												</span>
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
						</div>	
			</div>
	</div>		
	</section>
<script src="${ctx }/shenhai/js/system/mapInfo.js"></script>
</body>
</html>
