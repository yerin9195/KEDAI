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
	.highcharts-title {
		font-size: 20pt;
		font-weight: bold;
	}
	input[type="number"] {
	    min-width: 50px;
	}
	div#chart_container {height: 600px;}
	div#table_container table {width: 100%}
	div#table_container th, div#table_container td {border: solid 1px gray; text-align: center;} 
	div#table_container th {background: #e68c0e; color: white;} 
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
		<%--		
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
			
				break; --%>
				
			case "pageurlEmpname": // 페이지별 사원 접속통계
				$.ajax({
					url:"<%= ctxPath%>/admin/chart/pageurlEmpname.kedai",
			    	dataType:"json",
			    	success:function(json){
			    		let str_json = JSON.stringify(json);
					//	console.log(str_json);
					/*	
						{"categories":"[\"거래처정보\",\"게시판\",\"급여명세서\",\"사내연락망\",\"전자결재\",\"카쉐어\",\"커뮤니티\",\"통근버스\",\"회의실예약\"]",
						 "series":"[{\"name\":\"정예린\",\"data\":\"[\\\"1\\\"]\"},{\"name\":\"관리자\",\"data\":\"[\\\"2\\\"]\"},{\"name\":\"정예린\",\"data\":\"[\\\"1\\\"]\"},{\"name\":\"관리자\",\"data\":\"[\\\"1\\\"]\"},{\"name\":\"관리자\",\"data\":\"[\\\"4\\\"]\"},{\"name\":\"관리자\",\"data\":\"[\\\"1\\\"]\"},{\"name\":\"관리자\",\"data\":\"[\\\"1\\\"]\"},{\"name\":\"관리자\",\"data\":\"[\\\"1\\\"]\"},{\"name\":\"관리자\",\"data\":\"[\\\"1\\\"]\"}]"}
					*/
			    		str_json = str_json.replace(/\\/gi, "");
			    	//	console.log(str_json);
			    	/*	
			    		{"categories":"["거래처정보","게시판","급여명세서","사내연락망","전자결재","카쉐어","커뮤니티","통근버스","회의실예약"]",
			    		 "series":"[{"name":"정예린","data":"["1"]"},{"name":"관리자","data":"["2"]"},{"name":"정예린","data":"["1"]"},{"name":"관리자","data":"["1"]"},{"name":"관리자","data":"["4"]"},{"name":"관리자","data":"["1"]"},{"name":"관리자","data":"["1"]"},{"name":"관리자","data":"["1"]"},{"name":"관리자","data":"["1"]"}]"}
			    	*/	
			    		str_json = str_json.replace(/\"\[/gi, "[");
		    		    str_json = str_json.replace(/\]\"/gi, "]");
	    		    //	console.log(str_json);
		    		/*    
	    		    	{"categories":["거래처정보","게시판","급여명세서","사내연락망","전자결재","카쉐어","커뮤니티","통근버스","회의실예약"],
	    		    	 "series":[{"name":"정예린","data":["1"]},{"name":"관리자","data":["2"]},{"name":"정예린","data":["1"]},{"name":"관리자","data":["1"]},{"name":"관리자","data":["4"]},{"name":"관리자","data":["1"]},{"name":"관리자","data":["1"]},{"name":"관리자","data":["1"]},{"name":"관리자","data":["1"]}]}
			    	*/
			    	
		    		    const obj_str_json = JSON.parse(str_json);
		    		//  console.log(obj_str_json.categories);
		    		    // ['거래처정보', '게시판', '급여명세서', '사내연락망', '전자결재', '카쉐어', '커뮤니티', '통근버스', '회의실예약']
		    		//  console.log(obj_str_json.series);
					/*
		    		    {name: '정예린', data: ['1']}
		    		    {name: '관리자', data: ['2']}
		    		    {name: '정예린', data: ['1']}
		    		    {name: '관리자', data: ['1']}
		    		    {name: '관리자', data: ['4']}
		    		    {name: '관리자', data: ['1']}
		    		    {name: '관리자', data: ['1']}
		    		    {name: '관리자', data: ['1']}
		    		    {name: '관리자', data: ['1']}
					*/
						const arr_series = [];
			    		
		    		    for(let i=0; i<obj_str_json.series.length; i++) {
		    		    	 if(i == 0) {
		    		    	    const obj_series = {};
		    		    	    obj_series.name = obj_str_json.series[i].name;
		    		    	
		    		    	    const arr_data = [];
		    		    	    arr_data.push(Number(obj_str_json.series[i].data));
		    		    	    obj_series.data = arr_data;
		    		    	   
		    		    	    arr_series.push(obj_series);
		    		    	 }
		    		    	 else {
		    		    		 let flag = false;
		    		    		 
		    		    		 for(let k=0; k<arr_series.length; k++) {
		    		    		     if(arr_series[k].name == obj_str_json.series[i].name) {
		    		    			    arr_series[k].data.push(Number(obj_str_json.series[i].data));
		    		    			    flag = true;
		    		    		     }
		    		    		 } // end of for ----------
		    		    		 
		    		    		 if(!flag) {
		    		    			 const obj_series = {};
				    		    	 obj_series.name = obj_str_json.series[i].name;
				    		    	
				    		    	 const arr_data = [];
				    		    	 arr_data.push(Number(obj_str_json.series[i].data));
				    		    	 obj_series.data = arr_data;
				    		    	   
				    		    	 arr_series.push(obj_series); 
		    		    		 }
		    		    	}
		    		    } // end of for ----------
						
					//	console.log(arr_series);
					/*	
						0:{name: '정예린', data: [1, 1]}
						1:{name: '관리자', data: [2, 1, 4, 1, 1, 1, 1]}
					*/	
						$("div#chart_container").empty();
						$("div#table_container").empty();
						$("div#highcharts-data-table").empty();

						//////////////////////////////////////////////////////////////
						
						Highcharts.chart('chart_container', {
						    chart: {
						        type: 'column'
						    },
						    title: {
						        text: '페이지별 사원 접속 통계'
						    },
						    subtitle: {
						        text: ''
						    },
						    xAxis: {
						        categories: obj_str_json.categories,
						        crosshair: true
						    },
						    yAxis: {
						        title: {
						            useHTML: true,
						            text: '접속회수 (번)'
						        }
						    },
						    tooltip: {
						        headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
						        pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
						            		 '<td style="padding:0"><b>{point.y:.0f}</b>번 접속</td></tr>',
						        footerFormat: '</table>',
						        shared: true,
						        useHTML: true
						    },
						    plotOptions: {
						        column: {
						            pointPadding: 0.2,
						            borderWidth: 0
						        }
						    },
						    series: arr_series
						});
						
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

	<section class="row">
		<div class="col-6" style="border: 1px solid red;">
			<form name="searchFrm" style="margin: 50px 0 50px 0; ">
				<select name="searchType" id="searchType" style="height: 30px; padding-left: 1%;">
					<option value="deptname">부서별 인원통계</option>
					<option value="gender">성별 인원통계</option>
					<option value="deptnameGender">부서별 성별 인원통계</option>
					<option value="genderHireYear">성별 입사년도별 통계</option>
					<option value="pageurlEmpname">페이지별 사원 접속통계</option>
				</select>
			</form>
			
			<div id="chart_container" style="border: 1px solid red;"></div>
		</div>
		<div class="col-6" style="border: 1px solid red;">
			<div id="table_container" style="margin: 40px 0 0 0;"></div>
		</div>
	</section>
</div>
<%-- content end --%>