<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
   // 컨텍스트 패스명(context path name)을 알아오고자 한다.
   String ctxPath = request.getContextPath();

%>
<!-- Kakao Maps API -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f8cd36a9ca80015c17a395ab719b2d8d&libraries=services,places"></script>
<link href="<%= ctxPath %>/resources/css/jquery.timepicker.min.css" rel="stylesheet" />
<script src="<%= ctxPath %>/resources/js/jquery.timepicker.min.js"></script>

<style type="text/css">
   table#tblProdInput {border: solid #2c4459; 1px; 
                       border-collapse: collapse; }
                       
    table#tblProdInput td {border: solid #2c4459; 1px; 
                           padding: 10px;}
                          
    .prodInputName {background-color: #e68c0e; 
                    font-weight: bold; }                                                 
   
   .error {color: red; font-weight: bold; font-size: 9pt;}

/* Modal styles */
   .modal {
       display: none; /* Hidden by default */
       position: fixed; /* Stay in place */
       z-index: 1; /* Sit on top */
       left: 0;
       top: 0;
       width: 100%; /* Full width */
       height: 100%; /* Full height */
       overflow: auto; /* Enable scroll if needed */
       background-color: rgb(0,0,0); /* Fallback color */
       background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
       padding-top: 60px;
   }
   .modal-content {
       background-color: #fefefe;
       margin: 5% auto; /* 15% from the top and centered */
       padding: 20px;
       border: 1px solid #888;
       width: 80%; /* Could be more or less, depending on screen size */
   }
   .close {
       color: #aaa;
       float: right;
       font-size: 28px;
       font-weight: bold;
   }
   .close:hover,
   .close:focus {
       color: black;
       text-decoration: none;
       cursor: pointer;
   }
   #map {
       width: 100%;
       height: 400px;
       margin-top: 10px;
   }
   #results {
       list-style: none;
       padding: 0;
       max-height: 200px;
       overflow-y: auto;
       margin-top: 10px;
   }
   #results li {
       padding: 10px;
       border-bottom: 1px solid #ddd;
       cursor: pointer;
   }
   #results li:hover {
       background-color: #f0f0f0;
   }
   .selectButton {
    display: none;
    margin-left: 10px;
    padding: 5px;
    background-color: #007BFF;
    color: white;
    border: none;
    cursor: pointer;
   }
</style>

<script type="text/javascript">

