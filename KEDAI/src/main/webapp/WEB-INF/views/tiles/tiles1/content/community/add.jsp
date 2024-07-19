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
	div.fileDrop { 
		display: inline-block; 
        width: 100%; 
        height: 100px;
        overflow: auto;
        background-color: #fff;
    }
    div.fileDrop > div.fileList > span.delete {
    	display: inline-block; 
    	width: 20px; 
    	border: solid 1px #2c4459; 
    	text-align: center;
    } 
   	div.fileDrop > div.fileList > span.delete:hover {
   		background-color: #e68c0e; 
   		color: #fff; 
   		cursor: pointer;
   	}
   	div.fileDrop > div.fileList > span.fileName {
   		padding-left: 10px;
   	}
   	div.fileDrop > div.fileList > span.fileSize {
   		padding-right: 20px; 
   		float:right;
   	} 
   	span.clear {
   		clear: both;
   	}    
</style>
<script type="text/javascript">
	$(document).ready(function(){

		<%-- === 스마트 에디터 구현 시작 === --%>
		var obj = [];
		
		// 스마트에디터 프레임생성
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
     	
     	<%-- === jQuery 를 사용하여 드래그앤드롭(Drag&Drop)을 통한 파일 업로드 시작 === --%>
     	let file_arr = []; // 첨부되어진 파일 정보를 담아 둘 배열
     	
     	// 파일 Drag&Drop 만들기
     	$("div#fileDrop").on("dragenter", function(e){ //  드롭대상인 박스 안에 Drag 한 파일이 최초로 들어왔을 때
     		e.preventDefault(); // 해당 이벤트 이외에 별도로 브라우저에서 발생하는 행동을 막기 위해 사용하는 것
     		e.stopPropagation(); // 이벤트 버블링을 막기위해서 사용하는 것
     	}).on("dragover", function(e){ // 드롭대상인 박스 안에 Drag 한 파일이 머물러 있는 중일 때
     		e.preventDefault();
	        e.stopPropagation();
	        $(this).css("background-color", "#f0f0f0");
     	}).on("dragleave", function(e){ // Drag 한 파일이 드롭대상인 박스 밖으로 벗어났을 때
     		e.preventDefault();
	        e.stopPropagation();
	        $(this).css("background-color", "#fff");
     	}).on("drop", function(e){ // 드롭대상인 박스 안에서 Drag 한 것을 Drop(Drag 한 파일(객체)을 놓는 것) 했을 때
     		e.preventDefault();
     	
     		var files = e.originalEvent.dataTransfer.files; // drag 한 파일을 읽어온다.
     		
     		if(files != null && files != undefined){
     			let html = "";
	            const f = files[0]; // files[0] 을 사용하여 1개만 가져온다. 
	           	let fileSize = f.size/1024/1024; // 파일의 크기는 MB로 나타내기 위하여 /1024/1024 하였다.
	           	
	          	if(fileSize >= 10) {
	              	alert("10MB 이상인 파일은 업로드할 수 없습니다.");
	              	$(this).css("background-color", "#fff");
	              	return;
	           	}
	           	else {
	           		file_arr.push(f);
	              	const fileName = f.name; // 파일명   
	              	
	              	fileSize = fileSize < 1 ? fileSize.toFixed(3) : fileSize.toFixed(1);
	             	// fileSize 가 1MB 보다 작으면 소수부는 반올림하여 소수점 3자리까지 나타내며, 
	                // fileSize 가 1MB 이상이면 소수부는 반올림하여 소수점 1자리까지 나타낸다. 만약에 소수부가 없으면 소수점은 0 으로 표시한다.
	                // toFixed() 메서드는 숫자를 고정 소수점 표기법(fixed-point notation)으로 표시하여 나타난 수를 문자열로 반환한다.
	                
	              	html += "<div class='fileList'>" +
		                		"<span class='delete'>&times;</span>" +
		                		"<span class='fileName'>"+fileName+"</span>" +
		                		"<span class='fileSize'>"+fileSize+" MB</span>" +
		                		"<span class='clear'></span>" +
		                    "</div>";
		      		$(this).append(html);
	           	}
     		} // end of if(files != null && files != undefined){} ----------
     	
     		$(this).css("background-color", "#fff");
     	}); 
     	
     	// Drop 되어진 파일목록 제거하기
     	$(document).on("click", "span.delete", function(e){
     		let idx = $("span.delete").index($(e.target));
     		
     		file_arr.splice(idx, 1); // 드롭대상인 박스 안에 첨부파일을 드롭하면 파일들을 담아둘 배열인 file_arr 에서 파일을 제거한다.
 			// 배열명.splice(start, deleteCount); => 배열의 특정 위치의 배열 요소를 삭제하는 경우   
 			// start - 수정할 배열 요소의 인덱스, deleteCount - 삭제할 요소 개수
 			
     		$(e.target).parent().remove();
     	});
     	<%-- === jQuery 를 사용하여 드래그앤드롭(DragAndDrop)을 통한 파일 업로드 끝 === --%>
     	
     	// 등록 버튼을 클릭한 경우
     	$("button#btnWrite").click(function(){
     		
     		<%-- === 스마트 에디터 구현 시작 === --%>
            // id 가  content 인 textarea 에 에디터 대입
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
     		
     		// 폼(form)을 전송(submit)
     		const frm = document.addFrm;
     		frm.method = "post";
     		frm.action = "<%= ctxPath%>/community/addEnd.kedai";
     		frm.submit();
     	});
		
	}); // end of $(document).ready(function(){}) ----------
