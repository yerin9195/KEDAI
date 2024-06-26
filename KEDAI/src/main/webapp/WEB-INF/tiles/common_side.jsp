<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String ctxPath = request.getContextPath();
	//     /KEDAI
%>
<style type="text/css">
	.primary-nav {
		position: fixed;
		z-index: 999;
	}
	.menu {
		position: relative;
	}
	.menu ul {
		margin: 0;
	  	padding: 0;
	  	list-style: none;	
	}
	.open-panel {
	  	border: none;
	  	background-color: #fff;
	  	padding: 0;
	}
	.hamburger {
		background: #fff;
		position: relative;
		display: block;
		text-align: center;
		padding: 13px 0;
		width: 50px;
	  	height: 73px;
		left: 0;
	  	top: 0;
		z-index: 1000;
	  	cursor: pointer;
	}
	.hamburger:before {
		content:"\2630"; /* hamburger icon */
		display: block;
	  	color: #000;
	  	line-height: 32px;
	  	font-size: 16px;
	}
	.openNav .hamburger:before {
		content:"\2715"; /* close icon */
		display: block;
	  	color: #000;
	  	line-height: 32px;
	  	font-size: 16px;
	}
	.hamburger:hover:before {
	  	color: #363636;
	}
	.primary-nav .menu li {
		position: relative;
	}
	.menu .icon {
		position: absolute;
		top: 12px;
		right: 10px;
		pointer-events: none;
	  	width: 24px;
	  	height: 24px;
	  	color: #fff;
	}
	.menu,
	.menu a,
	.menu a:visited {
	  	text-decoration: none !important;
		position: relative;
	}
	.menu a {
	  	display: block;
	  	white-space: nowrap;
	  	padding: 1em;
	  	font-size: 16px;
	}
	.menu a:hover {
		color: #e68c0e;
	}
	.menu {
		margin-bottom: 3em;
	}
	.menu-dropdown li .icon {
		color: #fff;
	}
	.menu-dropdown li:hover .icon {
		color: #e68c0e;
	}
	.menu label {
	  	margin-bottom: 0;
	  	display: block;
	}
	.menu label:hover {
	  	cursor: pointer;
	}
	.menu input[type="checkbox"] {
	  	display: none;
	}
	input#menu[type="checkbox"] {
	  	display: none;
	}
	#menu:checked + ul.menu-dropdown {
		left: 0;
	    -webkit-animation: all .45s cubic-bezier(0.77, 0, 0.175, 1);
	            animation: all .45s cubic-bezier(0.77, 0, 0.175, 1);
	}
	.menu {
		position: absolute;
		display: block;
		left: -200px;
	  	top: 0;
		width: 250px;
	  	transition: all 0.45s cubic-bezier(0.77, 0, 0.175, 1);
	  	background: #2c4459;
		z-index: 999;
	}
	.menu-dropdown {
	  	top: 0;
	  	overflow-y: auto;
	}
	.overflow-container {
	 	position: relative;
	  	height: calc(100vh - 73px) !important;
	  	overflow-y: auto;
	  	border-top: 73px solid #fff;
	  	z-index: -1;
	  	display: block;
	}
	.menu div.logotype {
	  	position: absolute!important;
	  	top: 11px;
	  	left: 55px;
	  	display: block;
	  	text-transform: uppercase;
	  	font-weight: 400;
	  	color: #363636;
	  	font-size: 21px;
	  	padding: 10px;
	}
	.menu div.logotype span {
	  	font-weight: 800;
	}
	.menu:hover {
		position: absolute;
		left: 0;
		top: 0;
	}
	.openNav .menu:hover {
		position: absolute;
		left: -200px;
	}
	.openNav .menu {
		transform: translate3d(200px, 0, 0);
	    transition: transform .45s cubic-bezier(0.77, 0, 0.175, 1);
	}
</style>

<%-- side start --%>
<div class="primary-nav">
	<button class="hamburger open-panel nav-toggle">
		<span class="screen-reader-text"></span>
	</button>

	<nav role="navigation" class="menu">
		<div class="logotype">
			<c:if test="${not empty sessionScope.loginuser}">
				<span>${sessionScope.loginuser.name}</span>님 로그인 중
			</c:if>
		</div>
		<div class="overflow-container">
			<ul class="menu-dropdown">
				<li>
					<a href="#">전자결재</a>
					<span class="icon"><i class="fa-regular fa-pen-to-square"></i></span>
				</li>
				<li>
					<a href="#">급여명세서</a>
					<span class="icon"><i class="fa-solid fa-comment-dollar"></i></span>
				</li>
				<li>
					<a href="#">회의실예약</a>
					<span class="icon"><i class="fa-solid fa-clock-rotate-left"></i></span>
				</li>
				<li>
					<a href="#">게시판</a>
					<span class="icon"><i class="fa-solid fa-chalkboard-user"></i></span>
				</li>
				<li>
					<a href="#">커뮤니티</a>
					<span class="icon"><i class="fa-regular fa-comments"></i></span>
				</li>
				<li>
					<a href="#">투표하기</a>
					<span class="icon"><i class="fa-solid fa-ranking-star"></i></span>
				</li>
				<li>
					<a href="#">카쉐어</a>
					<span class="icon"><i class="fa-solid fa-car"></i></span>
				</li>
				<li>
					<a href="#">통근버스</a>
					<span class="icon"><i class="fa-solid fa-bus-simple"></i></span>
				</li>
				<li>
					<a href="#">사내연락망</a>
					<span class="icon"><i class="fa-solid fa-address-book"></i></span>
				</li>
				<li>
					<a href="#">거래처정보</a>
					<span class="icon"><i class="fa-solid fa-store"></i></span>
				</li>
				<li>
					<a href="<%= ctxPath%>/admin/register.kedai">사원정보등록</a>
					<span class="icon"><i class="fa-solid fa-user-plus"></i></span>
				</li>
			</ul>
		</div>
	</nav>
</div>

<script type="text/javascript">
	$('.nav-toggle').click(function(e) {
		e.preventDefault();
	  	$("html").toggleClass("openNav");
	  	$(".nav-toggle").toggleClass("active");
	});
</script>
<%-- side end --%>