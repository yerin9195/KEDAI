<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
   String ctxPath = request.getContextPath();
%>

<style type="text/css">>
    table {
          width: 100%;
          border-collapse: collapse;
          
      }
      th, td {
          padding: 10px;
          text-align: left;
          border: 1px solid black;
      }
      .header {
          font-size: 24px;
          font-weight: bold;
      }
      
    
      .full-width {
          width: 100%;
          padding: 10px;
          border-top: 1px solid black; /* 밑줄 얇은 선 */
      }
      
       /* 겉 테두리 스타일 */
      .outer-border {
          border: 3px solid black;
      }
      
      #yearMonth {
      	margin-bottom: 1%;
      	float: right;
      }
      
  </style>

<script type="text/javascript">
	$(document).ready(function(){
		var yearMonth = document.getElementById('yearMonth');
        
        var currentYear = new Date().getFullYear();
        var selectDateSpan = document.getElementById('selectedDate');
        var selectDate;

        // 연도 범위 설정 (예: 1900년부터 2100년까지)
        var startYear = currentYear - 5;
        var endYear = currentYear + 5;

        for (var i = startYear; i <= endYear; i++) {
            for (var j = 1; j <= 12; j++) {
                var month = j < 10 ? '0' + j : j; 
                var option = document.createElement('option');
                option.value = i + '-' + month; // 값은 YYYY-MM 형식으로 설정
                option.textContent = i + '년 ' + month + '월'; // 텍스트는 YYYY년 MM월 형식으로 설정
                yearMonth.appendChild(option);
            }
            
            // 초기 선택값 업데이트
            updateSelectDate();

            // 선택이 변경될 때마다 span 업데이트
            yearMonth.addEventListener('change', updateSelectDate);

            function updateSelectDate() {
                selectDate = yearMonth.value; // 선택된 값을 변수에 저장
                var selectText = yearMonth.options[yearMonth.selectedIndex].text;
                selectDateSpan.innerHTML = selectText + '&nbsp;10일';
            }
        }
	});	//	end of $(document).ready(function(){--------
</script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<div class="container" style="padding: 3%; border: solid 1px red;">

	<select id="yearMonth"></select>
		
    <table class="outer-border">
        <thead>
	        <tr>
	            <td colspan="3" class="header" style="height:100px;">급여명세서</td>
	            <td class="date" style="font-size: 16px; height:100px;">급여지급일 : <span id="selectedDate"></span></td>
	        </tr>
        </thead>
        <tbody style="border: solid 1px black;">
        	<tr>
        	<td colspan="4" class="full-width" style="background-color: grey;">■ 개인 정보</td>
        	</tr>
	        <tr>
		        <td>이름</td>
		        <td>사원1</td>
		        <td>부서</td>
		        <td>개발팀</td>
		    </tr>
		    <tr>
		        <td>직위</td>
		        <td>과장</td>
		        <td>입사일자</td>
		        <td>2021년 07월 01일</td>
		    </tr>
		    
		    <tr>
        	<td colspan="4" class="full-width" style="background-color: grey;">■ 세부 내역</td>
        	</tr>
        	<tr>
		        <td>임금 항목</td>
		        <td>지급 금액</td>
		        <td>공제 항목</td>
		        <td>공제 금액</td>
		    </tr>
		    <tr>
		        <td></td>
		        <td></td>
		        <td></td>
		        <td></td>
		    </tr>
		    <tr>
		        <td></td>
		        <td></td>
		        <td></td>
		        <td></td>
		    </tr>
		    <tr>
		        <td></td>
		        <td></td>
		        <td></td>
		        <td></td>
		    </tr>
        </tbody> 
    </table>
</div>

</body>
</html>

