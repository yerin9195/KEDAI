<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String ctxPath = request.getContextPath();
	//     /KEDAI
%>
<style type="text/css">
	input {
		padding-left: 1%;
	}
	.subject div {
		white-space: nowrap;
		overflow: hidden;
		text-overflow: ellipsis;
	}
	.moveColor {
		color: #2c4459;
		font-weight: bold;
		cursor: pointer;
	}
	.list_btn:hover {
		color: #e68c0e;
	}
	.view_btn {
		border: solid 1px #2c4459;
		color: #2c4459;
		font-size: 12pt;
		width: 120px;
		height: 40px;
	}
	.view_btn:hover {
		border: none;
		background: #e68c0e;
		color: #fff;
	}
	.add_btn {
		border: solid 1px #2c4459;
		color: #2c4459;
		font-size: 12pt;
		width: 80px;
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
	
		$("span.move").hover(function(e){
			$(e.target).addClass("moveColor");
		}, 
		function(e){
			$(e.target).removeClass("moveColor");
		});
		
	}); // end of $(document).ready(function(){}) ----------
	
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
		frm.action = "<%= ctxPath%>/community/view_2.kedai";
		frm.submit();
		
	} // end of function goView(community_seq) ----------
</script>

<%-- content start --%>
<div style="border: 0px solid red; padding: 2% 3% 0 0;">
	<c:if test="${requestScope.cvo.fk_category_code == 1}">
		<h3><span class="icon"><i class="fa-solid fa-seedling"></i></span>&nbsp;&nbsp;[ 동호회 ]&nbsp;&nbsp;${requestScope.cvo.subject}</h3>
	</c:if>
	<c:if test="${requestScope.cvo.fk_category_code == 2}">
		<h3><span class="icon"><i class="fa-solid fa-seedling"></i></span>&nbsp;&nbsp;[ 건의함 ]&nbsp;&nbsp;${requestScope.cvo.subject}</h3>
	</c:if>
	<c:if test="${requestScope.cvo.fk_category_code == 3}">
		<h3><span class="icon"><i class="fa-solid fa-seedling"></i></span>&nbsp;&nbsp;[ 사내소식 ]&nbsp;&nbsp;${requestScope.cvo.subject}</h3>
	</c:if>
	
	<c:if test="${not empty requestScope.cvo}">
		<div class="row mt-5">
			<div class="col-5" style="position: relative;">
				<table class="table table-bordered">
					<tr>
						<th style="width: 20%;">글번호</th>
						<td style="width: 30%;">${requestScope.cvo.community_seq}</td>
						<th style="width: 20%;">작성자</th>
						<td style="width: 30%;">${requestScope.cvo.nickname}</td>
					</tr>
					<tr>
						<th style="width: 20%;">조회수</th>
						<td style="width: 30%;">${requestScope.cvo.read_count}</td>
						<th style="width: 20%;">작성일자</th>
						<td style="width: 30%;">${requestScope.cvo.registerday}</td>
					</tr>
					<tr>
						<th style="width: 20%;">첨부파일</th>
						<td colspan="3"><a href="<%= ctxPath%>/community/download.kedai?community_seq=${requestScope.cvo.community_seq}">${requestScope.cvo.orgfilename}</a></td>
					</tr>
				</table>
				
				<div class="mt-3 subject">
					<div><i class="fa-solid fa-play"></i>&nbsp;&nbsp;이전글제목&nbsp;&nbsp;:&nbsp;&nbsp;<span class="move" onclick="goView('${requestScope.cvo.previousseq}')">${requestScope.cvo.previoussubject}</span></div>
					<br>
					<div><i class="fa-solid fa-play"></i>&nbsp;&nbsp;다음글제목&nbsp;&nbsp;:&nbsp;&nbsp;<span class="move" onclick="goView('${requestScope.cvo.nextseq}')">${requestScope.cvo.nextsubject}</span></div>
					<br>
					<button type="button" class="btn mr-3 pl-0 pr-0 list_btn" onclick="javascript:location.href='<%= ctxPath%>/community/list.kedai'">[ 전체목록보기 ]</button>
					<button type="button" class="btn mr-3 pl-0 pr-0 list_btn" onclick="javascript:location.href='<%= ctxPath%>${requestScope.goBackURL}'">[ 검색된결과목록보기 ]</button>
				</div>
		
				<div class="mt-3" style="overflow: hidden; overflow-y: scroll; word-break: break-all; border: 1px solid #2c4459; padding: 3%; height: 300px;">${requestScope.cvo.content}</div>
				
				<br><br><br>
				
				<div class="mt-3" style="position: absolute; bottom: 0;">
					<c:if test="${not empty sessionScope.loginuser && sessionScope.loginuser.empid == requestScope.cvo.fk_empid}">
						<button type="button" class="btn view_btn mr-3" onclick="javascript:location.href='<%= ctxPath%>/community/edit.kedai?community_seq=${requestScope.cvo.community_seq}'">수정</button>
						<button type="button" class="btn view_btn" onclick="javascript:location.href='<%= ctxPath%>/community/del.kedai?community_seq=${requestScope.cvo.community_seq}'">삭제</button>
					</c:if>
				</div>
			</div>
			
			<div class="col-7">
				<%-- 댓글쓰기 폼 추가 --%>
				<c:if test="${not empty sessionScope.loginuser}">
					<div class="d-md-flex justify-content-between">
						<h3><i class="fa-solid fa-comment-dots"></i>&nbsp;&nbsp;댓글</h3>
						<div>
							<button type="button" class="btn add_btn mr-3" onclick="goAddWrite()">등록</button>
			                <button type="reset" class="btn add_btn">취소</button>
						</div>
					</div>
					<form name="addWriteFrm" id="addWriteFrm" class="mt-3">
						<table class="table">
							<tr>
		                  		<th style="width: 15%;">작성자</th>
	               				<td>
	               					<input type="hidden" name="fk_empid" value="${sessionScope.loginuser.empid}" readonly />
	               					<input type="text" name="nickname" value="${sessionScope.loginuser.nickname}" readonly />
	               				</td>
							</tr>
							
							<tr>
								<th style="width: 15%;">내용</th>
								<td>
	                  				<input type="text" name="content" size="90" maxlength="1000" placeholder="댓글을 남겨보세요." style="height: 30px;" />
	                  				<%-- 댓글에 달리는 원게시물 글번호(댓글의 부모글 글번호) --%>
	                  				<input type="hidden" name="parentSeq" value="${requestScope.cvo.community_seq}" readonly />
	                  			</td>
							</tr>
						</table>
					</form>
				</c:if>
				
				<%-- 댓글 내용 보여주기 --%>
				<table class="table" style="margin-top: 5%; margin-bottom: 2%;">
	         		<thead>
	         			<tr>
	           			 	<th style="width: 8%; text-align: center;">순번</th>
	           			 	<th style="width: 52%; text-align: center;">내용</th>
				            <th style="width: 10%; text-align: center;">작성자</th>
				            <th style="width: 15%; text-align: center;">작성일자</th>
				            <th style="width: 15%; text-align: center;">수정/삭제</th>
	         			</tr>
	         		</thead>
	         		<tbody id="commentDisplay"></tbody>
	      		</table>
	      		
	      		<div style="display: flex; margin-bottom: 50px;">
	          		<div id="pageBar" style="margin: auto; text-align: center;"></div>
	       		</div>
			</div>
		</div>
	</c:if>
	
	<c:if test="${empty requestScope.cvo}">
		<div style="padding: 20px 0; font-size: 16pt; color: #2c4459;">존재하지 않는 글입니다.</div> 
	</c:if>
</div>

<%-- 이전글제목, 다음글제목 보기 --%>
<form name="goViewFrm">
	<input type="hidden" name="community_seq" />
	<input type="hidden" name="goBackURL" />
	<input type="hidden" name="searchType" />
	<input type="hidden" name="searchWord" />
</form> 
<%-- content end --%>