<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
   String ctxPath = request.getContextPath();
%>   

<style type="text/css">
    
    
	th {background-color: #e68c0e;;}
    
    .subjectStyle {font-weight: bold;
                   color: navy;
                   cursor: pointer; }
                   
    a {text-decoration: none !important;} /* 페이지바의 a 태그에 밑줄 없애기 */
    
</style>

<script type="text/javascript">
	$(document).ready(function(){

		$("span.subject").hover(function(e){	// 1번째 function은 mouseover,
			$(e.target).addClass("subjectStyle");
		}, function(e){		//  2번째 function은 mouseout
			$(e.target).removeClass("subjectStyle");
		});			
		
  	}); // end of $(document).ready(function(){})----------
  	
  	// Function Declaration
  	// 글제목 선택시 글 상세페이지로 이동하는 함수
  	function goView(seq){
  		
  		location.href=`<%= ctxPath%>/view.action?seq=\${seq}`;
  		// 또는
  		<%-- location.href="<%= ctxPath%>/view.action?seq="+seq;--%>
  		
  			
  	}// end of function goView(seq){}----------------------------
  	
  	function goRegister(){
  		location.href=`<%= ctxPath%>/carRegister.kedai`;
  	}
  	function goApply(){
  		location.href=`<%= ctxPath%>/carApply_detail.kedai`;
  	}
  	
</script>
    
<div style="display: flex; width: 100%;">
	<div style="margin: auto; padding: 3%; width: 100%">

   		<h2 style="margin-bottom: 30px; border-bottom: 1px solid orange; border-top: 1px solid orange;width:14%;">CAR SHARING</h2>
   
   		<form name="member_search_frm">
			<select name="searchType">
			   <option value="">검색대상</option>
			   <option value="name">출발지</option>
			   <option value="userid">도착지</option>
			   <option value="email">사원명</option>
			   <option value="email">셰어링날짜</option>
			</select>
			&nbsp;
			<input type="text" name="searchWord" />

        	<input type="text" style="display: none;" /> <%-- 조심할 것은 type="hidden" 이 아니다. --%> 
		
			<button type="button" class="btn btn-secondary" onclick="goSearch()">검색</button>

		</form>
   		<table style="width: 100%;" class="table table-bordered">
      		<thead>
          		<tr>
             		<th style="width: 70px;  text-align: center;">no</th>
            		<th style="width: 360px; text-align: center;">출발지 -> 도착지</th>
            		<th style="width: 70px;  text-align: center;">차주 닉네임</th>
            		<th style="width: 150px; text-align: center;">셰어링 날짜</th>
            		<th style="width: 70px;  text-align: center;">신청가능여부</th>
            		<th style="width: 70px;  text-align: center;">조회수</th>
          		</tr>
      		</thead>
      		
	      	<tbody>
	      		<c:if test="${not empty requestScope.boardList}">
	      			<c:forEach var="boardvo" items="${requestScope.boardList}">
	      				<tr>
	      					<td align="center">${boardvo.seq}</td>
	      					<td>
	      						<span class="subject" onclick="goView('${boardvo.seq}')">${boardvo.subject}</span>
	      					</td>
	      					<td align="center">${boardvo.name}</td>
	      					<td align="center">${boardvo.regDate}</td>
	      					<td align="center">${boardvo.readCount}</td>
	      				</tr>
	      			</c:forEach>
	      		</c:if>
	      	
	      		<c:if test="${empty requestScope.boardList}">
	      			<tr>
	      				<td colspan="5">데이터가 존재하지 않습니다.</td>
	      			</tr>
	      		</c:if>
	      	</tbody>
		</table>
		<div id="pageBar">
		    <nav>
		    	<ul class="pagination">${requestScope.pageBar}</ul>
		    </nav>
	    </div>
		<button class='btn btn-secondary btn-sm btnUpdateComment' onclick="goRegister()">등록하기</button>
		<button class='btn btn-secondary btn-sm btnUpdateComment' onclick="goApply()">신청하기</button>
	</div>
</div>