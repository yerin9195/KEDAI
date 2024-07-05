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
	width:100%;
	display:flex;
	justify-content:center;
	align-items:center;
	overflow:hidden;
	border:1px solid red;
	
}

.clientWrap .clientRegister .rgs-profile .imgbox img {
	width: 100%;
	/* height:auto; */
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

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script type="text/javascript">
	let comAddr_chk = false;
	let partnerNo_chk = false;
	
	
	$(document).ready(function(){
		
		$("span.error").hide();
		$("input#partner_part_emp_name").focus();
		
		$("input#partner_part_emp_name").on('input',(e)=>{
			
			const partner_part_emp_name = $(e.target).val().trim();
			if(partner_part_emp_name ==""){
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
		
		});  // id가 partner_part_emp_name 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
		
		
		$("input#partner_type").on('input',(e)=>{
			
			const partner_type = $(e.target).val().trim();
			if(partner_type == ""){
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
				$(e.target).parent().find("span.error").hide();
			}
			
		});// id가 partner_type 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
		
		$("input#part_emp_name").on('input',(e)=>{
			
			const part_emp_name = $(e.target).val().trim();
			if(part_emp_name == ""){
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
				$(e.target).parent().find("span.error").hide();
			}
			
		});	// id가 part_emp_name 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.-------------------------------------------------------------
		
		$("input#part_emp_email").on('input',(e)=> {
			
		    const part_emp_email = $(e.target).val().trim();
		    if (part_emp_email == "") {
		        // 입력하지 않거나 공백만 입력했을 경우 
		        $(".clientWrap :input").prop("disabled", true);
		        $(e.target).prop("disabled", false);
		        $(e.target).focus();
		        $(e.target).parent().find("span#email_empty.error").show();
		        // 중복된 숨기기 코드를 제거했습니다.
		    } else {
		        $(".clientWrap :input").prop("disabled", false);
		        $(e.target).parent().find("span#email_empty.error").hide();

		        const regExp_part_emp_email = new RegExp(/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i);
		        const bool = regExp_part_emp_email.test(part_emp_email); // $(e.target).val() 대신 part_emp_email 사용

		        if (!bool) {
		            $(".clientWrap :input").prop("disabled", true);
		            $(e.target).prop("disabled", false);
		            $(e.target).focus();
		            $(e.target).parent().find("span#email_format.error").show();
		            $(e.target).parent().find("span#email_empty.error").hide();
		        } else {
		            $(".clientWrap :input").prop("disabled", false);
		            
		            $(e.target).parent().find("span#email_format.error").hide();
		            $(e.target).parent().find("span#email_empty.error").hide();
		        }
		    }
		
       });// 아이디가  part_emp_email인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다. --> 거래처담당자 이메일 확인-------------------------------------
		
       
       // 사업자등록번호 유효성검사 // 
	   $("input#partner_no").on('input',(e)=>{
			const partner_no = $(e.target).val().trim();
		
			if(partnerNo == ""){
				// 입력하지 않거나 공백만 입력했을 경우 
				$(".clientWrap :input").prop("disabled", true);
				$(e.target).prop("disabled", false);
	     		$(e.target).focus();
	        	$(e.target).parent().parent().find("span#empty.error").show();
	        	
	        	$(e.target).parent().parent().find("span#format.error").hide();
			}
			else{
				$(".clientWrap :input").prop("disabled", false);
	    		$(e.target).parent().parent().find("span#empty.error").hide();
	    		
	    		
	    		const regExp_partner_no = new RegExp(/^[0-9]{3}-[0-9]{2}-[0-9]{5}$/);  
	     		const bool = regExp_partner_no.test($(e.target).val());
	
	    		if(!bool) {
		           $(".clientWrap :input").prop("disabled", true);
		           $(e.target).prop("disabled", false);
		           $(e.target).focus();
		           $(e.target).parent().parent().find("span#format.error").show();
		           
		           $(e.target).parent().parent().find("span#empty.error").hide();
	    	    }
	    	    else {
		           $(".clientWrap :input").prop("disabled", false);
		           $(e.target).parent().parent().find("span#format.error").hide();
		           $(e.target).parent().parent().find("span#empty.error").hide();
	    	    }
	    		
		    }
	   }); // 아이디가  comNumber인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.     */   
		
      ////////////////////////////////////////////////////////////////////////////////////
	  
      $("input#partnerNo_chk").click(function(){// "사업자 등록번호" 가 이미 있는지 확인하는 이벤트  
    	  partnerNo_chk = true;
      	   
      	  $.ajax({
      		  url:"<%=ctxPath%>/partnerNoCheck.kedai",
      		  data:{"partner_no":$("input#partner_no").val()},
      		  type:"post",
      		  async: true,
      		  dataType:"json",
      		  success: function(json){
      			  if(json.isExists){
      				  $("span#partNoChkResult").html("&nbsp;이미 등록된 사업자등록번호 입니다.").css({"color":"red"});
      			  	  $("input#partner_no").val("");
      			  	  
      			  }
      			  else{
      				  $("span#partNoChkResult").html("&nbsp;등록가능한 사업자등록번호입니다.").css({"color":"blue"});
      			  }
      		  },
	      	  error: function(request, status, error){
	          		alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	          }
      	  });
      		

      });
      
	  ////////////////////////////////////////////////////////////////////////////////////////
		
		$("input#partner_url").on('input',(e)=>{
			
			const partner_url = $(e.target).val().trim();
			if(partner_url == ""){
				// 입력하지 않거나 공백만 입력했을 경우 
				$(".clientWrap :input").prop("disabled", true);
				$(e.target).prop("disabled", false);
	            $(e.target).val("").focus();
	            
	            $(e.target).parent().find("span.error").show();
			}
			else{
				// 공백이 아닌 글자를 입력했을 경우
				$(".clientWrap :input").prop("disabled",false);
				$(e.target).parent().find("span.error").hide();
			}
			
		});	// id가 partner_url 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.

		/////////////////////////////////////////////////////////////////////////////
		
		$("input#fileInput").on('input',(e) => {
			
			const imgfilename = $(e.target).val().trim();
			if(imgfilename == ""){
				// 입력하지 않거나 공백만 입력했을 경우 
				$(".clientWrap :input").prop("disabled", true);
				$(e.target).prop("disabled", false);
	            $(e.target).val("").focus();
	            
	            $(e.target).parent().find("span.error").show();
			}
			else{
				// 공백이 아닌 글자를 입력했을 경우
				$(".clientWrap :input").prop("disabled",false);
				$(e.target).parent().find("span.error").hide();
			}
			
		});	// id가 imgfilename 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
		
		// 이미지 상자안에 이미지 파일이 아닌 다른 파일이 오면 리셋시키기
		$("#fileInput").on('change', function(event){
			const file= this.files[0];
			if(file && file.type.startsWith('image/')){
				// 파일이 이미지인 경우
				console.log("이미지 파일이 선택되었습니다.");
			}
			else{
				// 선택한 파일이 이미지가 아닌 경우
				alert('이미지 파일을 선택해주세요!!');
				$(this).val(''); // 입력 초기화
			}
		
		})//이미지 상자안에 이미지 파일이 아닌 다른 파일이 오면 리셋시키기
		
		// ==> 거래처 대표 이미지 파일선택을 하면 화면에 이미지를 미리 보여주기 시작 <<=== //
		$(document).on("change", "input#fileInput", function(e){
			
			const input_file = $(e.target).get(0);
			
			// 자바스크립트에서 file 객체의 실제 데이터(내용물)에 접근하기 위해 FileReader 객체를 생성하여 사용한다.
			const fileReader = new FileReader();
			
			fileReader.readAsDataURL(input_file.files[0]);
			// FileReader.readAsDataURL() --> 파일을 읽고, result속성에 파일을 나타내는 URL을 저장 시켜준다.
			
			fileReader.onload = function(){
			// FileReader.onload --> 파일 읽기 완료 성공시에만 작동하도록 하는 것임.
				
				// img태그 무조건쓰고 순수 자바스크립트로만 넣어야한다 미리보기는 이렇게!
				document.getElementById("previewImg").src = fileReader.result;
			
				console.log(fileReader.result)
			}
			
		})
	
	}); // end of $(document).ready(function(){}----------------------------
	
			
	// Function Declaration		
	// 주소찾기
	$("input#partner_postcode").attr("readonly",true);
	$("input#partner_address").attr("readonly",true);
	$("input#partner_extraaddress").attr("readonly",true);
	
	function comDaumPostcode() {
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
							.getElementById("partner_extraaddress").value = extraAddr;

				} else {
					document
							.getElementById("partner_extraaddress").value = '';
				}

				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				document.getElementById('partner_postcode').value = data.zonecode;
				document.getElementById("partner_address").value = addr;
				// 커서를 상세주소 필드로 이동한다.
				document.getElementById("partner_detailaddress").focus();
			}
		}).open();
		
		$("input#partner_postcode").attr("readonly",true);
		$("input#partner_address").attr("readonly",true);
		$("input#partner_extraaddress").attr("readonly",true);
		
		
	}// end of function comDaumPostcode()-----------------------------			
	
	// Function Declaration (정보 등록)
	function partnerRegister(){
		
		let partComReg = true;
		
		const partComReg_list = document.querySelectorAll("");
		for(let i=0; i<partComReg_list.length; i++){
			const val=partComReg_list[i].value.trim();
			
			if(val ==""){
				alert("* 은 필수입력사항입니다.");
				partComReg = false;
				
				break;
			
			}
		} // end of for()-----------------------------------------
		
	}	
	
	
	
	
