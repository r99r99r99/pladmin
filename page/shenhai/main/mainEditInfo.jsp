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
			.file {
			    position: relative;
			    display: inline-block;
			    background: #D0EEFF;
			    border: 1px solid #99D3F5;
			    border-radius: 4px;
			    padding: 4px 12px;
			    overflow: hidden;
			    color: #1E88C7;
			    text-decoration: none;
			    text-indent: 0;
			    line-height: 20px;
			}
			.file input {
			    position: absolute;
			    font-size: 100px;
			    right: 0;
			    top: 0;
			    opacity: 0;
			}
			.file:hover {
			    background: #AADFFD;
			    border-color: #78C3F3;
			    color: #004974;
			    text-decoration: none;
			}
		
		</style>
</head>
<body ng-app="myApp" ng-controller="customersCtrl" >
	<script src="${ctx}/resources/common/js/common.js" type="text/javascript"></script>
	<script src="${ctx }/resources/My97DatePicker/WdatePicker.js"></script>

	<%@ include file="../common/header.jsp" %>
	<script src="${ctx }/resources/angular-file-upload-master/dist/angular-file-upload.js"></script>
	<script src="${ctx }/resources/ajaxFileUpload/ajaxfileupload.js"></script>
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
							    <select  ng-model="u.stationId" class="form-control"
	                              ng-change="changeStation()" 
								  ng-options="option.id as option.title for option in stationList">
								 </select>
						    </div>
					    </li>
					    <li><label>开始时间</label>
						    <div class="vocation">
							    <input name="beginTime" ng-model="u.beginTime" id="beginTime" placeholder="开始时间" 
							      type="text" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"  ng-change="query()" class="timeput">
						    </div>
					    </li>
					     <li><label>结束时间</label>
						    <div class="vocation">
							    <input name="endTime" ng-model="u.endTime" id="endTime" placeholder="结束时间"  type="text" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"  ng-change="query()" class="timeput">
						    </div>
					    </li>
					    <li><label>&nbsp;</label><input name="" type="button" class="btn btn-primary" ng-click="changeStation()()" value="查询"/></li>
					    <li><label>&nbsp;</label><input name="" type="button" class="btn btn-primary" ng-click="addMain()" value="新增"/></li>
					    <li>
								
						</li>
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
<script src="${ctx }/shenhai/js/main/mainEditInfo.js"></script>	
<script type="text/javascript">
var count = 1;  
/** 
* 生成多附件上传框 
*/  
function createInput(parentId){  
    count++;  
    var str = '<div name="div" ><input type="file" style="float:left" contentEditable="false" id="uploads' + count + '' +  
    '" name="uploads'+ count +'" value="" style="width: 220px"/>';  
    document.getElementById(parentId).insertAdjacentHTML("beforeEnd",str);  
}  

/** 
* 删除多附件删除框 
*/  
function removeInput(evt, parentId){  
   var el = evt.target == null ? evt.srcElement : evt.target;  
   var div = el.parentNode;  
   var cont = document.getElementById(parentId);         
   if(cont.removeChild(div) == null){  
    return false;  
   }  
   return true;  
} 
function addOldFile(data){  
    var str = '<div name="div' + data.name + '" ><a href="#" style="text-decoration:none;font-size:12px;color:red;" onclick="removeOldFile(event,' + data.id + ')">删除</a>'+  
    '   ' + data.name +   
    '</div>';  
    document.getElementById('oldImg').innerHTML += str;  
}  
  
function removeOldFile(evt, id){  
    //前端隐藏域，用来确定哪些file被删除，这里需要前端有个隐藏域  
    $("#imgIds").val($("#imgIds").val()=="" ? id :($("#imgIds").val() + "," + id));  
    var el = evt.target == null ? evt.srcElement : evt.target;  
    var div = el.parentNode;  
    var cont = document.getElementById('oldImg');      
    if(cont.removeChild(div) == null){  
        return false;  
    }  
    return true;  
} 
</script>	
<script type="text/ng-template" id="popupTmpl.html">  
<div class="page-content" style="">
    <div class="modal-header"> 
            <h4>
	    ${currMenu.cMenuName }
	    </h4> 
    </div> 
    <div class="modal-body"> 
		<form class="form-horizontal" id="myForm" role="form" name="myForm" enctype="multipart/form-data" method="post"  novalidate>
			<input type="hidden" id="form-field-1" ng-model="m.id" />
			<input type="hidden" id="form-field-1" ng-model="m.dis" />
			<input type="hidden" id="form-field-1" ng-model="m.mtype" />

			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 站点 </label>

				<div class="col-sm-5">
							<select  ng-model="m.stationId" class="form-control"
                              ng-change="mchangeStation()" id="station" ng-disabled="m.dis"
							  ng-options="option.id as option.title for option in mstationList">
							 </select>
				</div>
			</div>
			<div class="space-4"></div>


			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 开始时间 </label>

				<div class="col-sm-5">
							  <input name="beginTime" ng-model="m.beginTime" id="mbeginTime" placeholder="开始时间"  ype="text" 
                                onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"  class="timeput" required>
				</div>
			</div>
			<div class="space-4"></div>

			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 结束时间 </label>

				<div class="col-sm-5">
							  <input name="endTime" ng-model="m.endTime" id="mendTime" placeholder="结束时间"  ype="text" 
                                onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"  class="timeput" required>
				</div>
			</div>
			<div class="space-4"></div>
	
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 维护参数 </label>
				<input type="hidden" ng-model="station.deviceIds" />
				<div class="col-sm-9">

						<multi-select-tree data-input-model="indicatorTree" multi-select="true" ng-model="indicator" id="ids"
                                   data-output-model="indicatorIds" data-default-label="请选择维护参数."
                                   data-callback="selectOnly1Or2(item, selectedItems)"
								   data-switch-view-callback="switchViewCallback(scopeObj)"
                                   data-select-only-leafs="true"
                                   data-switch-view="false">
							</multi-select-tree>
				</div>
			</div>
			<div class="space-4"></div>
			

			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 维修报告 </label>
				<div class="col-sm-9">
						<div id="newUpload2">  
	 							<input type="file" style="float:left" contentEditable="false" id="uploads1" name="uploads1" 
								value="" style="width: 220px"/>
								<ul>
									<li ng-repeat="pic in pics">
										<a href="${ctx }/exportMainFile.do?fileName={{pic.realName}}&filePath={{pic.pathName}}" >{{pic.realName}}</a>
									</li>
								</ul>
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

				</div>
			</div>
			
		</form>	
    </div>
</div>
</script> 
</body>
</html>
	