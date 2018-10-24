<%@ page language="java"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<!-- STYLESHEETS --><!--[if lt IE 9]><script src="${ctx }/shenhai/resources/cloud/js/flot/excanvas.min.js"></script><script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script><script src="http://css3-mediaqueries-js.googlecode.com/svn/trunk/css3-mediaqueries.js"></script><![endif]-->
	<link rel="stylesheet" type="text/css" href="${ctx }/shenhai/resources/cloud/css/cloud-admin.css" >
	<link rel="stylesheet" type="text/css" href="${ctx }/shenhai/resources/cloud/css/select.css" >
	<link rel="stylesheet" type="text/css"  href="${ctx }/shenhai/resources/cloud/css/themes/default.css" id="skin-switcher" >
	<link rel="stylesheet" type="text/css"  href="${ctx }/shenhai/resources/cloud/css/responsive.css" >
	
	<link href="${ctx }/shenhai/resources/cloud/font-awesome/css/font-awesome.min.css" rel="stylesheet">
	<!-- DATE RANGE PICKER -->
	<link rel="stylesheet" type="text/css" href="${ctx }/shenhai/resources/cloud/js/bootstrap-daterangepicker/daterangepicker-bs3.css" />
	<!-- DROPZONE -->
	<link rel="stylesheet" type="text/css" href="${ctx }/shenhai/resources/cloud/js/dropzone/dropzone.min.css" />
	
	
	<!-- JQUERY -->
	<script src="${ctx }/shenhai/resources/cloud/js/jquery/jquery-2.0.3.min.js"></script>
	<!-- JQUERY UI-->
	<script src="${ctx }/shenhai/resources/cloud/js/jquery-ui-1.10.3.custom/js/jquery-ui-1.10.3.custom.min.js"></script>
	<!-- BOOTSTRAP -->
	<script src="${ctx }/shenhai/resources/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<%-- 	<script src="${ctx }/shenhai/resources/cloud/bootstrap-dist/js/bootstrap.min.js"></script> --%>
	
		
	<!-- DATE RANGE PICKER -->
	<script src="${ctx }/shenhai/resources/cloud/js/bootstrap-daterangepicker/moment.min.js"></script>
	
	<script src="${ctx }/shenhai/resources/cloud/js/bootstrap-daterangepicker/daterangepicker.min.js"></script>
	<!-- SLIMSCROLL -->
	<script type="text/javascript" src="${ctx }/shenhai/resources/cloud/js/jQuery-slimScroll-1.3.0/jquery.slimscroll.min.js"></script>
	<script type="text/javascript" src="${ctx }/shenhai/resources/cloud/js/jQuery-slimScroll-1.3.0/slimScrollHorizontal.min.js"></script>
	 <!-- DROPZONE -->
	<script type="text/javascript" src="${ctx }/shenhai/resources/cloud/js/dropzone/dropzone.min.js"></script>
	<!-- COOKIE -->
	<script type="text/javascript" src="${ctx }/shenhai/resources/cloud/js/jQuery-Cookie/jquery.cookie.min.js"></script>
	
	<!-- angularjs -->
	<script src="${ctx }/shenhai/resources/angular-1.5.0/angular.js"></script>
	<script src="${ctx }/shenhai/resources/angular-1.5.0/angular-animate.js"></script>
	<script src="${ctx }/shenhai/resources/angular-1.5.0/angular-touch.js"></script>
	<!-- ngdialog -->
	<script src="${ctx }/shenhai/resources/ngdialog/ngDialog.js"></script>
	<link href="${ctx }/shenhai/resources/ngdialog/ngDialog.css" rel="stylesheet" type="text/css" />
	<link href="${ctx }/shenhai/resources/ngdialog/ngDialog-theme-default.css" rel="stylesheet" type="text/css" />
	
	
	<script src="${ctx }/shenhai/resources/ui-bootstrap-tpls/ui-bootstrap-tpls.js"></script>
	<%-- <script src="${ctx }/shenhai/resources/ng-grid/ng-grid.debug.js"></script>
	<script src="${ctx }/shenhai/resources/ng-grid/ng-grid-layout.js"></script> --%>
	<script src="${ctx }/shenhai/resources/ui-grid/ui-grid.js"></script>
	<script src="${ctx }/shenhai/resources/ui-grid/csv.js"></script>
	<script src="${ctx }/shenhai/resources/ui-grid/pdfmake.js"></script>
	<script src="${ctx }/shenhai/resources/ui-grid/vfs_fonts.js"></script>
	<link href="${ctx }/shenhai/resources/ui-grid/ui-grid.css" rel="stylesheet">
	<script src="${ctx }/shenhai/resources/ng-grid/ng-grid.min.js"></script>
	<link href="${ctx }/shenhai/resources/ng-grid/ng-grid.min.css" rel="stylesheet">
	<script src="${ctx }/shenhai/resources/ng-grid/ng-grid-csv-export.js"></script>	
	
	<link rel="stylesheet" href="${ctx }/shenhai/resources/angular-select-tree/angular-multi-select-tree-0.1.0.css" />
	<script type="text/javascript" src="${ctx }/shenhai/resources/angular-select-tree/angular-multi-select-tree-0.1.0.js"></script>
	<script type="text/javascript" src="${ctx }/shenhai/resources/angular-select-tree/angular-multi-select-tree-0.1.0.tpl.js"></script>
		
	<!-- 时间插件 -->
	
	<link rel="stylesheet" href="${ctx }/shenhai/resources/mbdatepicker/styles/mbdatepicker.css"/>
    <script src="${ctx }/shenhai/resources/mbdatepicker/mbdatepicker.js"></script>	
    
	<!-- CUSTOM SCRIPT -->
	<script src="${ctx }/shenhai/resources/cloud/js/script.js"></script>
	
	
	<script>
		jQuery(document).ready(function() {		
			App.setPage("widgets_box");  //Set current page
			App.init(); //Initialise plugins and elements
			/*  var updateClock = function(){
				 setTimeout(function(){
					 updateClock();
					$.ajax({
		      	        url: '${ctx}/getSystemWarn.do', //url  action是方法的名称
		      	        data: '',
		      	        type: 'POST',
		      	        dataType: "json", //可以是text，如果用text，返回的结果为字符串；如果需要json格式的，可是设置为json
		      	        ContentType: "application/json; charset=utf-8",
		      	        success: function(data) {
		      	           
		      	        },
		      	        error: function(msg) {
		      	            alert("失败");
		      	        }
		      		}); 
				 },6000);
			};
			//updateClock(); */
			
			
			/* setTimeout(function () {
                var unique_id = $.gritter.add({
                    // (string | mandatory) the heading of the notification
                    title: 'Welcome to Cloud Admin!',
                    // (string | mandatory) the text inside the notification
                    text: 'Cloud is a feature-rich Responsive Admin Dashboard Template with a wide array of plugins!',
                    // (string | optional) the image to display on the left
                    //image: 'img/gritter/cloud.png',
                    // (bool | optional) if you want it to fade out on its own or just sit there
                    sticky: true,
                    // (int | optional) the time you want it to be alive for before fading out
                    time: '',
                    // (string | optional) the class name you want to apply to that specific message
                    class_name: 'my-sticky-class'
                });

                // You can have it return a unique id, this can be used to manually remove it later using
                setTimeout(function () {
                    $.gritter.remove(unique_id, {
                        fade: true,
                        speed: 'slow'
                    });
                }, 12000);
            }, 2000); */
		});
	</script>
	
	