</script>

<%-- content start --%>
<div style="border: 0px solid red; padding: 2% 3% 0 0;">
	<div>
   		<h3><span class="icon"><i class="fa-solid fa-seedling"></i></span>&nbsp;&nbsp;글쓰기</h3>
	</div>
	
	<form name="addFrm" enctype="multipart/form-data" class="row mt-5"> 
		<div class="col-4">
			<div class="mb-3">
	   			<label for="fk_empid" style="width: 30%;">사원아이디</label>
	   			<input type="text" name="fk_empid" id="fk_empid" style="width: 180px; height: 30px;" value="${(sessionScope.loginuser).empid}" readonly />
	   		</div>
	   		<div class="mb-3">
	   			<label for="name" style="width: 30%;">작성자</label>
	   			<input type="text" name="name" id="name" style="width: 180px; height: 30px;" value="${(sessionScope.loginuser).name}" readonly />
	   		</div>
	   		<div class="mb-3">
	   			<label for="name" style="width: 30%;">닉네임</label>
	   			<input type="text" name="nickname" id="nickname" style="width: 180px; height: 30px;" value="${(sessionScope.loginuser).nickname}" readonly />
	   		</div>
	   		<div class="mb-3" style="display: flex;">
				<label for="fk_empid" style="width: 30%;">카테고리</label>
				<select name="category_name" class="infoData" style="width: 180px; height: 30px; margin-left: 0.9%;">
					<option value="">카테고리</option>
					<c:forEach var="Communitycvo" items="${requestScope.categoryList}">
                  		<option value="${Communitycvo.category_name}">${Communitycvo.category_name}</option>
           			</c:forEach>
				</select>
			</div>
			<br><br><br>
			<div class="mb-3">
	   			<label for="fileDrop" style="width: 100%;">파일첨부<span style="font-size: 12pt; color: #e68c0e;">&nbsp;&nbsp;* 파일을 하나씩 마우스로 끌어 오세요.</span></label>
	   			<div id="fileDrop" class="fileDrop border border-secondary"></div>
	   		</div>
		</div>
		
		<div class="col-8">
			<div class="mb-3">
				<label for="subject" style="width: 10%;">제목</label>
				<input type="text" name="subject" id="subject" size="100" maxlength="200" style="width: 50%; height: 30px;" /> 
			</div>
			<div class="mb-3">
   				<textarea style="width: 100%; height: 530px;" name="content" id="content"></textarea>
   			</div>
   			<div class="row">
   				<div class="col-6">
		   			<div>
		   				<label for="pwd" style="width: 30%;">비밀번호</label>
		   				<input type="password" name="pwd" id ="pwd" maxlength="20" />
		   			</div>
   				</div>
   				
   				<div class="col-6 d-md-flex justify-content-md-end">
			   		<button type="button" class="btn add_btn mr-3" id="btnWrite">등록</button>
			       	<button type="button" class="btn add_btn" onclick="javascript:history.back()">취소</button>
			   	</div>
   			</div>
		</div>
	</form>
</div>
<%-- content end --%>