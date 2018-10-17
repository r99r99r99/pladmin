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
		<script type="text/javascript" src="${ctx }/resources/ueditor/ueditor.config.js"></script>
		<!-- <script type="text/javascript" src="http://ueditor.baidu.com/ueditor/ueditor.config.js"></script> -->
		<script type="text/javascript" src="${ctx }/resources/ueditor/ueditor.all.js"></script>
  		<script type="text/javascript" src="${ctx }/resources/ueditor/angular-ueditor.js"></script>
	
  		<script type="text/javascript" src="${ctx }/resources/bootstrap-fileinput-master/js/fileinput.min.js"></script>
  		<link rel="stylesheet" type="text/css" href="${ctx }/resources/bootstrap-fileinput-master/css/fileinput.min.css" />
  		<script type="text/javascript" src="${ctx }/resources/bootstrap-fileinput-master/js/locales/zh.js"></script>
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
						<li><label>站点列表:</label>
						    <div class="vocation">
							    <select  ng-model="u.stationId" class="form-control" 
	                              ng-change="query()" 
								  ng-options="option.id as option.title for option in stationList">
								 </select>
						    </div>
					    </li>
						<li><label>图片类型:</label>
						    <div class="vocation">
							    <select id="selectError" ng-model="u.type" class="form-control"
	                              ng-change="query()" 
								  ng-options="option.classId as option.value for option in typelist">
								 </select>
						    </div>
					    </li>
					    <li><label>&nbsp;</label><input name="" type="button" class="btn btn-primary" ng-click="query()" value="查询"/></li>
					    <li><label>&nbsp;</label><input name="" type="button" class="btn btn-primary" ng-click="showModel()"  data-toggle="modal" data-target="#img-modal" value="上传图片"/></li>
					    </ul>
					    </div>
						<div class="container-fluid">
						<div class="row-fluid">
							<div class="col-sm-12">
								<div id="filter-items" class="row" >
									<div class="col-md-3 category_1 item" ng-repeat="pic in picList" >
										<div class="filter-content">
											<img ng-src="{{pic.src }}" alt="" class="img-responsive" data-toggle="modal" data-target="#show-modal" ng-click="showimage(pic.id );"/>
											<div class="hover-content">
												<h4>{{pic.origName }}</h4>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
			</div>
	</div>	
	
	
   <div id="show-modal" class="modal fade">
	  <div id="img-dialog" class="modal-dialog" style="width: 40%; height: auto;text-align: center;">
	    <div id="img-content" class="modal-content">
		    <div class="modal-body"> 
		    	<form class="form-horizontal" role="form" name="myForm"  novalidate>
		    		
					<div class="form-group">
						<div class="col-sm-12">
							<img ng-src="{{bimg.src}}" style="width:100%;height:auto;" alt="" class="img-responsive"/>
						</div>
					</div>
					<div class="space-4"></div>
					
					<div class="form-group">
							<div class="col-sm-12">
									<textarea class="form-control" ng-model="bimg.remark" placeholder="图片标注"
									id="form-field-8" placeholder="" maxlength="50" rows=3 cols=20></textarea>
							</div>
					</div>
					<div class="space-4"></div>
					
					
					<div class="clearfix form-actions">
						<div class="col-md-offset-3 col-md-9">
							<button class="btn btn-primary" type="button" ng-click="delePic()" 
								ng-disabled="myForm.code.$invalid||
		                                     myForm.name.$invalid
											">
									删除
							</button>
						</div>
					</div>
					
		    	</form>
		    </div>
	    </div><!-- /.modal-content -->
	  </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
	
   <div id="img-modal" class="modal fade">
	  <div id="img-dialog" class="modal-dialog" style="width: 48%; height: auot;text-align: center;">
	    <div id="img-content" class="modal-content">
	    	<div class="modal-header"> 
		            <h4>上传图片</h4> 
		    </div> 
		    <div class="modal-body"> 
		    	<form class="form-horizontal" role="form" name="myForm"  novalidate>
		    		
					<div class="form-group">
						<div class="col-sm-12">
							<input id="myFile" type="file" multiple class="file" data-overwrite-initial="false" data-min-file-count="1"  name="commoPicArr">
						</div>
					</div>
					<div class="space-4"></div>
					
					<div class="form-group">
							<div class="col-sm-12">
									<textarea class="form-control" ng-model="u.remark" placeholder="图片标注"
									id="form-field-8" placeholder="" maxlength="50" rows=3 cols=20></textarea>
							</div>
					</div>
					<div class="space-4"></div>
					
					
					<div class="clearfix form-actions">
						<div class="col-md-offset-3 col-md-9">
							<button class="btn btn-primary" type="button" ng-click="savePic()" 
								ng-disabled="myForm.code.$invalid||
		                                     myForm.name.$invalid
											">
									保存
							</button>
						</div>
					</div>
					
		    	</form>
		    </div>
	    </div><!-- /.modal-content -->
	  </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
	</section>
<script src="${ctx }/shenhai/js/station/stationPicture_info.js"></script>	
<script type="text/ng-template" id="popupTmpl.html"> 
<div class="page-content" style="">
    <div class="modal-header"> 
            <h4>
			    图片测试
	    	</h4> 
    </div> 


</div>
</script> 
</body>
</html>
	