<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
	width: calc(100vw - 250px);
	/* height: calc(100vh - 80px); */
	
	  display: flex;
	  justify-content: center;
	  align-items: center;
}

/* 여기서부터 시작 */
div#othercom_list .artWrap {
  display: flex;
  justify-content: space-around;
  flex-wrap: wrap;
  width: 80%;
  padding-right:10%;
	
}
div#othercom_list .artWrap article {
  width: calc(33.33% - 20px);
  background-color: #fff;
  box-shadow: 0 0 20px rgba(0, 0, 0, 0.25);
  padding-bottom: 20px;
  border-radius: 10px;
  overflow: hidden;
}
div#othercom_list .artWrap article:nth-of-type(3) ~ article {
  margin-top: 20px;
}
div#othercom_list .artWrap article .cardHead {
  display: flex;
  justify-content: space-between;
  align-items: center;
  background-color: #2C4459;
  color: #fff;
  padding-right: 20px;
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
div#othercom_list .artWrap article .cardBody {
  margin-top: 20px;
}
div#othercom_list .artWrap article .cardBody li {
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
	border-radius: 3px;
	width: auto;
	height: 50px;
	background-color: #e68c0e;
	color: 	#2C4459;
	font-weight: 700;
}

.othercom-reg : hover{
	background-color: red;
}
.reg{
	
	margin: 80px 0 50px 1200px;
	
}

.editcom{
   
	border-radius: 3px;
	width: auto;
	height: 50px;
	background-color: #e68c0e;
	color: 	#2C4459;
	font-weight: 700;
	
}




</style>

<script type="text/javascript">
	$(function(){
	  // console.log('2222')
	  $('.cardHead button').click(
	    function(){
	      $('.popupWrap').css({display : 'flex'})
	    }
	  );
	  $('.popupHead button').click(
	    function(){
	      $('.popupWrap').css({display : 'none'})
	    }
	  );
	})
</script>
<body>

<div class="reg">
	<button class="othercom-reg">
		거래처등록하기
	</button>
	</div>

