<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
   String ctxPath = request.getContextPath();
%>


<style type="text/css">>
	#myContent > div{
		border: solid 1px blue;
		width: 80%;
		margin-top: 2%;
	}

    table {
        width: 80%;
        border-collapse: collapse;
    }
    th, td {
        border: 1px solid black;
        padding: 8px;
        text-align: center;
    }
    th {
        background-color: #f2f2f2;
    }
    button {
        padding: 5px 10px;
    }
    .header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 10px;
    }
    .header h1 {
        margin: 0;
    }
    .search {
        fliat: right;
        align-items: center;
        width:30%;
    }
    .search input {
         margin-right: 5px;
         padding: 5px;
         width: 200px;
    }
    
   .modal-dialog {
            max-width: 50%;
        }
        
   

</style>

<script type="text/javascript">
	$(document).ready(function(){
		
		const modalClose = document.querySelector('.close_btn');
		
		$('#workListcom_btn').click(function(){
			 $('#modal1').modal("show");
             $("#datepicker").datepicker(); 
		});
		$('#close').click(function(e){
			modal.style.display = "none"
		});
		
		$('#workhis').click(function(e){
			$('#modal2').modal("show");
		});

		 $("#monthpicker").datepicker({
	            dateFormat: 'yy-mm', // 월과 년도 표시 형식 설정
	            changeMonth: true,   // 월 선택 가능
	            changeYear: true,   // 년도 선택 불가능
	            showButtonPanel: true, // 버튼 패널 표시
	            onSelect: function(dateText, inst) {
	                var selectedDate = $(this).datepicker('getDate');
	                var year = selectedDate.getFullYear(); // 선택한 년도 가져오기
	                var month = selectedDate.getMonth() + 1; // 선택한 월 가져오기
	                var weekdays = countWeekdays(year, month); // 평일 수 계산 함수 호출

	                $("#weekdayCount").text("평일 수: " + weekdays);
	            }
	        });
		 
         // 평일 수 계산 함수
          function countWeekdays(year, month) {
        	var weekdays = 0;
            var startDay = new Date(year, month - 1, 1);
            var endDay = new Date(year, month, 0);

            console.log(startDay);
            console.log(endDay);
            
            for (var day = 1; day <= endDay.getDate(); day++) {
                var currentDate = new Date(year, month - 1, day);
                if (currentDate.getDay() >= 1 && currentDate.getDay() <= 5) {
                    weekdays++;
                }
            }

            return weekdays;
        }
		 
	});	//	end of $(document).ready(function(){--------
		
	
	function addNewRow() {
	    const table = document.querySelector('tbody');
	    const newRow = table.insertRow();
	    
	    var today = new Date()
	    let year = today.getFullYear(); // 년도
	    let month = today.getMonth() + 1;  // 월
	    let date = today.getDate();  // 날짜
	    let seq = 1;
	    
	    const cellsContent = [
	        '<button>'+year+month+date+'-'+seq+'</button>',
	        '급여구분',
	        '대장명칭',
	        '지급일',
	        '지급연월',
	        '<button>근무기록확정</button>',
	        '<button>전체계산</button>',
	        '인원수',
	        '<button>조회</button>',
	        '<button>조회</button>',
	        '지급총액'
	    ];
	
	    for (let i = 0; i < cellsContent.length; i++) {
	        const newCell = newRow.insertCell(i);
	        newCell.innerHTML = cellsContent[i];
	        seq++;
	    }
	}
	
	 function datepicker() {
         // 모든 datepicker에 대한 공통 옵션 설정
         $.datepicker.setDefaults({
             dateFormat: 'yy-mm-dd', // Input Display Format 변경
             showOtherMonths: true,  // 빈 공간에 현재월의 앞뒤월의 날짜를 표시
             showMonthAfterYear: true, // 년도 먼저 나오고, 뒤에 월 표시
             changeYear: true,       // 콤보박스에서 년 선택 가능
             changeMonth: true,      // 콤보박스에서 월 선택 가능                
             yearSuffix: "년",       // 달력의 년도 부분 뒤에 붙는 텍스트
             monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'], // 달력의 월 부분 텍스트
             monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'], // 달력의 월 부분 Tooltip 텍스트
             dayNamesMin: ['일','월','화','수','목','금','토'], // 달력의 요일 부분 텍스트
             dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] // 달력의 요일 부분 Tooltip 텍스트
         });

         // input을 datepicker로 선언
         $("input#fromDate").datepicker();                    
         $("input#toDate").datepicker();
         
         // From의 초기값을 오늘 날짜로 설정
         $('input#fromDate').datepicker('setDate', 'today');
         
         // To의 초기값을 3일후로 설정
         $('input#toDate').datepicker('setDate', '+3D');
     }

    
     


</script>

<div class="header">
        <h1>급여명세서</h1>
        <div class="search-bar">
            <input type="text" id="search" placeholder="내용 검색">
            <button onclick="searchTable()">검색</button>
        </div>
    </div>

    <table>
        <thead>
            <tr>
                <th>신고귀속</th>
                <th>급여구분</th>
                <th>대장명칭</th>
                <th>지급일</th>
                <th>지급연월</th>
                <th>사전작업</th>
                <th>급여계산</th>
                <th>인원수</th>
                <th>급여대장</th>
                <th>명세서</th>
                <th>지급총액</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td><button>20230701-1</button></td>
                <td>급여</td>
                <td>2023년 07월 급여</td>
                <td>2023/06/02</td>
                <td>2023/06</td>
                <td><button id="workListcom_btn">근무기록확정</button></td>
                <td><button>전체계산</button></td>
                <td>2</td>
                <td><button>조회</button></td>
                <td><button>버튼</button></td>
                <td>1,000,000</td>
            </tr>
        </tbody>
    </table>
    <br>
    <button onclick="addNewRow()">신규</button>
	
	<!-- 모달1 -->
<div id="modal1" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title" id="exampleModalLabel">근무기록확정</h3>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body">
                <div class="container mt-3">
                    <!-- 상단 근태 버튼과 일괄적용 체크박스 -->
                    <div class="d-flex justify-content-start mb-2">
                        <button class="btn btn-primary btn-sm" id="workhis">근태</button>
                        <div class="form-check ml-2">
                            <input type="checkbox" class="form-check-input" id="batchApply">
                            <label class="form-check-label" for="batchApply">일괄적용</label>
                        </div>
                    </div>

                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th><input type="checkbox"></th>
                                <th>사원번호</th>
                                <th>사원명</th>
                                <th>부서명</th>
                                <th>근무일수</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><button class="btn btn-secondary btn-sm">1</button></td>
                                <td>2015-067A</td>
                                <td>사원1</td>
                                <td>회계팀</td>
                                <td><input type="text" class="form-control"></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="modal-footer">
                <div class="d-flex justify-content-end mt-3">
                    <button class="btn mr-2">저장</button>
                    <button class="btn" type="button" data-dismiss="modal">닫기</button>
                    <button>삭제</button>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 모달2 -->
<div class="modal fade" id="modal2" tabindex="-1" role="dialog" style="width: 30%">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">근무일수</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label for="monthpicker">월 선택</label>
                    <input type="text" id="monthpicker" class="form-control" readonly>
                </div>
                <div class="form-group">
                    <p id="weekdayCount"></p>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn mr-2">저장</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>
	   
</html>