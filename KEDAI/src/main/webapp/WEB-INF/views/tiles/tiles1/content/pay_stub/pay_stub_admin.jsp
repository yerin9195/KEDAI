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
		});
		$('#close').click(function(e){
			modal.style.display = "none"
		});
		
		$('#workhis').click(function(e){
			$('#modal2').modal("show");
			initializeDatepickers();
		});
		
		 // 모달1과 모달2의 상태를 확인하기 위한 변수
		  var isModal2Open = false;

		  // 모달2가 열릴 때 isModal2Open를 true로 설정
		  $('#modal2').on('show.bs.modal', function () {
		    isModal2Open = true;
		  });

		  // 모달2가 닫힐 때 isModal2Open를 false로 설정
		  $('#modal2').on('hidden.bs.modal', function () {
		    isModal2Open = false;
		  });

		  // 모달1이 닫히려고 할 때, 모달2가 열려 있는 경우 닫히지 않도록 방지
		  $('#modal1').on('hide.bs.modal', function (e) {
			if (isModal2Open) {
		    	alert("열려있는 창이 있습니다.");
		     	e.preventDefault();
		    }
		  });

		  // 모달2가 닫히지 않도록 설정
		  $('#modal2').modal({
		    backdrop: 'static',
		    keyboard: false,
		    show: false
		  });
		
	
	    //	
	    $('#dateSave').click(function(e){
	    	if($("#weekdayCount").val() == ""){
	    		alert("날짜를 지정하여 주시기 바랍니다.");
	    	}
	    	else{
	    		$("#weekdayCountfi").val($("#weekdayCount").val())
	    		$('#modal2').modal("hide")
	    		$('#start-date').datepicker('destroy'); 
	    	}
	    	
	    });
	    
	    $('#btnClose').click(function(e){
	    	$('#start-date').datepicker('setDate', "");
		    $('#end-date').datepicker('setDate', "");
		    $('#weekdayCount').val("");
		    $('#start-date').datepicker('destroy'); 
		    initializeDatepickers();
	    });
	    
	});	//	end of $(document).ready(function(){--------
		
	// 날짜 가져오기 함수
	function getDate(dateString) {
	    var date;
	    try {
	        date = $.datepicker.parseDate("yy-mm-dd", dateString);
	    } catch (error) {
	        date = null; // 날짜 형식 오류 처리
	    }
	    return date;
	}
	
	function initializeDatepickers() {
	    var currentYear = new Date().getFullYear(); 
	    var dateFormat = "yy-mm-dd";

	    $("#start-date").datepicker({
	        changeMonth: true,
	        changeYear: true,
	        dateFormat: dateFormat,
	        yearRange: (currentYear - 5) + ":" + (currentYear + 5),
	        onClose: function(selectedDate) {
	            $("#end-date").datepicker("option", "minDate", selectedDate ? selectedDate : null);
	            calculateWeekdays();
	        }
	    });

	    $("#end-date").datepicker({
	        changeMonth: true,
	        changeYear: true,
	        dateFormat: dateFormat,
	        yearRange: (currentYear - 5) + ":" + (currentYear + 5),
	        onClose: function(selectedDate) {
	            $("#start-date").datepicker("option", "maxDate", selectedDate ? selectedDate : null);
	            calculateWeekdays();
	        }
	    });
	}

	// 평일 수 계산 함수
	function calculateWeekdays() {
		 var startDate = getDate($("#start-date").val());
	    var endDate = getDate($("#end-date").val());

	    console.log("startDate:", startDate);
	    console.log("endDate:", endDate);
	    
	    if (startDate && endDate) {
	        console.log("start", startDate); // startDate 로그 확인
	        var weekdays = countWeekdays(startDate, endDate); // 평일 수 계산
	        $("#weekdayCount").val(weekdays); // 계산된 평일 수를 #weekdayCount 입력 필드에 설정
	    } else {
	        console.log("One or both dates are not selected."); // 날짜가 선택되지 않은 경우 로그
	    }
	}

	
		
    function countWeekdays(startDate, endDate) {
        var weekdays = 0;
        var currentDate = new Date(startDate);

        while (currentDate <= endDate) {
            var dayOfWeek = currentDate.getDay();
            if (dayOfWeek !== 0 && dayOfWeek !== 6) { // Sunday (0) and Saturday (6)
                weekdays++;
            }
            currentDate.setDate(currentDate.getDate() + 1);
        }

        return weekdays;
    }
	 
	
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
                                <td><input type="text" class="form-control" id="weekdayCountfi"></td>
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
                    <p>날짜 선택</p>
                    <label for="start-date">시작 날짜:</label>
				    <input type="text" id="start-date">
				    <label for="end-date">마지막 날짜:</label>
				    <input type="text" id="end-date">
                </div>
                <div class="form-group">
				 	<input type="hidden" id="weekdayCount" />
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn mr-2" id="dateSave">저장</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal" id="btnClose">닫기</button>
            </div>
        </div>
    </div>
</div>
	   
</html>