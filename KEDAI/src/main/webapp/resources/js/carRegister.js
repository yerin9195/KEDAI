

$(document).ready(function(){
	
    $("span.error").hide();

        
        ///////////////////////////////////////////////////////////


        // === "우편번호찾기"를 클릭했을 때 이벤트 처리하기 === //
	    $("button#zipcodeSearch").click(function(){
		
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
        

        
	});// end of $("img#zipcodeSearch").click()------------


    $('input#datepicker').keyup( (e) => {

        $(e.target).val("").next().show();

    });// end of $('input#datepicker').keyup()--------------------


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
   

   
});// end of $(document).ready(function(){})----------------


// Function Declaration
// "가입하기" 버튼 클릭시 호출되는 함수
function goRegister() {

    // *** 필수입력사항에 모두 입력이 되었는지 검사하기 시작 *** //
    let b_requiredInfo = true;

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
            alert("*표시된 필수입력사항은 모두 입력하셔야 합니다.");
            b_requiredInfo = false;
            break; 
        }
    }// end of for-----------------
 
    if(!b_requiredInfo) {
        return; // goRegister() 함수를 종료한다.
    }
    // *** 필수입력사항에 모두 입력이 되었는지 검사하기 끝 *** //


    // *** "아이디중복확인" 을 클릭했는지 검사하기 시작 *** //
    if( !b_idcheck_click ) {
        // "아이디중복확인" 을 클릭 안 했을 경우 
        alert("아이디 중복확인을 클릭하셔야 합니다.");
        return; // goRegister() 함수를 종료한다.
    }
    // *** "아이디중복확인" 을 클릭했는지 검사하기 끝 *** //


    // *** "이메일중복확인" 을 클릭했는지 검사하기 시작 *** //
    if( !b_emailcheck_click ) {
        // "이메일중복확인" 을 클릭 안 했을 경우 
        alert("이메일 중복확인을 클릭하셔야 합니다.");
        return; // goRegister() 함수를 종료한다.
    }
    // *** "이메일중복확인" 을 클릭했는지 검사하기 끝 *** //

   
    // *** "우편번호찾기" 를 클릭했는지 검사하기 시작 *** //
    if(!b_zipcodeSearch_click) {
        // "우편번호찾기" 를 클릭 안 했을 경우
		alert("우편번호찾기를 클릭하셔서 우편번호를 입력하셔야 합니다.");
		return; // goRegister() 함수를 종료한다.
    }
    // *** "우편번호찾기" 를 클릭했는지 검사하기 끝 *** //

    // *** 우편번호 및 주소에 값을 입력했는지 검사하기 시작 *** //
	const postcode = $("input#postcode").val().trim();
	const address = $("input#address").val().trim();
	const detailAddress = $("input#detailAddress").val().trim();
	const extraAddress = $("input#extraAddress").val().trim();
	
	if(postcode == "" || address == "" || detailAddress == "" || extraAddress == "") {
		alert("우편번호 및 주소를 입력하셔야 합니다.");
		return; // goRegister() 함수를 종료한다.
	}
	// *** 우편번호 및 주소에 값을 입력했는지 검사하기 끝 *** //


    // *** 성별을 선택했는지 검사하기 시작 *** //
    const radio_checked_length = $("input:radio[name='gender']:checked").length; 

    if(radio_checked_length == 0) {
        alert("성별을 선택하셔야 합니다.");
		return; // goRegister() 함수를 종료한다.
    }
    // *** 성별을 선택했는지 검사하기 끝 *** //


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


function goReset() {

    $("span.error").hide();

    $("span#idcheckResult").empty();
    $("span#emailCheckResult").empty();
}// end of function goReset()---------------------


function goGaib() {
	alert("회원가입에 대한 유효성검사를 한후에 통과되면 submit 하려고 함");
}

