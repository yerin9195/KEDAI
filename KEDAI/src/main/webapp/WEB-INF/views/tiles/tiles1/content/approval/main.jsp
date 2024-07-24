<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    String ctxPath = request.getContextPath();
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

<meta charset="UTF-8">

<%-- Bootstrap CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/bootstrap-4.6.2-dist/css/bootstrap.min.css" > 

<style type="text/css">
div.col-md-6 {
	padding-left:0;
	padding-right:40px;
}

</style>


<script type="text/javascript">
	$(document).ready(function(){
		
		$("table#memberTbl tr.memberInfo").click( e => {
			
		};
		
	});
	
	function newDoc(){
		
		const frm = document.docTypeFrm;
		
		let docRadio = document.querySelectorAll(`input[name='doctype_code']`); 
		let isCheck = false; // 라디오의 선택 유무 검사용 
/* 		?docType=dayoffDoc */
	<%--	location.href=`<%= ctxPath%>/approval/newdoc.kedai?docType=\${docType}`; --%>
		for(let i=0; i < docRadio.length; i++){
			if(docRadio[i].checked) {
				isCheck = true; 
				break;
			}  
		}// end of for------------------ 
		if(isCheck == false){
			alert("양식을 선택해주세요.");
		}
		
		frm.action = "<%= ctxPath%>/approval/newdoc.kedai";  
			// form 태그에 action 이 명기되지 않았으면 현재보이는 URL 경로로 submit 되어진다.
		//  frm.method = "get"; // form 태그에 method 를 명기하지 않으면 "get" 방식이다.
		frm.submit();
	}// end of function newDoc()------------------
	
	function allMyNowApproval(){
		
	}
	
	
	

	
</script>



<div style="border : 1px red solid; display:flex; ">
<span style="border : solid 1px #e68c0e; text-align :center; align-items: center; justify-content: center; " >전체 </span>
<button type="button" data-toggle="modal" style="width: 150px; height:5%; margin-top:1%; background-color:white; border : solid 1px black;" data-target="#newDocModal" >결재 작성하기</button>
</div>
	<!-- Modal -->
	<!-- Modal 구성 요소는 현재 페이지 상단에 표시되는 대화 상자/팝업 창입니다. -->
	<div class="modal fade" id="newDocModal">
		<div class="modal-dialog modal-dialog-centered">
	  	<!-- .modal-dialog-centered 클래스를 사용하여 페이지 내에서 모달을 세로 및 가로 중앙에 배치합니다. -->
	    	<div class="modal-content">
	      
	      	<!-- Modal header -->
	      		<div class="modal-header">
	        		<h5 class="modal-title">결재 양식 선택</h5>
	        		<button type="button" class="close" data-dismiss="modal">&times;</button>
	      		</div>
	      
	      	<!-- Modal body -->
	      		<form name="docTypeFrm">
		      		<div class="modal-body">
		      		<!--  라디오 버튼과 연결된 라벨(label)을 클릭했을 때 라디오 버튼이 체크되도록 하려면, 라벨의 for 속성과 라디오 버튼의 id 속성을 일치하게 해야 한다. -->
		      			<input type="radio" name="doctype_code" value="100" id="newdayoff" />
		      			<label for="newdayoff" style="margin-left: 1.5%;">휴가신청서</label> 
		      			<br>
		      			<input type="radio" name="doctype_code" value="101" id="newmeeting"/>
		      			<label for="newmeeting" style="margin-left: 1.5%;">회의록</label>
		      		</div>
		      
		      	<!-- Modal footer -->
		      		<div class="modal-footer">
		        		<button type="button" onclick="newDoc()" style="background-color:white; color:black; width:10%; height:30px; font-size:10pt; border: solid 1px gray; ">확인</button>
		        		<button type="button" style="background-color:white; color:black; width:10%; height:30px; font-size:10pt; border : solid 1px gray;" data-dismiss="modal">취소</button>
		      		</div>
	      		</form>
	    	</div>
	    	
	  	</div>
	</div>

<div class="container-fluid mt-4" style="width:95%;  margin-right: auto; margin-left:0;">
	<div class="row">
<%-- <div id="11" class="col-md-4">	
 <h5 style="margin: 1.5% 1%; border : solid 0px red;">전자결재 홈</h5>
 <hr>
 <div style="height:100px;"><p style="padding:auto;">결재할 문서가 없습니다.<p>
 <hr>
 </div> --%>
		<div id="22" class="col-md-6">	
			<div class="document_inProgress">
      			<div  style="display:flex; align-items: center;">
      				<span style="margin: 1.5% 1%; font-size: 15pt;"> 결재할 문서 </span>
      				<span style="margin-left:auto; align-self: flex-end; padding: 1% 2%;" onclick="javascript:location.href='<%=request.getContextPath() %>/approval/nowApprovalList.kedai'">더보기</span>
      			</div>
      			<table class="table table-hover">
      				<thead>
        				<tr>
				            <th scope="col" style="width:15%">기안일</th>
				            <th scope="col" style="width:15%">유형</th>
				            <th scope="col" style="width:15%">서류번호</th>
				            <th scope="col" style="width:55%">제목</th>
				            
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
   		<div id="33" class="col-md-6">	
     		<div class="document_approved">
      			<div  style="display:flex; align-items: center;">
      				<span style="margin: 1.5% 1%; font-size: 15pt;"> 기안 진행 문서 </span>
      				<span style="margin-left:auto; align-self: flex-end; padding: 1% 2%;" onclick="javascript:location.href='<%=request.getContextPath() %>/approval/showMyDocList.kedai'">더보기</span>
      			</div>
      			<table class="table table-hover">
        			<thead>
          				<tr>
				            <th scope="col" style="width:15%">기안일</th>
				            <th scope="col" style="width:15%">유형</th>
				            <th scope="col" style="width:20%">서류번호</th>
				            <th scope="col" style="width:50%">제목</th>
						</tr>
        			</thead>
        			<tbody>
        				<c:if test="${not empty requestScope.myDocList}">
      						<c:forEach var="myDocList" items="${requestScope.myDocList}" varStatus="status">
      							<c:if test="${status.index <= 9}"> <!-- 10개까지만 보이도록 설정 -->
	      							<tr>
	      								<td>${myDocList.created_date}</td>
	      								<td>${myDocList.doctype_name}</td>
	      								<td>${myDocList.doc_no}</td>
	      								<td><span class="subject" onclick="goView('${myDocList.doc_no}')">${myDocList.doc_subject}</span>
	      									<c:if test="${myDocList.isAttachment eq 1}">
	      										&nbsp;<i class="fa-solid fa-paperclip"></i>
	      									</c:if>  								
	      								</td>
	      							<%-- 	<c:if test="${empty pre_status}">
	      									<td><span style="background-color:gray; color:white; margin-top:10%;">미결재</span></td>
	      								</c:if>
	      								<c:if test="${not empty pre_status}">
	      									<td><span style="background-color:#e68c0e; color:white; margin-top:10%;">결재중</span></td>
	      								</c:if>--%>
	      							</tr>
	      						</c:if>
      						</c:forEach>
      					</c:if>
      					<c:if test="${empty requestScope.myDocList}">
      						<tr>
      							<td colspan="4" align="center"> 진행중인 기안 문서가 없습니다. </td>
      						</tr>
      					</c:if>
          			<!-- 	<tr>
			               <td>2024-01-01</td>
			               <td>증명서신청(회사)</td>
			               <td>김땡땡 사장님</td>
			               <td><span style="border : solid 0px green; background-color:gray; color:white; margin-top:10%;">결재완료</span></td>
          				</tr>
          				<tr>
				            <td>2024-01-01</td>
				            <td>증명서신청(회사)</td>
				            <td>김땡땡 사장님</td>
				            <td><span style="border : solid 0px green; background-color:gray; color:white; margin-top:10%;">결재완료</span></td>
          				</tr> -->
        			</tbody>
      			</table>
    		</div>
    	</div>
	</div>
</div>
</body>
</html>