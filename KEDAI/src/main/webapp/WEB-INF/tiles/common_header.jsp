<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.InetAddress"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String ctxPath = request.getContextPath();
	//	   /KEDAI
	
	// ==== #221. (웹채팅관련3) ==== 
    // 서버 IP 주소 알아오기(사용중인 IP주소가 유동IP 이라면 IP주소를 알아와야 한다.) 
	InetAddress inet = InetAddress.getLocalHost();
 	String serverIP = inet.getHostAddress();
 	
 	// System.out.println("serverIP : " + serverIP);
 	// serverIP : 192.168.0.210
 	
 	// 서버 포트번호 알아오기
 	int portnumber = request.getServerPort();
	// System.out.println("portnumber : " + portnumber);
 	// portnumber : 9099
 	
 	String serverName = "http://"+serverIP+":"+portnumber;
 	// System.out.println("serverName : " + serverName);
 	// serverName : http://192.168.0.210:9099
%>
<style type="text/css">
	.form-control:active, 
	.form-control:focus { 
		border: none; 
		box-shadow: none; 
		text-transform: none !important;
	}
	input::-ms-clear,
	input::-ms-reveal {
		display: none;
		width: 0;
		height: 0;
	}
	input::-webkit-search-decoration,
	input::-webkit-search-cancel-button,
	input::-webkit-search-results-button,
	input::-webkit-search-results-decoration {
		display: none;
	}
	.input_search {
		border: none;
	 	border-radius: 25px;
	 	padding: 2% 0% 2% 8%;
	}
	.input_search:focus {
		outline: none;
	}
	.btn:active, .btn:focus { 
		border: none; 
		box-shadow: none; 
	}
	/* tooltip */
	.tooltipbottom {
  		position: relative;
	}
	.tooltiptext {
  		width: 80px;
  		background-color: #e68c0e;
  		font-size: 10pt;
  		color: #fff;
  		text-align: center;
  		border-radius: 5px;
  		padding: 5px 0;
  		position: absolute;
  		z-index: 1;
  		bottom: -70%;
  		left: 65%;
 	 	margin-left: -50px;
  		opacity: 0;
  		transition: opacity 0.3s;
	}
	.tooltiptext::after {
  		content: "";
  		position: absolute;
  		top: -28%;
  		left: 50%;
  		margin-left: -5px;
  		border-width: 5px;
  		border-style: solid;
  		border-color: transparent transparent #e68c0e transparent;
	}
	.tooltipbottom:hover .tooltiptext {
  		opacity: 1;
	}
</style>

<%-- header start --%>
<div class="container-fluid">
	<nav class="navbar navbar-expand-lg pl-3 pr-3 pt-0 pb-0">
		<a class="navbar-brand" href="<%= ctxPath%>/index.kedai"><img alt="logo" src="<%= ctxPath%>/resources/images/common/logo_ver2.png" width="30%" /></a>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<form class="form-inline ml-auto my-2 mr-3 my-lg-0" style="position: relative;">
	      		<input class="mr-sm-2 mb-0 input_search" type="search" placeholder="Search">
	      		<button class="btn my-2 my-sm-0" type="submit" style="position: absolute; right: 1%;"><img alt="btn_search" src="<%= ctxPath%>/resources/images/common/btn_search.png" width="80%" /></button>
	    	</form>
	    	&nbsp;&nbsp;&nbsp;
	    	<ul class="navbar-nav">
		    	<li class="nav-item justify-content-end tooltipbottom">
		        	<span class="tooltiptext">로그아웃</span>
		        	<a class="nav-link" href="<%= ctxPath%>/logout.kedai" style="text-align: center;"><img alt="login" src="<%= ctxPath%>/resources/images/common/login.png" width="60%" /></a>
		      	</li>
		      	<li class="nav-item justify-content-end tooltipbottom">
		      		<span class="tooltiptext">알림</span>
		        	<a class="nav-link" href="#" style="text-align: center;"><img alt="alarm" src="<%= ctxPath%>/resources/images/common/alarm.png" width="60%" /></a>
		      	</li>
		      	<li class="nav-item justify-content-end tooltipbottom">
		      		<span class="tooltiptext">웹채팅</span>
		        	<a class="nav-link" href="<%= serverName%><%= ctxPath%>/chatting/multichat.kedai" style="text-align: center;"><img alt="alarm" src="<%= ctxPath%>/resources/images/common/chat.png" width="60%" /></a>
		      	</li>
		    </ul>
		</div>
	</nav>
</div>
<%-- header end --%>