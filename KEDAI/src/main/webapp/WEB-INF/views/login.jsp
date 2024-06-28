<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
	//     /KEDAI
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LOGIN</title>
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
	.login_btn{
		width: 100%;
		height: 60px;
		font-size: 18px;
		border: none;
		background: #2c4459;
		color: #fff;
		cursor: pointer;
	}
	.login_btn:hover {
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
	  	
		$("button#btnSubmit").click(function(){
	    	goLogin(); 
	    }); 
		
		$("input:password[id='pwd']").keydown(function(e){
        	if(e.keyCode == 13) { 
        		goLogin(); 
        	}
     	});
		
		if(${empty sessionScope.loginuser}){
			const loginid = localStorage.getItem('idSave');
	  		
  			if(loginid != null){
  				$("input#empid").val(loginid);
  				$("input:checkbox[id='idSave']").prop("checked", true);
  			}
		}
	}); // end of $(document).ready(function(){}) ----------
	
	function goLogin(){
		
		if($("input#empid").val().trim() == ""){
	        alert("아이디를 입력하세요.");
	        $("input#empid").val("").focus();
	        return; 
	    }

	    if($("input#pwd").val().trim() == ""){
	        alert("비밀번호를 입력하세요.");
	        $("input#pwd").val("").focus();
	        return; 
	    }
	    
		if($("input:checkbox[id='idSave']").prop("checked")){ 
	        localStorage.setItem('idSave', $("input#empid").val());
	    }
	    else{
	        localStorage.removeItem('idSave');
	    }
		
		const frm = document.loginFrm;
     	frm.action = "<%= ctxPath%>/loginEnd.kedai";
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
		
		<form name="loginFrm" style="width: 400px; margin: 0 auto;">
        	<div class="form-row">    
            	<div class="form-group" style="margin-bottom: 8px;">
               		<input type="text" class="form-control" name="empid" id="empid" value="" placeholder="사원아이디" />
               	</div>
   
            	<div class="form-group" style="margin-bottom: 8px;">
               		<input type="password" class="form-control" name="pwd" id="pwd" value="" placeholder="비밀번호" /> 
            	</div>
         	</div>
         </form>
         
         <div style="width: 400px; margin: 0 auto;">
         	<button class="login_btn" id="btnSubmit">로그인</button>
         	<br><br>
         	<div style="text-align: left;">
         		<input type="checkbox" id="idSave" />&nbsp;<label for="idSave">아이디 저장하기</label>
         		<div style="border: 0px solid red; float: right;">
         			<span><a href="">[ 아이디 찾기 ]</a></span>
         			<span><a href="">[ 비밀번호 찾기 ]</a></span>
         		</div>
         	</div>
         </div>        
	</div>
</body>
</html>