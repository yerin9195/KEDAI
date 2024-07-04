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
        
   .modal-body {
            max-height: 500px; /* 모달의 최대 높이 설정 */
            overflow-y: auto; /* 모달 내용의 세로 스크롤 설정 */
        }
        
	#modal3 > div > div > div.modal-body > table{
		font-size: 10pt;
		margin: 0 auto;
		width: 100%;
	}

   .bold-line {
          background-color: yellow;
    }
	
</style>

<script type="text/javascript">
	$(document).ready(function(){
		const modalClose = document.querySelector('.close_btn');
		
		$("#workListcom_btn").click(function(e){
			 $('#modal1').modal("show");
			 Memberview();
		});
		$('#close').click(function(e){
			modal.style.display = "none"
		});
		
		// 모두선택박스 반응
		 $(document).on('change', ".checkbox-member", function() {
	        var allChecked = true;
	        $(".checkbox-member").each(function() {
	            if (!$(this).prop("checked")) {
	                allChecked = false;
	                return false;
	            }
	        });
	
	        if (allChecked) {
	            $("#allCheckbox").prop("checked", true);
	        } else {
	            $("#allCheckbox").prop("checked", false);
	        }
    	});
		
		//	모두선택박스 컨트롤
		$('#allCheckbox').click(function(e) {
	        if($("#allCheckbox").is(':checked')) {
	    		$("input[name=checkbox-member]").prop("checked", true);
	    	} else {
	    		$("input[name=checkbox-member]").prop("checked", false);
	    	}
	    
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
	    
	    $('#btnClose').click(function(e){
	    	$('#start-date').datepicker('setDate', "");
		    $('#end-date').datepicker('setDate', "");
		    $('#weekdayCount').val("");
		    $('#start-date').datepicker('destroy'); 
		    initializeDatepickers();
	    });
	    
	   $('#total_bth').click(function(e){
		   $('#modal3').modal("show");
	   })
	    
	});	//	end of $(document).ready(function(){--------
		
		
	function Memberview(){
		var tbody = $('#modal1table');
		
		 $.ajax({
	    	 url:"<%= ctxPath%>/memberView.kedai",
	    	 type:"get",
	    	 dataType:"json",
	    	 success:function(json){
	    		 $.each(json, function(index, item) {
	    			if("100" === item.fk_dept_code){
	    				item.fk_dept_code = "인사부"; 
	    			}
	    			else if("200" === item.fk_dept_code){
	    				item.fk_dept_code = "영업지원부";
	    			}
	    			else if("300" === item.fk_dept_code){
	    				item.fk_dept_code = "회계부";
	    			}
	    			else if("400" === item.fk_dept_code){
	    				item.fk_dept_code = "상품개발부";
	    			}
	    			else if("500" === item.fk_dept_code){
	    				item.fk_dept_code = "마케팅부";
	    			}
	    			else if("600" === item.fk_dept_code){
	    				item.fk_dept_code = "해외사업부";
	    			}
	    			else if("700" === item.fk_dept_code){
	    				item.fk_dept_code = "온라인사업부";
	    			}
	    			else{
	    				item.fk_dept_code = "";
	    			
	    			}
	    		 
	    		        var newRow = '<tr>';
	    		        newRow += '<td><input type="checkbox" class="checkbox-member" id="checkbox-' + index + '" name="checkbox-member"></td>';
	    		        newRow += '<td class="empid">' + item.empid + '</td>'; // 사원번호
	    		        newRow += '<td>' + item.name + '</td>'; // 사원명
	    		        newRow += '<td>' + item.fk_dept_code + '</td>'; // 부서명
	    		        newRow += '<td><input type="text" class="form-control" id="weekdayCountfi" readonly /></td>'; // 근무일수
	    		        newRow += '<td><input type="text" class="form-control" readonly /></td>'; // 추가근무일수 (데이터가 없어서 비워둠)
	    		        newRow += '</tr>';
	    		        
	    		        // 새로운 행을 tbody에 추가
	    		        tbody.append(newRow);
	    
	    		    });
	    		 
	    		 $('#workhis').click(function(e){
	    			 if ($(".checkbox-member:checked").length == 0) {
	                     alert("선택한 사원이 없습니다.");
	                     return;
	                 } else {
	                     var selectedEmpIds = [];
	                     $(".checkbox-member:checked").each(function() {
	                         var empid = $(this).closest('tr').find('.empid').text();
	                         selectedEmpIds.push(empid);
	                     });
	                     //	alert("선택한 사원의 번호: " + selectedEmpIds.join(", "));
	                  
    					$('#modal2').modal("show");
    					initializeDatepickers();
	    				 
	    			 }
	    		});
	    		 
	    		 $('#dateSave').click(function(e){
	    		    	if($("#weekdayCount").val() == ""){
    		    		alert("날짜를 지정하여 주시기 바랍니다.");
    		    		return;
    		    	}
    		    	else{
    		    		 var weekdayCountValue = $("#weekdayCount").val();

    		    	        // Find all checked checkboxes
    		    	        $(".checkbox-member:checked").each(function() {
    		    	            // Find the closest tr and then find the #weekdayCountfi input inside it
    		    	            $(this).closest('tr').find('#weekdayCountfi').val(weekdayCountValue);
    		    	        });

    		    		$('#modal2').modal("hide")
    		    		$('#start-date').datepicker('destroy'); 
    		    	}
    		    	
    		    });
	    	  	
	    	 },
	    	 error: function(request, status, error){
			    alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			 }
	     });
	}
		
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
	        year+'년 0'+month+'월 급여',
	        '급여',
	        year+'/'+month+'/02',
	        year+'/'+month,
	        '<button id="workListcom_btn">근무기록확정</button>',
	        '<button id="total_bth">전체계산</button>',
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
	   
	    // 전체계산 버튼 클릭 이벤트 바인딩
	    newRow.querySelector('#workListcom_btn').addEventListener('click', function() {
	    	 $('#modal1').modal("show");
			 Memberview();
	    });
	    

	    // 전체계산 버튼 클릭 이벤트 바인딩
	    newRow.querySelector('#total_bth').addEventListener('click', function() {
	        $('#modal3').modal("show");
	    });
	    
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
            	<th>대장명칭</th>
                <th>급여구분</th>                
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
            	<td>2023년 07월 급여</td>
                <td>급여</td>
                <td>2023/06/02</td>
                <td>2023/06</td>
                <td><button id="workListcom_btn">근무기록확정</button></td>
                <td><button id="total_bth">전체계산</button></td>
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
                                <th><input type="checkbox" id="allCheckbox"></th>
                                <th>사원번호</th>
                                <th>사원명</th>
                                <th>부서명</th>
                                <th>근무일수</th>
                                <th>추가근무일수</th>
                            </tr>
                        </thead>
                        <tbody id="modal1table">
                          
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

<!--  계산 모달 -->>
<div id="modal3" class="modal fade" tabindex="-1" role="dialog" style="width: 80;">
    <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
			<h5>2023년 07월 급여 명세서</h5>
			<button type="button" class="close" data-dismiss="modal" aria-label="Close">
                 <span aria-hidden="true">&times;</span>
             </button>
            </div>
            <div class="modal-body">
				<table>
			    	<thead>
			        <tr>
			            <th colspan="4">사원정보</th>
			            <th colspan="5">급여 항목</th>
			            <th colspan="7">공제 항목</th>
			        </tr>
			        <tr>
			            <th>사원번호</th>
			            <th>성명</th>
			            <th>부서</th>
			            <th>직위</th>
			            <th>기본급</th>
			            <th>식대</th>
			            <th>연차수당</th>
			            <th>초과근무수당</th>
			            <th class="bold-line">지급총액</th>
			            <th>소득세</th>
			            <th>지방소득세</th>
			            <th>국민연금</th>
			            <th>건강보험</th>
			            <th>고용보험</th>
			            <th class="bold-line">공제총액</th>
			            <th class="bold-line">실지급액</th>
			        </tr>
			    </thead>
			    <tbody>
			        <tr>
			            <td>2010001</td>
			            <td>홍길동</td>
			            <td>영업부</td>
			            <td>사원</td>
			            <td>3000000</td>
			            <td>500000</td>
			            <td>100000</td>
			            <td>50000</td>
			            <td>3650000</td>
			            <td>500000</td>
			            <td>100000</td>
			            <td>150000</td>
			            <td>100000</td>
			            <td>50000</td>
			            <td>300000</td>
			            <td>3350000</td>
			        </tr>
				    </tbody>
				</table>
			</div>
		</div>
	</div>
</div>

	   
</html>