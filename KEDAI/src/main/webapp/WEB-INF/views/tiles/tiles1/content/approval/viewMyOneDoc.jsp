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

table#title_table th, table#docInfo th, table#docInfo td {
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
    height: 190px;
}

table.approvalList, .approvalList th, .approvalList td {
    border: 1px solid black; /* 테이블, th, td에 1px 두께의 검은 선을 설정합니다. */
    padding: 8px; /* 셀 안의 여백을 설정할 수 있습니다. */
    text-align: center; /* 셀 안의 텍스트를 가운데 정렬할 수 있습니다. */
}

div#fileList a {
    text-decoration: none; /* 상속된 링크 스타일 */
    color: black; 
}




</style>

<script type="text/javascript">
$(document).ready(function(){
	
	if (${requestScope.docvo.isAttachment} == 1) {
		goViewApprovalInfo();
	}
	
}); // end of $(document).ready(function())-----------------------------------


function goViewApprovalInfo(){
	
	$.ajax({
		url:"<%= ctxPath%>/approval/docfileListShow.kedai",
		type:"get",
		data:{"doc_no": "${requestScope.docvo.doc_no}"}, 
		dataType:"json",
		success :function(json){
			//console.log(JSON.stringify(json));
			/*
			[{"filename":"Electrolux냉장고_사용설명서_2024071918094832625998492500.pdf","org_filename":"Electrolux냉장고_사용설명서","doc_no":"KD24-101-5","filesize":"791567","file_no":"4"},{"filename":"쉐보레전면_2024071918094832625999624800.jpg","org_filename":"쉐보레전면","doc_no":"KD24-101-5","filesize":"131110","file_no":"5"}]
			또는
			[]
			*/
			
			$("#fileList").text();
			let v_html = ``;
			$.each(json, function(index, item){	
				v_html += "<a href='<%= ctxPath %>/approval/downloadDocfile.kedai?seq=" + item.file_no + "'>"
               			 + item.org_filename + "(" + item.filesize + ")</a>&nbsp;";
			});
			
		//	const input_width = $("input[name='searchWord']").css("width");// 검색어 input태그 width값 알아오기			
		//	$("div#displayList").css({"width":input_width});// 검색결과 div 의 width 크기를 검색어 입력 input 태그의 width 와 일치시키기 
			$("#fileList").html(v_html);
		},
		error: function(request, status, error){
            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
        }
	});// end of $.ajax---------------------
}

function btnOk(doc_no){
	
}

/*
function formatFileSize(size) {
    if (size < 1024){
    	return size + ' bytes';
    } 
    else if (size < 1048576){
    	return (size / 1024).toFixed(1) + ' KB';
    }
    else 
    	return (size / 1048576).toFixed(1) + ' MB';
}

*/
</script>



<div id="total_contatiner">
	<c:set var="mvo" value="${requestScope.docvo.minutesvo}" />
	<c:set var="avo" value="${requestScope.docvo.approvalvoList}" />
	<c:set var="dvo" value="${requestScope.docvo}" />
	<div style="display: flex;">
		<div id="leftside" class="col-md-4" style="width: 90%; padding: 0;">
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
			<table class="table left_table" id="docInfo">
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
			
			<c:if test="${not empty avo}">
				<table class="approvalList">
			        <tr>
			            <th rowspan="3" style="width:10%;">승인</th>
			            <c:forEach var="item" items="${avo}">
			            	<th style="height:30px;">${item.job_name}</th>
			            </c:forEach>
			        </tr>
			      	<tr>
			      		<c:forEach var="item" items="${avo}">
			      			<td style="width:30%;">
			      				<div style="height:100px;">${item.sign_img}</div>
			            		<div style="height:30px;" >${item.name}</div>
			            	</td>
			            </c:forEach>
			        </tr>
			        <tr>
			         	<c:forEach var="item" items="${avo}">
			      			<td style="height:30px; width:30%;">${item.approval_date}</td>
			            </c:forEach>
			        </tr>
				</table>
				</c:if>
		
	
		</div>
		<div class="col-md-6" style="margin: 0; width: 100%">
	
			<table style="margin-left: 5%;" class="table" >
				<tr>
					<th style="width: 12%;">제목</th>
					<td style="height:23pt;">${docvo.doc_subject}</td>
				</tr>
	
				<tr>
					<td colspan='2'>${docvo.doc_content}</td>
				</tr>
	    		<tr>
	       			<td width="12%" class="prodInputName">첨부파일</td>
	       			<td><div id="fileList">첨부된 파일이 없습니다.</div></td>
	    		</tr>
			</table>
			
			<div style="text-align: right; margin: 18px 0 18px 0;">
				<c:if test="${isNowApproval == true}">
					<button type="button" class="btn btn-dark btn-sm mr-4"
						id="btnOk('${docvo.doc_no}')">결재하기</button>
					<button type="button" class="btn btn-primary btn-sm"
						onclick="btnReject('${docvo.doc_no}')">반려하기</button>
				</c:if>
			</div>
			
			<!-- Modal -->
			<!-- Modal 구성 요소는 현재 페이지 상단에 표시되는 대화 상자/팝업 창입니다. -->
			<div class="modal" id="commentModal">
				<div class="modal-dialog modal-dialog-centered modal-lg h-75" >
				<!-- .modal-dialog-centered 클래스를 사용하여 페이지 내에서 모달을 세로 및 가로 중앙에 배치합니다. .modal-dialog 클래스를 사용하여 <div> 요소에 크기 클래스를 추가합니다.-->
					<div class="modal-content">
						<!-- Modal header -->
						<div class="modal-header">
							<h5 class="modal-title">결재의견</h5>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>
						<!-- Modal body -->
						<div class="modal-body row">
							<div class="modal_left col-md-4">
								<ul>
									<li class="dept">
										<c:forEach var="deptList" items="${requestScope.allDeptList}">
											<c:choose>
												<c:when test="${deptList.dept_name == ' '}">
													<div class="openList">
														<img src="<%=ctxPath%>/resources/images/common/Approval/plus.png" class="plus" />대표이사 
														<input type="hidden" value="${deptList.dept_code}" id="deptCode" />
													</div>
												</c:when>
												<c:otherwise>
													<div class="openList">
														<img src="<%=ctxPath%>/resources/images/common/Approval/plus.png" class="plus" />${deptList.dept_name} 
														<input type="hidden" value="${deptList.dept_code}" id="deptCode" />
													</div>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</li>
								</ul>
							</div>
						</div>
					<!-- Modal footer -->
						<div class="modal-footer">
							<button type="button" class="btn btn-danger my_close"
								data-dismiss="modal">취소</button>
							<button type="button" class="btn btn-primary btnSubmit"
								onclick="modalSubmit()" >확인</button>
						</div>
					</div>
				</div>
			</div>
			
			
			   		
		</div>
	</div>
</div>
</body>
</html>
