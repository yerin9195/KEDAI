<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
   String ctxPath = request.getContextPath();
%>

 <style type="text/css">
      .header { 
            display: flex; 
            justify-content: space-between; 
            align-items: center; 
            margin-right: 15%;
        }

        .date-navigation { 
            display: flex; 
            justify-content: center; 
            align-items: center; 
            padding-left: 45%;
            font-size: 35px;
        }

        .date-navigation button {
            margin: 0 10px; /* 버튼과 텍스트 사이의 간격 추가 */
            background-color: transparent; /* 배경색 제거 */
            border: none; /* 버튼의 기본 테두리 제거 */
            font-size: 35px; /* 버튼의 글자 크기 조정 */
            cursor: pointer; /* 버튼에 커서 포인터 표시 */
        }

        table {         
            border-collapse: collapse; 
            width: 80%;
        }

        th, td { 
            border: 1px solid #ddd; 
            text-align: center;
        }

        th { background-color: #f2f2f2; }
        
        .time-slot:hover {
            background-color: yellow;
            cursor: pointer;
        }

        /* 모달 스타일 */
        .modal-dialog {
            max-width: 800px; /* 원하는 너비로 설정 */
        }
        
        .modal-header, .modal-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .modal-body {
            display: flex;
            flex-direction: column;
            width: auto;
        }

        .form-group {
            margin-bottom: 1rem;
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

        .form-group label {
            display: block;
            margin-bottom: 5px;
        }

        .form-group input, .form-group textarea, .form-group select {
            padding: 8px;
            
        }
        
        .reserveBtn {
            padding: 22px;
        }

        .date-time-group {
            display: flex;
            align-items: center;
        }

        .date-input {
            margin-right: 10px;
            flex: 1;
        }

        .time-input {
            margin-right: 10px;
            width: 80px; /* 시간 입력 필드의 크기 조정 */
            text-align: center;
        }

        .checkbox-label {
            display: inline-block;
            margin-left: 10px;
        }

        .reservee {
            display: inline-block;
            background-color: #e0e0e0;
            padding: 5px 10px;
            border-radius: 5px;
        }

        .change-btn {
            margin-left: 10px;
            cursor: pointer;
        }
    </style>
 
 <script type="text/javascript">
 $(document).ready(function(){
	showallsub();
	setToday();
    
	//////////////////////////////////////////////////////////////////////////////////////////////////////
	  function populateTimeSelect() {
        var hourHtml = "";
        for (var i = 9; i <= 21; i++) {
            hourHtml += "<option value='" + (i < 10 ? '0' + i : i) + "'>" + (i < 10 ? '0' + i : i) + "</option>";
        }
        $("select#startHour, select#endHour").html(hourHtml);

        var minuteHtml = "";
        for (var i = 0; i < 60; i += 30) {
            minuteHtml += "<option value='" + (i < 10 ? '0' + i : i) + "'>" + (i < 10 ? '0' + i : i) + "</option>";
        }
        $("select#startMinute, select#endMinute").html(minuteHtml);
    }    
    populateTimeSelect(); // 시간과 분 드롭다운 초기화

	
 // '종일' 체크박스 클릭 시
    $("#allDay").click(function() {
        var isChecked = $(this).is(":checked");
        if (isChecked) {
            $("#startHour, #startMinute, #endHour, #endMinute").val("00").prop("disabled", true);
        } else {
            $("#startHour, #startMinute, #endHour, #endMinute").prop("disabled", false);
        }
    });

	
	///////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	$("#startDate").datepicker({
        onSelect: function(dateText) {
            const selectedDate = $(this).datepicker("getDate");
            const formattedDate = formatDate(selectedDate);
            $(this).val(formattedDate); // 선택한 날짜를 예약일(input id="startDate")에 설정
        }
    });


	   $("#endDate").datepicker({
	        onSelect: function(dateText) {
	        	 const selectedDate = $(this).datepicker("getDate");
	             const formattedDate = formatDate(selectedDate);
	             $(this).val(formattedDate); // 선택한 날짜를 예약일(input id="startDate")에 설정
	        }
	    });
	   
    // 예약 버튼 클릭 시 모달 보이기
 $(document).on("click", ".reserveBtn", function() {
            var hour = $(this).data('hour');
            var minute = $(this).data('minute');

            var formattedTime = (hour < 10 ? '0' : '') + hour + ":" + (minute === 0 ? "00" : minute);

            $("#reservationModal").modal("show");
            $("#reservationModal .modal-title").text("예약: " + $(this).closest('tr').find("td:first").text());
            $("#startDate").val($("#currentDate").text());
            $("#endDate").val($("#currentDate").text());
            $("#startHour").val(hour);
            $("#startMinute").val(minute);
            $("#endHour").val(hour);
            $("#endMinute").val(minute);
        });

        $(".reserveBtn").on("click", function() {
            var hour = $(this).data('hour');
            var minute = $(this).data('minute');
            var formattedTime = (hour < 10 ? '0' : '') + hour + ":" + (minute === 0 ? "00" : minute);
            $("#startTime").val(formattedTime);
            $("#endTime").val(formattedTime);
        });
        
        
     // 예약 정보 로드
        function loadReservations() {
            var currentDate = $("#currentDate").text();
            $.ajax({
                url: '/getReservations', // 서버에서 예약 정보를 가져오는 URL
                method: 'GET',
                data: { date: currentDate },
                success: function(data) {
                    updateTable(data);
                }
            });
        }
     
     
     
    $(document).on("click", "#startDate", function() {
   	    // currentDate 버튼의 텍스트를 startDate input 필드에 설정
   	            // 예약일(input id="startDate") 클릭 시 달력 보이기
       	$("#startDate").datepicker("show");
   	    var currentDateText = document.getElementById('currentDate').innerText;
   	    document.getElementById('startDate').value = currentDateText;
   	});
    
    $(document).on("click", "#endDate", function() {
   	    // currentDate 버튼의 텍스트를 startDate input 필드에 설정
   	            // 예약일(input id="startDate") 클릭 시 달력 보이기
       	$("#endDate").datepicker("show");
   	    var currentDateText = document.getElementById('currentDate').innerText;
   	    document.getElementById('endDate').value = currentDateText;
   	});
    

    $(".close, #reserveCancel").on("click", function() {
        $("#reservationModal").hide();
    });

    $(".datepicker").datepicker({
        dateFormat: "yy-mm-dd"
    });

/*     $(".timepicker").timepicker({
        timeFormat: "HH:mm",
        interval: 30,
        minTime: "09:00",
        maxTime: "21:30",
        dynamic: false,
        dropdown: true,
        scrollbar: true
    }); */

    
    
    // 오늘 날짜 설정
    const today = new Date();
    const formattedToday = formatDate(today);
    $("#currentDate").text(formattedToday);
    $("#startDate").val(formattedToday); // 예약일(input id="startDate")에 오늘 날짜 설정
    $("#endDate").val(formattedToday);
	
     
     $("#assetSelect").change(function() {
         var selectedRoomMainSeq = $(this).val(); // 선택된 roomMainSeq 값 가져오기
		//	console.log(selectedRoomMainSeq);
         
         
         // 선택된 값이 존재할 때만 AJAX 요청 보내기
         if(selectedRoomMainSeq == '전사 자산 목록'){
        	 selectedRoomMainSeq = '0';
        	showallsub();
         }
         
         if (selectedRoomMainSeq > 1) {
        	 $.ajax({
        	        url: "<%= request.getContextPath() %>/roommain.kedai?roomMainSeq=" + selectedRoomMainSeq,
        	        type: "GET",
        	        dataType: "json",
        	        success: function(json) {
        	        	var tableBody = $("#assetTableBody");
                        tableBody.empty(); // 기존 테이블 내용 초기화
                        for (var i = 0; i < json.length; i++) {
                            var roomSubSeq = json[i].roomSubSeq;
                            var roomSubName = json[i].roomSubName;
                            var row = $("<tr>");
                            var leftCell = $("<td>");
                            leftCell.text(roomSubName);
                            row.append(leftCell);
                            for (var hour = 9; hour <= 21; hour++) {
                                var cell1 = $("<td>").addClass("time-slot").append("<button class='reserveBtn'></button>");
                                var cell2 = $("<td>").addClass("time-slot").append("<button class='reserveBtn'></button>");
                                row.append(cell1);
                                row.append(cell2);
                            }
                            tableBody.append(row);
                        }
        	        },
        	        error: function(request, status, error) {
        	            alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
        	        }
        	    });
         } else {
             // 선택이 해제된 경우, 두 번째 선택 박스 초기화
             $("#additionalSelect").html("");
         }
     });
     
     // 시간 슬롯 클릭 이벤트 추가
     $(document).on("click", ".time-slot button", function() {
         var cell = $(this).closest("td");
         var row = cell.closest("tr");
         var assetName = row.find("td:first").text();

         // 클릭된 버튼의 data-hour와 data-minute 값을 가져옵니다.
         var hour = $(this).data('hour');
         var minute = $(this).data('minute');

         // 시간 포맷팅
         var formattedTime = (hour < 10 ? '0' : '') + hour + ":" + (minute === 0 ? "00" : minute);

         $("#reservationModal").modal("show");
         $("#reservationModal .modal-title").text("예약: " + assetName);
         $("#startTime").val(formattedTime);
         $("#endTime").val(formattedTime); // 필요에 따라 종료 시간을 설정합니다.
     });

     // 모달 내 예약일자 및 시간 초기화
     $(".reserveBtn").on("click", function() {
         var hour = $(this).data('hour');
         var minute = $(this).data('minute');
         var formattedTime = (hour < 10 ? '0' : '') + hour + ":" + (minute === 0 ? "00" : minute);
         $("#startTime").val(formattedTime);
         $("#endTime").val(formattedTime);
     });
     
 });
    


 
 // Ajax로 자산 목록 가져오기
	$.ajax({
	    url: "<%= ctxPath %>/roommain.kedai",
	    type: "GET",
	    dataType: "json", // 반환되는 데이터 타입 (JSON 형식)
	    success: function(json) {
	        var options = "<option>전사 자산 목록</option>";
	        for (var i = 0; i < json.length; i++) {
	            options += "<option value='" + json[i].roomMainSeq + "'>" + json[i].roomMainName + "</option>";
	        }
	        $("#assetSelect").html(options); // id가 assetSelect인 select 태그에 옵션들을 추가
	        
	        
	    },
	    error: function(request, status, error) {
	        alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
	    }
	});




	 function changeDate(days) {
		 const currentDateElement = document.getElementById('currentDate');
		    const currentDateText = currentDateElement.innerText;
		    const currentDate = new Date(currentDateText);

		    currentDate.setDate(currentDate.getDate() + days);

		    const formattedDate = formatDate(currentDate);
		    currentDateElement.innerText = formattedDate;

		    // startDate와 endDate도 현재 날짜로 업데이트
		    document.getElementById('startDate').value = formattedDate;
		    document.getElementById('endDate').value = formattedDate;
	 }
	 
	 

	 function formatDate(date) {
	     const year = date.getFullYear();
	     const month = ('0' + (date.getMonth() + 1)).slice(-2);
	     const day = ('0' + date.getDate()).slice(-2);
	     const dayOfWeek = ['일', '월', '화', '수', '목', '금', '토'][date.getDay()];
	     return year + '-' + month + '-' + day + ' (' + dayOfWeek + ')';
	 }
	
	 function showModal(asset, time) {
	     alert(`예약: ${asset} - ${time}`);
	 }
	
	  // 오늘 날짜 설정
	    function setToday() {
	        const today = new Date();
	        const formattedToday = formatDate(today);
	        $("#currentDate").text(formattedToday);
	        $("#startDate").val(formattedToday);
	        $("#endDate").val(formattedToday);
	    }

	    function changeDate(days) {
	        const currentDateElement = $("#currentDate");
	        const currentDateText = currentDateElement.text().split(' ')[0];
	        const currentDate = new Date(currentDateText);
	        currentDate.setDate(currentDate.getDate() + days);

	        const formattedDate = formatDate(currentDate);
	        currentDateElement.text(formattedDate);

	        // startDate와 endDate도 현재 날짜로 업데이트
	        $("#startDate").val(formattedDate);
	        $("#endDate").val(formattedDate);
	    }

	    function formatDate(date) {
	        const year = date.getFullYear();
	        const month = ('0' + (date.getMonth() + 1)).slice(-2);
	        const day = ('0' + date.getDate()).slice(-2);
	        const dayOfWeek = ['일', '월', '화', '수', '목', '금', '토'][date.getDay()];
	        return year + '-' + month + '-' + day + ' (' + dayOfWeek + ')';
	    }

	    // 초기 날짜 설정
	    setToday();

	    // 날짜 변경 버튼 클릭 핸들러
	    $(document).on("click", "[data-change-date]", function() {
	        const days = parseInt($(this).attr("data-change-date"));
	        changeDate(days);
	    });
	  
 	function showallsub(){
 		$.ajax({
 	        url: "<%= ctxPath %>/roomall.kedai",
 	        type: "GET",
 	        dataType: "json", // 반환되는 데이터 타입 (JSON 형식)
 	        success: function(json) {
 	            var tableBody = $("#assetTableBody");
 	            tableBody.empty(); // 기존 테이블 내용 초기화
 	            for (var i = 0; i < json.length; i++) {
 	                var roomSubSeq = json[i].roomSubSeq;
 	                var roomSubName = json[i].roomSubName;
 	                var row = $("<tr>");
 	                var leftCell = $("<td>");
 	                leftCell.text(roomSubName);
 	                row.append(leftCell);
 	                for (var hour = 9; hour <= 21; hour++) {
 	                    var cell1 = $("<td>").addClass("time-slot").append("<button class='reserveBtn' data-hour='" + hour + "' data-minute='00'></button>");
 	                    var cell2 = $("<td>").addClass("time-slot").append("<button class='reserveBtn' data-hour='" + hour + "' data-minute='30'></button>");
 	                    row.append(cell1);
 	                    row.append(cell2);
 	                }
 	                tableBody.append(row);
 	            }
 	        },
 	        error: function(request, status, error) {
 	            alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
 	        }
 	    
 	    });
 	
 		
 	}
 	
 </script>

 <div class="header">
        <div class="title">
            <h3 style="margin-top: 20%;">예약</h3>
        </div>
    </div>
    <div style="width: 85%; background-color:grey;">
        <div class="assets">
            <select id="assetSelect">
                <option>전사 자산 목록</option>
            </select>
            <hr />
        </div>
    </div>
    <br>
    <div class="header">
        <div class="date-navigation">
            <button onclick="changeDate(-1)">&lt;</button>
            <button onclick="currentDate()" id="currentDate"></button>
            <button onclick="changeDate(1)">&gt;</button>
            <button onclick="setToday()" style="font-size: 10pt;">오늘</button>
        </div>
    </div>
    <div id="datepicker" style="display:none;"></div>
    <table>
        <thead>
             <tr>
            <td></td>
            <c:forEach var="hour" begin="9" end="21">
                <th colspan="2">${hour}</th>
            </c:forEach>

        </tr>
        <tr>
            <c:forEach var="hour" begin="9" end="21">
            </c:forEach>
        </tr>
        </thead>
        <tbody id="assetTableBody">
            <!-- 여기에 예약 가능한 자산 목록을 Ajax로 가져오기 -->
        </tbody>
    </table>
    <hr style="margin-top: 1%; width: 85%;" />
    
   <!-- 모달 -->
    <div class="modal" id="reservationModal">
        <div class="modal-dialog">
            <div class="modal-content">

                <!-- 모달 헤더 -->
                <div class="modal-header">
                    <h4 class="modal-title">예약</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>

                <!-- 모달 바디 -->
                <div class="modal-body">
                      <form id="reservationForm">
                    <div class="form-group">
                        <label for="reservationDate">예약일</label>
                        <div class="date-time-group">
                            <input type="text" id="startDate" class="date-input" readonly>
                            <select id="startHour" class="time-select"></select>
                            :
                            <select id="startMinute" class="time-select"></select>
                            ~
                            <input type="text" id="endDate" class="date-input" readonly>
                            <select id="endHour" class="time-select"></select>
                            :
                            <select id="endMinute" class="time-select"></select>
                        </div>
                        <label for="allDay" class="checkbox-label">
                            <input type="checkbox" id="allDay"> 종일
                        </label>
                    </div>
                    <div class="form-group">
                        <label for="reserver">예약자</label>
                        <input type="text" class="form-control" id="reserver" value="${sessionScope.loginuser.name} ${sessionScope.loginuser.job_name}" readonly/>
                    </div>
                    <div class="form-group">
                        <label for="purpose">목적</label>
                        <input type="text" class="form-control" id="purpose">
                    </div>
                </form>
                </div>

                <!-- 모달 푸터 -->
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary">확인</button>
                    <button type="button" class="btn btn-secondary" id="reserveCancel" data-dismiss="modal">취소</button>
                </div>

            </div>
        </div>
    </div>

    
    
</body>
</html>
