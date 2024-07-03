<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
	String ctxPath = request.getContextPath();
%>

<style type="text/css">
div#myHead {
	height: 80px;
	background-color: #999;
}

div#row {
	display: flex !important;
}

div#register_com {
	width: calc(100vw - 250px);
	height: calc(100vh - 80px);
	display: flex;
	justify-content: center;
	align-items: center;
}

/* 여기서부터 시작 */
.clientWrap {
	width: 100%;

}

.clientWrap label {
	display: flex;
	flex-direction: column;
	margin-top: 20px;
}

.clientWrap label:first-of-type {
	margin-top: 0;
}

.clientWrap label span {
	font-size: 14px;
	line-height: 20px;
}

.clientWrap label input {
	font-size: 16px;
	height: 40px;
}

.clientWrap .clientHeader {
	display: flex;
	padding: 10px 0;
}

.clientWrap .clientHeader button {
	height: 40px;
	width: 40px;
	background-repeat: no-repeat;
	background-size: 16px;
	background-position: center;
}

.clientWrap .clientHeader h3 {
	font-size: 20px;
	line-height: 40px;
	margin-left: 20px;
	font-weight: 700;
}

.clientWrap .clientRegister {
	display: flex;
	border-top: 1px solid #ccc;
	padding-top: 20px;
}

.clientWrap .clientRegister>div {
	
}

.clientWrap .clientRegister .rgs-profile {
	width: calc(20% - 20px);
	margin-right: 20px;
}

.clientWrap .clientRegister .rgs-profile .imgbox {
	background-color: #ffe9e9;
}

.clientWrap .clientRegister .rgs-profile .imgbox img {
	width: 100%;
}

.clientWrap .clientRegister .rgs-body {
	width: 80%;
}

.clientWrap .clientRegister .rgs-body .rgs-forms{
	display:flex;
}
.clientWrap .clientRegister .rgs-left {
	width: 50%;
	padding: 0 10px;
}

.clientWrap .clientRegister .rgs-right {
	width: 50%;
	padding: 0 10px;
}

.clientWrap .clientRegister .rgs-body .rgs-address{
	padding: 0 10px;
}
.clientWrap .clientRegister .rgs-body .rgs-address label{
	width: 50%;
	padding-right: 10px;
}
.clientWrap .clientRegister .rgs-body .rgs-address label span{
 display: block;
 display: flex;
}
.clientWrap .clientRegister .rgs-body .rgs-address label input[type=button]{
	margin-left: 10px;
}
.clientWrap .clientRegister .rgs-body .rgs-address input{
	width: 100%;
	font-size: 16px;
 	height: 40px  
}
.clientWrap .clientRegister .rgs-body .rgs-address input.addfield{
	margin-top: 10px
}
.clientWrap .clientRegister .rgs-body .rgs-address input.addfield:nth-of-type(1){
	margin-top: 0px
}
.clientWrap .clientConfirm {
	display: flex;
	justify-content: center;
	padding: 20px 0;
	border-top: 1px solid #ccc;
	margin-top: 20px;
}

.clientWrap .clientConfirm input {
	height: 40px;
	background-color: #666;
	color: #fff;
	padding: 0 20px;
	margin: 0 5px;
	border-radius: 5px;
}

.chk_businum input[type="text"]
 {
	width:100%;
	margin-right:10px;
}

.chk_businum input[type="button"]{
	width: 50%;
}

.star,.error{
	font-size:12px;
	color:red;

}



</style>


