<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String ctxPath = request.getContextPath();
	//     /KEDAI
%>
<style type="text/css">
.itemTag {
    display: block;
    width: 340px;
    height: 48px; 
    border: 1px solid #00a1e4; 
    text-align: center; 
    margin: 16px auto; 
    color: #00a1e4; 
    font-size: 15px;
    line-height: 48px;
    font-weight: bold;
}	
.btnRegister button {
	border-radius: 25px;
	color: #fff;
	width: 200px;
	height: 50px;
}
.btnRegister button:nth-child(1) {
	background: #2c4459;
	margin-right: 10px;
}
.btnRegister button:nth-child(2) {
	background: #e68c0e;
}

</style>

<script type="text/javascript">

// Function Declaration
function goEdit(){
	location.href=`<%= ctxPath%>/myCarEdit.kedai`;
} // end of function goRegister() ----------

function goBack(){
	location.href="javascript:history.back();"
} // end of function goReset() ----------

function goOwner(){
	location.href=`<%= ctxPath%>/owner.kedai`;
}
function goCustomer(){
	location.href=`<%= ctxPath%>/customer.kedai`;
}

</script>

<%-- content start --%>	
<div style="border: 0px solid red; padding: 5% 0;">
<h3><span class="icon"><i class="fa-solid fa-seedling"></i></span>&nbsp;&nbsp;나의 차량 정보</h3>
<hr style="color: gray; width: 90%;">
<div style="border-top: 5px solid #2c4459; border-left: 1px solid lightgray; border-bottom: 1px solid lightgray; border-right: 1px solid lightgray; padding: 1% 0; width: 90%; display:flex;">
	<div class="col-4" style="border: 0px solid blue; text-align:center;" >
		<br><br>
		<img src="<%= ctxPath%>/resources/images/member/DORY.jpg" style="width:90%;"/>
		<br><br><br>	
	</div>
	<div class="col-8" style="border: 0px solid red; padding-top:3%; padding-left: 3%;">
		<h2>차종</h2>
		<hr style="color: gray; width: 90%;">
		<div style=" display: flex;">
			<div class="col-6" style="border-right: 2px solid lightgray;">
				<h4>운전 종별</h4>
				<span style="display:block; text-align: center; font-size: 30pt;">
					<i class="fa-solid fa-id-card"></i>&nbsp;&nbsp;
					<span style="font-size:23pt;">2종</span>
				</span>	
			</div>
			<div class="col-6">
				<h4>운전 경력</h4>
				<span style="display:block; text-align: center; font-size: 30pt;">
					<i class="fa-solid fa-car"></i>&nbsp;&nbsp;
					<span style="font-size:23pt;"> 3년 이상</span>
				</span>
			</div>
		</div>
		<div style="display: flex; margin-top: 4%;">
			<div class="col-6" style="border-right: 2px solid lightgray;">
				<h4>보험가입여부</h4>
				<span style="display:block; text-align: center; font-size: 30pt;"><i class="fa-solid fa-circle-check"></i></span>	
			</div>
			<div class="col-6">
				<h4>약관동의여부</h4>
				<span style="display:block; text-align: center; font-size: 30pt;"><i class="fa-solid fa-circle-xmark"></i></span>
			</div>
		</div>
	</div>
</div>
<div class="mt-3" style="position: relative; left: 500px; top: 85px;">
	<div class="btnRegister">
        <button type="button" onclick="goEdit()">수정하기</button>
        <button type="reset" onclick="goBack()">뒤로가기</button>
        <button type="reset" onclick="goOwner()">카셰어링현황(차주)</button>
        <button type="reset" onclick="goCustomer()">카셰어링신청현황(신청자)</button>
    </div>
</div>
</div>

<!-- 차량정보가 없을때는 등록된 차량정보가 없다고 띄우고 수정하기 버튼이 등록하기 버튼으로 표시되어야한다. -->
<%-- content end --%>