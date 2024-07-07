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

<script type="text/javascript">

//"우편번호찾기" 를 클릭했는지 클릭을 안했는지 여부를 알아오기 위한 용도  
let b_zipcodeSearch_click = false;

$(document).ready(function(){
   
   // 모든 에러 메세지는 숨긴 상태에서 하나씩 show 해줄거임
   $('span.error').hide();
	
	$("input:text[name='name']").click(function(){
		alert("사원명은 변경 불가합니다.");
	})
	$("input:text[name='email']").click(function(){
		alert("이메일은 변경 불가합니다.");
	})
	

	
// === "출발지 우편번호찾기"를 클릭했을 때 이벤트 처리하기 === //
   $("button#departure_zipcodeSearch").click(function(){
	
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
                   document.getElementById("departure_extraAddress").value = extraAddr;
               
               } else {
                   document.getElementById("departure_extraAddress").value = '';
               }

               // 우편번호와 주소 정보를 해당 필드에 넣는다.
               document.getElementById('departure_postcode').value = data.zonecode;
               document.getElementById("departure_address").value = addr;
               // 커서를 상세주소 필드로 이동한다.
               document.getElementById("departure_detailAddress").focus();
           }
       }).open();
   

   
});// end of $("img#zipcodeSearch").click()------------

//=== "도착지 우편번호찾기"를 클릭했을 때 이벤트 처리하기 === //
$("button#arrive_zipcodeSearch").click(function(){
	
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
                document.getElementById("arrive_extraAddress").value = extraAddr;
            
            } else {
                document.getElementById("arrive_extraAddress").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('arrive_postcode').value = data.zonecode;
            document.getElementById("arrive_address").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("arrive_detailAddress").focus();
        }
    }).open();



});// end of $("img#zipcodeSearch").click()------------

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
   
   // 시작 값이 오늘보다 이전인 경우 오류 메세지 띄우기 수정
   // $('input#datepicker1').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)
   
   

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

   ///////////////////////////////////////////////////////////////////////
   
   $('input#datepicker2').bind("change", (e) => {
       if( $(e.target).val() != "") {
           $(e.target).next().hide();
       }
   });
	
///////////////////////////////////////////////////////
});//end of $(document).ready(function(){})---------------------------------------

//Function Declaration
//"등록하기" 버튼 클릭시 호출되는 함수
function goRegister() {
// 등록하기 버튼 클릭시 정원,기간이 제대로 입력되었는지 출발지, 도착지를 검사한다.
 // *** 필수입력사항에 모두 입력이 되었는지 검사하기 시작 *** //
 let b_requiredInfo = true;

	var datepicker1 =  document.getElementById('datepicker1').value;
	alert("~~~확인용 : "+datepicker1);
/*   
 $("input.requiredInfo").each(function(index, elmt){
     const data = $(elmt).val().trim();
     if(data == ""){
         alert("*표시된 필수입력사항은 모두 입력하셔야 합니다.");
         b_requiredInfo = false;
         return false; // break; 라는 뜻이다.
     }
 });
*/

// 또는
 const requiredInfo_list = document.querySelectorAll("input.requiredInfo"); 
 for(let i=0; i<requiredInfo_list.length; i++){
     const val = requiredInfo_list[i].value.trim();
     if(val == ""){
         alert("모든 항목을 입력하셔야 합니다.");
         b_requiredInfo = false;
         break; 
     }
 }// end of for-----------------

 if(!b_requiredInfo) {
     return; // goRegister() 함수를 종료한다.
 }
 // *** 필수입력사항에 모두 입력이 되었는지 검사하기 끝 *** //


 // *** "우편번호찾기" 를 클릭했는지 검사하기 시작 *** //
 if(!b_zipcodeSearch_click) {
     // "우편번호찾기" 를 클릭 안 했을 경우
      alert("우편번호찾기를 클릭하셔서 우편번호를 입력하셔야 합니다.");
      return; // goRegister() 함수를 종료한다.
 }
 // *** "우편번호찾기" 를 클릭했는지 검사하기 끝 *** //

 // *** 우편번호 및 주소에 값을 입력했는지 검사하기 시작 *** //
   const postcode = $("input#departurepostcode").val().trim();
   const address = $("input#address").val().trim();
   const detailAddress = $("input#detailAddress").val().trim();
   const extraAddress = $("input#extraAddress").val().trim();
   
   if(postcode == "" || address == "" || detailAddress == "" || extraAddress == "") {
      alert("우편번호 및 주소를 입력하셔야 합니다.");
      return; // goRegister() 함수를 종료한다.
   }
   // *** 우편번호 및 주소에 값을 입력했는지 검사하기 끝 *** //





 // *** 생년월일 값을 입력했는지 검사하기 시작 *** //
 const birthday = $('input#datepicker').val().trim();

 if(birthday == ""){
     alert("생년월일을 입력하셔야 합니다.");
      return; // goRegister() 함수를 종료한다.
 }
 // *** 생년월일 값을 입력했는지 검사하기 끝 *** //


 // *** 약관에 동의를 했는지 검사하기 시작 *** //
 const checkbox_checked_length = $("input:checkbox[id='agree']:checked").length; 

 if(checkbox_checked_length == 0) {
     alert("이용약관에 동의하셔야 합니다.");
      return; // goRegister() 함수를 종료한다.
 }
 // *** 약관에 동의를 했는지 검사하기 끝 *** //

 
 const frm = document.registerFrm;
 frm.action = "memberRegister.up";
 frm.method = "post";
 frm.submit();

}// end of function goRegister()---------------------


