<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>회의실 예약</title>
   <style>
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

         // 초기 날짜 설정
         const today = new Date();
         document.getElementById('currentDate').innerText = formatDate(today);
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

    // 날짜 형식화 함수
    function formatDate(date) {
        const year = date.getFullYear();
        const month = ('0' + (date.getMonth() + 1)).slice(-2);
        const day = ('0' + date.getDate()).slice(-2);
        const dayOfWeek = ['일', '월', '화', '수', '목', '금', '토'][date.getDay()];
        return year + '-' + month + '-' + day + ' (' + dayOfWeek + ')';
    }

    function showModal(asset, time) {
        alert(`예약: ${asset} - ${time}`);
        // 여기서 실제 모달을 띄우는 코드를 작성하세요.
    }
    
    function setToday() {
        const today = new Date();
        document.getElementById('currentDate').innerText = formatDate(today);
    }
    
   </script>
</head>
<body>
    <div class="header">
        <div class="title">
            <h3 style="margin-top: 20%;">예약</h3>
        </div>
    </div>
    
    <div style="width: 85%; background-color:grey;">
    	 <div class="assets">
           <select>
               <option>전사 자산 목록</option>
               <option>1층 회의실</option>
               <option>2층 회의실</option>
               <!-- 더 많은 자산을 여기에 추가하세요 -->
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
		    
       </thead>
       <tbody>
          <% 
                // 자산 목록을 배열로 정의
                String[] assets = {"1층 회의실", "2층 회의실"};
                // 자산 목록을 반복하여 테이블 행 생성
                for(String asset : assets) {
            %>
            <tr>
                <td><%= asset %></td>
                <c:forEach var="hour" begin="9" end="21">
                    <td class="time-slot" onclick="showModal('<%= asset %>', '${hour}:00')"></td>
                    <td class="time-slot" onclick="showModal('<%= asset %>', '${hour}:30')"></td>
                </c:forEach>
            </tr>
            <% } %>
            
        </tbody>
    </table>
    <hr style="margin-top: 1%; width: 85%;" />
    <div>
    	
    </div>
</body>
</html>
