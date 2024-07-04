<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	// 컨텍스트 패스명(context path name)을 알아오고자 한다.
	String ctxPath = request.getContextPath();

%>
<style type="text/css">
	table#tblProdInput {border: solid #2c4459; 1px; 
	                    border-collapse: collapse; }
	                    
    table#tblProdInput td {border: solid #2c4459; 1px; 
	                       padding: 10px;}
	                       
    .prodInputName {background-color: #e68c0e; 
                    font-weight: bold; }	                       	                    
	
	.error {color: red; font-weight: bold; font-size: 9pt;}

</style>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> 
<script type="text/javascript">
let b_zipcodeSearch_click = false;

$(document).ready(function(){
	
	// 모든 에러 메세지는 숨긴 상태에서 하나씩 show 해줄거임
	$('span.error').hide();
	
    $("input#email").blur( (e) => { 

        // const regExp_email = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;  
	    // 또는
	       const regExp_email = new RegExp(/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i);  
	       // 이메일 정규표현식 객체 생성 
           
           const bool = regExp_email.test($(e.target).val());
   
           if(!bool) {
               // 이메일이 정규표현식에 위배된 경우 
               
               $("table#tblProdInput :input").prop("disabled", true);
               $(e.target).prop("disabled", false);
               $(e.target).val("").focus();
           
           //  $(e.target).next().show();
           //  또는
               $(e.target).parent().find("span.error").show();
   
           }
           else {
               // 이메일이 정규표현식에 맞는 경우 
               $("table#tblProdInput :input").prop("disabled", false);
   
               //  $(e.target).next().hide();
               //  또는
               $(e.target).parent().find("span.error").hide();
           }
   
       });// 아이디가 email 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.  
       
    $("input#postcode").blur( (e) => {
		
        //	const regExp_postcode = /^[0-9]{5}$/;  
        //  또는
        //	const regExp_postcode = /^\d{5}$/;
            const regExp_postcode = new RegExp(/^\d{5}$/);  
            // 숫자 5자리만 들어오도록 검사해주는 정규표현식 객체 생성 
            
            const bool = regExp_postcode.test($(e.target).val());	
            
            if(!bool) {
                // 우편번호가 정규표현식에 위배된 경우 
                
                $("table#tblProdInput :input").prop("disabled", true);  
                $(e.target).prop("disabled", false); 
                
            //	$(e.target).next().next().show();
            //  또는
                $(e.target).parent().find("span.error").show();
                     
                $(e.target).val("").focus(); 
            }
            else {
                // 우편번호가 정규표현식에 맞는 경우 
                $("table#tblProdInput :input").prop("disabled", false);
                
                $(e.target).parent().find("span.error").hide();
            }
            
    });// 아이디가 postcode 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.

    
    ///////////////////////////////////////////////////////////
    var elmt = document.getElementById("extraAddress").value;
	console.log("~~~확인용: " + elmt);
    // 우편번호를 읽기전용(readonly) 로 만들기
    $("input#postcode").attr("readonly", true);

    // 주소를 읽기전용(readonly) 로 만들기
    $("input#address").attr("readonly", true);
    
    // 참고항목을 읽기전용(readonly) 로 만들기
    $("input#extraAddress").attr("readonly", true);

    // === "우편번호찾기"를 클릭했을 때 이벤트 처리하기 === //
    $("button#zipcodeSearch").click(function(){
	
	    b_zipcodeSearch_click = true;
	    // "우편번호찾기" 를 클릭했는지 클릭을 안했는지 여부를 알아오기 위한 용도  
	
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                let addr = ''; // 주소 변수
                let extraAddr = ''; // 참고항목 변수

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
                    document.getElementById("extraAddress").value = extraAddr;
                } else {
                    document.getElementById("extraAddress").value = '';

                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("detailAddress").focus();
            }
        }).open();
    
        // 우편번호를 읽기전용(readonly) 로 만들기
        $("input#postcode").attr("readonly", true);

        // 주소를 읽기전용(readonly) 로 만들기
        $("input#address").attr("readonly", true);
    
        // 참고항목을 읽기전용(readonly) 로 만들기
        $("input#extraAddress").attr("readonly", true);

    
	});// end of $("button#zipcodeSearch").click()------------

	//=== jQuery UI 의 datepicker === //
	$('input#datepicker1').datepicker({
	     dateFormat: 'yy-mm-dd'  //Input Display Format 변경
	    ,showOtherMonths: true   //빈 공간에 현재월의 앞뒤월의 날짜를 표시
	    ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
	    ,changeYear: true        //콤보박스에서 년 선택 가능
	    ,changeMonth: true       //콤보박스에서 월 선택 가능                
	//  ,showOn: "both"          //button:버튼을 표시하고,버튼을 눌러야만 달력 표시됨. both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시됨.  
	//  ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
	//  ,buttonImageOnly: true   //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
	//  ,buttonText: "선택"       //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
	    ,yearSuffix: "년"         //달력의 년도 부분 뒤에 붙는 텍스트
	    ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
	    ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
	    ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
	    ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
	//  ,minDate: "-1M" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
	//  ,maxDate: "+1M" //최대 선택일자(+1D:하루후, +1M:한달후, +1Y:일년후)                
	});
	
	// 초기값을 오늘 날짜로 설정
	$('input#datepicker').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)
	
	
	// === 전체 datepicker 옵션 일괄 설정하기 ===  
	//     한번의 설정으로 $("input#fromDate"), $('input#toDate')의 옵션을 모두 설정할 수 있다.
	$(function() {
	    //모든 datepicker에 대한 공통 옵션 설정
	    $.datepicker.setDefaults({
	         dateFormat: 'yy-mm-dd' //Input Display Format 변경
	        ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
	        ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
	        ,changeYear: true //콤보박스에서 년 선택 가능
	        ,changeMonth: true //콤보박스에서 월 선택 가능                
	     // ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시됨. both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시됨.  
	     // ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
	     // ,buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
	     // ,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
	        ,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
	        ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
	        ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
	        ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
	        ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
	     // ,minDate: "-1M" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
	     // ,maxDate: "+1M" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)                    
	    });
	
    });
	
	///////////////////////////////////////////////////////////////////////


	//=== jQuery UI 의 datepicker === //
	$('input#datepicker2').datepicker({
	     dateFormat: 'yy-mm-dd'  //Input Display Format 변경
	    ,showOtherMonths: true   //빈 공간에 현재월의 앞뒤월의 날짜를 표시
	    ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
	    ,changeYear: true        //콤보박스에서 년 선택 가능
	    ,changeMonth: true       //콤보박스에서 월 선택 가능                
	//  ,showOn: "both"          //button:버튼을 표시하고,버튼을 눌러야만 달력 표시됨. both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시됨.  
	//  ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
	//  ,buttonImageOnly: true   //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
	//  ,buttonText: "선택"       //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
	    ,yearSuffix: "년"         //달력의 년도 부분 뒤에 붙는 텍스트
	    ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
	    ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
	    ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
	    ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
	//  ,minDate: "-1M" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
	//  ,maxDate: "+1M" //최대 선택일자(+1D:하루후, +1M:한달후, +1Y:일년후)                
	});
	
	// 초기값을 오늘 날짜로 설정
	// $('input#datepicker').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)
	
	
	// === 전체 datepicker 옵션 일괄 설정하기 ===  
	//     한번의 설정으로 $("input#fromDate"), $('input#toDate')의 옵션을 모두 설정할 수 있다.
	$(function() {
	    //모든 datepicker에 대한 공통 옵션 설정
	    $.datepicker.setDefaults({
	         dateFormat: 'yy-mm-dd' //Input Display Format 변경
	        ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
	        ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
	        ,changeYear: true //콤보박스에서 년 선택 가능
	        ,changeMonth: true //콤보박스에서 월 선택 가능                
	     // ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시됨. both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시됨.  
	     // ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
	     // ,buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
	     // ,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
	        ,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
	        ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
	        ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
	        ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
	        ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
	     // ,minDate: "-1M" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
	     // ,maxDate: "+1M" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)                    
	    });
	
    });
	
	///////////////////////////////////////////////////////////////////////
	
	$('input#datepicker2').bind("change", (e) => {
	    if( $(e.target).val() != "") {
	        $(e.target).next().hide();
	    }
	});// 생년월일에 마우스로 달력에 있는 날짜를 선택한 경우 이벤트 처리 한것 
	

