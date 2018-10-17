<%@ page language="java"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
</head>
<body>
				<div id="sidebar" class="sidebar">
					<div class="sidebar-menu nav-collapse">
						<div class="divide-20"></div>
						<!-- SEARCH BAR -->
						<!-- <div id="search-bar">
							<input class="search" type="text" placeholder="Search"><i class="fa fa-search search-icon"></i>
						</div> -->
						<!-- /SEARCH BAR -->
						
						<!-- SIDEBAR MENU -->
						<ul>
							<c:forEach var="menu" items="${menuList}">
								<c:if test="${menu.isopen ==1}">
								<li class="has-sub active" style="z-index:999;">
									<a href="javascript:;" class="">
									<i class="${menu.picture }"></i> <span class="menu-text">${menu.name }</span>
									<span class="arrow open"></span>
									</a>
									<ul class="sub">
										<c:forEach var="childMenu" items="${menu.childMenu }">
											<c:if test="${childMenu.iscurr ==1}">
												<li class="current tit"><a class="" href="${childMenu.url }?currmenuId=${childMenu.code }">
												<span class="sub-menu-text">${childMenu.name }</span>
												</a>
												</li>
											</c:if>
											<c:if test="${childMenu.iscurr !=1}">
												<li class="tit"><a class="" href="${childMenu.url }?currmenuId=${childMenu.code }">
												<span class="sub-menu-text">${childMenu.name }</span>
												</a>
												</li>
											</c:if>
										</c:forEach>
									</ul>
								</li>
								</c:if>
								<c:if test="${menu.isopen !=1}">
								<li class="has-sub" style="z-index:999;">
									<a href="javascript:;" class="">
									<i class="${menu.picture }"></i> <span class="menu-text">${menu.name }</span>
									<span class="arrow"></span>
									</a>
									<ul class="sub">
										<c:forEach var="childMenu" items="${menu.childMenu }">
											<li class="tit"><a  href="${childMenu.url }?currmenuId=${childMenu.code }">
											<span class="sub-menu-text">${childMenu.name }</span>
											</a>
											</li>
										</c:forEach>
									</ul>
								</li>
								</c:if>
							</c:forEach>
						</ul>
						<!-- /SIDEBAR MENU -->
					</div>
				</div>
				<!-- /SIDEBAR -->
</body>
</html>