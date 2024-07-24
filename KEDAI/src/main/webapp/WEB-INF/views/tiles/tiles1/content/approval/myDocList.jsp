<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String ctxPath = request.getContextPath();
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="around_docList">    
<div id="title" style="margin: 1.5% 1%; font-size: 15pt;"> 기안 진행 문서</div>

	<form name="searchFrm" style="margin-top: 20px;">
    	<select name="searchType" style="height: 26px;">
    		<option value="doctype_name">종류</option>
        	<option value="doc_subject">제목</option>
         	<option value="doc_content">내용</option>
         	<option value="doc_no">문서번호</option>
         	<option value="doc_subject_content">글제목+글내용</option>
         	<option value="name">기안자</option>
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
	        	<th scope="col" style="width:11%">기안일</th>
	           	<th scope="col" style="width:13%">유형</th>
	           	<th scope="col" style="width:13%">서류번호</th>
	           	<th scope="col" style="width:41%">제목</th>
	           	<th scope="col" style="width:10%">기안자</th>
	           	<th scope="col" style="width:10%">기안부서</th>
			</tr>
		</thead>
		<tbody>
  			<c:if test="${not empty requestScope.nowApproval}">
  				<c:forEach var="nowApproval" items="${requestScope.nowApproval}" varStatus="status">
  					<c:if test="${status.index <= 9}"> <!-- 10개까지만 보이도록 설정 -->
   						<tr>
   							<td>${nowApproval.created_date}</td>
   							<td>${nowApproval.doctype_name}</td>
   							<td>${nowApproval.doc_no}</td>
   							<td><span class="subject" onclick="goView('${nowApproval.doc_no}')">${nowApproval.doc_subject}</span>
   								<c:if test="${nowApproval.isAttachment eq 1}">
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
   							<td>
   							</td>
   						</tr>
   					</c:if>
  				</c:forEach>
  			</c:if>
  			<c:if test="${empty requestScope.nowApproval}">
  				<tr>
  					<td colspan="4" align="center"> 결재할 문서가 없습니다. </td>
  				</tr>
  			</c:if>
       	<%-- 
              <td>2024-01-01</td>
              <td>증명서신청(회사)</td>
              <td>김땡땡 사장님</td>
              <td><span style="border : solid 0px green; background-color:green; color:white; margin-top:10%;">결재중</span></td>
       	</tr>
         	<tr>
           	<td>2024-01-01</td>
              	<td>증명서신청(회사)</td>
              	<td>김땡땡 사장님</td>
              	<td><span style="border : solid 0px green; background-color:green; color:white; margin-top:10%;">결재중</span></td>
         	</tr>	--%>	
  		</tbody>
  	</table>
</div>
</div>  
할루할룽