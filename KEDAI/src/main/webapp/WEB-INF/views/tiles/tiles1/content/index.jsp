<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String ctxPath = request.getContextPath();
	//     /KEDAI
%>
<style type="text/css">
	/* highchart */
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
	/* tab */
	.nav-tabs {
		padding-bottom: 1px;
		border-bottom: 1px solid #e68c0e;
	}
	.nav-tabs .nav-link,
	.nav-tabs .nav-link:hover {
		color: #e68c0e;
		background: #fff;
		border-color: #e68c0e #e68c0e #fff;
	}
	.nav-tabs .nav-link.active {
		color: #fff;
		background: #e68c0e;
	}
	/* myPage */
	.myPageList button {
	    background: none;
		color: #fff;
		font-size: 12pt;
	}
	.myPageList button:hover {
		color: #fff;
	}
	.dropdown-menu li {
		margin-left: 5%;
		margin-bottom: 5%;
	}
	.dropdown-menu li a {
		color: #363636;
		text-decoration: none;
	}
	.dropdown-menu li a:hover {
		color: #e68c0e;
	}
	/* menu */
    .pointMinus_btn {
		text-align: center;
		align-content: center;
		border: solid 1px #2c4459;
		background: none;
		color: #2c4459;
		font-size: 12pt;
		width: 120px;
		height: 40px;
	}
	.pointMinus_btn:hover {
		text-decoration: none;
		border: none;
		background: #e68c0e;
		color: #fff;
	}
</style>

<script src="<%= ctxPath%>/resources/Highcharts-10.3.1/code/highcharts.js"></script>
<script src="<%= ctxPath%>/resources/Highcharts-10.3.1/code/modules/exporting.js"></script>
<script src="<%= ctxPath%>/resources/Highcharts-10.3.1/code/modules/export-data.js"></script>
<script src="<%= ctxPath%>/resources/Highcharts-10.3.1/code/modules/accessibility.js"></script>

