<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>

<%
   String ctxPath = request.getContextPath();
%>
<!-- <link rel="stylesheet" type="text/css" href="othercom_list.css" /> -->

<style type="text/css">
*{
  margin: 0; padding: 0;
}
div#container{}
div#myHead{
  height: 80px;
  background-color: #999;
}
div#row{
  display: flex !important;
}

div#othercom_list{
	width:100%;
	/* width: calc(100vw - 250px); */
	display: flex;
	justify-content: center;
	align-items: center;
}

/* 여기서부터 시작*/
div#othercom_list .artWrap {
  display: flex;
  justify-content: space-around;
  flex-wrap: wrap;  
  gap: 20px;
  border: solid 1px orange;
/*   margin: 2%; */
}

div#cover_all{
  width: 80%;
  border: solid 1px purple;
  margin-left : 5%;

}


div#othercom_list .artWrap article {
	width: calc(33.33% - 20px);

  background-color: #fff;
  box-shadow: 0 0 20px rgba(0, 0, 0, 0.25);
  padding-bottom: 20px;
  border-radius: 10px;
  flex: 1 1 calc(33.33% - 20px);
}

div#othercom_list .artWrap article:nth-of-type(3) ~ article {
  margin-top: 20px;
}

div#othercom_list .artWrap article .cardHead {

  color: white;
  background-color:#2C4459;
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 10px 10px 10px 30px;
  
}

div#othercom_list .artWrap article .cardHead h4 {
  font-size: 18px;
  font-weight: 700;
  line-height: 40px;
  text-indent: 40px;

}
div#othercom_list .artWrap article .cardHead h6 {
	font-size:14px;
	font-weight: 400;
	color: #e68c0e; 
	padding-right:50%;
	font-style: italic;
	
}

div#othercom_list .artWrap article .cardHead button {
  width: 30px;
  height: 30px;
  border-radius: 50px;
}
div#othercom_list .artWrap article .cardHead button img {
  height: 16px;
}
.cardBody {
  list-style-type: none;
  padding: 0;
}
div#othercom_list .artWrap article .cardBody li {
  padding-top:3%;
  padding-left: 5%;
  display: flex;
}
div#othercom_list .artWrap article .cardBody li .listImg {
  width: 40px;
  height: 40px;
  display: flex;
  justify-content: center;
  align-items: center;
}
div#othercom_list .artWrap article .cardBody li .listImg img {
  height: 16px;
}
div#othercom_list .artWrap article .cardBody li .listTxt {
  line-height: 40px;
}

.popupWrap {
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.6);
  position: fixed;
  top: 0;
  left: 0;
  display: none;
  justify-content: center;
  align-items: center;
}
.popupWrap .popup {
  width: calc(100% - 800px);
  background-color: #f9f9f9;
  border-radius: 20px;
  overflow: hidden;
}
.popupWrap .popup .popupHead {
  display: flex;
  justify-content: space-between;
  align-items: center;
  background-color: #2C4459;
  color: #fff;
  padding-right: 20px;
}
.popupWrap .popup .popupHead h4 {
  font-size: 24px;
  font-weight: 700;
  line-height: 60px;
  text-indent: 40px;
}

.popupWrap .popup .popupHead h4 {

}
.popupWrap .popup .popupHead button.close {
  width: 30px;
  height: 30px;
  border-radius: 50px;
  background-color: white;
  padding-bottom: 3px;
}
.popupWrap .popup .popupHead button.close  > img {
  height: 16px;
}
.popupWrap .popup .popupBody {
  padding: 100px 0;
}
.popupWrap .popup .popupBody .forAlign {
  display: flex;
  justify-content: center;
  align-items: center;
}
.popupWrap .popup .popupBody .popupImg {
  width: 180px;
  height: 180px;
  background-color: #999;
}
.popupWrap .popup .popupBody .popupList {
  margin-left: 50px;
}
.popupWrap .popup .popupBody .popupList li {
  width: 300px;
  display: flex;
  margin-top: 20px;
  font-size: 18px;
  font-weight: 700;
}
.popupWrap .popup .popupBody .popupList li:first-of-type {
  margin-top: 0;
}
.popupWrap .popup .popupBody .popupList li:hover {
  background-color: #eee;
}
.popupWrap .popup .popupBody .popupList li .listImg {
  width: 40px;
  height: 40px;
  display: flex;
  justify-content: center;
  align-items: center;
}
.popupWrap .popup .popupBody .popupList li .listImg img {
  height: 16px;
}
.popupWrap .popup .popupBody .popupList li .listTxt {
  line-height: 40px;
}

