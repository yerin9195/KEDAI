<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%

   String ctxPath = request.getContextPath();

%>

<script type="text/javascript" src="<%= ctxPath%>/resources/js/employee.js"></script>
<style type="text/css">

*{margin: 0;
 padding: 0;
 box-sizing:border-box;}

.employeeWrap{
	width: 100%;
	display: flex;
	justify-content:center;
	margin-top: 40px;
}
.employeeWrap .address{
	width: 90%;
	margin-left: -80px;
}
.employeeWrap .address .add-header{}
.employeeWrap .address .add-header h2{
	font-size: 20px;
	font-weight: 700;
	line-height: 40px;
}

.employeeWrap .address .search_bar{
	width:100%;
	display: flex;
	justify-content: space-between;
	margin-top: 20px;
}
.employeeWrap .address .search_bar .sch_left{display: flex;}
.employeeWrap .address .search_bar .sch_left select{
	margin-right: 10px;
}
.employeeWrap .address .search_bar .sch_left input{
	height: 40px;
	outline:0;
}
.employeeWrap .address .search_bar .sch_left input[type=button]{
	padding : 0 20px;
}
.employeeWrap .address .search_bar .sch_right{
	display:flex;
	align-items: center;
}
.employeeWrap .address .search_bar .sch_right select{
	height: 40px;
}

.emp_table {
     width: 100%;
     margin-top: 20px;
}

.emp_table th,td {
	text-align:center;
	border-left: solid 1px gray;
	border-bottom: solid 1px gray;
	height: 56px;
	vertical-align: middle;
}
.emp_table th:first-of-type, .emp_table td:first-of-type{
	border-left:0;
}

th{
	background-color:#2c4459;
	color: white;
}

.nameStyle{
	font-weight:bold;
	/*  color:#c180ff;*/
	cursor:pointer;
}

tr:hover{
color:#2c4459;
}

.button {
	background-color: #2c4459;
}

.btn.btn-secondary {
    background-color:#2c4459;
    border-color: #c180ff;;
}
#upbar {
    padding-top: 1rem; 		/* 상단 패딩 */
    padding-bottom: 1%; 	/* 하단 패딩 */
    border: solid 1px red; 	/* 빨간색 실선 테두리 */
    display: flex; 			/* 플렉스 박스 레이아웃 */
    position: relative; 	/* 상대적 위치 지정 */
}

.pagenation{
	display:flex;
	justify-content: center;
}
.pagenation button{}
.pagenation ul{
	display: flex;
}
.pagenation ul li{}

/* 팝업 버튼 요소 시작*/

.tempBtn {
    border: none;
    background-color: #ccc;
    cursor: pointer;
    margin-right: 40%;
}

 .tempBtn:hover img,
 .tempBtn:active img {
      filter: brightness(0.5); /* 이미지 밝기 조정 */
      transform: scale(0.95); /* 크기 축소 */
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3); /* 그림자 추가 */
} 
/* 팝업 버튼 요소 끝 */

/* 팝업 내용 요소 시작 */
.popup-overlay-tree{
  
  display: none;
  justify-content: center;
  align-items: center;
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);
  z-index: 999;
}
.popup-overlay-tree .popup{
	width: 70%;
	outline: 2px solid red;
	padding: 20px 60px;
	border-radius: 20px;
	position: relative;
	background-color: #fff;
}
.popup-overlay-tree .popup .header{
	font-size:22px;
	font-weight: 700;
}
.popup-overlay-tree .popup .section{} 
.popup-overlay-tree .popup .section .img-box{} 
.popup-overlay-tree .popup .section .img-box img{
	width:100%;
} 
.popup-overlay-tree .popup .close-btn img{
    position: flex;
    top: 10px;
    right: 10px;
}
.popup-overlay-tree .popup .close-btn button{
   
   cursor: pointer;
   border: none; 									/* 경계선 없애기 */
   background-color: #2c4459;  
}
.popup-overlay-tree .popup .close-btn button i{
   font-size: 20px;
   color: #fff;
}
.popup-overlay-tree .popup .close-btn img {
    width: 20px; 						/* 원하는 너비로 조정 */
    height: 20px; 					    /* 원하는 높이로 조정 */
    background-color: gray;
    border-radius:50%;
    display:none;
}

.popupHead{}

/* 팝업 내용 요소 끝 */   
   
/* 직원정보 볼 수있는 hover 요소 */
.hover{
	 background-color: #2c4459;  /* 원하는 배경색으로 변경 */

}
.hover td{
	 color: #e68c0e;
	 font-weight:700;
}
 .name-popup {
	position: fixed;
	top: 55%;
	left: 55%;
	transform: translate(-50%, -50%);
	display: none; /* 처음에는 보이지 않도록 설정 */
	background-color: white;
	padding: 20px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
	z-index: 1000; /* 다른 요소 위에 표시되도록 설정 */
	width: 65%;
	height:65%;
	border-radius:1%;
 }