<div id="othercom_list" style="border: solid 1px red;">
	
  <section class="artWrap">
    <article>
      <div class="cardHead pl-5">
        <div class="h5 pt-3 ">거래처명&nbsp;&nbsp;&nbsp;<span class="h6">업종:</span></div>
        <button><img src="<%= ctxPath%>/resources/images/common/chevron-right.svg" alt=""></button>
      </div>
      <ul class="cardBody">
        <li>
          <div class="listImg">
            <img src="<%= ctxPath%>/resources/images/common/team.svg" alt="">
          </div>
          <div class="listTxt">담당자부서</div>
        </li>
        <li>
          <div class="listImg"><img src="<%= ctxPath%>/resources/images/common/user.svg" alt=""></div>
          <div class="listTxt">
            <span>홍길동</span>
            <span>직급</span>
          </div>
        </li>
        <li>
          <div class="listImg"><img src="<%= ctxPath%>/resources/images/common/phone.svg" alt=""></div>
          <div class="listTxt">010-0000-0000</div>
        </li>
        <li>
          <div class="listImg"><img src="<%= ctxPath%>/resources/images/common/email.svg" alt=""></div>
          <div class="listTxt">email@domain.name</div>
        </li>
      </ul>
    </article>
    <article>
      <div class="cardHead pl-5">
        <div class="h5 pt-3">거래처명&nbsp;&nbsp;&nbsp;<span class="h6">업종:</span></div>
        <button><img src="<%= ctxPath%>/resources/images/common/chevron-right.svg" alt=""></button>
      </div>
      <ul class="cardBody">
        <li>
          <div class="listImg">
            <img src="<%= ctxPath%>/resources/images/common/team.svg" alt="">
          </div>
          <div class="listTxt">담당자부서</div>
        </li>
        <li>
          <div class="listImg"><img src="<%= ctxPath%>/resources/images/common/user.svg" alt=""></div>
          <div class="listTxt">
            <span>홍길동</span>
            <span>직급</span>
          </div>
        </li>
        <li>
          <div class="listImg"><img src="<%= ctxPath%>/resources/images/common/phone.svg" alt=""></div>
          <div class="listTxt">010-0000-0000</div>
        </li>
        <li>
          <div class="listImg"><img src="<%= ctxPath%>/resources/images/common/email.svg" alt=""></div>
          <div class="listTxt">email@domain.name</div>
        </li>
      </ul>
    </article>
    <article>
      <div class="cardHead pl-5">
        <div class="h5 pt-3 ">거래처명&nbsp;&nbsp;&nbsp;<span class="h6">업종:</span></div>
        <button><img src="<%= ctxPath%>/resources/images/common/chevron-right.svg" alt=""></button>
      </div>
      <ul class="cardBody">
        <li>
          <div class="listImg">
            <img src="<%= ctxPath%>/resources/images/common/team.svg" alt="">
          </div>
          <div class="listTxt">담당자부서</div>
        </li>
        <li>
          <div class="listImg"><img src="<%= ctxPath%>/resources/images/common/user.svg" alt=""></div>
          <div class="listTxt">
            <span>홍길동</span>
            <span>직급</span>
          </div>
        </li>
        <li>
          <div class="listImg"><img src="<%= ctxPath%>/resources/images/common/phone.svg" alt=""></div>
          <div class="listTxt">010-0000-0000</div>
        </li>
        <li>
          <div class="listImg"><img src="<%= ctxPath%>/resources/images/common/email.svg" alt=""></div>
          <div class="listTxt">email@domain.name</div>
        </li>
      </ul>
    </article>
    <article>
      <div class="cardHead pl-5">
        <div class="h5 pt-3 ">거래처명&nbsp;&nbsp;&nbsp;<span class="h6">업종:</span></div>
        <button><img src="<%= ctxPath%>/resources/images/common/chevron-right.svg" alt=""></button>
      </div>
      <ul class="cardBody">
        <li>
          <div class="listImg">
            <img src="<%= ctxPath%>/resources/images/common/team.svg" alt="">
          </div>
          <div class="listTxt">담당자부서</div>
        </li>
        <li>
          <div class="listImg"><img src="<%= ctxPath%>/resources/images/common/user.svg" alt=""></div>
          <div class="listTxt">
            <span>홍길동</span>
            <span>직급</span>
          </div>
        </li>
        <li>
          <div class="listImg"><img src="<%= ctxPath%>/resources/images/common/phone.svg" alt=""></div>
          <div class="listTxt">010-0000-0000</div>
        </li>
        <li>
          <div class="listImg"><img src="<%= ctxPath%>/resources/images/common/email.svg" alt=""></div>
          <div class="listTxt">email@domain.name</div>
        </li>
      </ul>
    </article>
    <article>
      <div class="cardHead pl-5">
        <div class="h5 pt-3 ">거래처명&nbsp;&nbsp;&nbsp;<span class="h6">업종:</span></div>
        <button><img src="<%= ctxPath%>/resources/images/common/chevron-right.svg" alt=""></button>
      </div>
      <ul class="cardBody">
        <li>
          <div class="listImg">
            <img src="<%= ctxPath%>/resources/images/common/team.svg" alt="">
          </div>
          <div class="listTxt">담당자부서</div>
        </li>
        <li>
          <div class="listImg"><img src="<%= ctxPath%>/resources/images/common/user.svg" alt=""></div>
          <div class="listTxt">
            <span>홍길동</span>
            <span>직급</span>
          </div>
        </li>
        <li>
          <div class="listImg"><img src="<%= ctxPath%>/resources/images/common/phone.svg" alt=""></div>
          <div class="listTxt">010-0000-0000</div>
        </li>
        <li>
          <div class="listImg"><img src="<%= ctxPath%>/resources/images/common/email.svg" alt=""></div>
          <div class="listTxt">email@domain.name</div>
        </li>
      </ul>
    </article>
    <article>
      <div class="cardHead pl-5">
        <div class="h5 pt-3 ">거래처명&nbsp;&nbsp;&nbsp;<span class="h6">업종:</span></div>
        <button><img src="<%= ctxPath%>/resources/images/common/chevron-right.svg" alt=""></button>
      </div>
      <ul class="cardBody">
        <li>
          <div class="listImg">
            <img src="<%= ctxPath%>/resources/images/common/team.svg" alt="">
          </div>
          <div class="listTxt">담당자부서</div>
        </li>
        <li>
          <div class="listImg"><img src="<%= ctxPath%>/resources/images/common/user.svg" alt=""></div>
          <div class="listTxt">
            <span>홍길동</span>
            <span>직급</span>
          </div>
        </li>
        <li>
          <div class="listImg"><img src="<%= ctxPath%>/resources/images/common/phone.svg" alt=""></div>
          <div class="listTxt">010-0000-0000</div>
        </li>
        <li>
          <div class="listImg"><img src="<%= ctxPath%>/resources/images/common/email.svg" alt=""></div>
          <div class="listTxt">email@domain.name</div>
        </li>
      </ul>
    </article>
  </section>
</div>







<!-- popup area -->
<div class="popupWrap">
  <div class="popup">
    <div class="popupHead">
      <h4>거래처명</h4>
     <!--  <button id="edit_com" style="display: flex;">수정하기</button> -->
      <button class="close"><img src="<%= ctxPath%>/resources/images/common/xmark.svg" alt=""></button>
    </div>
    <div class="popupBody">
      <div class="forAlign">
        <div class="popupImg">

        </div>
        <ul class="popupList">
          <li>
            <div class="listImg">
              <img src="<%= ctxPath%>/resources/images/common/business_num.svg" alt="">
            </div>
            <div class="listTxt">123-45-6789</div>
          </li>
          <li>
            <div class="listImg">
              <img src="<%= ctxPath%>/resources/images/common/comp.svg" alt="">
            </div>
            <div class="listTxt">강남구 도곡동</div>
          </li>
          <li>
            <div class="listImg">
              <img src="<%= ctxPath%>/resources/images/common/homepage.svg" alt="">
            </div>
            <div class="listTxt">www.domain.com</div>
          </li>
        </ul>
        <ul class="popupList">
          <li>
            <div class="listImg"><img src="<%= ctxPath%>/resources/images/common/user.svg" alt=""></div>
            <div class="listTxt">
              <span>홍길동</span>
              <span>직급</span>
            </div>
          </li>
          <li>
            <div class="listImg"><img src="<%= ctxPath%>/resources/images/common/phone.svg" alt=""></div>
            <div class="listTxt">010-0000-0000</div>
          </li>
          <li>
            <div class="listImg"><img src="<%= ctxPath%>/resources/images/common/email.svg" alt=""></div>
            <div class="listTxt">email@domain.name</div>
          </li>
        </ul>
      </div>
     	<button class="editcom" style="border: solid 1px red; float: right; margin-right: 100px;">수정하기</button>
    </div>
  </div>
</div>
</body>

</html>