</script>
<div align="center" style="margin-bottom: 20px;">

   <div style="border: solid #2c4459; 2px; width: 250px; margin-top: 20px; padding-top: 8px; padding-bottom: 8px; border-left: hidden; border-right: hidden;">       
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
               <select name="fk_cnum" class="infoData" style="padding: 5px;">
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
            <td width="25%" class="prodInputName">사원명</td>      <!-- readonly로 받아올것 -->
            <td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;" >
               <input type="text" name="name" style="padding: 5px;" value="${sessionScope.loginuser.name}" readonly />
            </td>
         </tr>
          <tr>
                <td class="prodInputName">이메일&nbsp;</td>
                <td style="border-top: hidden; border-bottom: hidden;">
               <input type="text" name="email" style="padding: 5px;" value="${sessionScope.loginuser.email}" readonly />
                </td>
          </tr>
            <tr>
                <td class="prodInputName">기간</td>
                <td>
                   <input type="text" name="start" id="datepicker1" maxlength="10" value="" style="padding: 5px;" placeholder = "시작일자" readonly/><span>&nbsp;~&nbsp;</span>
                   <input type="text" name="last" id="datepicker2" maxlength="10" value="" style="padding: 5px;" placeholder = "종료일자" readonly/>
                   <span class="error period">종료일자가 시작일자보다 이전이면 안됩니다.</span>
                </td>
            </tr>
         <tr>
            <td width="25%" class="prodInputName">출발지</td>
            <td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
               <input type="text" name="postcode" id="departure_postcode" size="6" maxlength="5" style="padding: 5px;" placeholder="우편번호" readonly/>&nbsp;&nbsp;
                    <%-- 우편번호 찾기 --%>
                    <button type="button" style="background-color: white; padding: 5px;" id="departure_zipcodeSearch"><i class="fa-solid fa-magnifying-glass"></i></button>
                    <span class="error">우편번호 형식에 맞지 않습니다.</span><br>
               <input type="text" name="address" id="departure_address" size="40" maxlength="200" style="padding: 5px;" placeholder="주소" readonly/><br>
                    <input type="text" name="detailaddress" id="departure_detailAddress" size="40" maxlength="200" style="padding: 5px;" placeholder="상세주소" />&nbsp;
                    <input type="text" name="extraaddress" id="departure_extraAddress" size="40" maxlength="200" style="padding: 5px;" placeholder="참고항목" value="" readonly/>                            
                    <span class="error">주소를 입력하세요.</span><span class="error compulsory">필수입력</span>
            </td>
         </tr>
         <tr>
            <td width="25%" class="prodInputName">도착지</td>
            <td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
               <!-- <input type="text" name="postcode" id="arrive_postcode" size="6" maxlength="5" style="padding: 5px;" placeholder="출발지 이름"/>
               <span class="hint">ex)여의도역, 사옥 A건물 B2층 주차장</span><br>
                --><input type="text" name="postcode" id="arrive_postcode" size="6" maxlength="5" style="padding: 5px;" placeholder="우편번호" readonly/>&nbsp;&nbsp;
                    <%-- 우편번호 찾기 --%>
                    <button type="button" style="background-color: white; padding: 5px;" id="arrive_zipcodeSearch"><i class="fa-solid fa-magnifying-glass"></i></button>
                    <span class="error">우편번호 형식에 맞지 않습니다.</span><br>
               <input type="text" name="address" id="arrive_address" size="40" maxlength="200" style="padding: 5px;" placeholder="주소" readonly/><br>
                    <input type="text" name="detailaddress" id="arrive_detailAddress" size="40" maxlength="200" style="padding: 5px;" placeholder="상세주소" />&nbsp;
                    <input type="text" name="extraaddress" id="arrive_extraAddress" size="40" maxlength="200" style="padding: 5px;" placeholder="참고항목" value="" readonly/>                            
                    <span class="error">주소를 입력하세요.</span><span class="error compulsory">필수입력</span>
            </td>
         </tr>
         <tr>
            <td width="25%" class="prodInputName">약관동의</td>
            <td width="75%" align="left" >
               <iframe src="<%= ctxPath%>/iframe_agree/agree.html" width="100%" height="100px" style="border: solid 1px navy;"></iframe>
               <label for="agree">이용약관에 동의합니다.(필수)</label>&nbsp;&nbsp;<input type="checkbox" id="agree" />
            </td>
         </tr>
         <tr style="height: 70px;">
            <td colspan="2" align="center" style="border-left: hidden; border-bottom: hidden; border-right: hidden; padding: 1%;">
                <input type="button" value="등록하기" id="btnRegister" onclick="goRegister()" style="width: 120px; background-color:#2c4459; color: white;" class="btn btn-lg mr-5" /> 
                <input type="reset" value="뒤로가기" onclick="cancel()" style="width: 120px; background-color: #2c4459; color: white;" class="btn btn-lg" />   
            </td>
         </tr>
      </tbody>
      </table>
      
   </form>

</div>