<script type="text/javascript">
	$(document).ready(function(){
		
		$("li.nav-item > a.active").trigger('click');
		
		loopshowNowTime();
		showWeather();
		
		// 사원수 조회하기
		$.ajax({
			url: "${pageContext.request.contextPath}/index/memberTotalCountJSON.kedai",
			type: "get",
			dataType: "json",	 
		   	success: function(json){
		   	//	console.log(JSON.stringify(json));
		   	//	console.log(JSON.stringify(json.totalCount));
		   		
		   		let v_html = json.totalCount.toLocaleString('en');
		   		$("span.memberTotalCount").html(v_html);
		   	},
			error: function(request, status, error){
            	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
		});
		
		// 게시글수 조회하기
		$.ajax({
			url: "${pageContext.request.contextPath}/index/boardTotalCountJSON.kedai",
			type: "get",
			dataType: "json",	 
		   	success: function(json){
		   	//	console.log(JSON.stringify(json));
		   	//	console.log(JSON.stringify(json.totalCount));
		   		
		   		let v_html = json.totalCount.toLocaleString('en');
		   		$("span.boardTotalCount").html(v_html);
		   	},
			error: function(request, status, error){
            	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
		});
		
		// 게시판 글 조회하기
		$("li.nav-item").click(function(e){
			$.ajax({
				url: "${pageContext.request.contextPath}/index/boardListJSON.kedai",
				type: "get",
				data: {"category_code" : $(e.target).find('input').val()},
				dataType: "json",	 
			   	success: function(json){
			   	//	console.log(JSON.stringify(json));
			   		
			   		let v_html = `<table class='table table-bordered table-hover' style='table-layout: fixed'>`;
			   		v_html += `<thead><tr>`;
			   		v_html += `<td style='width: 50%;' align='center'>글제목</td>`;
	   				v_html += `<td style='width: 20%;' align='center'>작성자</td>`;
	   				v_html += `<td style='width: 30%;' align='center'>작성일자</td>`;
	   				v_html += `</tr></thead><tbody>`;
			   		
			   		if(json.length > 0){ // 검색된 데이터가 있는 경우
			   			
			   			$.each(json, function(index, item){
			   				const subject = item.subject;
			   				const name = item.name;
			   				const registerday = item.registerday;
			   				
			   				v_html += `<tr style='cursor: pointer;' class='boardList'>`
			   				v_html += `<td style='text-overflow:ellipsis; overflow:hidden; white-space:nowrap;'>\${subject}</td>`;
			   				v_html += `<td align='center'>\${name}</td>`;
			   				v_html += `<td align='center'>\${registerday}</td></tr>`;
			   				
			   			}); // end of $.each(json, function(index, item) ----------
			   			
			   		}
			   		else{
			   			v_html += `<tr><td colspan='3'>데이터가 존재하지 않습니다.</td></tr>`
			   		}
			   		
			   		v_html += `</tbody></table>`;
			   		
			   		$("div.tab-pane").html(v_html);
			   	},
				error: function(request, status, error){
	            	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	            }
			});
		   			
		});
			
		$(document).on("click", "tbody > tr.boardList", function(e){
			location.href="<%= ctxPath%>/board/list.kedai"; 
		});
		
		// 식단표 조회하기
		$.ajax({
			url: "${pageContext.request.contextPath}/index/boardMenuJSON.kedai",
			type: "get",
			dataType: "json",	 
		   	success: function(json){
		   	//	console.log(JSON.stringify(json));
		   	
		   		const subject = json.subject;
		   		const filename = json.filename;
		   		
		   		const v_html_1 = `<span>\${subject}</span>`;
		   		const v_html_2 = `<img src='<%= ctxPath%>/resources/files/board_attach_file/\${filename}' alt='img' style='width: 100%; height: 100%;' />`;
		   		
				$("div.subject").html(v_html_1);
				$("span.filename").html(v_html_2);
		   	},
			error: function(request, status, error){
            	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
		});
		
		$("button.pointMinus_btn").click(function(){
			
			const now = new Date();
			
			let month = now.getMonth() + 1;
			if(month < 10){
				month = "0"+month;
			}
			
			let date = now.getDate();
			if(date < 10){
				date = "0"+date;
			}
			
			let strNow = now.getFullYear()+"년 "+month+"월 "+date+"일";
			
			if(confirm("*** 식권 결제하기 ***\n\n"+strNow+"\n100point 를 결제하시겠습니까?")){
				location.href="<%= ctxPath%>/index/payment.kedai"; 
			}
		});
		
	}); // end of $(document).ready(function(){}) ----------
	
	// 코인충전 결제금액 선택하기
	function goCoinPurchaseTypeChoice(ctxPath, empid){
		
		// 포인트충전 결제금액 선택하는 팝업창 띄우기
	    const url = "${pageContext.request.contextPath}/member/coinPurchaseTypeChoice.kedai?empid="+empid;
	    
	    const width = 650;
	    const height = 570;
	    
	    const left = Math.ceil((window.screen.width - width)/2); // 예> 1400-650 = 750 => 750/2 = 375 
	    // window.screen.width 은 모니터의 너비이다.
	    // Math.ceil() 은 소수부를 올려서 정수로 만드는 것이다.

	    const top = Math.ceil((window.screen.height - height)/2); // 예> 900-570 = 330 => 330/2 = 165 
	    // window.screen.height 은 모니터의 높이이다.
	    // Math.ceil() 은 소수부를 올려서 정수로 만드는 것이다.
	    
	 	// 팝업창 띄우기
	    window.open(url, "coinPurchaseTypeChoice", `"left="+left, "top="+top, "width="+width, "height="+height`);
		
	} // end of goCoinPurchaseTypeChoice(empid, ctxPath) ----------
	
	// 포트원(회사명 구 아임포트) 을 사용하여 결제하기
	function goCoinPurchaseEnd(ctxPath, empid, coinmoney){
		
		// 포트원(회사명 구 아임포트) 결제 팝업창 띄우기
	    const url = "${pageContext.request.contextPath}/member/coinPurchaseEnd.kedai?empid="+empid+"&coinmoney="+coinmoney;
		
		const width = 1000;
	    const height = 600;
	    
	    const left = Math.ceil((window.screen.width - width)/2); // 예> 1400-1000 = 400 => 400/2 = 200 
	    // window.screen.width 은 모니터의 너비이다.
	    // Math.ceil() 은 소수부를 올려서 정수로 만드는 것이다.

	    const top = Math.ceil((window.screen.height - height)/2); // 예> 900-600 = 300 => 300/2 = 150 
	    // window.screen.height 은 모니터의 높이이다.
	    // Math.ceil() 은 소수부를 올려서 정수로 만드는 것이다.
	    
	 	// 팝업창 띄우기
	    window.open(url, "coinPurchaseEnd", `"left="+left, "top="+top, "width="+width, "height="+height`);
		
	} // end of function goCoinPurchaseEnd(ctxPath, coinmoney, empid) ----------
	
	// tbl_employees 테이블에 해당 사용자의 포인트 증가(update) 시키기
	function goCoinUpdate(ctxPath, empid, coinmoney){
		
		$.ajax({
			url: "<%= ctxPath%>/member/pointUpdate.kedai",
			type: "post",
			data: {"empid":empid, "coinmoney":coinmoney},
			dataType: "json",	 
		   	success: function(json){
		   	//	console.log(JSON.stringify(json));

		   	 	alert(json.message);
	            location.href = json.loc;
		   	},
			error: function(request, status, error){
            	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
		});
		
	} // end of function goCoinUpdate(ctxPath, coinmoney, empid) ----------
	
	// 현재 시간 나타내기
	function showNowTime(){
		
		const now = new Date();
		
		let month = now.getMonth() + 1;
		if(month < 10){
			month = "0"+month;
		}
		
		let date = now.getDate();
		if(date < 10){
			date = "0"+date;
		}
		
		let strNow = "<span style='font-size: 14pt; color: #363636;'>"+now.getFullYear()+"-"+month+"-"+date+"</span><br>";
		
		let hour = "";
		if(now.getHours() < 10){
			hour = "0"+now.getHours();
		}
		else{
			hour = now.getHours();
		}
		
		let minute = "";
		if(now.getMinutes() < 10){
			minute = "0"+now.getMinutes();
		}
		else{
			minute = now.getMinutes();
		}
		
		let second = "";
		if(now.getSeconds() < 10){
			second = "0"+now.getSeconds();
		}
		else{
			second = now.getSeconds();
		}
		
		strNow += "<span style='font-size: 28pt; font-weight: bold; color: #e68c0e;'>"+hour+":"+minute+":"+second+"</span>";
		
		$("span#clock").html(strNow);
		
	} // end of function showNowTime() ----------
	
	// 현재 시간 갱신하기
	function loopshowNowTime(){
		
		showNowTime();
		
		setTimeout(function(){
			loopshowNowTime();
		}, 1000); // 시간을 1초 마다 자동 갱신하는 것이다.
		
	} // end of function loopshowNowTime() ----------
	
	// 기상청 날씨정보 공공API XML 데이터 호출하기
	function showWeather(){
		
		$.ajax({
			url:"<%= ctxPath%>/weather/weatherXML.kedai",
			type:"get",
			dataType:"xml", 
			success:function(xml){ 
				const rootElement = $(xml).find(":root"); // current
				const weather = rootElement.find("weather");
				const updateTime = $(weather).attr("year")+"년 "+$(weather).attr("month")+"월 "+$(weather).attr("day")+"일 "+$(weather).attr("hour")+"시"; // 2024년 07월 29일 15시
				const localArr = rootElement.find("local"); // 97
				
				let html = "<div class='row'><div class='col-9'><i class='fa-solid fa-temperature-high'></i>&nbsp;&nbsp;<span style='font-weight:bold;'>"+updateTime+"</span>&nbsp;";
		            html += "<span style='color: #e68c0e; cursor: pointer; font-size: 9pt; text-decoration: underline;' onclick='javascript:showWeather();'>업데이트</span></div><div class='col-3 d-md-flex justify-content-md-end'><button type='button' data-toggle='modal' data-target='#myWeather' style='cursor: pointer; background: none;'>더보기&nbsp;<i class='fa-solid fa-angles-right'></i></button></div></div>";
		            html += "<div style='max-height: 250px; overflow-y: scroll; margin-top: 3%;'><table class='table table-hover' align='center'>";
			        html += "<tr>";
			        html += "<th style='width: 30%;'>지역</th>";
			        html += "<th style='width: 40%;'>날씨</th>";
			        html += "<th style='width: 30%;'>기온</th>";
			        html += "</tr>";
			        
			    // XML 을 JSON 으로 변경하기
		        var jsonObjArr = [];     
				
		        for(let i=0; i<localArr.length; i++){ // 97
		        	let local = $(localArr).eq(i); 
		        
		        	let icon = $(local).attr("icon");  
			        if(icon == "") {
			        	icon = "없음";
			        }
			        
			        html += "<tr>";
					html += "<td>"+$(local).text()+"</td><td><img src='<%= ctxPath%>/resources/images/weather/"+icon+".png' />&nbsp;&nbsp;"+$(local).attr("desc")+"</td><td>"+$(local).attr("ta")+"</td>";
					html += "</tr>";
					
					var jsonObj = {"locationName":$(local).text(), "ta":$(local).attr("ta")}; // 지역명, 기온
		        	
					jsonObjArr.push(jsonObj);
		        	
		        } // end of for ----------
		        
		        html += "</table></div>";
		        
		        $("div#displayWeather").html(html);
		        
		        // XML 을 JSON 으로 변경된 데이터를 가지고 차트그리기
		        var str_jsonObjArr = JSON.stringify(jsonObjArr);
		        
		        $.ajax({
		        	url:"<%= ctxPath%>/weather/weatherXMLtoJSON.kedai",
		        	type:"post",
					data:{"str_jsonObjArr":str_jsonObjArr},
					dataType:"JSON",
					success:function(json){
					// 	alert(json.length); // 11
					
						// chart 그리기
						var dataArr = [];
						$.each(json, function(index, item){
							dataArr.push([item.locationName, Number(item.ta)]);
						}); // end of $.each(json, function(index, item){}) ----------
					
						Highcharts.chart('weather_chart_container', {
						    chart: {
						        type: 'column'
						    },
						    title: {
						        text: ''
						    },
						    subtitle: {
						    //    text: 'Source: <a href="http://en.wikipedia.org/wiki/List_of_cities_proper_by_population">Wikipedia</a>'
						    },
						    xAxis: {
						        type: 'category',
						        labels: {
						            rotation: -45,
						            style: {
						                fontSize: '12px',
						                fontFamily: 'Verdana, sans-serif'
						            }
						        }
						    },
						    yAxis: {
						        min: -10,
						        title: {
						            text: '온도 (℃)'
						        }
						    },
						    legend: {
						        enabled: false
						    },
						    tooltip: {
						        pointFormat: '현재기온: <b>{point.y:.1f} ℃</b>'
						    },
						    series: [{
						        name: '지역',
						        data: dataArr, // 위에서 만든것을 대입시킨다.
						        dataLabels: {
						            enabled: true,
						            rotation: -90,
						            color: '#FFFFFF',
						            align: 'right',
						            format: '{point.y:.1f}', // one decimal
						            y: 10, // 10 pixels down from the top
						            style: {
						                fontSize: '12px',
						                fontFamily: 'Verdana, sans-serif'
						            }
						        }
						    }]
						});
					
					},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					}
		        });
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
		
	} // end of function showWeather() ----------
</script>

<%-- content start --%>
<div class="container-fluid">
	<section class="row justify-content-between">
		<div class="col-9" style="border: 0px solid red;">
			<div class="row justify-content-between mt-2">
				<div class="col-4 pr-2" style="height: 100px; display: flex; align-items: center;">
					<div style="width: 20%">
						<div style="width: 80px; height: 80px; border-radius: 50%; background: #e68c0e; text-align: center; align-content: center;">
							<img alt="people" src="<%= ctxPath%>/resources/images/common/people.png" width="60%" />
						</div>
					</div>
					<div style="width: 60%; margin-left: 20%;">
						<h6>사원 수</h6>
						<h6><span class="h2 memberTotalCount"></span>&nbsp;명</h6>
					</div>
				</div>
				<div class="col-4 pr-2" style="height: 100px; display: flex; align-items: center;">
					<div style="width: 20%">
						<div style="width: 80px; height: 80px; border-radius: 50%; background: #e68c0e; text-align: center; align-content: center;">
							<img alt="note" src="<%= ctxPath%>/resources/images/common/note.png" width="60%" />
						</div>
					</div>
					<div style="width: 60%; margin-left: 20%;">
						<h6>게시글 수</h6>
						<h6><span class="h2 boardTotalCount"></span>&nbsp;개</h6>
					</div>
				</div>
				<div class="col-3 pr-5" style="align-content: center; text-align: right;">
					<span id="clock"></span>
				</div>
			</div>
			
			<div class="row justify-content-between mt-2" style="border: 0px solid red; height: 300px;">
				<div class="col-6 pl-0" style="border: 1px solid red;" id="displayWeather"></div>
				<div class="modal" id="myWeather">
					<div class="modal-dialog">
				    	<div class="modal-content">
					      	<div class="modal-header">
					        	<h4 class="modal-title">오늘의 날씨(℃)</h4>
					        	<button type="button" class="close" data-dismiss="modal" aria-label="Close">&times;</button>
					      	</div>
					      	<div class="modal-body">
					        	<figure class="highcharts-figure">
								    <div id="weather_chart_container"></div>
								</figure> 
					      	</div>
			    		</div>
			  		</div>
				</div>
				
				<div class="col-6 pl-0" style="border: 1px solid red;">
					달력
				</div>
			</div>
		</div>
		
		<div class="col-3" style="border: 0px solid red; background: #2c4459; text-align: center; color: #fff;">
			<div class="mt-5" style="width: 180px; height: 180px; overflow: hidden; display: inline-block;">
				<img alt="img" style="width: 100%; height: 100%; border-radius: 50%;" src="<%= ctxPath%>/resources/files/employees/${(sessionScope.loginuser).imgfilename}">
			</div>
			<div class="mt-3">
				<h4>${(sessionScope.loginuser).name}&nbsp;[ ${(sessionScope.loginuser).nickname} ]</h4>
				<h5>${(sessionScope.loginuser).job_name}</h5>
				<span style="font-weight: bold;">포인트&nbsp;:</span>&nbsp;&nbsp;<fmt:formatNumber value="${(sessionScope.loginuser).point}" pattern="###,###" /> POINT
				<br><br>
				<div class="row pl-5 pr-5">
					<div class="myPageList col-6">
						<button class="dropdown-toggle" type="button" data-toggle="dropdown">마이페이지&nbsp;&nbsp;</button>
						<ul class="dropdown-menu" style="padding-left: 3%;">
							<li><a href="<%= ctxPath%>/member/memberEdit.kedai">나의 정보 수정</a></li>
							<li><a href="<%= ctxPath%>/myCar.kedai">나의 카셰어링</a></li>
							<li><a href="#">포인트 결제 내역</a></li>
							<li><a href="#">나의 결재 내역</a></li>
						</ul>
					</div>
					<div class="col-6">
						[&nbsp;<a href="javascript:goCoinPurchaseTypeChoice('<%= ctxPath%>', '${(sessionScope.loginuser).empid}')">포인트충전</a>&nbsp;]
					</div>
				</div>
			</div>
		</div>
	</section>
	
	<section class="row justify-content-between mt-2">
		<div class="col-5 pl-0" style="border: 1px solid red; height: 350px;">
			<ul class="nav nav-tabs">
				<li class="nav-item">
					<a class="nav-link active" data-toggle="tab" href="#menu1">사내공지 <input type="hidden" name="category_code" value="1" /></a>
				</li>
				<li class="nav-item">
					<a class="nav-link" data-toggle="tab" href="#menu2">팝업일정<input type="hidden" name="category_code" value="2" /></a>
				</li>
			</ul>
		
			<div class="tab-content">
				<div class="tab-pane container px-0 active" id="menu1"></div>
				<div class="tab-pane container px-0" id="menu2"></div>
			</div>	
		</div>
			
		<div class="col-3 pl-0" style="border: 1px solid red; text-align: center;">
			<div class="h2" style="width: 120px; height: 40px; background: #e68c0e; color: #fff; margin: 0 auto;">MENU</div>
			<div data-toggle='modal' data-target='#myMenu' style="margin-top: 8%;"><span class="filename" style="cursor: pointer;"></span></div>
			<div class="modal" id="myMenu">
				<div class="modal-dialog" style="max-width: 900px;">
			    	<div class="modal-content" style="width: 900px; height: 800px;">
				      	<div class="modal-header">
				        	<div class="modal-title h3 subject"></div>
				        	<button type="button" class="close" data-dismiss="modal" aria-label="Close">&times;</button>
				      	</div>
				      	<div class="modal-body">
				        	<div><span class="filename"></span></div>
				        	<br>
				        	<div><button class="btn pointMinus_btn">결제하기</button></div>
				      	</div>
		    		</div>
		  		</div>
			</div>
		</div>
		
		<div class="col-4 px-0" style="border: 1px solid red; text-align: center;">
			<h4>chart</h4>
		</div>
	</section>
</div>
<%-- content end --%>