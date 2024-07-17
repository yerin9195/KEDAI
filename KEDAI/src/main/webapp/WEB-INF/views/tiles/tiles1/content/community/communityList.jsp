<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String ctxPath = request.getContextPath();
	//     /KEDAI
%>
<style type="text/css">

</style>
<script type="text/javascript">
	$(document).ready(function(){
	
	}); // end of $(document).ready(function(){}) ----------
	
	function goSearch(){
		
		const frm = document.searchFrm;
		
		frm.method = "get";
		frm.action = "<%= ctxPath%>/community/list.kedai";
		frm.submit();
		
	} // end of function goSearch(){} ----------
	
	function goView(community_seq){
		
		const goBackURL = "${requestScope.goBackURL}";
		const frm = document.goViewFrm;
		
		frm.community_seq.value = community_seq;
		frm.goBackURL.value = goBackURL;
		
		if(${not empty requestScope.paraMap}) { // paraMap 에 넘겨준 값이 존재하는 경우
			frm.searchType.value = "${requestScope.paraMap.searchType}";
			frm.searchWord.value = "${requestScope.paraMap.searchWord}";
		}
		
		// "get" 방식에서 & 는 전송될 데이터의 구분자로 사용되기 때문에 "post" 방식으로 보내줘야 한다.
		frm.method = "post";
		frm.action = "<%= ctxPath%>/community/view.kedai";
		frm.submit();
		
	} // end of function goView(board_seq){} ----------
</script>

<%-- content start --%>
<div style="border: 0px solid red; padding: 2% 3% 0 0;">
	<h3><span class="icon"><i class="fa-solid fa-seedling"></i></span>&nbsp;&nbsp;커뮤니티</h3>

	<section>
		<div class="d-md-flex justify-content-md-end">
			<form name="searchFrm" style="width: 34%; position: relative;">
		   		<select name="searchType" style="height: 30px;">
		      		<option value="subject">글제목</option>
		      		<option value="content">글내용</option>
		      		<option value="subject_content">글제목+글내용</option>
		      		<option value="name">작성자</option>
		   		</select>
		   		
		   		<input type="text" name="searchWord" size="40" width="500px" autocomplete="off" style="height: 30px;" /> 
		   		<input type="text" style="display: none;"/> 
		   		<button type="button" class="search_btn" onclick="goSearch()">검색</button>
		   		
		   		<div id="displayList" style="position: absolute; left: 0; border: solid 1px gray; border-top: 0px; height: 100px; margin-left: 22.5%; margin-top: 1px; background: #fff; overflow: hidden; overflow-y: scroll;">
				</div>
			</form>
			&nbsp;&nbsp;&nbsp;&nbsp;<a href="<%= ctxPath%>/community/add.kedai" class="btn add_btn">등록하기</a>
		</div>
		
		<table class="table table-bordered mt-3" id="communityTbl">
			<thead>
	       		<tr>
	          		<th style="width: 10%; text-align: center;">순번</th>
	          		<th style="width: 10%; text-align: center;">글번호</th>
	         		<th style="width: 40%; text-align: center;">글제목</th>
	         		<th style="width: 10%; text-align: center;">작성자</th>
	         		<th style="width: 20%; text-align: center;">작성일자</th>
	         		<th style="width: 10%; text-align: center;">조회수</th>
	       		</tr>
	   		</thead>
		
			<tbody>
				<c:if test="${not empty requestScope.communityList}">
				
				</c:if>
				
				<c:if test="${empty requestScope.communityList}">
					<tr class="communityList">
	      				<td colspan="6">커뮤니티에 데이터가 존재하지 않습니다.</td>
	      			</tr>
				</c:if>
			</tbody>
		</table>
		
		<div align="center" style="border: solid 0px gray; width: 50%; margin: 2% auto;">
			${requestScope.pageBar}
		</div>
	</section>
</div>

<%-- 사용자가 "검색된결과목록보기" 버튼을 클릭했을때 돌아갈 페이지를 알려주기 위해 현재 페이지 주소를 뷰단으로 넘겨준다. --%>
<form name="goViewFrm">
	<input type="hidden" name="community_seq" />
	<input type="hidden" name="goBackURL" />
	<input type="hidden" name="searchType" />
	<input type="hidden" name="searchWord" />
</form> 
<%-- content end --%>