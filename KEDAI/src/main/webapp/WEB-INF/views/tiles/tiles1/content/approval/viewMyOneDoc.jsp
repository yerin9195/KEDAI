<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style type="text/css">
div#title {
	font-size: 27px;
	margin: 3% 0 1% 0;
}

div#title2 {
	font-size: 25px;
	margin: 0 0 1% 0;
}

table.left_table {
	width: 100%;
	border-bottom-width: 0.5px;
	border-bottom-style: solid;
	border-bottom-color: lightgrey;
}

table.left_table th {
	width: 25%;
	background-color: #EBEBEB;
}

table#title_table td {
	width: 25%;
	padding: 0 0 0 3%;
}

table#title_table th, table#meeting th, table#meeting td {
	padding: 0 0 0 3%;
}

table#approval th, table#approval td {
	padding: 0%;
}

table#approval{
	text-align: center;
}

table.left_table input {
	height: 15pt;
}

table.approvalList {
    width: 100%; /* 테이블 전체 너비를 설정할 수 있습니다. */
    border-collapse: collapse; /* 테이블 셀의 경계를 병합합니다. */
}

table.approvalList, .approvalList th, .approvalList td {
    border: 1px solid black; /* 테이블, th, td에 1px 두께의 검은 선을 설정합니다. */
    padding: 8px; /* 셀 안의 여백을 설정할 수 있습니다. */
    text-align: center; /* 셀 안의 텍스트를 가운데 정렬할 수 있습니다. */
}


</style>



<div id="total_contatiner">
	<div style="display: flex;">
		<div id="leftside" class="col-md-4" style="width: 90%; padding: 0;">
		<c:set var="docvo" value="${requestScope.getOneDocCommon}" />
		<c:set var="mvo" value="${requestScope.minutesvo}" />
			<div id="title">${docvo.doctype_name}</div>
			<table class="table left_table" id="title_table">
				<tr>
					<th>문서번호</th>
					<td>${docvo.doc_no}</td>
					<th>기안일자</th>
					<td>${docvo.created_date}</td>
				</tr>
				<tr>
					<th>기안자</th>
					<td>${docvo.name}</td>
					<th>부서</th>
					<td>${docvo.dept_name}</td>
				</tr>
			</table>
			<table class="table left_table" id="meeting">
			
				<tr>
					<th>회의일자</th>
					<td>${mvo.meeting_date}</td>
				</tr>
				<tr>
					<th>회의 주관 부서</th>
					<td>${mvo.host_dept}</td>
				</tr>
				<tr>
					<th>회의 참석자</th>
					<td>${mvo.attendees}</td>
				</tr>
			</table>
			<div id="title2">
				결제라인
			</div>
			<div class="htmlAdd">
				<table class="approvalList">
			        <tr>
			            <th rowspan="3">승인</th>
			            <th>대표이사</th>
			            <th>이사</th>
			            <th>부장</th>
			        </tr>
			      	<tr>
			            <td>24.01.01</td>
			            <td>24.01.02</td>
			            <td>24.01.02</td>
			        </tr>
			        <tr>
			            <td>김땡땡</td>
			            <td>박땡땡</td>
			            <td>이땡땡</td>
			        </tr>
				</table>
			</div>
	
		</div>
		<div class="col-md-6" style="margin: 0; width: 100%">
	
			<table style="margin-left: 5%;" class="table" id="newDoc">
				<tr>
					<th style="width: 12%;">제목</th>
					<td style="height:23pt;">${docvo.doc_subject}</td>
				</tr>

				<tr>
					<td colspan='2'>${docvo.doc_content}</td>
				</tr>
	    		<tr>
	       			<td width="12%" class="prodInputName">파일첨부</td>
	       			<td>이곳에 파일을 올려주세요.</td>
	    		</tr>
			</table>
			   		
		</div>
	</div>
</div>
</body>
</html>
