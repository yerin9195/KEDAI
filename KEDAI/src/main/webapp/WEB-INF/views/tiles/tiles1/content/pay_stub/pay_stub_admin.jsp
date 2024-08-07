<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
   String ctxPath = request.getContextPath();
%>


<style type="text/css">
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
        padding: 1px 20px;
        margin: 0 1px;
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
		
		$("#workdaySmt").click(function(e){	
			if (confirm("저장하시겠습니까?")) {
				salary_submit();
				$('#modal1').modal("hide");
			}
			else{
				 e.preventDefault();
			}
		});
		

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
	    

	// 삭제 버튼 클릭 시 체크된 행 삭제
	    $("#deleteRows").click(function() {
	        // 체크된 체크박스가 있는지 확인
	        if ($(".checkbox-member:checked").length == 0) {
	            alert("선택한 사원이 없습니다.");
	            return;
	        }

	        // 확인 메시지 표시
	        if (confirm("선택한 행을 삭제하시겠습니까?")) {
	            // 체크된 행을 순회하며 삭제
	            $(".checkbox-member:checked").each(function() {
	                $(this).closest('tr').remove();
	            });
	        }
	    });
	});	//	end of $(document).ready(function(){--------
		
	
		
	//	근무기록 확정 시 회원목록 조회하기
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
	    		        newRow += '<td><input type="text" class="form-control" readonly /><input type="hidden" id="memberSalary" value="' + item.salary + '"/></td>'; // 추가근무일수 (데이터가 없어서 비워둠)
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

        // Create select elements for year and month
        const yearSelect = document.createElement('select');
        yearSelect.classList.add('yearSelect');
        const monthSelect = document.createElement('select');
        monthSelect.classList.add('monthSelect');

        const currentYear = new Date().getFullYear();
        const currentMonth = new Date().getMonth() + 1; // Month is zero-indexed in JavaScript

        // Populate year select with the past 5 years
        for (let i = 0; i < 5; i++) {
            const yearOption = document.createElement('option');
            yearOption.value = currentYear - i;
            yearOption.textContent = (currentYear - i).toString();
            yearSelect.appendChild(yearOption);
        }

        // Populate month select with 1 to 12
        for (let i = 1; i <= 12; i++) {
            const monthOption = document.createElement('option');
            monthOption.value = i < 10 ? '0' + i : i.toString();
            monthOption.textContent = i < 10 ? '0' + i : i.toString();
            monthSelect.appendChild(monthOption);
        }

        // Set the initial values for the select elements to the current year and month
        yearSelect.value = currentYear.toString();
        monthSelect.value = currentMonth < 10 ? '0' + currentMonth : currentMonth.toString();

        const cellsContent = [
            '급여',
            '', // This will be replaced with the select elements for year and month
            '<button id="workListcom_btn">근무기록확정</button>',
            '<button id="total_bth">전체계산</button>',
            '<button>조회</button>',
            '<button>조회</button>',
            '지급총액'
        ];

        // Append cells to the new row
        for (let i = 0; i < cellsContent.length; i++) {
            const newCell = newRow.insertCell(i);
            if (i === 1) {
                newCell.appendChild(yearSelect);
                newCell.appendChild(document.createTextNode('년 '));
                newCell.appendChild(monthSelect);
                newCell.appendChild(document.createTextNode('월 급여'));
            } else {
                newCell.innerHTML = cellsContent[i];
            }
        }

        // 전체계산 버튼 클릭 이벤트 바인딩
        newRow.querySelector('#workListcom_btn').addEventListener('click', function() {
            $('#modal1').modal("show");
            Memberview();
        });

        // 전체계산 버튼 클릭 이벤트 바인딩
        newRow.querySelector('#total_bth').addEventListener('click', function() {
        	 console.log("????")
 		    loadSalaryData();
 			$('#modal3').modal("show");
        });
    }

	
    function salary_submit() {
        var workdayval = $("#weekdayCount").val();
        var empidval = [];
        var memberSalary = [];
        var payment_date = $(".yearSelect").val() +"/"+ $(".monthSelect").val();
        
        $(".checkbox-member:checked").each(function() {
            var empid = $(this).closest('tr').find('.empid').text();
            var memSal = $(this).closest('tr').find('#memberSalary').val();
            empidval.push(empid.trim());
            memberSalary.push(memSal.trim());
        });

        // 유효성 검사: workdayval이 유효한지 확인
        if (workdayval <= 0 || isNaN(workdayval)) {
            alert("근로 일자를 올바르게 입력해 주세요.");
            return;
        }

        // 유효성 검사: empidval 및 memberSalary 배열 확인
        if (empidval.length === 0 || memberSalary.length === 0) {
            alert("선택된 직원이 없습니다.");
            return;
        }


        $.ajax({
            url: "<%= ctxPath%>/salaryCal.kedai",
            type: "post",
            data: {
                workday: workdayval,
                "empid": empidval,
                memberSalary: memberSalary
                payment_date: payment_date
            },
            traditional: true,
            dataType: 'json',
            success: function(response) {
                console.log(response);
                if (Array.isArray(response)) {
                    response.forEach(function(item) {
                        console.log("사원번호: " + item.empid);
                        console.log("기본급: " + item.base_salary);
                        console.log("근로일: " + item.work_day);
                    });
                } else {
                    console.error("서버로부터 예상치 못한 데이터를 수신했습니다.");
                }
            },
            error: function(request, status, error) {
                alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
            }
        });
    }
    
    console.log($('#yearMonth').val())

    function loadSalaryData() {
        $.ajax({
            url: "<%= ctxPath %>/salaryData.kedai",
            type: "GET",
            data: {
                yearMonth: $('#yearMonth').val(), // 파라미터 값을 가져옵니다
                empid: $('#empid').val()           // 파라미터 값을 가져옵니다
            },

            dataType: "json",
            success: function(response) {
                var tbody = $('#modal3 table tbody');
                tbody.empty();
                
                // 서버에서 반환하는 JSON 데이터가 배열 형태인지 확인
                if (Array.isArray(response)) {
                    $.each(response, function(index, salary) {
                        // 데이터 필드 이름이 서버에서 반환하는 것과 일치하는지 확인
                        var newRow = '<tr>';
                        newRow += '<td>' + (salary.base_salary || '') + '</td>';
                        newRow += '<td>' + (salary.meal_allowance || '') + '</td>';
                        newRow += '<td>' + (salary.annual_allowance || '') + '</td>';
                        newRow += '<td>' + (salary.overtime_allowance || '') + '</td>';
                        newRow += '<td>' + (salary.total_income || '') + '</td>';
                        newRow += '<td>' + (salary.income_tax || '') + '</td>';
                        newRow += '<td>' + (salary.local_income_tax || '') + '</td>';
                        newRow += '<td>' + (salary.pension || '') + '</td>';
                        newRow += '<td>' + (salary.health_insurance || '') + '</td>';
                        newRow += '<td>' + (salary.employment_insurance || '') + '</td>';
                        newRow += '<td>' + (salary.total_deduction || '') + '</td>';
                        newRow += '<td>' + (salary.net_pay || '') + '</td>';
                        newRow += '</tr>';
                        
                        tbody.append(newRow);
                    });
                } else {
                    alert("서버에서 반환된 데이터 형식이 올바르지 않습니다.");
                }
            },
            error: function(xhr, status, error) {
                console.error("데이터를 불러오지 못했습니다:", status, error);
                alert("데이터를 불러오지 못했습니다.");
            }
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
            	<th>급여구분</th> 
            	<th>대장명칭</th>
                <th>사전작업</th>
                <th>급여계산</th>
                <th>급여대장</th>
                <th>명세서</th>
                <th>지급총액</th>
            </tr>
        </thead>
        <tbody>
           
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
                <button id="workdaySmt">저장</button>
                    <button data-dismiss="modal">닫기</button>
                    <button id="deleteRows">삭제</button>
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

<!-- 모달 3: 총급여 계산 -->
<div id="modal3" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">총급여 계산</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body">
                <table>
                    <thead>
                        <tr>
                            <th>기본급</th>
                            <th>식대 보조금</th>
                            <th>연차 수당</th>
                            <th>초과근무 수당</th>
                            <th>총 수익</th>
                            <th>소득세</th>
                            <th>지방 소득세</th>
                            <th>국민연금</th>
                            <th>건강보험</th>
                            <th>고용보험</th>
                            <th>총 공제액</th>
                            <th>실 지급액</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- 계산된 급여 정보가 여기에 추가됩니다 -->
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

	   
</html>