$(document).ready(function(){
   
	   
    $('span.error').hide();

    $("input:text[name='email']").click(function(){ alert("이메일은 변경 불가합니다.");});
    $("input:text[name='name']").click(function(){alert("사원명은 변경 불가합니다.");});
    $("input:text[name='departure_name']").click(function(){ alert("출발지 이름은 검색기능을 통해 이용 가능합니다.");});
    $("input:text[name='departure_address']").click(function(){ alert("출발지 주소는 검색기능을 통해 이용 가능합니다.");});
    $("input:text[name='arrive_name']").click(function(){alert("도착지 이름은 검색기능을 통해 이용 가능합니다.");});
    $("input:text[name='arrive_address']").click(function(){alert("도착지 주소는 검색기능을 통해 이용 가능합니다.");});
    
    
	var modal = document.getElementById("mapModal");
    var btn = document.getElementById("arrive_zipcodeSearch");
    var span = document.getElementsByClassName("close")[0];
    var searchButton = document.getElementById('searchButton');
    var selectedPlace = null;

    // 모달 display 속성 변경 추적
    Object.defineProperty(modal.style, 'display', {
        set: function(value) {
            console.log('Modal display changed to:', value);
            this.setProperty('display', value);
        }
    });
    
    // 모달 열기
    btn.onclick = function() {
        modal.style.display = "block";
        initializeMap();
        console.log('Modal opened');
    }

    // 모달 닫기
    span.onclick = function() {
        modal.style.display = "none";
    }

    // 모달 외부 클릭 시 닫기
    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }


    if (typeof kakao === 'undefined' || !kakao.maps) {
        console.error('Failed to load Kakao Maps API');
        return;
    }


    var map;
    var ps;
    var markers = [];
    
    function initializeMap() {
        var mapContainer = document.getElementById('map'); 
        var mapOption = { 
            center: new kakao.maps.LatLng(37.566535, 126.97796919999996), 
            level: 3 
        }; 

        map = new kakao.maps.Map(mapContainer, mapOption); 

        if (!kakao.maps.services) {
            console.error('Kakao Maps services library not loaded');
            return;
        }

        ps = new kakao.maps.services.Places(); 
        
    }

    // 검색 버튼 클릭 이벤트 핸들러
    searchButton.onclick = function(clickEvent) {
        var buildingName = document.getElementById('buildingName').value;
//      console.log('Searching for:', buildingName);
        ps.keywordSearch(buildingName, placesSearchCB);
        clickEvent.preventDefault();      
        clickEvent.stopPropagation();
    };


    function placesSearchCB(data, status, pagination) {
        if (status === kakao.maps.services.Status.OK) {
            console.log('Search successful:', data);
            var resultsList = document.getElementById('results');
            resultsList.innerHTML = '';
            var bounds = new kakao.maps.LatLngBounds();
            
         // Clear existing markers
            clearMarkers();
         
            data.forEach(function(place) {
                var li = document.createElement('li');
//              console.log('li successful:', li);
                li.textContent = place.place_name;
                var selectButton = document.createElement('button');
                selectButton.textContent = '선택';
                selectButton.className = 'selectButton';
                selectButton.onclick = function() {
                    alert('Selected: ' + place.place_name + place.road_address_name);
                    showPlaceInfo(place);
                };

                li.appendChild(selectButton);
                li.onclick = function() {
                    map.setCenter(new kakao.maps.LatLng(place.y, place.x));
                    clearMarkers();
                    displayMarker(place);
                    document.querySelectorAll('.selectButton').forEach(function(button) {
                        button.style.display = 'none';
                    });
                    selectButton.style.display = 'inline';
                };
                resultsList.appendChild(li);
                
                // Display marker for each place
                var marker = displayMarker(place);
                markers.push(marker);
                bounds.extend(new kakao.maps.LatLng(place.y, place.x));
            });
            // Adjust map bounds to show all markers
            map.setBounds(bounds);
            
        } else {
            console.error('Failed to find the location:', status);
        }
    }
    function displayMarker(place) {
        var marker = new kakao.maps.Marker({
            map: map,
            position: new kakao.maps.LatLng(place.y, place.x)
        });

        kakao.maps.event.addListener(marker, 'click', function() {
            var infowindow = new kakao.maps.InfoWindow({
                content: '<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>'
            });
            infowindow.open(map, marker);
        });
        return marker;
    }
    function clearMarkers() {
        markers.forEach(function(marker) {
            marker.setMap(null);
        });
        markers = [];
    }
    function showPlaceInfo(place) {
        console.log(place);
        var place_name = place.place_name;
        var road_address_name = place.road_address_name;
        $("input[name='departure_name']").val(place_name);		
		$("input[name='departure_address']").val(road_address_name);

    }
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
   $('input#datepicker_start').datepicker({
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
   $('input#datepicker_end').datepicker({
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
   $('#startTime').timepicker();
   // 해당 테그에 키보드로 입력 못하도록
   // 키보드로 값을 입력했을 때 즉시 지우는 이벤트 핸들러
   $('#startTime').on('input', function() {
       $(this).val('');
   });
});//end of $(document).ready(function(){})---------------------------------------

//Function Declaration
//"등록하기" 버튼 클릭시 호출되는 함수
function goRegister() {
	// *** 필수입력사항에 모두 입력이 되었는지 검사하기 시작 *** //
	let b_requiredInfo = true;
	
// 등록하기 버튼 클릭시 정원,기간이 제대로 입력되었는지 출발지, 도착지를 검사한다.
    var selectElement = document.getElementById('fk_cnum');
    var selectedValue = selectElement.options[selectElement.selectedIndex].value;
//  console.log("~~~ 확인용 :"+ selectedValue);
	if(selectedValue == ""){
		b_requiredInfo = false;
	}
	
   	var datepicker_start =  document.getElementById('datepicker_start').value;
   	var datepicker_end =  document.getElementById('datepicker_end').value;
   

   	// 기간 제약조건(시작일자가 끝나는 일자보다 이전이면 안된다.)
   	if(datepicker_start > datepicker_end){
      	$('span.period').show();
      	$('input#datetimepicker1').val("");
      	$('input#datetimepicker2').val("");
      	$('input#datetimepicker1').focus();
      	return;
	 }
	
	 // *** 약관에 동의를 했는지 검사하기 시작 *** //
	 const checkbox_checked_length = $("input:checkbox[id='agree']:checked").length; 
	
	 if(checkbox_checked_length == 0) {
	     alert("이용약관에 동의하셔야 합니다.");
	      return; // goRegister() 함수를 종료한다.
	 }
	 // *** 약관에 동의를 했는지 검사하기 끝 *** //
	
	 const requiredInfo_list = document.querySelectorAll("input.requiredInfo"); 
	 for(let i=0; i<requiredInfo_list.length; i++){
	     const val = requiredInfo_list[i].value.trim();
	     if(val == ""){
	         alert("모든 항목을 입력하셔야 합니다. (약관 동의 필수)");
	         b_requiredInfo = false;
	         break; 
	     }
	 }// end of for-----------------

	 if(!b_requiredInfo) {
	     return; // goRegister() 함수를 종료한다.
	 }
	 // *** 필수입력사항에 모두 입력이 되었는지 검사하기 끝 *** //
	
	 
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
               <select name="fk_cnum" id="fk_cnum" class="infoData" style="padding: 5px;">
                  <option value="">:::선택하세요:::</option>
                     <option value="1">1</option>
                     <option value="2">2</option>
                     <option value="3">3</option>
                     <option value="4">4</option>
               </select>
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
                   <input type="text" name="start" id="datepicker_start" maxlength="10" value="" style="padding: 5px;" placeholder = "시작일자" readonly/><span>&nbsp;~&nbsp;</span>
                   <input type="text" name="last" id="datepicker_end" maxlength="10" value="" style="padding: 5px;" placeholder = "종료일자" readonly/>
                   <span class="error period">종료일자가 시작일자보다 이전이면 안됩니다.</span>
                </td>
            </tr>
          <tr>
                <td class="prodInputName">출발시간&nbsp;</td>
                <td style="border-top: hidden; border-bottom: hidden;">
                <input type="text" name="startTime" id="startTime" style="padding: 5px;" value="" placeholder="출발시간"/>
                </td>
          </tr>
		<tr>
            <td width="25%" class="prodInputName">출발지</td>
            <td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
               <input type="text" name="departure_name" id="departure_name" class="requiredInfo" size="40" maxlength="40" style="padding: 5px;" placeholder="출발지 이름" readonly/>&nbsp;&nbsp;
			   <button type="button" style="background-color: white; padding: 5px;" id="arrive_zipcodeSearch"><i class="fa-solid fa-magnifying-glass"></i></button><br>
			   <input type="text" name="departure_address" id="departure_address" class="requiredInfo" size="80" maxlength="80" style="padding: 5px;" placeholder="출발지 주소" readonly/> 
               <!-- 출발지 이름에서 주소를 가지고 온 값을 넣어주고 수정 불가능하다. -->
                <!-- The Modal start -->
                <div id="mapModal" class="modal">
                    <!-- Modal content -->
                    <div class="modal-content">
                        <span class="close">&times;</span>
                        <input type="text" id="buildingName" placeholder="Enter building name">
                        <button id="searchButton">Search</button>
                        <div id="map"></div>
                        <ul id="results"></ul>
                    </div>
                </div>
                <!-- The Modal end -->
            </td>
         </tr>
         <tr>
            <td width="25%" class="prodInputName">도착지</td>
            <td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
               <input type="text" name="arrive_name" id="arrive_name" class="requiredInfo" size="40" maxlength="40" style="padding: 5px;" placeholder="도착지 이름" readonly/>&nbsp;&nbsp;
               <button type="button" style="background-color: white; padding: 5px;" id="arrive_zipcodeSearch"><i class="fa-solid fa-magnifying-glass"></i></button><br>
               <input type="text" name="arrive_address" id="arrive_address" class="requiredInfo" size="80" maxlength="80" style="padding: 5px;" placeholder="도착지 주소" readonly/> 
               <!-- 출발지 이름에서 주소를 가지고 온 값을 넣어주고 수정 불가능하다. -->
               
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
                <input type="button" value="등록하기" id="btnRegister" onclick = "goRegister()" style="width: 120px; background-color:#2c4459; color: white;" class="btn btn-lg mr-5" /> 
                <input type="button" value="뒤로가기" onclick="cancel()" style="width: 120px; background-color: #2c4459; color: white;" class="btn btn-lg" />   
            </td>
         </tr>
      </tbody>
      </table>
      
   </form>

</div>
