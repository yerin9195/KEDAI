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
<%-- Optional JavaScript --%>
<script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery-3.7.1.min.js"></script>
<style type="text/css">
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
		
		const method = "${requestScope.method}";
		
		if(method == "GET"){
			$("div#div_findResult").hide();
		}
		
		if(method == "POST"){
			$("input:text[name='name']").val("${requestScope.name}");
			$("input:text[name='email']").val("${requestScope.email}");
		}
	  	
		$("button#btnSubmit").click(function(){
			goidFind(); 
	    }); 
		
		$("input:text[id='email']").keydown(function(e){
        	if(e.keyCode == 13) { 
        		goidFind(); 
        	}
     	});
		
	}); // end of $(document).ready(function(){}) ----------
	
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
	}
</script>	
</head>
<body>
	<div style="margin: 5% auto; text-align: center;">
		<div style="width: 400px; margin: 0 auto; margin-bottom: 20px;">
			<img alt="logo" src="<%= ctxPath%>/resources/images/common/logo_ver1.png" width="60%" class="img-fluid" />
		</div>
		
		<form name="idFindFrm" style="width: 400px; margin: 0 auto;">
        	<div class="form-row">    
            	<div class="form-group" style="margin-bottom: 8px;">
               		<input type="text" class="form-control" name="name" id="name" placeholder="이름" />
               	</div>
   
            	<div class="form-group" style="margin-bottom: 8px;">
               		<input type="text" class="form-control" name="email" id="email" placeholder="abcd1234@kedai.com" /> 
            	</div>
         	</div>
        </form>
         
        <div style="width: 400px; margin: 0 auto;">
       		<button class="idFind_btn" id="btnSubmit">아이디찾기</button>
        </div>
        <br>
        <div class="my-3 text-center" id="div_findResult">
        	<c:if test="${not empty sessionScope.loginuser}">
           		${requestScope.name}님의 아이디는 <span style="color: #fbc02d; font-size: 16pt; font-weight: bold;">${requestScope.id}</span> 입니다.
           	</c:if>
		   	<c:if test="${empty sessionScope.loginuser}">
           		입력하신 정보로 등록된 사원 아이디는 <span style="color: #fbc02d; font-size: 16pt; font-weight: bold;">${requestScope.id}</span>
           	</c:if>
		</div>        
	</div>
</body>
</html>