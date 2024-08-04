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
	input[type="number"] {
	    min-width: 50px;
	}
	div#chart_container {height: 600px;}
	div#table_container table {width: 100%;}
	div#table_container th, div#table_container td {text-align: center;} 
	div#table_container th {background: #e68c0e; color: #fff;}
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
			    	// 	console.log(JSON.stringify(json)); 
			    	 	/*
			    	 		[{"dept_name":"마케팅부","cnt":"10","percentage":"30.3"},
		    	 			{"dept_name":"영업지원부","cnt":"7","percentage":"21.21"},
		    	 			{"dept_name":"인사부","cnt":"7","percentage":"21.21"},
		    	 			{"dept_name":"상품개발부","cnt":"6","percentage":"18.18"},
		    	 			{"dept_name":"회계부","cnt":"2","percentage":"6.06"},
		    	 			{"dept_name":"부서없음","cnt":"1","percentage":"3.03"}]
			    	 	*/
			    	 	
						let resultArr = [];
						
			    	 	for(let i=0; i<json.length; i++){
			    	 		let obj;
			    	 		
			    	 		if(i == 0){
			    	 			obj = {
			    	 					name: json[i].dept_name,
							            y: Number(json[i].percentage),
							            sliced: true,
							            selected: true
		    	 					  }
			    	 		}
			    	 		else{
			    	 			obj = {
			    	 					name: json[i].dept_name,
							            y: Number(json[i].percentage)
		    	 					  }
			    	 		}
			    	 		
			    	 		resultArr.push(obj);
			    	 	} // end of for ----------
			    	 	
			    	 	$("div#chart_container").empty();
						$("div#table_container").empty();
						$("div#highcharts-data-table").empty();
			    	 	
						//////////////////////////////////////////////////////////////

						Highcharts.chart('chart_container', {
						    chart: {
						        plotBackgroundColor: null,
						        plotBorderWidth: null,
						        plotShadow: false,
						        type: 'pie'
						    },
						    title: {
						        text: '<span style="font-size: 18pt; font-weight: bold; color: #e68c0e;">《&nbsp;KEDAI 부서별 인원통계&nbsp;》</span>'
						    },
						    tooltip: {
						        pointFormat: '{series.name}: <b>{point.percentage:.2f}%</b>'
						    },
						    accessibility: {
						        point: {
						            valueSuffix: '%'
						        }
						    },
						    plotOptions: {
						        pie: {
						            allowPointSelect: true,
						            cursor: 'pointer',
						            dataLabels: {
						                enabled: true,
						                format: '<b>{point.name}</b>: {point.percentage:.2f} %'
						            }
						        }
						    },
						    series: [{
						        name: '인원비율',
						        colorByPoint: true,
						        data: resultArr
						    }]    
						});
						
						//////////////////////////////////////////////////////////////

						let v_html = "<table class='table table-bordered'>";
						
						v_html += "<tr>"+
								  "<th style='width: 40%;'>부서명</th>"+
								  "<th style='width: 30%;'>인원수(명)</th>"+
								  "<th style='width: 30%;'>퍼센티지(%)</th>"+
								  "</tr>";
						
					  	let totalCount = 0;
					  	let totalPercentage = 0;
					  	
					 	$.each(json, function(index, item){
					 		v_html += "<tr>"+
					 		          "<td>"+item.dept_name+"</td>"+
					 		          "<td>"+item.cnt+"</td>"+
					 		          "<td>"+item.percentage+"</td>"+
					 		          "</tr>";
					 		          
					 		totalCount += Number(item.cnt);
					 		totalPercentage += parseFloat(item.percentage);
					 	});
					 	
					 	totalPercentage = isNaN(totalPercentage)?'Invalid':totalPercentage.toFixed(2);
					 	
					 	v_html += "<tr style='font-weight: bold;'>"+
					 			  "<td>합계</td>"+
					 			  "<td>"+totalCount+"</td>"+
					 			  "<td>"+totalPercentage+"</td>"+
					 	          "</tr>";
					 	
					 	v_html += "</table>";
					 	
					 	$("div#table_container").html(v_html);
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
			    	// 	console.log(JSON.stringify(json)); 
			    	 	/*
			    	 		[{"gender":"여","cnt":"14","percentage":"42.4"},
			    	 		{"gender":"남","cnt":"19","percentage":"57.6"}]
			    	 	*/
			    	 	
						let resultArr = [];
						
			    	 	for(let i=0; i<json.length; i++){
			    	 		let obj;
			    	 		
			    	 		if(i == 0){
			    	 			obj = {
			    	 					name: json[i].gender,
							            y: Number(json[i].percentage),
							            sliced: true,
							            selected: true
		    	 					  }
			    	 		}
			    	 		else{
			    	 			obj = {
			    	 					name: json[i].gender,
							            y: Number(json[i].percentage)
		    	 					  }
			    	 		}
			    	 		
			    	 		resultArr.push(obj);
			    	 	} // end of for ----------
			    	 	
			    	 	$("div#chart_container").empty();
						$("div#table_container").empty();
						$("div#highcharts-data-table").empty();
						
						//////////////////////////////////////////////////////////////

						Highcharts.chart('chart_container', {
						    chart: {
						        plotBackgroundColor: null,
						        plotBorderWidth: null,
						        plotShadow: false,
						        type: 'pie'
						    },
						    title: {
						        text: '<span style="font-size: 18pt; font-weight: bold; color: #e68c0e;">《&nbsp;KEDAI 성별 인원통계&nbsp;》</span>'
						    },
						    tooltip: {
						        pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
						    },
						    accessibility: {
						        point: {
						            valueSuffix: '%'
						        }
						    },
						    plotOptions: {
						        pie: {
						            allowPointSelect: true,
						            cursor: 'pointer',
						            dataLabels: {
						                enabled: true,
						                format: '<b>{point.name}</b>: {point.percentage:.1f} %'
						            }
						        }
						    },
						    series: [{
						        name: '인원비율',
						        colorByPoint: true,
						        data: resultArr
						    }]    
						});
						
						//////////////////////////////////////////////////////////////
			    	 	
						let v_html = "<table class='table table-bordered'>";
						
						v_html += "<tr>"+
								  "<th style='width: 40%;'>성별</th>"+
								  "<th style='width: 30%;'>인원수(명)</th>"+
								  "<th style='width: 30%;'>퍼센티지(%)</th>"+
								  "</tr>";
						
					  	let totalCount = 0;
					  	let totalPercentage = 0;
					  	
					 	$.each(json, function(index, item){
					 		v_html += "<tr>"+
					 		          "<td>"+item.gender+"</td>"+
					 		          "<td>"+item.cnt+"</td>"+
					 		          "<td>"+item.percentage+"</td>"+
					 		          "</tr>";
					 		          
					 		totalCount += Number(item.cnt);
					 		totalPercentage += parseFloat(item.percentage);
					 	});
					 	
					 	totalPercentage = isNaN(totalPercentage)?'Invalid':totalPercentage.toFixed(1);
					 	
					 	v_html += "<tr style='font-weight: bold;'>"+
					 			  "<td>합계</td>"+
					 			  "<td>"+totalCount+"</td>"+
					 			  "<td>"+totalPercentage+"</td>"+
					 	          "</tr>";
					 	
					 	v_html += "</table>";
					 	
					 	$("div#table_container").html(v_html);
		    		},
			    	error: function(request, status, error){
					   alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					}
				});
			
				break;
				
			case "deptnameGender": // 부서별 성별 인원통계
				$.ajax({
					url:"<%= ctxPath%>/admin/chart/empCntByDeptname.kedai",
			    	dataType:"json",
			    	success:function(json){
			    	// 	console.log(JSON.stringify(json)); 
			    	 	/*
			    	 		[{"dept_name":"마케팅부","cnt":"10","percentage":"30.3"},
		    	 			{"dept_name":"영업지원부","cnt":"7","percentage":"21.21"},
		    	 			{"dept_name":"인사부","cnt":"7","percentage":"21.21"},
		    	 			{"dept_name":"상품개발부","cnt":"6","percentage":"18.18"},
		    	 			{"dept_name":"회계부","cnt":"2","percentage":"6.06"},
		    	 			{"dept_name":"부서없음","cnt":"1","percentage":"3.03"}]
			    	 	*/
			    	 	
			    	 	let deptnameArr = []; // 부서명별 인원수 퍼센티지 객체 배열
			    	 	
			    	 	$.each(json, function(index, item){
			    	 		deptnameArr.push(item.dept_name);
			    	 	}); 
			    	 	
			    	 	let genderArr = []; // 특정 부서명에 근무하는 직원들의 성별 인원수 퍼센티지 객체 배열
			    	 	
			    	 	$.each(json, function(index, item){
			    	 		$.ajax({
			    	 			url:"<%= ctxPath%>/admin/chart/genderCntSpecialDeptname.kedai",
				    			data:{"dept_name":item.dept_name},
				    			dataType:"json",
				    			success:function(json2){
				    			//	console.log(JSON.stringify(json2));
				    				/*
				    					[{"gender":"남","cnt":"5","percentage":"15.15"},{"gender":"여","cnt":"5","percentage":"15.15"}]
										[{"gender":"남","cnt":"1","percentage":"3.03"}]
										[{"gender":"남","cnt":"1","percentage":"3.03"},{"gender":"여","cnt":"1","percentage":"3.03"}]
										[{"gender":"남","cnt":"5","percentage":"15.15"},{"gender":"여","cnt":"2","percentage":"6.06"}]
										[{"gender":"남","cnt":"3","percentage":"9.09"},{"gender":"여","cnt":"4","percentage":"12.12"}]
										[{"gender":"남","cnt":"4","percentage":"12.12"},{"gender":"여","cnt":"2","percentage":"6.06"}]
				    				*/
				    				
				    				const genderArr = [];
				    				
				    				$.each(json2, function(index2, items2) {
				    				    // Create a new series object for each item
				    				    const obj_series = { name: '', data: [] };
				    				    
				    				    obj_series.name = items2[0].gender; 

				    				    // Iterate through the items to build the data array
				    				    $.each(items, function(innerIndex, item3) {
				    				        obj_series.data.push(parseFloat(item3.percentage)); // Convert percentage to number
				    				    });

				    				    // Add the series data to the genderArr
				    				    genderArr.push({
				    				        name: obj_series.name,
				    				        data: obj_series.data
				    				    });
				    				});
				    				
				    			},
				    			error: function(request, status, error){
								   alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
								}
			    	 		});
			    	 	});
			    	 	
			    	 	$("div#chart_container").empty();
						$("div#table_container").empty();
						$("div#highcharts-data-table").empty();
						
						//////////////////////////////////////////////////////////////
						
						Highcharts.chart('chart_container', {
						    chart: {
						        type: 'bar'
						    },
						    title: {
						        text: '<span style="font-size: 18pt; font-weight: bold; color: #e68c0e;">《&nbsp;KEDAI 부서별 성별 인원통계&nbsp;》</span>'
						    },
						    subtitle: {
						        text: ''
						    },
						    xAxis: {
						        categories: deptnameArr,
						        title: {
						            text: null
						        }
						    },
						    yAxis: {
						        min: 0,
						        title: {
						            text: 'Population (millions)',
						            align: 'high'
						        },
						        labels: {
						            overflow: 'justify'
						        }
						    },
						    tooltip: {
						        valueSuffix: ' millions'
						    },
						    plotOptions: {
						        bar: {
						            dataLabels: {
						                enabled: true
						            }
						        }
						    },
						    legend: {
						        layout: 'vertical',
						        align: 'right',
						        verticalAlign: 'top',
						        x: -40,
						        y: 80,
						        floating: true,
						        borderWidth: 1,
						        backgroundColor:
						            Highcharts.defaultOptions.legend.backgroundColor || '#FFFFFF',
						        shadow: true
						    },
						    credits: {
						        enabled: false
						    },
						    series: [{
						        name: 'Year 1990',
						        data: [631, 727, 3202, 721, 26]
						    }, {
						        name: 'Year 2000',
						        data: [814, 841, 3714, 726, 31]
						    }, {
						        name: 'Year 2010',
						        data: [1044, 944, 4170, 735, 40]
						    }, {
						        name: 'Year 2018',
						        data: [1276, 1007, 4561, 746, 42]
						    }]
						});
						
		    		},
			    	error: function(request, status, error){
					   alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					}
				});
			
				break;
		<%--		
			case "genderHireYear": // 입사년도별 성별 인원통계
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
		--%>		
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
						        text: '<span style="font-size: 18pt; font-weight: bold; color: #e68c0e;">《&nbsp;페이지별 사원 접속 통계&nbsp;》</span>'
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
	<br>
	<form name="searchFrm">
		<select name="searchType" id="searchType" style="height: 30px; padding-left: 0.5%;">
			<option value="deptname">부서별 인원통계</option>
			<option value="gender">성별 인원통계</option>
			<option value="deptnameGender">부서별 성별 인원통계</option>
			<option value="genderHireYear">입사년도별 성별 인원통계</option>
			<option value="pageurlEmpname">페이지별 사원 접속통계</option>
		</select>
	</form>
	<br><br>
	<section class="row" style="height: 600px;">
		<div class="col-6" style="border: 1px solid blue;">
			<div id="chart_container" style="border: 1px solid red;"></div>
		</div>
		<div class="col-6" style="border: 1px solid red;">
			<div id="table_container"></div>
		</div>
	</section>
</div>
<%-- content end --%>