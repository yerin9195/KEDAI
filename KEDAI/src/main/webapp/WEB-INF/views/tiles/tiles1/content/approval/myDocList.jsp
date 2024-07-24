<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String ctxPath = request.getContextPath();
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>      
<div id="title" style="margin: 1.5% 1%; font-size: 15pt;"> 기안 진행 문서</div>

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
할루할룽