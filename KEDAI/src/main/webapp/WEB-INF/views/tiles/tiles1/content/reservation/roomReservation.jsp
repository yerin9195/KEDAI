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
     
 </style>
 
 <script type="text/javascript">
 $(document).ready(function(){
     $("#datepicker").datepicker({
         dateFormat: "yy-mm-dd",
         onSelect: function(dateText) {
             const date = new Date(dateText);
             document.getElementById('currentDate').innerText = formatDate(date);
         }
     });
     const today = new Date();
     document.getElementById('currentDate').innerText = formatDate(today);
 });
 
 // Ajax로 자산 목록 가져오기
	 $.ajax({
	    url: "<%= ctxPath %>/roommain.kedai",
	    type: "GET",
	    dataType: "json", // 반환되는 데이터 타입 (JSON 형식)
	    success: function(json) {
	        var options = "<option>전사 자산 목록</option>";
	        for (var i = 0; i < json.length; i++) {
	            options += "<option value='" + json[i].roomMainName + "</option>";
	        }
	        $("#assetSelect").html(options);
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
                    <th colspan="2"> ${hour} </th>
                </c:forEach>
            </tr>
        </thead>
        <tbody>
            <!-- 여기에 예약 가능한 자산 목록을 Ajax로 가져오기 -->
        </tbody>
    </table>
    <hr style="margin-top: 1%; width: 85%;" />
</body>
</html>
