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
</style>

<%-- content start --%>
<div class="container-fluid">
	<section class="row justify-content-between">
		<div class="col-8" style="border: 1px solid red;">
			<div class="row justify-content-between mt-2">
				<div class="col-5 pl-5 pr-2" style="height: 100px; display: flex; align-items: center;">
					<div style="width: 60%">
						<h6>사원 수</h6>
						<h3>1,543</h3>
					</div>
					<div style="width: 20%">
						<div style="width: 80px; height: 80px; border-radius: 50%; background: #e68c0e; text-align: center; align-content: center;">
							<img alt="people" src="<%= ctxPath%>/resources/images/common/people.png" width="60%" />
						</div>
					</div>
				</div>
				<div class="col-5 pl-5 pr-2" style="height: 100px; display: flex; align-items: center;">
					<div style="width: 60%">
						<h6>게시글 수</h6>
						<h3>455</h3>
					</div>
					<div style="width: 20%">
						<div style="width: 80px; height: 80px; border-radius: 50%; background: #e68c0e; text-align: center; align-content: center;">
							<img alt="note" src="<%= ctxPath%>/resources/images/common/note.png" width="60%" />
						</div>
					</div>
				</div>
			</div>
			
			<div class="row justify-content-between mt-2" style="border: 1px solid red; height: 200px;">
				<div class="col-4" style="border: 1px solid red;">
					날씨
				</div>
				<div class="col-3" style="border: 1px solid red;">
					차트
				</div>
				<div class="col-5" style="border: 1px solid red;">
					달력
				</div>
			</div>
		</div>
		
		<div class="col-4" style="border: 1px solid red; background: #2c4459; text-align: center; color: #fff;">
			<div class="mt-3" style="width: 120px; height: 120px; border-radius: 50%; background: #fff; display: inline-block;">
			
			</div>
			<div class="mt-3">
				<h4>이름&nbsp;[ 닉네임 ]</h4>
				<h5>직책</h5>
				<span style="font-weight: bold;">포인트&nbsp;:</span>&nbsp;&nbsp;<fmt:formatNumber value="${(sessionScope.loginuser).point}" pattern="###,###" /> POINT
				<br><br>
				[&nbsp;<a href="javascript:goEditMyInfo('${(sessionScope.loginuser).userid}','<%= ctxPath%>')">마이페이지</a>&nbsp;]&nbsp;&nbsp;&nbsp;&nbsp;
               	[&nbsp;<a href="javascript:goCoinPurchaseTypeChoice('${(sessionScope.loginuser).userid}','<%= ctxPath%>')">포인트충전</a>&nbsp;]
			</div>
		</div>
	</section>
	
	<section class="row justify-content-between mt-2">
		<div class="col-8 pl-0" style="border: 1px solid red; height: 300px;">
			<ul class="nav nav-tabs">
				<li class="nav-item">
					<a class="nav-link active" data-toggle="tab" href="#home">사내공지</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" data-toggle="tab" href="#menu1">식단표</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" data-toggle="tab" href="#menu2">팝업일정</a>
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
			<h4>식단표</h4>
			<img alt="menu" src="" width="100%" />
		</div>
	</section>

	<section class="row justify-content-between mt-2">
		<div class="col-4" style="border: 1px solid red;">
			<h4>메모장</h4>
		</div>
		<div class="col-8" style="border: 1px solid red;">
			<h4>투표하기</h4>
			<div class="row">
				<div class="col-6">
					<h6>이달의 우수사원</h6>
					<a href="" style="color: #363636;"><p>투표하러 가기&nbsp;&nbsp;<i class="fa-solid fa-angles-right"></i></p></a> 
				</div>
				<div class="col-6">
					<h6>점심 메뉴 추천</h6>
					<a href="" style="color: #363636;"><p>투표하러 가기&nbsp;&nbsp;<i class="fa-solid fa-angles-right"></i></p></a>
				</div>
			</div>
		</div>
	</section>
</div>
<%-- content end --%>