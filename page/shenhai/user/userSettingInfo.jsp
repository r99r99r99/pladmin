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
		<div id="main-content" >
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
								<a href="${ctx }/userSettingInfo.do">人员信息设置</a>
							</li>
						</ul><!-- .breadcrumb -->
					</div>
					<div class="container-fluid">
					<div class="page-content" style="">
						<div class="">
								<strong style="margin-left:50px;">
									{{user.realName}}
									<i class="icon-double-angle-right"></i>
								</strong>
						</div><!-- /.page-header -->
						
						<div class="row">
						<div class="col-xs-10">
							<form class="form-horizontal" role="form" name="myForm"  novalidate>
								<input type="hidden" id="form-field-1" ng-model="user.id" />
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 用户名 </label>
					
									<div class="col-sm-9">
											<input type="text" ng-model="user.userName" name="userName"  placeholder="用户名" class="form-control ng-pristine ng-valid ng-touched" readonly/>
									</div>
								</div>
								<div class="space-4"></div>
					
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 姓名 </label>
					
									<div class="col-sm-9">
											<input type="text" id="form-field-1" ng-model="user.realName" name="realName" class="form-control ng-pristine ng-valid ng-touched" required/>
											<span style="color:red" ng-show="myForm.realName.$invalid">
											<span ng-show="myForm.realName.$error.required">用户姓名是必须的。</span>
											</span>
									</div>
								</div>
								<div class="space-4"></div>
					
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 手机 </label>
					
									<div class="col-sm-9">
											<input type="text" id="form-field-1" ng-model="user.telephone" class="form-control ng-pristine ng-valid ng-touched" />
									</div>
								</div>
								<div class="space-4"></div>
					
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 电话 </label>
					
									<div class="col-sm-9">
											<input type="text" id="form-field-1" ng-model="user.phone" class="form-control ng-pristine ng-valid ng-touched" />
									</div>
								</div>
								<div class="space-4"></div>
					
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 生日 </label>
					
									<div class="col-sm-9">
											<input  value="${user.birthday }"  type="text" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" onchange="" class="form-control ng-pristine ng-valid ng-touched" id="input">
									</div>
								</div>
								<div class="space-4"></div>
					
								<div class="form-group">
									<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> e-mail </label>
					
									<div class="col-sm-9">
											<input type="email" id="form-field-1" ng-model="user.email" name="email" class="form-control ng-pristine ng-valid ng-touched" />
											<span ng-hide='myForm.email.$pristine || myForm.email.$valid' ng-show='myForm.email.$invalid'><span style="color:red">Email不正确.</span></span>
									</div>
								</div>
								<div class="space-4"></div>
					
								<div class="form-group" style="display: none">
									<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 头像 </label>
					
									<div class="col-sm-9">
											<input type="file" nv-file-select="" uploader="uploader"  multiple accept="image/*" />
											<input type="file" nv-file-select="" uploader="uploader"  multiple accept="image/*" />
											<ul>
					            				<li ng-repeat="item in uploader.queue">
					                				<div>图片名称: {{ item.file.name }}</div>
					                				<div>图片大小: {{ item.file.size/1024/1024|number:2 }} Mb</div>
					                				<div ng-show="uploader.isHTML5">
					                    				进度: {{ item.progress }}
					                    				<div class="item-progress-box">
					                        				<div class="item-progress" ng-style="{ 'width': item.progress + '%' }"></div>
					                    				</div>
					                				</div>
					                				<div ng-if="controller.isImage(item._file)">
					                        			<!-- Image preview -->
					                        			<!--auto height-->
					                        			<!--<div ng-thumb="{ file: item.file, width: 100 }"></div>-->
					                        			<!--auto width-->
					                        				<div ng-thumb="{ file: item._file, height: 100 }"></div>
					                        			<!--fixed width and height -->
					                        				<!--<div ng-thumb="{ file: item.file, width: 100, height: 100 }"></div>-->
					                				</div>
					                			<div>
					                			</div>
					            				</li>
					        				</ul>
									</div>
								</div>
								<div class="space-4"></div>
								
								<div class="clearfix form-actions">
									<div class="col-md-offset-3 col-md-9">
										<button class="btn btn-primary" id="botton" type="button" ng-click="save()" 
											ng-disabled="myForm.userName.$invalid||
					                                     myForm.realName.$invalid">
												保存
										</button>
									</div>
								</div>
							</form>	
						</div>
						<div>
					</div>
					</div></div>
				</div>
			</div>
			</div>
			</div></div>
			 <!--body wrapper end-->
		</div>
		
        <!--footer section start--> 
        <!--footer section end-->
      <!-- main content end-->
	</section>
<script src="${ctx }/shenhai/js/user/userSettingInfo.js"></script>
<link rel="stylesheet" href="${ctx }/resources/angular-select-tree/angular-multi-select-tree-0.1.0.css" />
		<script type="text/javascript" src="${ctx }/resources/angular-select-tree/angular-multi-select-tree-0.1.0.js"></script>
		<script type="text/javascript" src="${ctx }/resources/angular-select-tree/angular-multi-select-tree-0.1.0.tpl.js"></script>
		<script src="${ctx }/resources/angular-file-upload-master/dist/angular-file-upload.js"></script>
		<script src="${ctx }/resources/angular-file-upload-master/dist/directives.js"></script>	
</body>
</html>
