<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String ctxPath = request.getContextPath();
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style type="text/css">

</style>


<script type="text/javascript">
$(document).ready(function(){
	$(document).on("keydown", "input:text[name='searchWord']", function(e){
		if(e.keyCode == 13){
			goSearch();
		}
	}); 
	
	// 검색시 검색조건 및 검색어 값 유지시키기
	if("${requestScope.paraMap.searchType}" != "" && "${requestScope.paraMap.searchWord}" != ""){ 
		$("select[name='searchType']").val("${requestScope.paraMap.searchType}");
		$("input[name='searchWord']").val("${requestScope.paraMap.searchWord}");
	}
			
});// end of $(document).ready-------------


//function Declaration

function goView(doc_no, fk_doctype_code){
	<%--location.href=`<%= ctxPath%>/view.action?seq=\${seq}&goBackURL=\${goBackURL}`;--%>
	<%-- 또는 location.href=`<%= ctxPath%>/view.action?seq=+seq`; --%>

	const goBackURL = "${requestScope.goBackURL}"; <%-- 문자열 : 쌍따옴표--%>
	// goBackURL = "/list.action?searchType=subject&searchWord=정화&currentShowPageNo=3"
	// &은 종결자. 그래서 			/list.action?searchType=subject 까지밖에 못 받아온다.

	<%--	
	아래처럼 get 방식으로 보내면 안된다. 왜냐하면 get방식에서 &는 전송될 데이터의 구분자로 사용되기 때문이다.
	location.href=`<%= ctxPath%>/view.action?seq=\${seq}&goBackURL=\${goBackURL}`;
	--%>

	<%-- 그러므로 &를 글자 그대로 인식하는 post 방식으로 보내야 한다.	아래에 #132에 표기된 form태그를 먼저 만든다.	--%>

	const frm = document.forms["goViewFrm"];
	frm.doc_no.value = doc_no;
	frm.fk_doctype_code.value = fk_doctype_code;
	frm.goBackURL.value=goBackURL;

	if(${not empty requestScope.paraMap}){ // 검색조건이 있을 경우
		frm.searchType.value = "${requestScope.paraMap.searchType}";	
		frm.searchWord.value = "${requestScope.paraMap.searchWord}";		
	}

	frm.method = "post";
	frm.action = "<%= ctxPath%>/approval/viewOneDoc.kedai";
	frm.submit();

}//end of goView(doc_no, fk_doctype_code)---------------------------


function goSearch(){
	const frm = document.searchFrm;
<%--	frm.method = "get"; //안쓰면 get방식
//	frm.action = "<%= ctxPath%>/list.action"; // 쓰나 안 쓰나 똑같음. --%>

	console.log(frm);
	frm.submit();
}// end of function goSearch()--------------

</script>



<div id="around_docList">    
<div id="title" style="margin: 1.5% 1%; font-size: 15pt;"> 결재 대기 문서</div>

	<form name="searchFrm" style="margin-top: 20px;">
    	<select name="searchType" style="height: 26px;">
    		<option value="doctype_name">종류</option>
        	<option value="doc_subject">제목</option>
         	<option value="doc_content">내용</option>
         	<option value="doc_no">문서번호</option>
         	<option value="doc_subject_content">글제목+글내용</option>
      	</select>
      	<input type="text" name="searchWord" size="40" autocomplete="off" /> 
      	<input type="text" style="display: none;"/> <%-- form 태그내에 input 태그가 오로지 1개 뿐일경우에는 엔터를 했을 경우 검색이 되어지므로 이것을 방지하고자 만든것이다. 
      	여기 Hidden을 주면 안 된다!! --%> 
      	<button type="button" class="btn btn-secondary btn-sm" onclick="goSearch()">검색</button>
	</form>
