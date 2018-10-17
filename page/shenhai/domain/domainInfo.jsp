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
						<!-- <li><label>模糊查询</label>
						    <div class="vocation">
							    <input type="text" class="form-control" ng-model="u.name" >
						    </div>
						 </li>
						<li><label>启用状态</label>
						    <div class="vocation">
							    <select  ng-model="u.isactive" class="form-control"
	                              ng-change="query()" 
								  ng-options="option.classId as option.value for option in isList">
								 </select>
						    </div>
					    </li> -->
					    <li><label>&nbsp;</label><input name="" type="button" class="btn btn-primary" ng-click="query()" value="查询"/></li>
					    <li><label>&nbsp;</label><input name="" type="button" class="btn btn-primary" ng-click="addRole()" value="新增"/></li>
					    <li><label>&nbsp;</label><input name="" type="button" class="btn btn-primary" ng-click="editRole()" value="编辑"/></li>
					    <li><label>&nbsp;</label><input name="" type="button" class="btn btn-primary" ng-click="deleRole()" value="删除"/></li>
					    <li><label>&nbsp;</label><input name="" type="button" class="btn btn-primary" ng-click="addLevel()" value="新增层级"/></li>
					    <li><label>&nbsp;</label><input name="" type="button" class="btn btn-primary" ng-click="deleLevel()" value="删除层级"/></li>
					    <li><label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					                     </label><input name="" type="button" class="btn btn-primary" onclick="saveRoleMenuUser()" value="保存"/></li>
					    </ul>
					    </form>
						<div class="row">
				    	<div class="col-md-3">
				    		<div ui-grid="gridOptions" class="gridStylerole" ui-grid-selection style="width:100%"></div>
				    	</div>
				    	<div class="col-md-3">
				    		<div ui-grid="gridOptions2" class="gridStylerole" ui-grid-selection style="width:100%"></div>
				    	</div>
				    	<div class="col-md-3">
				    		<div class="box border green" style="height:700px">
				    			<div class="box-title">
				    				<h4>站点列表</h4>
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
	</div>		
	</section>
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
			<input type="hidden" id="form-field-1" ng-model="m.id" />
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 功能区编码 </label>

				<div class="col-sm-5">
						<input type="text" ng-model="m.code" name="code"  placeholder="功能区编码" class="form-control" required />
						<span style="color:red" ng-show=" myForm.code.$invalid">
						<span ng-show="myForm.code.$error.required">功能区编码是必须的。</span>
						</span>
				</div>
			</div>
			<div class="space-4"></div>

			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 功能区名称 </label>

				<div class="col-sm-5">
						<input type="text" ng-model="m.name" name="name"  placeholder="功能区名称" class="form-control" required />
						<span style="color:red" ng-show=" myForm.name.$invalid">
						<span ng-show="myForm.name.$error.required">功能区名称是必须的。</span>
						</span>
				</div>
			</div>
			<div class="space-4"></div>



			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 备注 </label>

				<div class="col-sm-5">
						<input type="text" id="form-field-1" ng-model="m.remark" name="remark" class="form-control"/>
						</span>
				</div>
			</div>
			<div class="space-4"></div>

			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 状态 </label>

				<div class="col-sm-5">
							 <select id="selectError" ng-model="m.isactive" class="form-control"
							  ng-options="option.classId as option.value for option in isactivelist">
							 </select>
				</div>
			</div>
			<div class="space-4"></div>
		
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 排序 </label>

				<div class="col-sm-5">
						<input type="text" id="form-field-1" maxlength="3"  ng-model="m.orderCode" name="orderCode" class="form-control"/>
						</span>
				</div>
			</div>
			<div class="space-4"></div>

			<div class="clearfix form-actions">
				<div class="col-md-offset-3 col-md-9">
					<button class="btn btn-primary" type="button" ng-click="save()" 
						ng-disabled="myForm.name.$invalid
									||myForm.code.$invalid
									||myForm.isactive.$invalid">
							保存
					</button>

				</div>
			</div>
		</form>	
	</div>
	<div>
</div>
</script>
<script type="text/ng-template" id="level.html">  
<div class="page-content" style="">
	<div class="page-header">
			<strong>
				{{level.name}}
				<i class="icon-double-angle-right"></i>
			</strong>
	</div><!-- /.page-header -->
	
	<div class="row">
	<div class="col-xs-12">
		<form class="form-horizontal" role="form" name="myForm"  novalidate>
			<input type="hidden" id="form-field-1" ng-model="level.id" />
			<input type="hidden" id="form-field-1" ng-model="level.domainId" />
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 编码 </label>

				<div class="col-sm-5">
						<input type="text" ng-model="level.code" name="code"  placeholder="编码" class="form-control" required />
						<span style="color:red" ng-show=" myForm.code.$invalid">
						<span ng-show="myForm.code.$error.required">编码是必须的。</span>
						</span>
				</div>
			</div>
			<div class="space-4"></div>

			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 名称 </label>

				<div class="col-sm-5">
						<input type="text" ng-model="level.name" name="name"  placeholder="名称" class="form-control" required />
						<span style="color:red" ng-show=" myForm.name.$invalid">
						<span ng-show="myForm.name.$error.required">名称是必须的。</span>
						</span>
				</div>
			</div>
			<div class="space-4"></div>



			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 备注 </label>

				<div class="col-sm-5">
						<input type="text" id="form-field-1" ng-model="level.remark" name="remark" class="form-control"/>
						</span>
				</div>
			</div>
			<div class="space-4"></div>

			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 颜色 </label>

				<div class="col-sm-5">
						<input type="text" id="form-field-1" maxlength="3"  ng-model="level.color" name="color" class="form-control"/>
						</span>
				</div>
			</div>
			<div class="space-4"></div>

			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 排序 </label>

				<div class="col-sm-5">
						<input type="number" id="form-field-1" maxlength="3"  ng-model="level.orderCode" name="orderCode" class="form-control"/>
						</span>
				</div>
			</div>
			<div class="space-4"></div>


			<div class="clearfix form-actions">
				<div class="col-md-offset-3 col-md-9">
					<button class="btn btn-primary" type="button" ng-click="savelevel()" 
						ng-disabled="myForm.name.$invalid
									||myForm.code.$invalid
									||myForm.isactive.$invalid">
							保存
					</button>

				</div>
			</div>
		</form>	
	</div>
	<div>
</div>
</script>
		<script src="${ctx }/shenhai/js/domain/domainInfo.js"></script>
		<link rel="stylesheet" href="${ctx }/resources/zTree/css/zTreeStyle/zTreeStyle.css" type="text/css">
		<script type="text/javascript" src="${ctx }/resources/zTree/js/jquery.ztree.core-3.5.js"></script>
		<script type="text/javascript" src="${ctx }/resources/zTree/js/jquery.ztree.excheck-3.5.js"></script>
		
</body>
</html>
	