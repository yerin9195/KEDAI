<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String ctxPath = request.getContextPath();
	//     /KEDAI
%>
<style type="text/css">
	.nav-tabs {
		padding-bottom: 1px;
		border-bottom: 1px solid #e68c0e;
	}
	.nav-tabs .nav-link {
		color: #e68c0e;
		background: #fff;
	}
	.nav-tabs .nav-link.active {
		color: #fff;
		background: #e68c0e;
	}
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
</style>

<script type="text/javascript">
	$(document).ready(function(){
		
		loopshowNowTime();
	//	showWeather();
		
		// 사원수 조회하기
		$.ajax({
			url: "${pageContext.request.contextPath}/member/memberTotalCountJSON.kedai",
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
			url: "${pageContext.request.contextPath}/board/boardTotalCountJSON.kedai",
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
</script>

<%-- content start --%>
<div class="container-fluid">
	<section class="row justify-content-between">
		<div class="col-9" style="border: 1px solid red;">
			<div class="row justify-content-between mt-2">
				<div class="col-4 pl-5 pr-2" style="height: 100px; display: flex; align-items: center;">
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
				<div class="col-4 pl-5 pr-2" style="height: 100px; display: flex; align-items: center;">
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
			
			<div class="row justify-content-between mt-2" style="border: 1px solid red; height: 300px;">
				<div class="col-6" style="border: 1px solid red;">
					날씨
				</div>
				<div class="col-6" style="border: 1px solid red;">
					달력
				</div>
			</div>
		</div>
		
		<div class="col-3" style="border: 1px solid red; background: #2c4459; text-align: center; color: #fff;">
			<div class="mt-5" style="width: 180px; height: 180px; overflow: hidden; display: inline-block;">
				<img alt="img" style="width: 100%; height: 100%; border-radius: 50%;" src="<%= ctxPath%>/resources/files/${(sessionScope.loginuser).imgfilename}">
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
	
	<section class="row justify-content-between mt-2" style="height: 350px;">
		<div class="col-8 pl-0" style="border: 1px solid red;">
			<ul class="nav nav-tabs">
				<li class="nav-item">
					<a class="nav-link active" data-toggle="tab" href="#home">사내공지</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" data-toggle="tab" href="#menu1">팝업일정</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" data-toggle="tab" href="#menu2">식단표</a>
				</li>
			</ul>
		
			<div class="tab-content py-3">
				<div class="tab-pane container active" id="home">
					Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
				</div>
				<div class="tab-pane container" id="menu1">
					Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
				</div>
				<div class="tab-pane container" id="menu2">
					Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam.
				</div>
			</div>	
		</div>
			
		<div class="col-4 pl-0 pr-0" style="border: 1px solid red; text-align: center;">
			<h4>chart</h4>
		</div>
	</section>
</div>
<%-- content end --%>