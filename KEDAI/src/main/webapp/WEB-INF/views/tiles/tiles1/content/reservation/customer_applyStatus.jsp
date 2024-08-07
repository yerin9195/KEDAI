<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String ctxPath = request.getContextPath();
	//     /KEDAI
%>
<style type="text/css">
.nav-tabs .nav-link.active {
    background-color: #2c4459; /* 활성화된 탭의 배경색 변경 */
    color: white; /* 활성화된 탭의 글자색 변경 */
    border-bottom-color: transparent; /* 활성화된 탭의 하단 선 제거 */
}
.nav-tabs .nav-item {
    flex: 1; /* 각 탭을 균등하게 분배 */
    text-align: center;
}
</style>

<script type="text/javascript">

</script>



<%-- content start --%>	
<div style="border: 0px solid red; padding: 2% 0; width: 90%;">
<!-- Navigation Tabs -->
<ul class="nav nav-tabs" style="margin-bottom:4%;">
    <li class="nav-item">
        <a class="nav-link" style="color: black; font-size:12pt;" href="<%= ctxPath %>/myCar.kedai">차량정보</a>
    </li>
    <li class="nav-item">
        <a class="nav-link" style="color: black; font-size:12pt;" href="<%= ctxPath %>/owner_Status.kedai">카셰어링현황(차주)</a>
    </li>
    <li class="nav-item">
        <a class="nav-link" style="color: black; font-size:12pt;" href="<%= ctxPath %>/owner_Settlement.kedai">카셰어링정산(차주)</a>
    </li>
    <li class="nav-item">
        <a class="nav-link active" style="color: white; font-size:12pt;" href="<%= ctxPath %>/customer_applyStatus.kedai">카셰어링신청현황(신청자)</a>
    </li>
    <li class="nav-item">
        <a class="nav-link" style="color: black; font-size:12pt;" href="<%= ctxPath %>/customer_Settlement.kedai">카셰어링정산(신청자)</a>
    </li>
</ul>



    <div style="display: flex; border: solid 0px red; width: 100%;">
        <div style="margin: auto; width: 100%">
            <div style="overflow-x: auto;"> <!-- 가로 스크롤바 추가 -->
                <table style="width: 100%; margin-top: 1%;" class="table table-bordered">
                    <thead>
                        <tr>
                            <th style="text-align: center;">no</th>
                            <th style="text-align: center;">일자</th>
                            <th style="text-align: center;">출발예정시각</th>
                            <th style="text-align: center;">탑승자</th>
                            <th style="text-align: center;">탑승여부</th>
                            <th style="text-align: center;">탑승위치</th>
                            <th style="text-align: center;">탑승시간</th>
                            <th style="text-align: center;">하차위치</th>
                            <th style="text-align: center;">하차시간</th>
                            <th style="text-align: center;">이용시간</th>
                            <th style="text-align: center;">정산금액</th>
                            <th style="text-align: center;">결제금액</th>
                            <th style="text-align: center;">미결제금액</th>
                            <th style="text-align: center;">메일보내기</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:if test="${not empty requestScope.owner_SettlementList}">
                            <c:forEach var="owner_carShare" items="${requestScope.owner_SettlementList}" varStatus="status">
                                <tr>
                                    <td align="center">${(requestScope.totalCount)-(requestScope.currentShowPageNo-1)*(requestScope.sizePerPage)-(status.index)}</td>
                                    <td align="center">${owner_carShare.share_date}</td>
                                    <td align="center">${owner_carShare.share_may_time}</td>
                                    <td align="center">${owner_carShare.nickname_applicant}</td>
                                    <c:if test="${not empty owner_carShare.getin_time and not empty owner_carShare.getout_time }">
                                        <td align="center"><i class="fa-solid fa-circle"></i></td>
                                    </c:if>
                                    <c:if test="${empty owner_carShare.getin_time or empty owner_carShare.getout_time }">
                                        <td align="center"><i class="fa-solid fa-xmark"></i></td>
                                    </c:if>
                                    <td align="center" class="rdp_name">${owner_carShare.rdp_name} </td>
                                    <td align="center"><input type="text" style="border: none; font-size: 15pt;" name="getin_time_${status.index}" value="${owner_carShare.getin_time}" readonly/></td>
                                    <td align="center" class="rds_name">${owner_carShare.rds_name}</td>
                                    <td align="center"><input type="text" style="border: none; font-size: 15pt;" name="getout_time_${status.index}" value="${owner_carShare.getout_time}" readonly/></td>
                                    <c:if test="${not empty owner_carShare.getin_time and not empty owner_carShare.getout_time }">
                                        <td align="center" style="color: red;">${owner_carShare.use_time}분</td>
                                    </c:if>
                                    <c:if test="${empty owner_carShare.getin_time or empty owner_carShare.getout_time }">
                                        <td align="center"><i class="fa-solid fa-xmark"></i></td>
                                    </c:if>
									<td align="center">
									    <c:choose>
									        <c:when test="${owner_carShare.settled_amount ne 0}">
									            <fmt:formatNumber value="${owner_carShare.settled_amount}" type="number" /><span>point</span>
									        </c:when>
									        <c:otherwise>
									            <i class="fa-solid fa-xmark"></i>
									        </c:otherwise>
									    </c:choose>
									</td>
									
									<td align="center">
									    <c:choose>
									        <c:when test="${owner_carShare.payment_amount ne 0}">
									            <fmt:formatNumber value="${owner_carShare.payment_amount}" type="number" /><span>point</span>
									        </c:when>
									        <c:otherwise>
									            <i class="fa-solid fa-xmark"></i>
									        </c:otherwise>
									    </c:choose>
									</td>
									
									<td align="center">
									    <c:choose>
									        <c:when test="${owner_carShare.settled_amount eq 0}">
									           	 이용전
									        </c:when>
									        <c:when test="${owner_carShare.nonpayment_amount ne 0.0}">
									            <fmt:formatNumber value="${owner_carShare.nonpayment_amount}" type="number" /><span>point</span>
									        </c:when>
									        <c:otherwise>
									            <i class="fa-solid fa-xmark"></i>
									        </c:otherwise>
									    </c:choose>
									</td>
									<c:if test="${owner_carShare.settled_amount eq 0}">
									    <td align="center"> </td>
									</c:if>
									<c:if test="${owner_carShare.settled_amount ne 0}">
									    <td align="center">
										    <button type="button" style="background-color:white;" 
										        onclick="request_payment('${status.index}', '${owner_carShare.pf_empid}', '${owner_carShare.pf_res_num}', '${owner_carShare.nickname_applicant}', '${owner_carShare.email_applicant}', '${owner_carShare.nonpayment_amount}')">
										        <i class="fa-solid fa-comments"></i>
										    </button>
										</td>
									</c:if>
                                
                                </tr>
                            </c:forEach>
                        </c:if>
                        <c:if test="${empty requestScope.owner_SettlementList}">
                            <tr>
                                <td colspan="13">데이터가 존재하지 않습니다.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div> <!-- 가로 스크롤바 끝 -->
            <div id="pageBar" align="center" style="border: solid 0px gray; width: 50%; margin: 1.5% auto;">
                ${requestScope.pageBar}
            </div>
        </div>
    </div>
</div>
<form name="goViewFrm">
   <input type="hidden" name="board_seq" />
   <input type="hidden" name="goBackURL" />
   <input type="hidden" name="searchType" />
   <input type="hidden" name="searchWord" />
</form>

