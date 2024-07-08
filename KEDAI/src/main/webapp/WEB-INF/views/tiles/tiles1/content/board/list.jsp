<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String ctxPath = request.getContextPath();
	//     /KEDAI
%>
<style type="text/css">
	.btnAdd {
		border: solid 1px #2c4459;
		background: none;
		color: #2c4459;
		font-size: 12pt;
		width: 120px;
		height: 40px;
		margin-left: 10px;
	}
	.btnAdd:hover {
		border: none;
		background: #e68c0e;
		color: #fff;
	}
	table#boardTbl tr.boardList:hover {
      	cursor: pointer;
   	}
	.search_btn {
		width: 5%;
		height: 30px;
		font-size: 14px;
		border: none;
		background: #2c4459;
		color: #fff;
		cursor: pointer;
	}
	.search_btn:hover {
		background: #e68c0e;
	}
</style>
<script type="text/javascript">
	$(document).ready(function(){
		
		$("div#displayList").hide();
		
	}); // end of $(document).ready(function(){}) ----------
</script>

<%-- content start --%>
<div style="border: 1px solid red; padding: 1% 0;">
	<h3><span class="icon"><i class="fa-solid fa-seedling"></i></span>&nbsp;&nbsp;게시판</h3>

	<section style="width: 95%;">
		<div class="d-md-flex justify-content-md-end">
			<c:if test="${(sessionScope.loginuser).fk_job_code eq '1'}">
				<button type="button" class="btnAdd" onclick="goAdd()">등록하기</button>
			</c:if>
		</div>
	
		<table class="table table-bordered table-hover mt-3" id="boardTbl">
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
				<c:if test="${not empty requestScope.boardList}">
					<c:forEach var="boardvo" items="${requestScope.boardList}" varStatus="status">
						<tr class="boardList">
		      				
		      			</tr>
					</c:forEach>
				</c:if>
				
				<c:if test="${empty requestScope.boardList}">
	      			<tr class="boardList">
	      				<td colspan="6">게시판에 데이터가 존재하지 않습니다.</td>
	      			</tr>
	      		</c:if>
			</tbody>
		</table>
 	
		<div align="center" style="border: solid 1px gray; width: 50%; margin: 3% auto;">
			${requestScope.pageBar}
		</div>
		
		<form name="searchFrm" style="margin-top: 20px;">
	   		<select name="searchType" style="height: 26px;">
	      		<option value="subject">글제목</option>
	      		<option value="content">글내용</option>
	      		<option value="subject_content">글제목+글내용</option>
	      		<option value="name">작성자</option>
	   		</select>
	   		
	   		<input type="text" name="searchWord" size="40" autocomplete="off" /> 
	   		<input type="text" style="display: none;"/> 
	   		<button type="button" class="search_btn" onclick="goSearch()">검색</button>
		</form>
		
		<div id="displayList" style="border: solid 1px gray; border-top: 0px; height: 100px; margin-left: 8.5%; margin-top: -1px; margin-bottom: 30px; overflow: auto;">
		</div>
	</section>
</div>

<form name="goViewFrm">
	<input type="hidden" name="board_seq" />
	<input type="hidden" name="goBackURL" />
	<input type="hidden" name="searchType" />
	<input type="hidden" name="searchWord" />
</form> 
<%-- content end --%>