.popup-content{
	display: inline-block;
}

.close-popup{
	position:absolute;
	top:0;
	right:0;
	background-color: gray;
	border:none;
	padding: 5px;
	cursor:pointer;
	border-radius:50%
	
}

.close-popup img{
	width:15px;
	height:15px;
}

.emp_table tr:hover{
	background-color:#2c4459;
	color:#e68c0e;
}

.form-control:focus {
    box-shadow: none;
    border-color: #BA68C8;
}

.profile-button {
    background: rgb(99, 39, 120);
    box-shadow: none;
    border: none;
}

.profile-button:hover {
    background: #682773;
}

.profile-button:focus {
    background: #682773;
    box-shadow: none;
}

.profile-button:active {
    background: #682773;
    box-shadow: none;
}

.back:hover {
    color: #682773;
    cursor: pointer;
}

.labels {
    font-size: 11px;
    text-align: center;
   
}

.rounded-squre{
	border-radius:10px;
	width:150px;
	height:150px;
	object-fit:cover;
}

.container-border{
	border: 3px solid #e6ccff;
	border-radius:10px;
	/* width:60% */;
	margin-top:20%;
}
	
.popup-overlay-emp{
	width: 100%;
	height: 100%;
	position: fixed;
	top: 0; left: 0;
	background-color: rgba(0,0,0,0.7);
	display:flex;
	justify-content: center;
	align-items: center;
	display: none;
}
.emp-detail.popup{
	width: 70%;
	outline: 2px solid red;
	padding: 20px 60px;
	border-radius: 20px;
	position: relative;
	background-color: #ffffff;
}
.emp-detail .header{
	display: flex;
	justify-content: space-between;
}
.emp-detail .header h2{
	font-size: 24px;
	line-height: 40px;
	
}
.emp-detail .section{
	display: flex;
}
.emp-detail .section .article{}
.emp-detail .section .article.left{
	width: 25%;
	margin-top: 20px;
}
.emp-detail .section .article .img-box{
	width: 70%;
	/* margin: 0 auto; */
	
	background-color: #ccc;
}
.emp-detail .section .article .img-box img{
	width: 100%;
}
.emp-detail .section .article.right{
	width: 75%;
}
.emp-detail .section .article .input-forms{
	display: flex;
	flex-wrap: wrap;
}
.emp-detail .section .article .input-forms label{
	width: 50%;
	padding: 0 10px;
}
.emp-detail .section .article .input-forms label:nth-of-type(2)~label{
	margin-top:10px;
}
.emp-detail .section .article .input-forms label span{}
.emp-detail .section .article .input-forms label input{}
.emp-detail .section .article .input-address {
	padding: 0 10px;
	margin-top:10px;
}
.emp-detail .section .article .input-address label{
	width: 50%;
}
.emp-detail .section .article .input-address label span{
	display: flex;
	padding-right: 10px;
}
.emp-detail .section .article .input-address label input:last-of-type{
	margin-left: 10px
}
.emp-detail .section .article .input-address input{
	margin-top: 10px;
}
.emp-detail .section .article .input-btns{
	display: flex;
	justify-content: center;
	padding: 20px 0;
}
.emp-detail .section .article .input-btns button{}
.emp-detail.popup .close-btn{
	position: absolute;
	top: 20px; right: 20px;
}
.emp-detail.popup .close-btn button{
	width: 40px;
	height: 40px;
	background-color: #000;
	border-radius: 40px;
}
.emp-detail.popup .close-btn button{
	cursor: pointer;
   border: none; 									/* 경계선 없애기 */
   background-color: #2c4459;  
}
.emp-detail.popup .close-btn button i{
	font-size: 20px;
   color: #fff;
}

bigName{
	padding-bottom:20%;
}

.form-control{
	margin: 0 auto;
} 

.header{
	display : flex;
}

#xmark{
	border-radius :50%; 
	width:5%;
}




</style>


<script type="text/javascript">

	
	$(document).ready(function() {

		/* 조직도 팝업 여는 함수 시작 시작 */
		$('.tempBtn').click(function() {
			$('.popup-overlay-tree').css({
				display : 'flex'
			});
		});

		// 팝업 닫기
		$('.close-btn').click(function() {
			$('.popup-overlay-tree').css({
				display : 'none'
			});
		});

		/* 조직도 팝업 여는 함수 시작 끝 */
		
		// 클릭 시 팝업
		$('.emp-name').click(function() {
			$('.popup-overlay-emp').css({
				display : 'flex'
			});
			console.log('open popup')
		})

		// 닫기 버튼을 클릭하면 팝업 제거
		$('.popup-overlay-emp .close-btn').click(function() {
			$('.popup-overlay-emp').css({
				display : 'none'
			});
		});
	});
