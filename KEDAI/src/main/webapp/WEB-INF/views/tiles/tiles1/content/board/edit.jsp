<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String ctxPath = request.getContextPath();
	//     /KEDAI
%>
<style type="text/css">
	input {
		padding-left: 1%;
	}
	.add_btn {
		border: solid 1px #2c4459;
		color: #2c4459;
		font-size: 12pt;
		width: 120px;
		height: 40px;
	}
	.add_btn:hover {
		border: none;
		background: #e68c0e;
		color: #fff;
	}
</style>
<script type="text/javascript">
	$(document).ready(function(){
		
		<%-- === 스마트 에디터 구현 시작 === --%>
		var obj = [];
		
		//스마트에디터 프레임생성
      	nhn.husky.EZCreator.createInIFrame({ 
        	oAppRef: obj,
          	elPlaceHolder: "content", 
          	sSkinURI: "<%= ctxPath%>/resources/smarteditor/SmartEditor2Skin.html",
          	htParams : {
            	// 툴바 사용 여부 (true:사용 / false:사용하지 않음)
              	bUseToolbar : true,            
              	// 입력창 크기 조절바 사용 여부 (true:사용 / false:사용하지 않음)
              	bUseVerticalResizer : false,    
              	// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용 / false:사용하지 않음)
              	bUseModeChanger : true
          	}
      	});
     	<%-- === 스마트 에디터 구현 끝 === --%>
     	
     	// 수정 버튼을 클릭한 경우
     	$("button#btnUpdate").click(function(){
     		
     		<%-- === 스마트 에디터 구현 시작 === --%>
            // id 가  content 인 textarea 에 에디터에서 대입
            obj.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
           	<%-- === 스마트 에디터 구현 끝 === --%>
           	
         	// 카테고리 유효성 검사하기
         	const category_name = $("select[name='category_name']").val();
         	if(category_name == ""){
         		alert("카테고리를 선택하세요.");
         		$("select[name='category_name']").focus();
         		return; // 종료
         	}
           	
           	// 제목 유효성 검사하기
     		const subject = $("input:text[name='subject']").val().trim();
     		if(subject == ""){
     			alert("제목을 입력하세요.");
     			$("input:text[name='subject']").val("");
     			return; // 종료
     		}
     		
     		// 내용 유효성 검사하기(스마트에디터를 사용할 경우)
     		let content_val = $("textarea[name='content']").val().trim();
     		
     		content_val = content_val.replace(/&nbsp;/gi, ""); 
     		// <p>&nbsp; &nbsp; &nbsp; &nbsp; </p> => 공백(&nbsp;)을 "" 으로 변환 => <p>    </p>
     		
     		content_val = content_val.substring(content_val.indexOf("<p>")+3);
     		content_val = content_val.substring(0, content_val.indexOf("</p>"));
     		
     		if(content_val.trim().length == 0){
     			alert("내용을 입력하세요.");
     			return; // 종료
     		}
     		
     		// 비밀번호 유효성 검사하기
     		const pwd = $("input:password[name='pwd']").val();
     		if(pwd == ""){
     			alert("비밀번호를 입력하세요.");
     			return; // 종료
     		}
     		else{
     			if("${requestScope.bvo.pwd}" != pwd){
     				alert("입력하신 비밀번호가 일치하지 않습니다.");
         			return; // 종료
     			}
     		}
     		
     		// 폼(form)을 전송(submit)
     		const frm = document.editFrm;
     		frm.method = "post";
     		frm.action = "<%= ctxPath%>/board/editEnd.kedai";
     		frm.submit();
     	});
		
	}); // end of $(document).ready(function(){}) ----------
</script>

<%-- content start --%>
<div style="border: 0px solid red; padding: 1% 3% 3% 0;">
	<div>
   		<h3><span class="icon"><i class="fa-solid fa-seedling"></i></span>&nbsp;&nbsp;글수정하기</h3>
	</div>
   	
   	<form name="editFrm" enctype="multipart/form-data" class="row mt-5"> 
   		<div class="col-4">
   			<div class="mb-3">
	   			<label for="fk_empid" style="width: 30%;">사원아이디</label>
	   			<input type="text" name="fk_empid" id="fk_empid" style="width: 180px; height: 30px;" value="${sessionScope.loginuser.empid}" readonly />
	   		</div>
	   		<div class="mb-3">
	   			<label for="name" style="width: 30%;">작성자</label>
	   			<input type="text" name="name" id="name" style="width: 180px; height: 30px;" value="${sessionScope.loginuser.name}" readonly />
	   			
	   			<!-- 동일한 작성가가 글을 여러개 작성할 수도 있기 때문에 글번호를 넘겨줘야 한다. -->
	   			<input type="hidden" name="board_seq" value="${requestScope.bvo.board_seq}" />
	   		</div>
	   		<div class="mb-3" style="display: flex;">
				<label for="fk_empid" style="width: 30%;">카테고리</label>
				<select name="category_name" class="infoData" style="width: 180px; height: 30px; margin-left: 0.9%;">
					<option value="">카테고리</option>
					<c:forEach var="cvo" items="${requestScope.categoryList}">
                  		<option value="${cvo.category_name}">${cvo.category_name}</option>
           			</c:forEach>
				</select>
			</div>
   		</div>
   		
   		<div class="col-8">
   			<div class="mb-3">
	   			<label for="subject" style="width: 10%;">제목</label>
     			<input type="text" name="subject" id="subject" size="100" maxlength="200" style="width: 50%; height: 30px;" value="${requestScope.bvo.subject}" /> 
	   		</div>
	   		<div class="mb-3">
   				<textarea style="width: 100%; height: 530px;" name="content" id="content">${requestScope.bvo.content}</textarea>
   			</div>
   			<div class="row">
   				<div class="col-6">
   					<div>
		   				<label for="attach" style="width: 30%;">파일 첨부</label>
		   				<input type="file" name="attach" style="padding-left: 0%;"/>
		   			</div>
		   			<div>
		   				<label for="pwd" style="width: 30%;">비밀번호</label>
		   				<input type="password" name="pwd" id ="pwd" maxlength="20" />
		   			</div>
   				</div>
   				
   				<div class="col-6 d-md-flex justify-content-md-end">
			   		<button type="button" class="btn add_btn mr-3" id="btnUpdate">수정</button>
			       	<button type="button" class="btn add_btn" onclick="javascript:history.back()">취소</button>
			   	</div>
   			</div>
   		</div>
   	</form>
</div>
<%-- content end --%>