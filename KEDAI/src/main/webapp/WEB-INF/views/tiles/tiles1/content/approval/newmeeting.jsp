<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
    
<style type="text/css">

table, th, td {
  border: 1px solid black;
  border-collapse: collapse;
}

th, td{
	padding:2%;
}

table tr{
	height: 50px; 
}

span#title{
	margin : 2% 0;
}

table#title_table th{
	width : 25%;
	background-color: #EBEBEB;
}

table#title_table td{
	width : 25%;
}

table#meeting th{
	 width:25%;
	 background-color: #EBEBEB;
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
	<%-- === 스마트 에디터 구현 끝 === --%>	
	
	 <%-- === 스마트 에디터 구현 시작 === --%>
     // id가 content인 textarea에 에디터에서 대입
       obj.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
    <%-- === 스마트 에디터 구현 끝 === --%>
	 
	 // 글제목 유효성 검사
	 const subject = $("input:text[name='subject']").val().trim();
	 if(subject == ""){
		 alert("글 제목을 입력하세요!!");
		 $("input:text[name='subject']").val("");
		 return; // 종료
	 }
	 
	 // 글내용 유효성 검사(스마트 에디터를 사용할 경우) 
	 <%-- const content = $("textarea[name='content']").val().trim();
	 if(content == ""){
		 alert("글 내용을 입력하세요!!");
		 return; // 종료
	 } 
	 ==> 이렇게 입력했을 경우 html로 변환했을 때 <p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</p> 이렇게 나옴. 
	 그래서 공백이라고 인식하지 못함.
	--%>
	let content_val = $("textarea[name='content']").val().trim();
		//alert(content_val); // content에 공백만 여러개를 입력하여 쓰기할 경우 알아보는 것
		// <p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</p>
	//content_val.replace("&nbsp;", ""); 첫 번째로 발견된 &nbsp; 문자열만을 빈 문자열로 대체. 그러므로 여러 개의 &nbsp;가 존재하는 경우 첫 번째만 대체되고 나머지는 그대로 남게 됨.
		content_val = content_val.replace(/&nbsp;/gi, ""); // 공백(&nbsp;)을 ""으로 변환
		/*    
    	대상문자열.replace(/찾을 문자열/gi, "변경할 문자열");
  		==> 여기서 꼭 알아야 될 점은 나누기(/)표시안에 넣는 찾을 문자열의 따옴표는 없어야 한다는 점입니다. 
            	그리고 뒤의 gi는 다음을 의미합니다.

      g : 전체 모든 문자열을 변경 global
      i : 영문 대소문자를 무시, 모두 일치하는 패턴 검색 ignore
   */ 
   	alert(content_val);
  	// <p>    </p>
  	
 	content_val = content_val.substring(content_val.indexOf("<p>")+3);
 	content_val = content_val.substring(0,content_val.indexOf("</p>"));
 	
 	if(content_val.trim().length == 0){
 		alert("글 내용을 입력하세요!!");
 		return; //종료
 	}
	 	
	 // 폼(form)을 전송(submit)
	const frm = document.newDocFrm;
 	frm.method = "post";
  	frm.action = "<%= ctxPath%>/newDocEnd.kedai";
    frm.submit();
    
</script>	


<div id="total_contatiner" style="display:flex;">
	<div id="left-table" class="col-md-5" style="width:100%; padding:0;">
		<span id="title" style=" font-size:30px;"> 회의록</span>
		<table id="title_table" style="width:100%;">
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
		<br>
		<table id="meeting" style="width:100%;">
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
	</div>
	<div class="col-md-6" style="margin:0;">
		<form name="newDocFrm" enctype="multipart/form-data"> 
        	<table style="width: 100%" class="table table-bordered">
	         	<tr>
	            	<th style="width : 50%;">제목</th>
	            	<td>
	            		<%-- === 원글쓰기인 경우 === 
	                	<c:if test='${requestScope.fk_seq eq ""}'>--%> 
	        				<input type="text" name="subject" size="100" maxlength="200" /> 
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
            		<th style="width : 50%;">파일첨부</th>  
            		<td>
                		<input type="file" name="attach" />
            		</td>
         		</tr>
         		
         		<%-- === #170. 파일첨부 타입 추가하기 끝 === --%>

        	</table>
        
        
        	<div style="margin: 20px;">
            	<button type="button" class="btn btn-secondary btn-sm mr-3" id="btnWrite">완료</button>
            	<button type="button" class="btn btn-secondary btn-sm" onclick="javascript:history.back()">취소</button>  
        	</div>
        <%-- 버튼이 form 태그 안에 있으면 무조건 get방식으로 submit되어진다. 유효성 검사를 하고 post방식으로 submit해주고 싶다면 무조건   type="button" 해야 한다. --%>
     	</form>
	</div>
</div>

</body>
</html>