///////////////////////////////////////////////////////
});//end of $(document).ready(function(){})---------------------------------------
</script>
<div align="center" style="margin-bottom: 20px;">

	<div style="border: solid #2c4459; 2px; width: 250px; margin-top: 20px; padding-top: 10px; padding-bottom: 10px; border-left: hidden; border-right: hidden;">       
		<span style="font-size: 15pt; font-weight: bold;">카셰어링&nbsp;등록</span>	
	</div>
	<br/>
	
	<%-- !!!!! ==== 중요 ==== !!!!! --%>
	<%-- 폼에서 파일을 업로드 하려면 반드시 method 는 POST 이어야 하고 
	     enctype="multipart/form-data" 으로 지정해주어야 한다.!! --%>
	<form name="prodInputFrm" enctype="multipart/form-data"> 
	      
		<table id="tblProdInput" style="width: 80%;">
		<tbody>
			<tr>
				<td width="25%" class="prodInputName" style="padding-top: 10px;">정원</td>
				<td width="75%" align="left" style="padding-top: 10px;" >
					<select name="fk_cnum" class="infoData">
						<option value="">:::선택하세요:::</option>

							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>

					</select>
					<span class="error compulsory">필수입력</span>
				</td>	
			</tr>
			<tr>
				<td width="25%" class="prodInputName">사원명</td>		<!-- readonly로 받아올것 -->
				<td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;" >
					<input type="text" style="width: 300px;" name="pname" class="box infoData" />
				</td>
			</tr>
		    <tr>
                  <td class="prodInputName">이메일&nbsp;</td>
                  <td style="border-top: hidden; border-bottom: hidden;">
                     <input type="text" name="email" id="email" maxlength="60" class="requiredInfo" />
                     <span class="error">이메일 형식에 맞지 않습니다.</span>
                     <%-- 이메일중복체크 --%>
                     <button id="emailcheck" style="background-color: white;"><i class="fa-regular fa-square-check"></i></button>
                     <span id="emailCheckResult"></span>
                  </td>
 			</tr>
            <tr>
                <td class="prodInputName">기간</td>
                <td>
                   <input type="text" name="start" id="datepicker1" maxlength="10" value=""/><span>&nbsp;~&nbsp;</span>
                   <input type="text" name="last" id="datepicker2" maxlength="10" value=""/>
                   <span class="error">기간은 마우스로만 클릭하세요.</span>
                </td>
            </tr>
			<tr>
				<td width="25%" class="prodInputName">출발지</td>
				<td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
					<input type="text" name="postcode" id="postcode" size="6" maxlength="5" style="padding: 5px;" placeholder="우편번호" readonly/>&nbsp;&nbsp;
                    <%-- 우편번호 찾기 --%>
                    <button style="background-color: white; padding: 5px;" id="zipcodeSearch"><i class="fa-solid fa-magnifying-glass"></i></button>
                    <span class="error">우편번호 형식에 맞지 않습니다.</span><br>
					<input type="text" name="address" id="address" size="40" maxlength="200" style="padding: 5px;" placeholder="주소" readonly/><br>
                    <input type="text" name="detailaddress" id="detailAddress" size="40" maxlength="200" style="padding: 5px;" placeholder="상세주소" readonly/>&nbsp;<input type="text" name="extraaddress" id="extraAddress" size="40" maxlength="200" placeholder="참고항목" readonly/>            
                    <span class="error">주소를 입력하세요.</span><span class="error compulsory">필수입력</span>
				</td>
			</tr>
			<tr>
				<td width="25%" class="prodInputName">도착지</td>
				<td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
				    <input type="text" name="postcode" id="postcode" size="6" maxlength="5" style="padding: 5px;" placeholder="우편번호" readonly/>&nbsp;&nbsp;
                    <%-- 우편번호 찾기 --%>
                    <button onclick="address()" style="background-color: white; padding: 5px;"><i class="fa-solid fa-magnifying-glass"></i></button>
                    <span class="error">우편번호 형식에 맞지 않습니다.</span><br>
					<input type="text" name="address" id="address" size="40" maxlength="200" style="padding: 5px;" placeholder="주소" /><br>
                    <input type="text" name="detailaddress" id="detailAddress" size="40" maxlength="200" style="padding: 5px;" placeholder="상세주소" />&nbsp;<input type="text" name="extraaddress" id="extraAddress" size="40" maxlength="200" placeholder="참고항목" />            
                    <span class="error">주소를 입력하세요.</span><span class="error compulsory">필수입력</span>
				</td>
			</tr>
			<tr>
				<td width="25%" class="prodInputName">유의사항(선택)</td>
				<td width="75%" align="left" >
					<textarea name="pcontent" rows="5" cols="60" style="width: 95%; "></textarea>
				</td>
			</tr>
			<tr style="height: 70px;">
				<td colspan="2" align="center" style="border-left: hidden; border-bottom: hidden; border-right: hidden; padding: 30px 0;">
				    <input type="button" value="제품등록" id="btnRegister" style="width: 120px; background-color:#2c4459; color: white;" class="btn btn-lg mr-5" /> 
				    <input type="reset" value="취소"  style="width: 120px; background-color: #2c4459; color: white;" class="btn btn-lg" />	
				</td>
			</tr>
		</tbody>
		</table>
		
	</form>

</div>
