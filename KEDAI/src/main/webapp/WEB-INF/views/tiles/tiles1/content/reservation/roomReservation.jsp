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
      width: 85%;
     
     }
     th, td { 
      border: 1px solid #ddd; 
      padding: 15px; 
      text-align: center;
     }
     th { background-color: #f2f2f2; }
     
     .time-slot:hover{
     		background-color: yellow;
     		cursor: pointer;
     }
     
       /* 모달 스타일 */
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            padding-top: 100px;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgb(0,0,0);
            background-color: rgba(0,0,0,0.4);
        }

        .modal-content {
            background-color: #fefefe;
            margin: auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
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

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
        }

        .form-group input, .form-group textarea, .form-group select {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
        }
     
 </style>
 
 <script type="text/javascript">
 $(document).ready(function(){
	showallsub();
 
 
     $("#datepicker").datepicker({
         dateFormat: "yy-mm-dd",
         onSelect: function(dateText) {
             const date = new Date(dateText);
             document.getElementById('currentDate').innerText = formatDate(date);
         }
     });
     const today = new Date();
     document.getElementById('currentDate').innerText = formatDate(today);
     
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
                                var cell1 = $("<td>").addClass("time-slot").append("<button class='reserveBtn'>예약</button>");
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
     
     $(document).on("click", ".reserveBtn", function() {
         $("#reservationModal").show();
     });

     $(".close, #reserveCancel").on("click", function() {
         $("#reservationModal").hide();
     });

     $(".datepicker").datepicker({
         dateFormat: "yy-mm-dd"
     });

     $(".timepicker").timepicker({
         timeFormat: "HH:mm",
         interval: 30,
         minTime: "09:00",
         maxTime: "21:30",
         dynamic: false,
         dropdown: true,
         scrollbar: true
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


 
 function currentDate(){
     $("#datepicker").datepicker("show");
 }

 function changeDate(days) {
     const currentDateText = document.getElementById('currentDate').innerText.replace(/[<>]/g, '').trim();
     const currentDate = new Date(currentDateText);
     currentDate.setDate(currentDate.getDate() + days);
     document.getElementById('currentDate').innerText = formatDate(currentDate);
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

 function setToday() {
     const today = new Date();
     document.getElementById('currentDate').innerText = formatDate(today);
 }
  // test
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
                         var cell1 = $("<td>").addClass("time-slot").attr("data-hour", hour).text("예약");
                         var cell2 = $("<td>").addClass("time-slot").attr("data-hour", hour).text("예약");
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
 	
 	function changeDate(delta) {
 	    // 날짜 변경 로직
 	}

 	function currentDate() {
 	    // 현재 날짜 설정 로직
 	}

 	function setToday() {
 	    // 오늘 날짜 설정 로직
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
<div id="reservationModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h2>예약</h2>
        <div class="form-group">
            <label for="reservationDate">예약일:</label>
            <input type="text" id="reservationDate" class="datepicker">
        </div>
        <div class="form-group">
            <label for="startTime">시작 시간:</label>
            <input type="text" id="startTime" class="timepicker">
        </div>
        <div class="form-group">
            <label for="endTime">종료 시간:</label>
            <input type="text" id="endTime" class="timepicker">
        </div>
        <div class="form-group">
            <label><input type="checkbox" id="allDay"> 종일</label>
        </div>
        <div class="form-group">
            <label for="reserver">예약자:</label>
            <input type="text" id="reserver" value="<%= session.getAttribute("name") %>" readonly>
        </div>
        <div class="form-group">
            <label for="purpose">목적:</label>
            <textarea id="purpose"></textarea>
        </div>
        <div class="form-group">
            <button id="reserveConfirm">확인</button>
            <button id="reserveCancel">취소</button>
        </div>
    </div>
</div>
    
    
</body>
</html>
