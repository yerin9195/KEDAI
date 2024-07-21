<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%
   String ctxPath = request.getContextPath();
%>   

<style type="text/css">
    th {background-color: #e68c0e;}
    .subjectStyle {font-weight: bold; color: navy; cursor: pointer; }
    a {text-decoration: none !important;} /* 페이지바의 a 태그에 밑줄 없애기 */
</style>

<script type="text/javascript">
    $(document).ready(function(){
        $("span.subject").hover(function(e){
            $(e.target).addClass("subjectStyle");
        }, function(e){
            $(e.target).removeClass("subjectStyle");
        });            
    });

    function goRegister(){
        location.href=`<%= ctxPath%>/carRegister.kedai`;
    }

    function goApply(formName){
        const frm = document.forms[formName];
        frm.action = "<%= ctxPath%>/carApply_detail.kedai"; 
        frm.method = "post";
        frm.submit();
    }
</script>
    
<div style="display: flex; width: 100%;">
    <div style="margin: auto; padding: 3%; width: 100%">

        <h2 style="margin-bottom: 30px; border-bottom: 1px solid orange; border-top: 1px solid orange;width:14%;">CAR SHARING</h2>
   
        <form name="member_search_frm">
            <select name="searchType">
               <option value="">검색대상</option>
               <option value="name">출발지</option>
               <option value="userid">도착지</option>
               <option value="email">사원명</option>
               <option value="email">셰어링날짜</option>
            </select>
            &nbsp;
            <input type="text" name="searchWord" />
            <input type="text" style="display: none;" /> <%-- 조심할 것은 type="hidden" 이 아니다. --%> 
            <button type="button" class="btn btn-secondary" onclick="goSearch()">검색</button>
        </form>
        
        <table style="width: 100%; margin-top: 1%;" class="table table-bordered">
            <thead>
                <tr>
                    <th style="width: 70px; text-align: center;">no</th>
                    <th style="width: 240px; text-align: center;">출발지 -> 도착지</th>
                    <th style="width: 70px; text-align: center;">차주 닉네임</th>
                    <th style="width: 200px; text-align: center;">셰어링 날짜</th>
                    <th style="width: 70px; text-align: center;">출발시간</th>
                    <th style="width: 70px; text-align: center;">신청가능여부</th>
                    <th style="width: 70px; text-align: center;">조회수</th>
                </tr>
            </thead>
            <tbody>
                <c:if test="${not empty requestScope.carShareList}">
                    <c:forEach var="carShare" items="${requestScope.carShareList}" varStatus="status">
                        <tr>
                            <form name="carShareFrm${status.index}">
                                <input type="hidden" name="res_num" value="${carShare.res_num}"/>
                            </form> 
                            <td align="center">1</td>
                            <td>${carShare.dp_name} &nbsp;&nbsp;->&nbsp;&nbsp;${carShare.ds_name}</td>
                            <td align="center">${carShare.nickname}</td>
                            <c:set var="startDate" value="${carShare.start_date}" />
                            <c:set var="lastDate" value="${carShare.last_date}" />
                            <td align="center">
                                <fmt:parseDate value="${startDate}" var="parsedStartDate" pattern="yyyy-MM-dd HH:mm:ss" />
                                <fmt:formatDate value="${parsedStartDate}" pattern="yyyy-MM-dd" />
                                ~
                                <fmt:parseDate value="${lastDate}" var="parsedLastDate" pattern="yyyy-MM-dd HH:mm:ss" />
                                <fmt:formatDate value="${parsedLastDate}" pattern="yyyy-MM-dd" />
                            </td>
                            <td align="center">${carShare.start_time}</td>
                            <c:if test="${carShare.end_status == 1 && carShare.cancel_status == 1}">
                                <td align="center">
                                    <input type="button" value="신청가능" class="subject" onclick="goApply('carShareFrm${status.index}')" />
                                </td>
                            </c:if>
                            <c:if test="${carShare.end_status == 0 || carShare.cancel_status == 0}">
                                <td align="center">신청불가능</td>
                            </c:if>
                            <td align="center">조회수</td>
                        </tr>
                    </c:forEach>
                </c:if>
                <c:if test="${empty requestScope.carShareList}">
                    <tr>
                        <td colspan="7">데이터가 존재하지 않습니다.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>

        <div id="pageBar">
            <nav>
                <ul class="pagination">${requestScope.pageBar}</ul>
            </nav>
        </div>

        <button class="btn btn-secondary btn-sm btnUpdateComment" onclick="goRegister()">등록하기</button>
    </div>
</div>
