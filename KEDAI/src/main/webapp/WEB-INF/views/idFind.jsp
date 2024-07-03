<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String ctxPath = request.getContextPath();
	//     /KEDAI
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디찾기</title>
<%-- Font Awesome 6 Icons --%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
<%-- Optional JavaScript --%>
<script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery-3.7.1.min.js"></script>
<style type="text/css">
	.tab {
	  overflow: hidden;
	}
	.tab button {
		width: 200px;
	  	float: left;
	  	border: none;
	  	outline: none;
	  	cursor: pointer;
	  	padding: 14px 16px;
	  	transition: 0.3s;
	  	background: #fff;
	  	font-size: 18px;
	}
	.tab button.active {
	  	background: #e68c0e;
	  	color: #fff;
	}
	.tabcontent {
	  	display: none;
	  	padding-top: 2%; 
	}
	.form-group input{
		width: 400px;
		height: 60px;
		padding: 0 10px;
		outline: none;
		border: 1px solid #2c4459;
		box-sizing: border-box;
		color: #363636;
	}
	.idFind_btn{
		width: 100%;
		height: 60px;
		font-size: 18px;
		border: none;
		background: #2c4459;
		color: #fff;
		cursor: pointer;
	}
	.idFind_btn:hover {
		background: #e68c0e;
	}
	a{
		text-decoration: none;
		color: #363636;
	}
	a:hover {
		font-weight: bold;
	}
</style>

<script type="text/javascript">
	$(document).ready(function(){
		
		$("button.idBtn").addClass("active");
		$(".tabId").show();
		
		const method = "${requestScope.method}";
		
		if(method == "GET"){
			$("div#div_findResult").hide();
		}
		
		if(method == "POST"){
			$("input:text[name='name']").val("${requestScope.name}");
			$("input:text[name='email']").val("${requestScope.email}");
		}
	  	
		$("button#btnSubmitId").click(function(){
			goidFind(); 
	    }); 
		
		$("input:text[id='email']").keydown(function(e){
        	if(e.keyCode == 13) { 
        		goidFind(); 
        	}
     	});
		
	}); // end of $(document).ready(function(){}) ----------
	
	function openForm(evt, findInfo) {
		
    	// 모든 "tabcontent" 클래스를 가진 요소들을 숨김
    	$(".tabcontent").hide();

    	// "tablinks" 클래스를 가진 모든 요소에서 "active" 클래스를 제거
    	$(".tablinks").removeClass("active");

    	// 선택된 탭을 보여주고, 해당 탭을 여는 버튼에 "active" 클래스 추가
    	$("#" + findInfo).show();
    	$(evt.currentTarget).addClass("active");
    	
	} // end of $(document).ready(function(){}) ----------
	
	function goidFind(){
		
		if($("input#name").val().trim() == ""){
	        alert("이름을 입력하세요.");
	        $("input#name").val("").focus();
	        return; 
	    }

		const email = $("input:text[name='email']").val();
		const regExp_email = new RegExp(/^[0-9a-z]([-_\.]?[0-9a-z])*@[0-9a-z]([-_\.]?[0-9a-z])*\.[a-z]{2,3}$/i); 

        const bool = regExp_email.test(email);

        if(!bool){
        	alert("이메일을 올바르게 입력하세요.");
        	$("input#email").val("").focus();
			return;
        }
	 
		const frm = document.idFindFrm;
     	frm.action = "<%= ctxPath%>/login/idFind.kedai";
     	frm.method = "post";
     	frm.submit();
     	
	} // end of function goidFind() ----------