</script>

<div id="register_com" style="padding-right:10%;">
	<form action="" class="clientWrap">
		<div class="clientHeader">
			<button style="background-image: url(<%=ctxPath%>/resources/images/common/arrow-left-solid.svg)">
			</button>
			<h3>거래처등록하기</h3>
		</div>
		<div class="clientRegister">
			<div class="rgs-profile">
				<div class="imgbox" style="padding-bottom:10px width=25%;">
					<div style="padding-bottom:10px; width=25%"></div>
					<img id="previewImg" width="300" <%-- src="<%=ctxPath%>/resources/images/common/picture.png" alt="" --%>>
				</div>
				<input type="file" id="fileInput" value="fileInput" accept="image/*">
				<span style="font-style:italic; font-size:12px; color:fff;">대표사진을 등록하세요&nbsp;<span class="star">*</span></span> 
				<span class="error">거래처명은 필수 입력사항입니다.</span>
			</div>
			<div class="rgs-body">
				<div class="rgs-forms">
					<div class="rgs-left">
						<label> 
							<span>거래처명&nbsp;<span class="star">*</span></span> 
							<input type="text" class="comName" id="partner_name" placeholder="거래처명을 입력하세요.">
							<span class="error">거래처명은 필수 입력사항입니다.</span>
						</label> 
						<label> 
							<span>거래처업종&nbsp;<span class="star">*</span></span> 
							<input type="text" id="partner_type" placeholder="거래처업종을 입력하세요.">
							<span class="error">거래처업종은 필수 입력사항입니다.</span>
						</label> 
						<div class="chk_businum">
						<label> 
							<span>사업자등록번호&nbsp;<span class="star">*</span></span> 
							<div style="display:flex;">
								<input type="text" name="partner_no" id="partner_no" class="" placeholder="사업자등록번호를 입력하세요."/>
								<input type="button" id="partnerNo_chk" onclick="" value="중복확인"/> 
								<span id="partNoChkResult"></span>
							</div>
							<span id="empty" class="error">사업자등록번호는 필수 입력사항입니다.</span> 
							<span id="format" class="error">사업자등록번호형식이 잘못되었습니다.</span>
						</label>
						</div> 
						<label> 
							<span>웹사이트&nbsp;<span class="star">*</span></span> 
							<input type="text" id="partner_url" placeholder="사이트주소를 입력하세요.">
							<span class="error">거래처 웹사이트는 필수 입력사항입니다.</span>
						</label>
					</div>
					<div class="rgs-right">
						<label> 
							<span>담당자명&nbsp;<span class="star">*</span></span> 
							<input type="text" id="part_emp_name" placeholder="담당자명을 입력하세요.">
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
							<input type="text" id="part_emp_email" placeholder="담당자이메일을 입력하세요.">
							<span id="email_empty" class="error">담당자 이메일은 필수 입력사항입니다.</span>
							<span id="email_format" class="error">이메일 형식이 잘못되었습니다.</span>
						</label>
					</div>
				</div>
				<div class="rgs-address">
					<label>
						<span>주소&nbsp;<span class="star">*</span></span><span class="error">거래처주소는 필수 입력사항입니다.</span>
						<span>						
							<input type="text" id="partner_postcode" placeholder="우편번호">
							<input type="button" id="comAddr_chk" onclick="comDaumPostcode()" value="우편번호 찾기"> 
						</span>
					</label>
					<input class="addfield" type="text" id="partner_address" placeholder="주소"> 
					<input class="addfield" type="text" id="partner_detailaddress" placeholder="상세주소"> 
					<input class="addfield" type="text" id="partner_extraaddress" placeholder="참고항목">
				</div>
			</div>
		</div>
		<div class="clientConfirm">
			<input type="reset" value="취소"><input type="submit" value="등록">
		</div>
	</form>
	<!--//들고가야함  -->
</div>
