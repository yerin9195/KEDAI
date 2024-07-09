<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String ctxPath = request.getContextPath();
	//     /KEDAI
%>
<style type="text/css">
	a{
		color: #2c4459
	}
</style>

<script type="text/javascript">

</script>

<div>
<a href="<%= ctxPath%>/member/memberEdit.kedai">나의 정보 수정</a><br>
<a href="<%= ctxPath%>/myCar.kedai">나의 차량 정보 등록</a><br>
<a href="<%= ctxPath%>/myCarReserveAndPay.kedai">나의 카셰어링 예약 및 결제내역</a><br>
<a href="#">포인트 결제 내역</a><br>
<a href="#">나의 결재 내역</a><br>
<a href="#">내가 만든 설문조사</a><br>
</div>