<script type="text/javascript">
	$(document).ready(function(){
		
		$("span.error").hide();
		$("input#comName").focus();
		
		$("input#comName").blur((e) => {
			
			const comName = $(e.target).val().trim();
			if(comName ==""){
				// 입력하지 않거나 공백만 입력했을 경우 
	            /*	
				   >>>> .prop() 와 .attr() 의 차이 <<<<	         
			            .prop() ==> form 태그내에 사용되어지는 엘리먼트의 disabled, selected, checked 의 속성값 확인 또는 변경하는 경우에 사용함. 
			            .attr() ==> 그 나머지 엘리먼트의 속성값 확인 또는 변경하는 경우에 사용함.
				*/
				$(".clientWrap :input").prop("disabled" ,true);
			    $(e.target).prop("disabled", false);
			    $(e.target).val("");
			    
			//  $(e.target).next().show();
		    //  또는
		        $(e.target).parent().find("span.error").show();
			}
			
			else{
				// 공백이 아닌 글자를 입력했을 경우
				$(".clientWrap :input").prop("disabled" ,false);
				
				$(e.target).parent().find("span.error").hide();
			}
		
		});  // id가 comName 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
		
		
		$("input#comType").blur((e) => {
			
			const comType = $(e.target).val().trim();
			if(comType == ""){
				// 입력하지 않거나 공백만 입력했을 경우 
				$(".clientWrap :input").prop("disabled", true);
				$(e.target).prop("disabled", false);
	            $(e.target).val("").focus();
	            
       		//  $(e.target).next().show();
            //  또는
	            $(e.target).parent().find("span.error").show();
			}
			else{
				// 공백이 아닌 글자를 입력했을 경우
				$(".clientWrap :input").prop("disabled",false);
				$(e.target).parent().fidn("span.error").hide();
			}
			
		});// id가 comType 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
		
		$("input#Name").blur((e) => {
			
			const Name = $(e.target).val().trim();
			if(Name == ""){
				// 입력하지 않거나 공백만 입력했을 경우 
				$(".clientWrap :input").prop("disabled", true);
				$(e.target).prop("disabled", false);
	            $(e.target).val("").focus();
	            
       		//  $(e.target).next().show();
            //  또는
	            $(e.target).parent().find("span.error").show();
			}
			else{
				// 공백이 아닌 글자를 입력했을 경우
				$(".clientWrap :input").prop("disabled",false);
				$(e.target).parent().fidn("span.error").hide();
			}
			
		});	// id가 Name 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
		
		$("input#comEmail").blur( (e) => { 

        // const regExp_email = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;  
	    // 또는
	       const regExp_comEmail = new RegExp(/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i);  
	       // 이메일 정규표현식 객체 생성 
           
           const bool = regExp_comEmail.test($(e.target).val());
   
           if(!bool) {
               // 이메일이 정규표현식에 위배된 경우 
               
               $(".clientWrap :input").prop("disabled", true);
               $(e.target).prop("disabled", false);
               $(e.target).val("").focus();
           
           //  $(e.target).next().show();
           //  또는
               $(e.target).parent().find("span.error").show();
   
           }
           else {
               // 이메일이 정규표현식에 맞는 경우 
               $(".clientWrap :input").prop("disabled", false);
   
               //  $(e.target).next().hide();
               //  또는
               $(e.target).parent().find("span.error").hide();
           }
   
       });// 아이디가  comEmail인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.       
		
		
		
		$("input#comNumber").blur( (e) => { 

			const comNumber = $(e.target).val().trim();
			if(comNumber == ""){
					// 입력하지 않거나 공백만 입력했을 경우 
					$(".clientWrap :input").prop("disabled", true);
					$(e.target).prop("disabled", false);
		      $(e.target).focus();
	        $(e.target).parent().parent().find("span#empty.error").show();
			}
			
			else{
				$(".clientWrap :input").prop("disabled", false);
        $(e.target).parent().parent().find("span#empty.error").hide();
			}

			const regExp_comNumber = new RegExp(/^[0-9]{3}-[0-9]{2}-[0-9]{5}$/);  
      const bool = regExp_comNumber.test($(e.target).val());

       if(!bool) {
           
           $(".clientWrap :input").prop("disabled", true);
           $(e.target).prop("disabled", false);
           $(e.target).focus();
       
           $(e.target).parent().parent().find("span#format.error").show();
       }
       else {
           $(".clientWrap :input").prop("disabled", false);
           $(e.target).parent().parent().find("span#format.error").hide();
       }
   
	});// 아이디가  comNumber인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.       
			
		
		
		
		
		
		
		
		
		
		
		
		
		
	}); // end of $(document).ready(function(){}----------------------------

</script>