.h5{
  font-weight: 700;
}

.h6{
	font-style:italic;
	color:#e68c0e;
}

.edit{
	border: solid 0px red;
	display: flex;
	padding-top: 15px;

	
}

.othercom-reg{
	background-color:#e68c0e;
	float:right;
	font-size:17px;

	
}

.othercom-reg:hover{
	background-color:#2C4459;
	color:#e68c0e;
}
 
.reg{
	border: 1px solid blue;
	width:20%;
	border-radius:3px;
	color:#2C4459;
	font-weight:700;
	float:right;
	
	
}

.reg-search{
	border:1px solid red;
	margin : 20px 10px;
}



.editcom{
	border-radius: 3px;
	width: auto;
	height: 50px;
	background-color: #e68c0e;
	color: 	#2C4459;
	font-weight: 700;
}

.delcom{
	border-radius: 3px;
	width: auto;
	height: 50px;
	background-color: #2C4459;
	color: 	#e68c0e;
	font-weight: 700;
	margin: 0 auto;
}

.othercom_title{
	font-size: 20px;
	border: 1px solid blue;
	font-weight: 700;
	line-height: 40px;
	margin-top: 3%;
}

</style>

<script type="text/javascript">

$(function(){
	  $('.cardHead button').click(function(){
		  var partner_no = $(this).closest('article').attr('partner_no');
		  console.log(partner_no)
	    // 클릭한 거래처 정보 상세보기
	    $.ajax({
	      url: "<%= ctxPath%>/partnerPopupClick.kedai?partner_no=" + partner_no,
	      type: "get",
	      async: true,
/* 	      data: {
	        "partner_name": partner_name
	      },
 */	      dataType: "json",
	      success: function(json){
	        // 서버에서 거래처이름으로 정보 얻어오기
	        console.log("??", json.partner_name)
	        if(json.partner_name != null){
	          $("#pop_partnerName").html(json.partner_name);
	          $("#pop_partnerNo").html(json.partner_no);
	          $("#pop_partnerImg").attr("src", "./resources/files/" + json.imgfilename);
	          $("#pop_partnerAddress").html(json.partner_address);
	          $("#pop_partnerDetailaddress").html(json.partner_detailaddress);
	          $("#pop_partnerUrl").html(json.partner_url);
	          $("#pop_partEmpTel").html(json.part_emp_tel);
	          $("#pop_partEmpEmail").html(json.part_emp_email);
	          $("#pop_partEmpName").html(json.part_emp_name);
	          $("#pop_partEmpRank").html(json.part_emp_rank);
	      
	          
	          /*
				private String partner_type;
				private String partner_url; 
				private String partner_postcode;
				private String partner_detailaddress;
				private String partner_extraaddress;
				private String imgfilename;
				private String originalfilename;
				private String part_emp_name;
				private String part_emp_tel;
				private String part_emp_email;
				private String part_emp_dept;
				private String part_emp_rank;
	          */
	          
	          
	        } else {
	          $("#partnerNameContainer").html("거래처이름을 불러오지 못했습니다.");
	        }
	      },
	      error: function(request, status, error) {
	        alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
	      }
	    });
		  $('.popupWrap').css({display: 'flex'});
	  });
	 
	  
	  
	  $('.popupHead button').click(function(){
	    $('.popupWrap').css({display: 'none'});
	  });
	});
	/* 카드 팝업 열고 닫기 끝 */

	$(".cardHead button").click(function(){
	  // 필요한 추가 작업이 있으면 여기에 작성
	});
	
	function editPopup() {
		const partner_no = $("#pop_partnerNo").html();
		location.assign("othercom_modify.kedai?partner_no=" + partner_no);
	}


	
	
	
</script>


<div id="cover_all">
<div class="othercom_title">
		거래처 목록
</div>
<div class="reg-search">
	
    <c:if test="${(sessionScope.loginuser).fk_job_code eq '1'}">
        <div class="reg"><a href="<%= ctxPath%>/othercom_register.kedai" class="othercom-reg">거래처등록하기</a></div>
    </c:if> 
	
    <form name="employee_search_frm" style="display:flex;">
		<select name ="searchType" style="margin-right:10px;">
			<option value="">검색대상</option>
			<option value="department">부서</option>
			<option value="position">직위</option>
			<option value="name">이름</option>
		</select>
		<input type="search" name="searchWord;" style="margin-right:10px"/>
		<input type="button" name="searchWord;" onclick="goSearch()" value="검색"/>
	</form>