<div id="inside_docList" class="col-md-10">	
	<table class="table table-hover">
		<thead>
			<tr>				
	        	<th scope="col" style="width:5%">순번</th>
	        	<th scope="col" style="width:10%">기안일</th>
	           	<th scope="col" style="width:10%">유형</th>
	           	<th scope="col" style="width:13%">서류번호</th>
	           	<th scope="col" style="width:40%">제목</th>
	           	<th scope="col" style="width:10%">기안자</th>
	           	<th scope="col" style="width:10%">결재상태</th>
			</tr>
		</thead>
		<tbody>
  			<c:if test="${not empty requestScope.allNowApprovalList}">
  				<c:forEach var="allAList" items="${requestScope.allNowApprovalList}" varStatus="status">
  					<c:if test="${status.index <= 9}"> <!-- 10개까지만 보이도록 설정 -->
   						<tr>
   							<td align="center">
							${(requestScope.totalCount) - (requestScope.currentShowPageNo - 1 ) * (requestScope.sizePerPage) - (status.index)}</td>
													
						<%-- >>> 페이징 처리시 보여주는 순번 공식 <<<
					                     데이터개수 - (페이지번호 - 1) * 1페이지당보여줄개수 - 인덱스번호 => 순번 
					                  
					                     <예제>
					                     데이터개수 : 12
					                     1페이지당보여줄개수 : 5
					                  
					                     ==> 1 페이지       
					                     12 - (1-1) * 5 - 0  => 12
					                     12 - (1-1) * 5 - 1  => 11
					                     12 - (1-1) * 5 - 2  => 10
					                     12 - (1-1) * 5 - 3  =>  9
					                     12 - (1-1) * 5 - 4  =>  8
					                  
					                     ==> 2 페이지
					                     12 - (2-1) * 5 - 0  =>  7
					                     12 - (2-1) * 5 - 1  =>  6
					                     12 - (2-1) * 5 - 2  =>  5
					                     12 - (2-1) * 5 - 3  =>  4
					                     12 - (2-1) * 5 - 4  =>  3
					                  
					                     ==> 3 페이지
					                     12 - (3-1) * 5 - 0  =>  2
					                     12 - (3-1) * 5 - 1  =>  1 
                 		--%>
                 		
                 		
   							<td>${allAList.created_date}</td>
   							<td>${allAList.doctype_name}</td>
   							<td>${allAList.doc_no}</td>
   							<td><span class="subject" onclick="goView('${allAList.doc_no}', '${allAList.fk_doctype_code}')">${allAList.doc_subject}</span>
   								<c:if test="${allAList.isAttachment eq 1}">
   									&nbsp;<i class="fa-solid fa-paperclip"></i>
   								</c:if>  								
   							</td>
   							<%-- 	<c:if test="${empty pre_status}">
   									<td><span style="border : solid 0px green; background-color:gray; color:white; margin-top:10%;">미결재</span></td>
   								</c:if>
   								<c:if test="${not empty pre_status}">
   									<td><span style="border : solid 0px green; background-color:#e68c0e; color:white; margin-top:10%;">결재중</span></td>
   								</c:if>
   								--%>
   							<td>${allAList.name}</td>					
   							<c:if test="${allAList.doc_status eq 0}"><td>미처리</td></c:if>
							<c:if test="${allAList.doc_status eq 1}"><td>진행중</td></c:if>
							<c:if test="${allAList.doc_status eq 2}"><td>결재완료</td></c:if>
							<c:if test="${allAList.doc_status eq 3}"><td>반려</td></c:if>
   						</tr>
   					</c:if>
  				</c:forEach>
  			</c:if>
  			<c:if test="${empty requestScope.allNowApprovalList}">
  				<tr>
  					<td colspan="7" align="center"> 결재 대기 문서가 없습니다. </td>
  				</tr>
  			</c:if>
  		</tbody>
  	</table>
  	<div align="center" style="border: solid 0px gray; width: 80%; margin: 30px auto;">
		${requestScope.pageBar}
	</div>
</div>
</div>  


<%--===#132.페이징 처리되어진 후 특정 글제목을 클릭하여 상세내용을 본 이후
    //           사용자가 "검색된결과목록보기" 버튼을 클릭했을때 돌아갈 페이지를 알려주기 위해
    //           현재 페이지 주소를 뷰단으로 넘겨준다.  --%>
    
<form name="goViewFrm">
	<input type="hidden" name="doc_no" />
    <input type="hidden" name="fk_doctype_code" />
 <%-- 	<input type="hidden" name="seq" />name="겟파라미터" --%>
	<input type="hidden" name="goBackURL" />
	<input type="hidden" name="searchType" />
	<input type="hidden" name="searchWord" />
</form>   