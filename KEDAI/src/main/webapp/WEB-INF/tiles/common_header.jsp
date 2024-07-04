<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String ctxPath = request.getContextPath();
	//	   /KEDAI
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
</style>

<%-- header start --%>
<div class="container-fluid">
	<nav class="navbar navbar-expand-lg">
		<a class="navbar-brand" href="<%= ctxPath%>/index.kedai"><img alt="logo" src="<%= ctxPath%>/resources/images/common/logo_ver2.png" width="30%" /></a>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<form class="form-inline ml-auto my-2 mr-3 my-lg-0" style="position: relative;">
	      		<input class="mr-sm-2 mb-0 input_search" type="search" placeholder="Search">
	      		<button class="btn my-2 my-sm-0" type="submit" style="position: absolute; right: 1%;"><img alt="btn_search" src="<%= ctxPath%>/resources/images/common/btn_search.png" width="80%" /></button>
	    	</form>
	    	&nbsp;&nbsp;
	    	<ul class="navbar-nav">
		    	<li class="nav-item">
		        	<a class="nav-link" href="#" style="text-align: center;"><img alt="login" src="<%= ctxPath%>/resources/images/common/login.png" width="60%" /></a>
		      	</li>
		      	<li class="nav-item">
		        	<a class="nav-link" href="#" style="text-align: center;"><img alt="mail" src="<%= ctxPath%>/resources/images/common/mail.png" width="60%" /></a>
		      	</li>
		      	<li class="nav-item">
		        	<a class="nav-link" href="#" style="text-align: center;"><img alt="alarm" src="<%= ctxPath%>/resources/images/common/alarm.png" width="60%" /></a>
		      	</li>
		    </ul>
		</div>
	</nav>
</div>
<%-- header end --%>