</script>	
</head>
<body>
	<div style="margin: 5% auto; text-align: center;">
		<div style="width: 400px; margin: 0 auto; margin-bottom: 3%;">
			<img alt="logo" src="<%= ctxPath%>/resources/images/common/logo_ver4.png" width="100%" class="img-fluid" />
		</div>
		
		<div class="tab" style="width: 400px; margin: 0 auto;">
			<button class="tablinks idBtn" onclick="openForm(event, 'idFind')">아이디 찾기</button>
		  	<button class="tablinks pwBtn" onclick="openForm(event, 'pwdFind')">비밀번호 찾기</button>
		</div>
		
		<!-- 아이디 찾기 -->
		<div id="idFind" class="tabcontent tabId">
	  		<form name="idFindFrm" style="width: 400px; margin: 0 auto;">
	  			<div style="text-align: left;"><i class="fa-regular fa-circle-check"></i>&nbsp;&nbsp;이메일로 찾기</div>
		  		<br>
	        	<div class="form-row">    
	            	<div class="form-group" style="margin-bottom: 3%;">
	               		<input type="text" class="form-control" name="name" id="name" placeholder="이름" />
	               	</div>
	   
	            	<div class="form-group" style="margin-bottom: 3%;">
	               		<input type="text" class="form-control" name="email" id="email" placeholder="abcd1234@kedai.com" /> 
	            	</div>
	         	</div>
	        </form>
	        
	        <div style="width: 400px; margin: 0 auto;">
       			<button type="button" class="idFind_btn" id="btnSubmitId">아이디 찾기</button>
        	</div>
        	<br>
	        <div class="my-3 text-center" id="div_findResult">
	        	<c:if test="${not empty requestScope.empid}">
	           		${requestScope.name}님의 아이디는 <span style="color: #e68c0e; font-size: 16pt; font-weight: bold;">${requestScope.empid}</span> 입니다. 
	           	</c:if>
			   	<c:if test="${empty requestScope.empid}">
	           		입력하신 정보로 등록된 사원 아이디는 <span style="color: #e68c0e; font-size: 16pt; font-weight: bold;">${requestScope.empid}</span>
	           	</c:if>
			</div>  
		</div>
		
    	<!-- 비밀번호 찾기 -->
		<div id="pwdFind" class="tabcontent tabPwd">
			<form name="idFindFrm" style="width: 400px; margin: 0 auto;">
	  			<div style="text-align: left;"><i class="fa-regular fa-circle-check"></i>&nbsp;&nbsp;사원아이디 & 이메일로 찾기</div>
		  		<br>
	        	<div class="form-row">    
	            	<div class="form-group" style="margin-bottom: 3%;">
	               		<input type="text" class="form-control" name="empid" id="empid" placeholder="사원아이디" />
	               	</div>
	            	
	            	<div class="form-group" style="margin-bottom: 3%;">
	               		<input type="text" class="form-control" name="name" id="name" placeholder="이름" />
	               	</div>
	   
	            	<div class="form-group" style="margin-bottom: 3%;">
	               		<input type="text" class="form-control" name="email" id="email" placeholder="abcd1234@kedai.com" /> 
	            	</div>
	         	</div>
	        </form>
	        
	        <div style="width: 400px; margin: 0 auto;">
       			<button type="button" class="pwdFind_btn" id="btnSubmitPwd">비밀번호 찾기</button>
        	</div>
        	<br>
	        <div class="my-3 text-center" id="div_findResult">
        		<c:if test="${requestScope.isExist == false}">
			   		<span style="color: #fbc02d; font-size: 16pt; font-weight: bold;">입력하신 정보로 가입된 회원은 존재하지 않습니다.</span>
			   	</c:if>
			   
			   	<c:if test="${requestScope.isExist == true && requestScope.sendMailSuccess == true}">
		   			<span>인증번호가 <span style="color: #fbc02d; font-size: 16pt; font-weight: bold;">${requestScope.email}</span> 로 발송되었습니다.<br>전송된 인증번호를 입력해주세요.</span>
				   	<br><br>
				   	<input type="text" name="input_confirmCode" style="border-radius: 5px; outline: none; text-align: center;" />
				   	<br>
				   	<button type="button" class="btn btn-warning">인증하기</button>
			   	</c:if>
			   
			   	<c:if test="${requestScope.isExist == true && requestScope.sendMailSuccess == false}">
		   	   		<span style="color: red;">메일발송이 실패했습니다.</span>
		   		</c:if>
			</div> 
		</div>     
	</div>
</body>
</html>