</script>



<div class="employeeWrap">
	<div class="address">
		<div class="add-header">
			<h2>사내연락망</h2>
		</div>
		
		<div class="search_bar">
		
			<div class="sch_left">
				<form name="employee_search_frm">
					<select name ="searchType">
						<option value="">검색대상</option>
						<option value="department">부서</option>
						<option value="position">직위</option>
						<option value="name">이름</option>
					</select>
					<input type="search" name="searchWord;" />
					<input type="button" name="searchWord;" onclick="goSearch()" value="검색"/>
				</form>
			</div>	
	     
	     <button class="tempBtn">
	     		조직도 보기
	     </button>
    	 
	    <!-- 팝업 오버레이 -->
	    <div class="popup-overlay-tree" id="popupOverlay">
		    <!-- 팝업 창 -->
		    <div class="popup">
		    	<div class="header">
		    		<div style="width : 98%"><h2>회사 조직도</h2></div>
		    		<button id="xmark" class="close-btn" style="">
							<i class="fa-solid fa-xmark"></i>
							<%-- <img src="<%= ctxPath%>/resources/images/common/xmark.svg" alt=""> --%>
					</button>
		    	</div>

		    	<div class="section">
		    		<div class="img-box">
		    			<img src="<%= ctxPath%>/resources/images/common/ptree.png" alt="">
		    		</div>
		    	</div>
		    	
        
		    </div>
			</div>
			
			<div class="sch_right">
				<span style="font-size: 12pt; font-weight: bold;">페이지당 회원명수&nbsp;-&nbsp;</span>
				<select name="sizePerPage">
					<option value="10">10명</option>
					<option value="30">30명</option>
					<option value="50">50명</option>		
				</select>
			</div> 
	</div>
					
		<table id="" class="emp_table">
				   <thead>
				       <tr>
				          <th id ="depart">부서</th>
				          <th id ="position">직위</th>
				          <th id="name">이름</th>
				          <th id="tel">회사전화</th>
				          <th id="email">이메일</th>
				       </tr>
				   </thead>
				
				   <tbody>
				 	   <tr>
			   			 <td>회계팀</td>
			   			 <td>대리</td>
			   			 <td class="emp-name">
				   				김철수
			  			 </td>
			  			 <td>010-2222-3333</td>
			  			 <td>cheolsu@naver.com</td>
		  			</tr>
		  		<tr>
		  			 <td>개발 1팀</td>
		  			 <td>차장</td>
		  			 <td class="emp-name">
		  			 		윤한나
		  			 </td>
		  			 <td>010-3333-4444</td>
		  			 <td>hanna@naver.com</td>
		  		</tr>
		  		<tr>
		  			 <td>회계팀</td>
		  			 <td>부장</td>
		  			 <td class="emp-name">
		  			 		정유리
		  			 </td>
		  			 <td>010-4444-5555</td>
		  			 <td>glass@naver.com</td>
		  		</tr>
		  		<tr>
		  			 <td>마케팅부</td>
		  			 <td>대리</td>
		  			 <td class="emp-name">
		  			 		조규리	
		  			 </td>
		  			 <td>010-5555-6666</td>
		  			 <td>tangerin@naver.com</td>
		  		</tr>
		  		<tr>
		  			 <td>회계팀</td>
		  			 <td>대리</td>
		  			 <td class="emp-name">
		  					김철수
		  			 </td>
		  			 <td>010-2222-3333</td>
		  			 <td>cheolsu@naver.com</td>
		  		</tr>
		  		<tr>
		  			 <td>회계팀</td>
		  			 <td>대리</td>
		  			 <td class="emp-name">
		  					김철수
		  			 </td>
		  			 <td>010-2222-3333</td>
		  			 <td>cheolsu@naver.com</td>
		  		</tr>
		  		<tr>
		  			 <td>회계팀</td>
		  			 <td>대리</td>
		  			 <td class="emp-name">
		  					김철수
		  			 </td>
		  			 <td>010-2222-3333</td>
		  			 <td>cheolsu@naver.com</td>
		  		</tr>
		  		<tr>
		  			 <td>회계팀</td>
		  			 <td>대리</td>
		  			 <td class="emp-name">
		  					김철수
		  			 </td>
		  			 <td>010-2222-3333</td>
		  			 <td>cheolsu@naver.com</td>
		  		</tr>
		  		<tr>
		  			 <td>회계팀</td>
		  			 <td>대리</td>
		  			 <td class="emp-name">
		  					김철수
			   		 </td>
			   		 <td>010-2222-3333</td>
			   		 <td>cheolsu@naver.com</td>
			   		</tr>
			   		
			   		</tbody>
				</table>
			</div>	
		</div>		
				
		<div class="pagenation">
			<button>&lt;</button>
			<ul>
				<li>1</li>
				<li>2</li>
				<li>3</li>
				<li>4</li>
				<li>...</li>
			</ul>
			<button>&gt;</button>
		</div>



	<%-- 팝업 클릭시 보이는 직원 상세 테이블 --%>
