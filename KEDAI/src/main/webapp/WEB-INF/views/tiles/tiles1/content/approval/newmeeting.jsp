<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>

<%-- Bootstrap CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/bootstrap-4.6.2-dist/css/bootstrap.min.css" > 
    
<style type="text/css">


table th,
table td{
	padding:0;
}

/*
table.left_table tr{
	height: 15px; 
}*/

div#title{
	font-size:27px;
	margin : 3% 0 1% 0;
}

div#title2{
	font-size:25px;
	margin : 0 0 1% 0;
}
table.left_table{
	width:100%
}

table.left_table th{
	width : 25%;
	background-color: #EBEBEB;
}

table#add th{
	padding-left:35px;
}

table#title_table td{
	width : 25%;
}

</style>



<script type="text/javascript">
	
	$(document).ready(function(){
		<%-- === #167.-2 스마트 에디터 구현 시작 === --%>
		//전역변수
		var obj = [];
		
		//스마트에디터 프레임생성
		nhn.husky.EZCreator.createInIFrame({
		oAppRef: obj,
		elPlaceHolder: "content", // id가 content인 textarea에 에디터를 넣어준다.
		sSkinURI: "<%= ctxPath%>/resources/smarteditor/SmartEditor2Skin.html",
		htParams : {
		 	// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseToolbar : true,            
		      // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
		    bUseVerticalResizer : true,    
		      // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
		    bUseModeChanger : true,
		}
	});
		
	// 쓰기버튼
	$("#btnWrite").click(function(){
	       
		<%-- === 스마트 에디터 구현 시작 === --%>
		// id가 content인 textarea에 에디터에서 대입
	    obj.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
		<%-- === 스마트 에디터 구현 끝 === --%>
			
		// 글제목 유효성 검사
		const subject = $("input#subject").val().trim();
		if(subject == "") {
			alert("글제목을 입력하세요!!");
			return;
		}	
	<%-- === 글내용 유효성 검사(스마트 에디터 사용 할 경우) 시작 === --%>
		var contentval = $("textarea#content").val();
		        
		 // 글내용 유효성 검사 하기 
         // alert(contentval); // content에  공백만 여러개를 입력하여 쓰기할 경우 알아보는것.
         // <p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</p> 이라고 나온다.
         
        contentval = contentval.replace(/&nbsp;/gi, ""); // 공백을 "" 으로 변환
         /*    
		         대상문자열.replace(/찾을 문자열/gi, "변경할 문자열");
		     ==> 여기서 꼭 알아야 될 점은 나누기(/)표시안에 넣는 찾을 문자열의 따옴표는 없어야 한다는 점입니다. 
		                  그리고 뒤의 gi는 다음을 의미합니다.
		
		 	 g : 전체 모든 문자열을 변경 global
		 	 i : 영문 대소문자를 무시, 모두 일치하는 패턴 검색 ignore
		*/ 
      //   alert(contentval);
      //   <p>             </p>
         
        contentval = contentval.substring(contentval.indexOf("<p>")+3);   // "             </p>"
        contentval = contentval.substring(0, contentval.indexOf("</p>")); // "             "
                  
        if(contentval.trim().length == 0) {
        	alert("글내용을 입력하세요!!");
               return;
        }
	<%-- === 글내용 유효성 검사(스마트 에디터 사용 할 경우) 끝 === --%>

	
	 // 폼(form)을 전송(submit)
	const frm = document.newDocFrm;
 	frm.method = "post";
  	frm.action = "<%= ctxPath%>/newDocEnd.kedai";
    frm.submit();
    
</script>	


<div id="total_contatiner" style="display:flex;">
	<div id="leftside" class="col-md-5" style="width:90%; padding:0;">
		<div id="title"> 회의록</div>
		<table class="table left_table" id="title_table" >
			<tr>
				<th>문서번호</th>
				<td>1</td>
				<th>기안일자</th>
				<td>2024-06-01</td>
			</tr>
			<tr>
				<th>기안자</th>
				<td>김땡땡</td>
				<th>부서</th>
				<td>영업부</td>		
			</tr>
		</table>
		<table class="table left_table" id="meeting" >
			<tr>
				<th>주관부서</th>
				<td>ggg</td>
			</tr>
			<tr>
				<th>회의일자</th>
				<td>ggg</td>
			</tr>
			<tr>
				<th>회의장소</th>
				<td>gggg</td>
			</tr>
			<tr>
				<th>회의 참여부서</th>
				<td>어쩌구</td>
			</tr>
		</table>
		
		<div id="title2"> 결제라인 &nbsp; &nbsp; &nbsp;&nbsp;&nbsp; <button type="button" class="btn btn-outline-secondary btn-sm">선택하기</button></div> 
		<table class="table left_table" id="approval">
			<tr style="text-align:center;">
				<th>순서</th>
				<th>소속</th>
				<th>직급</th>
				<th>성명</th>
			</tr>
		</table>
	</div>
	<div class="col-md-6" style="margin:0; width: 100%">
		<form name="newDocFrm" enctype="multipart/form-data" > 
        	<table style="margin-left:5%;" class="table" id="add">
	         	<tr>
	            	<th style="width:20%;">제목</th>
	            	<td>
	            		<%-- === 원글쓰기인 경우 === 
	                	<c:if test='${requestScope.fk_seq eq ""}'>--%> 
	        				<input type="text" style="height:23pt;" name="subject" size="80" maxlength="100" /> 
						<%--</c:if>     --%>
	                    
	            	</td>
	            </tr>
	         
	         	<tr>
	            	<th colspan='2'>내용</th> 
	            </tr>
	            <tr>
	            	<td colspan='2'>
	                	<textarea style="width: 100%; height: 500px;" name="content" id="content"></textarea>
	            	</td>
	         	</tr>
	         	<%-- === #170. 파일첨부 타입 추가하기 시작=== --%>
	         	
	         	<tr>
            		<th>파일첨부</th>  
            		<td>
                		<input type="file" name="attach" />
            		</td>
         		</tr>
         		
         		<%-- === #170. 파일첨부 타입 추가하기 끝 === --%>

        	</table>
        
        
        	<div style="margin: 20px;">
            	<button type="button" class="btn btn btn-dark btn-sm mr-4" id="btnWrite" >확인</button>
            	<button type="button" class="btn btn-primary btn-sm" onclick="javascript:history.back()">취소</button>  
        	</div>
        <%-- 버튼이 form 태그 안에 있으면 무조건 get방식으로 submit되어진다. 유효성 검사를 하고 post방식으로 submit해주고 싶다면 무조건   type="button" 해야 한다. --%>
     	</form>
	</div>
</div>

</body>
</html>