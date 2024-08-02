<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
	//     /KEDAI
%>
<style type="text/css">
	.highcharts-figure,
	.highcharts-data-table table {
	    min-width: 320px;
	    max-width: 800px;
	    margin: 1em auto;
	}
	div#chart_container {
	    height: 400px;
	}
	.highcharts-data-table table {
	    font-family: Verdana, sans-serif;
	    border-collapse: collapse;
	    border: 1px solid #ebebeb;
	    margin: 10px auto;
	    text-align: center;
	    width: 100%;
	    max-width: 500px;
	}
	.highcharts-data-table caption {
	    padding: 1em 0;
	    font-size: 1.2em;
	    color: #555;
	}
	.highcharts-data-table th {
	    font-weight: 600;
	    padding: 0.5em;
	}
	.highcharts-data-table td,
	.highcharts-data-table th,
	.highcharts-data-table caption {
	    padding: 0.5em;
	}	
	.highcharts-data-table thead tr,
	.highcharts-data-table tr:nth-child(even) {
	    background: #f8f8f8;
	}	
	.highcharts-data-table tr:hover {
	    background: #f1f7ff;
	}
	input[type="number"] {
	    min-width: 50px;
	}
	div#table_container table {width: 100%}
	div#table_container th, div#table_container td {border: solid 1px gray; text-align: center;} 
	div#table_container th {background-color: #595959; color: white;} 
</style>

<script type="text/javascript">
	$(document).ready(function(){
		
		$("select#searchType").change(function(e){
		   func_choice($(this).val());
	   });
		
		$("select#searchType").val("deptname").trigger("change"); 
		
	}); // end of $(document).ready(function(){}) ----------
	
	function func_choice(searchTypeVal) {
		
		switch(searchTypeVal) {
			case "":
				$("div#chart_container").empty();
				$("div#table_container").empty();
				$("div#highcharts-data-table").empty();
				
				break;
				
			case "deptname": // 부서별 인원통계
				$.ajax({
					url:"<%= ctxPath%>/admin/chart/empCntByDeptname.kedai",
			    	dataType:"json",
			    	success:function(json){
			    	 	console.log(JSON.stringify(json)); 
			    	 	
		    		},
			    	error: function(request, status, error){
					   alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					}
				});
			
				break;
				
			case "gender": // 성별 인원통계
				$.ajax({
					url:"<%= ctxPath%>/admin/chart/empCntByGender.kedai",
			    	dataType:"json",
			    	success:function(json){
			    	 	console.log(JSON.stringify(json)); 
			    	 	
		    		},
			    	error: function(request, status, error){
					   alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					}
				});
			
				break;
				
			case "deptnameGender": // 부서별 성별 인원통계 를 선택한 경우 
				$.ajax({
					url:"<%= ctxPath%>/admin/chart/empCntByDeptnameGender.kedai",
			    	dataType:"json",
			    	success:function(json){
			    	 	console.log(JSON.stringify(json)); 
			    	 	
		    		},
			    	error: function(request, status, error){
					   alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					}
				});
			
				break;
				
			case "genderHireYear": // 성별 입사년도별 통계 를 선택한 경우
				$.ajax({
					url:"<%= ctxPath%>/admin/chart/empCntByGenderHireYear.kedai",
			    	dataType:"json",
			    	success:function(json){
			    	 	console.log(JSON.stringify(json)); 
			    	 	
		    		},
			    	error: function(request, status, error){
					   alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					}
				});
			
				break;
				
			case "pageurlEmpname": // 페이지별 사원 접속통계
				$.ajax({
					url:"<%= ctxPath%>/admin/chart/pageurlEmpname.kedai",
			    	dataType:"json",
			    	success:function(json){
			    	 	console.log(JSON.stringify(json)); 
			    	 	
		    		},
			    	error: function(request, status, error){
					   alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					}
				});
			
				break;
		
		} // end of switch (searchTypeVal) ----------
		
	} // end of function func_choice(searchTypeVal) ----------
</script>
	
<%-- content start --%>	
<div style="border: 0px solid red; padding: 2% 3% 0 0;">
	<h3><span class="icon"><i class="fa-solid fa-seedling"></i></span>&nbsp;&nbsp;통계정보 조회하기</h3>

	<form name="searchFrm" style="margin: 50px 0 50px 0; ">
		<select name="searchType" id="searchType" style="height: 30px;">
			<option value="deptname">부서별 인원통계</option>
			<option value="gender">성별 인원통계</option>
			<option value="deptnameGender">부서별 성별 인원통계</option>
			<option value="genderHireYear">성별 입사년도별 통계</option>
			<option value="pageurlEmpname">페이지별 사원 접속통계</option>
		</select>
	</form>
	
	<div id="chart_container"></div>
	<div id="table_container" style="margin: 40px 0 0 0;"></div>
</div>
<%-- content end --%>