<div id="register_com" style="padding-right:10%;">
	<form action="" class="clientWrap">
		<div class="clientHeader">
			<button style="background-image: url(<%=ctxPath%>/resources/images/common/arrow-left-solid.svg)">
				<span hidden>뒤로가기</span>
			</button>
			<h3>거래처등록하기</h3>
		</div>
		<div class="clientRegister">
			<div class="rgs-profile">
				<div class="imgbox">
					<img src="<%=ctxPath%>/resources/images/common/picture.png" alt="">
				</div>
				<input type="file" value="" accept="img/*">
			</div>
			<div class="rgs-body">
				<div class="rgs-forms">
					<div class="rgs-left">
						<label> 
							<span>거래처명&nbsp;<span class="star">*</span></span> 
							<input type="text" class="comName" id="comName" placeholder="거래처명을 입력하세요.">
							<span class="error">거래처명은 필수 입력사항입니다.</span>
						</label> 
						<label> 
							<span>거래처업종&nbsp;<span class="star">*</span></span> 
							<input type="text" id="comType" placeholder="거래처업종을 입력하세요.">
							<span class="error">거래처업종은 필수 입력사항입니다.</span>
						</label> 
						<div class="chk_businum">
						<label> 
							<span>사업자등록번호&nbsp;<span class="star">*</span></span> 
							<div style="display:flex;">
								<input type="text" id="comNumber" placeholder="사업자등록번호를 입력하세요."/>
								<input type="button" onclick="" value="중복확인"/> 

							</div>
								<span id="empty" class="error">사업자등록번호는 필수 입력사항입니다.</span> 
								<span id="format" class="error">사업자등록번호형식이 잘못되었습니다.</span>
						</label>
						</div> 
						<label> 
							<span>웹사이트&nbsp;<span class="star">*</span></span> 
							<input type="text" placeholder="사이트주소를 입력하세요.">
							<span class="error">거래처 웹사이트는 필수 입력사항입니다.</span>
						</label>
					</div>
					<div class="rgs-right">
						<label> 
							<span>담당자명&nbsp;<span class="star">*</span></span> 
							<input type="text" id="Name" placeholder="담당자명을 입력하세요.">
							<span class="error">담당자명은 필수 입력사항입니다.</span>
						</label> 
						<label> 
							<span>담당자부서</span> 
							<input type="text" placeholder="담당자부서를 입력하세요.">
						</label> 
						<label> 
							<span>담당자전화번호</span> 
							<input type="text" placeholder="담당자연락처를 입력하세요">
						</label> 
						<label>
							<span>담당자이메일&nbsp;<span class="star">*</span></span>
							<input type="text" id="comEmail" placeholder="담당자이메일을 입력하세요.">
							<span class="error">담당자 이메일은 필수 입력사항입니다.</span>
						</label>
					</div>
				</div>
				<div class="rgs-address">
					<label>
						<span>주소&nbsp;<span class="star">*</span></span><span class="error">거래처주소는 필수 입력사항입니다.</span>
						<span>						
							<input type="text" id="sample6_postcode" placeholder="우편번호">
							<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"> 
						</span>
					</label>
					<input class="addfield" type="text" id="sample6_address" placeholder="주소"> 
					<input class="addfield" type="text" id="sample6_detailAddress" placeholder="상세주소"> 
					<input class="addfield" type="text" id="sample6_extraAddress" placeholder="참고항목">
					
					<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
					
					<script>
					function sample6_execDaumPostcode() {
						new daum.Postcode({
							oncomplete : function(data) {
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
								if (data.userSelectedType === 'R') {
									// 법정동명이 있을 경우 추가한다. (법정리는 제외)
									// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
									if (data.bname !== ''
											&& /[동|로|가]$/g
													.test(data.bname)) {
										extraAddr += data.bname;
									}
									// 건물명이 있고, 공동주택일 경우 추가한다.
									if (data.buildingName !== ''
											&& data.apartment === 'Y') {
										extraAddr += (extraAddr !== '' ? ', '
												+ data.buildingName
												: data.buildingName);
									}
									// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
									if (extraAddr !== '') {
										extraAddr = ' ('
												+ extraAddr + ')';
									}
									// 조합된 참고항목을 해당 필드에 넣는다.
									document
											.getElementById("sample6_extraAddress").value = extraAddr;

								} else {
									document
											.getElementById("sample6_extraAddress").value = '';
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
		<div class="clientConfirm">
			<input type="reset" value="취소"><input type="submit" value="등록">
		</div>
	</form>
	<!--//들고가야함  -->
</div>