<div class="popup-overlay-emp">
	<div class="emp-detail popup">
		<div class="header">
			<h2>직원정보 상세보기</h2>
		</div>
		<div class="section">
			<div class="article left">
				<div class="img-box">
					<img src="<%= ctxPath%>/resources/images/common/picture.png">
				</div>
			</div>
			<div class="article right">
				<div class="input-forms">
					<label> 
						<span>이름</span> 
						<input type="text" class="form-control" value="유선우" readonly>
					</label> 
					<label> 
						<span>닉네임</span>
						<input type="text" class="form-control" value="qwldnjs" readonly>
					</label> 
					<label> 
						<span>부서</span>
						<input type="text" class="form-control" value="디자인부" readonly>
					</label> 
					<label> 
						<span>직위</span> 
						<input type="text" class="form-control" value="부장" readonly>
					</label> 
					<label> 
						<span>Email</span> 
						<input type="text" class="form-control" value="qwldnjs@hanmail.net" readonly>
					</label> 
					<label> 
						<span>내선전화</span> 
						<input type="text" class="form-control" value="000#" readonly>
					</label>
					<label>
					 	<span>휴대폰번호</span>
					 	<input type="text" class="form-control" value="000#" readonly>
					</label>
					<label> 
						<span>입사일자</span> 
						<input type="text" class="form-control" value="000#" readonly>
					</label>
					<label> 
						<span>기본급여</span> 
						<input type="text" class="form-control" value="000#" readonly>
					</label>
					<label> 
						<span>포인트</span> 
						<input type="text" class="form-control" value="000#" readonly>
					</label>
					
				</div>
				<div class="input-address">
					<label>
						<span>주소</span>
						<span>						
							<input type="text" id="sample6_postcode" placeholder="우편번호" class="form-control" readonly>
							<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" readonly>
						</span>					
					</label>
					<input type="text" id="sample6_address" placeholder="주소"class="form-control" readonly>
					<input type="text" id="sample6_detailAddress" placeholder="상세주소"class="form-control" readonly>
					<input type="text" id="sample6_extraAddress" placeholder="참고항목"class="form-control" readonly>
				
				<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
				<script>
			    function sample6_execDaumPostcode() {
			        new daum.Postcode({
			            oncomplete: function(data) {
			                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
			
			                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
			                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
			                var addr = ''; // 주소 변수
			                var extraAddr = ''; // 참고항목 변수
			
			                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
			                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
			                    addr = data.roadAddress;
			                } else { // 사용자가 지번 주소를 선택했을 경우(J)
			                    addr = data.jibunAddress;
			                }
			
			                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
			                if(data.userSelectedType === 'R'){
			                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
			                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
			                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
			                        extraAddr += data.bname;
			                    }
			                    // 건물명이 있고, 공동주택일 경우 추가한다.
			                    if(data.buildingName !== '' && data.apartment === 'Y'){
			                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
			                    }
			                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
			                    if(extraAddr !== ''){
			                        extraAddr = ' (' + extraAddr + ')';
			                    }
			                    // 조합된 참고항목을 해당 필드에 넣는다.
			                    document.getElementById("sample6_extraAddress").value = extraAddr;
			                
			                } else {
			                    document.getElementById("sample6_extraAddress").value = '';
			                }
			
			                // 우편번호와 주소 정보를 해당 필드에 넣는다.
			                document.getElementById('sample6_postcode').value = data.zonecode;
			                document.getElementById("sample6_address").value = addr;
			                // 커서를 상세주소 필드로 이동한다.
			                document.getElementById("sample6_detailAddress").focus();
			            }
			        }).open();
			    }
				</script>				
				</div>
			</div>
		</div>
		<div class="close-btn">
			<button><i class="fa-solid fa-xmark"></i></button>
			<%-- <button><img src="<%= ctxPath%>/resources/images/common/xmark.svg"></button> --%>
		</div>
	</div>
</div>




        





