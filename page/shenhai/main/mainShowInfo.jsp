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
		<script src="${ctx }/shenhai/js/file/ajaxfileupload.js"></script
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
					    <li><label>设备</label>
						    <div class="vocation">
							    <select  ng-model="u.deviceId" class="form-control"
	                              ng-change="changeDevice()" 
								  ng-options="option.id as option.name for option in deviceList">
								 </select>
						    </div>
					    </li>
					    <li><label>维护类型</label>
						    <div class="vocation">
							    <select  ng-model="u.configId" class="form-control"
	                              ng-change="query()" 
								  ng-options="option.id as option.name for option in configList">
								 </select>
						    </div>
					    </li>
					    <li><label>开始时间</label>
						    <div class="vocation">
							    <input name="beginTime" ng-model="u.beginTime" id="beginTime" placeholder="开始时间" 
							      type="text" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" onchange="timeChange()" ng-change="query()" class="timeput">
						    </div>
					    </li>
					     <li><label>结束时间</label>
						    <div class="vocation">
							    <input name="endTime" ng-model="u.endTime" id="endTime" placeholder="结束时间"  type="text" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" onchange="timeChange()" ng-change="query()" class="timeput">
						    </div>
					    </li>
					    <li><label>&nbsp;</label><input name="" type="button" class="btn btn-primary" ng-click="query()" value="查询"/></li>
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
<script src="${ctx }/shenhai/js/main/mainShowInfo.js"></script>

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
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 设备 </label>

				<div class="col-sm-5">
							 <select  ng-model="m.deviceId" class="form-control"
                              ng-change="mchangeDevice()" id="device" ng-disabled="m.dis"
							  ng-options="option.id as option.name for option in mdeviceList">
							 </select>
				</div>
			</div>
			<div class="space-4"></div>
			
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 维护类型 </label>

				<div class="col-sm-5">
							 <select id="selectError" ng-model="m.configId" class="form-control"
							  ng-change="mchangeType()"  id="config" ng-disabled="m.dis"
							  ng-options="option.id as option.name for option in mconfigList">
							 </select>
				</div>
			</div>
			<div class="space-4"></div>

			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 维护状态 </label>

				<div class="col-sm-5">
							 <select id="selectError" ng-model="m.state" class="form-control"
							  ng-options="option.classId as option.value for option in stateList">
							 </select>
				</div>
			</div>
			<div class="space-4"></div>

			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 开始时间 </label>

				<div class="col-sm-5">
							  <input name="beginTime" ng-model="m.beginTime" id="beginTime" placeholder="开始时间"  ype="text" 
                                onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"  class="timeput" required>
				</div>
			</div>
			<div class="space-4"></div>

			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 结束时间 </label>

				<div class="col-sm-5">
							  <input name="endTime" ng-model="m.endTime" id="endTime" placeholder="结束时间"  ype="text" 
                                onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"  class="timeput" required>
				</div>
			</div>
			<div class="space-4"></div>
	
			<div class="form-group" id="reasonid">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 维护原因 </label>

				<div class="col-sm-5">
							 <textarea class="form-control" ng-model="m.reason" id="form-field-8" 
								maxlength="200"  placeholder="" rows=4 cols=60></textarea>
				</div>
			</div>
			<div class="space-4"></div>

			<div class="form-group" >
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 所需材料 </label>

				<div class="col-sm-5">
							 <textarea class="form-control" ng-model="m.material" id="form-field-8" 
								maxlength="200"  placeholder="" rows=4 cols=60></textarea>
				</div>
			</div>
			<div class="space-4"></div>
			
			<div class="form-group" >
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 维护结果 </label>

				<div class="col-sm-5">
							 <textarea class="form-control" ng-model="m.result" id="form-field-8" 
								maxlength="200"  placeholder="" rows=6 cols=60></textarea>
				</div>
			</div>
			<div class="space-4"></div>

			<div class="form-group" >
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 上传图片 </label>

				<div class="col-sm-5">
						<div class="input-group" >
							<div id="newUpload2">  
								<ul>
									<li ng-repeat="pic in pics"><img ng-src="${ctx }/{{pic.pathName}}" alt="pic.realName" width="200px"/></li>
								</ul>
        					</div> 
						</div>
				</div>
			</div>
			<div class="space-4"></div>
		</form>	
    </div>
</div>
</script> 
</body>
</html>
	