</head>
<body>
	<!-- HEADER -->
	<header class="navbar clearfix" id="header">
		<div class="container">
				<div class="navbar-brand">
					<!-- COMPANY LOGO -->
					<a href="firstPage.do" style="text-decoration:none;">
						<div style="margin-left:50px;min-width: 200px;">
							<span style="color:#FFF;font-size:22px">${system.systemName }</span>
						</div>
					</a>
					<!-- /COMPANY LOGO -->
					<!-- TEAM STATUS FOR MOBILE -->
					<div class="visible-xs">
						<a href="#" class="team-status-toggle switcher btn dropdown-toggle">
							<i class="fa fa-users"></i>
						</a>
					</div>
					<!-- /TEAM STATUS FOR MOBILE -->
					<!-- SIDEBAR COLLAPSE -->
					<div id="sidebar-collapse" class="sidebar-collapse btn">
						<i class="fa fa-bars" 
							data-icon1="fa fa-bars" 
							data-icon2="fa fa-bars" ></i>
					</div>
					<!-- /SIDEBAR COLLAPSE -->
				</div>
				<!-- NAVBAR LEFT -->
				<%-- <ul class="nav navbar-nav pull-left hidden-xs" id="navbar-left">
					<li class="dropdown">
						<a href="#" class="team-status-toggle dropdown-toggle tip-bottom" data-toggle="tooltip" >
							<i class="fa fa-users"></i>
							<span class="name">${station.title }</span>
							<i class="fa fa-angle-down"></i>
						</a>
					</li>
				</ul> --%>
				<!-- /NAVBAR LEFT -->
				<!-- BEGIN TOP NAVIGATION MENU -->					
				<ul class="nav navbar-nav pull-right">
					<!-- BEGIN NOTIFICATION DROPDOWN -->	
					<%-- <li class="dropdown" id="header-notification">
						<a href="${ctx}/info_warnvalue.do?currmenuId=108020" class="dropdown-toggle">
							<i class="fa fa-bell"></i>
							<span class="badge">${warnNum}</span>
							
						</a>
					</li> --%>
					<!-- END NOTIFICATION DROPDOWN -->
					<!-- BEGIN USER LOGIN DROPDOWN -->
					<li class="dropdown user" id="header-user">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown">
							<img alt="" src="shenhai/resources/cloud/img/avatars/avatar3.jpg" />
							<span class="username">${user.realName }</span>
							<i class="fa fa-angle-down"></i>
						</a>
						<ul class="dropdown-menu">
							<li><a href="${ctx}/userSettingInfo.do"><i class="fa fa-user"></i> &nbsp;个人设置</a></li>
							<li><a href="${ctx}/passSettingInfo.do"><i class="fa fa-cog"></i> &nbsp;密码修改</a></li>
							<li><a href="${ctx}/logout.do"><i class="fa fa-power-off"></i>&nbsp;&nbsp;退出登录</a></li>
						</ul>
					</li>
					<!-- END USER LOGIN DROPDOWN -->
				</ul>
				<!-- END TOP NAVIGATION MENU -->
		</div>
		
		<!-- TEAM STATUS -->
		<div class="container team-status" id="team-status">
		  <div id="scrollbar">
			<div class="handle">
			</div>
		  </div>
		  <%-- <div id="teamslider">
			  <ul class="team-list">
			  
			  	<c:forEach var="station" items="${stations}">
			  		<li class="current">
					  <a href="changeWp.do?wpid=${station.id }">
					  <span class="image">
						  <img src="${station.pic }" alt="" />
					  </span>
					  <span class="title">
						${station.title }
					  </span>
						<div class="progress">
						  <div class="progress-bar progress-bar-success" style="width: 100%">
							<!-- <span class="sr-only">35% Complete (success)</span> -->
						  </div>
						  <!-- <div class="progress-bar progress-bar-warning" style="width: 20%">
							<span class="sr-only">20% Complete (warning)</span>
						  </div>
						  <div class="progress-bar progress-bar-danger" style="width: 10%">
							<span class="sr-only">10% Complete (danger)</span>
						  </div> -->
						</div>
						<span class="status">
							<div class="field">
								<span class="badge badge-green"></span>站点类型
								<span class="pull-right">${station.stationTypeName }</span>
							</div>
							<div class="field">
								<span class="badge badge-orange"></span>水质类型
								<span class="pull-right">${station.waterTypeName }</span>
							</div>
							<div class="field">
								<span class="badge badge-red"></span> 地区
								<span class="pull-right">${station.regionName}</span>
							</div>
					    </span>
					  </a>
					</li>
			  	</c:forEach>
				
			  </ul>
			</div> --%>
		  </div>
		<!-- /TEAM STATUS -->
	</header>
	<!--/HEADER -->    
</body>
</html>