</div>  
   
<div id="othercom_list" class="othercom_list">
  <div class="artWrap">
    <c:forEach var="partvo" items="${requestScope.partnervoList}">
      <article partner_no="${partvo.partner_no}">
        <div class="cardHead">
          <div class="h5"><span id="asdasd">${partvo.partner_name}</span>&nbsp;&nbsp;&nbsp;<span class="h6">업종:${partvo.partner_type}</span></div>
          <button class="detailbtn"><img src="<%= ctxPath%>/resources/images/common/chevron-right.svg" alt="" id="detailbtn"></button>
        </div>
        <ul class="cardBody">
          <li>
            <div class="listImg">
              <img src="<%= ctxPath%>/resources/images/common/team.svg" alt="">
            </div>
            <div class="listTxt">${partvo.part_emp_dept}</div>
          </li>
          <li>
            <div class="listImg"><img src="<%= ctxPath%>/resources/images/common/user.svg" alt=""></div>
            <div class="listTxt">
              <span>${partvo.part_emp_name}</span>
              <span>${partvo.part_emp_rank}</span>
            </div>
          </li>
          <li>
            <div class="listImg"><img src="<%= ctxPath%>/resources/images/common/phone.svg" alt=""></div>
            <div class="listTxt">${partvo.part_emp_tel}</div>
          </li>
          <li>
            <div class="listImg"><img src="<%= ctxPath%>/resources/images/common/email.svg" alt=""></div>
            <div class="listTxt">${partvo.partner_url}</div>
          </li>
        </ul>
      </article>
    </c:forEach>
  </div>
</div>


<!-- popup area -->
<div class="popupWrap">
  <div class="popup">
    <div class="popupHead">
      <h4 id="pop_partnerName"></h4>
      <button class="close"><img src="<%= ctxPath%>/resources/images/common/xmark.svg" alt=""></button>
    </div>
    <div class="popupBody">
      <div class="forAlign">
        <div class="popupImg" style="width:200px; border: 1px solid red; height:200px; overflow: hidden;">
          <img id="pop_partnerImg" src="" alt="" style="object-fit: cover;">
			<!-- 사진들어오는곳  -->
        </div>
        <ul class="popupList">
          <li>
            <div class="listImg">
              <img src="<%= ctxPath%>/resources/images/common/business_num.svg" alt="">
            </div>
            <div id="pop_partnerNo" class="listTxt"></div>
          </li>
          <li>
            <div class="listImg">
              <img src="<%= ctxPath%>/resources/images/common/comp.svg" alt="">
            </div>
            <div id="pop_partnerAddress" class="listTxt"></div>
          </li>
          <li>
            <div class="listImg">
              <img src="<%= ctxPath%>/resources/images/common/homepage.svg" alt="">
            </div>
            <div id="pop_partnerUrl" class="listTxt"></div>
          </li>
        </ul>
        <ul class="popupList">
          <li>
            <div class="listImg"><img src="<%= ctxPath%>/resources/images/common/user.svg" alt=""></div>
            <div class="listTxt">
              <span id="pop_partEmpName"></span>
              <span id="pop_partEmpRank"></span>
            </div>
          </li>
          <li>
            <div class="listImg"><img src="<%= ctxPath%>/resources/images/common/phone.svg" alt=""></div>
            <div id="pop_partEmpTel" class="listTxt"></div>
          </li>
          <li>
            <div class="listImg"><img src="<%= ctxPath%>/resources/images/common/email.svg" alt=""></div>
            <div id="pop_partEmpEmail" class="listTxt"></div>
          </li>
        </ul>
      </div>
      <c:if test="${(sessionScope.loginuser).fk_job_code eq '1'}">
        <div class="buttonContainer" style="width: 200px; margin: 1% auto; border:solid 0px blue;">
          <button onclick="editPopup()" class="editcom" style="border: solid 0px red; float: left; margin-right: 10px;">수정하기</button>
          <button onclick="delPopup()" class="delcom" style="border: solid 0px red; float: left;">삭제하기</button>
        </div>
      </c:if>
    </div>
  </div>
</div>
</div>