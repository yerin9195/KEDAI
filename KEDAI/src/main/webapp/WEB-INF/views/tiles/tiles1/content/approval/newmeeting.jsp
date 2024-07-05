<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>

<%-- Bootstrap CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/bootstrap-4.6.2-dist/css/bootstrap.min.css" > 

<script src="<%= ctxPath%>/resources/jquery-ui/jquery-ui.min.js"></script>
<link rel="stylesheet" href="<%= ctxPath%>/resources/jquery-ui/jquery-ui.css">
    
<style type="text/css">

div#title{
	font-size:27px;
	margin : 3% 0 1% 0;
}

div#title2{
	font-size:25px;
	margin : 0 0 1% 0;
}
table.left_table{
	width:100%;
	border-bottom-width: 0.5px;
	border-bottom-style: solid;
	border-bottom-color: lightgrey;
}

table.left_table th{
	width : 25%;
	background-color: #EBEBEB;
}

table#title_table td{
	width : 25%;
	padding: 0 0 0 3%;
}

table#title_table th,
table#meeting th,
table#meeting td{
	padding: 0 0 0 3%;
}

table#approval th,
table#approval td{
	padding: 0%;
}

table.left_table input{
	height : 15pt;
}

.modal-dialog {
	 height: 500px;
	 max-height:500px;	
}


.modal-body {
	overflow-y:  auto;
}

div.openList img{
	width:11px; 
	height:11px; 
	margin-right:0.5%;
	margin-bottom: 0.5%;
	cursor:pointer;
}

.moreList {
	display:none;
}

ul.approvalList > li {
	cursor:pointer;
	
}

.modal-body ul {
      padding-left: 20px; /* 중첩된 목록에 대한 기본 들여쓰기 */
}


</style>



<script type="text/javascript">
	
	$(document).ready(function(){
	<%-- === #166.-2 스마트 에디터 구현 시작 === --%>
  //전역변수
		var obj = [];
  
  //스마트에디터 프레임생성
  		nhn.husky.EZCreator.createInIFrame({
    	oAppRef: obj,
    	elPlaceHolder: "content", // id가 content인 textarea에 에디터를 넣어준다.
    	sSkinURI: "<%= ctxPath%>/resources/smarteditor/SmartEditor2Skin.html",
    	htParams : {
	    	// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
	        bUseToolbar : true,            
	        // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
	        bUseVerticalResizer : false,    
	        // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
	        bUseModeChanger : true,
    	}
		});
		
  		 <%-- === 스마트 에디터 구현 끝 === --%>
  	     
  	     // 글쓰기 버튼
  	     $("button#btnWrite").click(function(){
  	    	 
  	    	 <%-- === 스마트 에디터 구현 시작 === --%>
  	         // id가 content인 textarea에 에디터에서 대입
  	           obj.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
  	        <%-- === 스마트 에디터 구현 끝 === --%>
  	    	 
  	    	 // 글제목 유효성 검사
  	    	 const subject = $("input:text[name='subject']").val().trim();
  	    	 if(subject == ""){
  	    		 alert("글 제목을 입력하세요!!");
  	    		 $("input:text[name='subject']").val("");
  	    		 return; // 종료
  	    	 }
  	    	 
  	    	 // 글내용 유효성 검사(스마트 에디터를 사용할 경우) 
  	    	 <%-- const content = $("textarea[name='content']").val().trim();
  	    	 if(content == ""){
  	    		 alert("글 내용을 입력하세요!!");
  	    		 return; // 종료
  	    	 } 
  	    	 ==> 이렇게 입력했을 경우 html로 변환했을 때 <p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</p> 이렇게 나옴. 
  	    	 그래서 공백이라고 인식하지 못함.
  	    	--%>
  	    	let content_val = $("textarea[name='content']").val().trim();
  	   		// alert(content_val); // content에 공백만 여러개를 입력하여 쓰기할 경우 알아보는 것
  	   		// <p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</p>
  			//content_val.replace("&nbsp;", ""); 첫 번째로 발견된 &nbsp; 문자열만을 빈 문자열로 대체. 그러므로 여러 개의 &nbsp;가 존재하는 경우 첫 번째만 대체되고 나머지는 그대로 남게 됨.
  	   		content_val = content_val.replace(/&nbsp;/gi, ""); // 공백(&nbsp;)을 ""으로 변환
  	   		/*    
  	        	대상문자열.replace(/찾을 문자열/gi, "변경할 문자열");
  	      		==> 여기서 꼭 알아야 될 점은 나누기(/)표시안에 넣는 찾을 문자열의 따옴표는 없어야 한다는 점입니다. 
  	                	그리고 뒤의 gi는 다음을 의미합니다.
  	   
  		      g : 전체 모든 문자열을 변경 global
  		      i : 영문 대소문자를 무시, 모두 일치하는 패턴 검색 ignore
  		   */ 
  	      	
  	     	content_val = content_val.substring(content_val.indexOf("<p>")+3);
  	     	content_val = content_val.substring(0,content_val.indexOf("</p>"));
  	     	
  	     	if(content_val.trim().length == 0){
  	     		alert("글 내용을 입력하세요!!");
  	     		return; //종료
  	     	}
  	     	
  	   // 폼(form)을 전송(submit)
  	   	 	const frm = document.newDocFrm;
  	     	frm.method = "post";
  	      //frm.action = "<%= ctxPath%>/approval/newDocEnd.kedai";
  	        frm.submit();
  	        
		});// end of $("button#btnWrite").click(function()--------------
  	  
				
				
				
		$("input#datepicker").keyup(function(e) {
	  		$(e.target).val("");
	  		$(e.target).datepicker('setDate', 'today');
	  		alert("기안일자는 마우스로만 클릭하세요.");
	  		
	  	}); //  end of $('input#datepicker').keyup((e) => {})--------------------------------------
	  	
 // === jQuery UI 의 datepicker === //
	    $("input#datepicker").datepicker({
	             dateFormat: 'yy-mm-dd'  //Input Display Format 변경
	            ,showOtherMonths: true   //빈 공간에 현재월의 앞뒤월의 날짜를 표시
	            ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
	            ,changeYear: true        //콤보박스에서 년 선택 가능
	            ,changeMonth: true       //콤보박스에서 월 선택 가능                
	        //   ,showOn: "both"          //button:버튼을 표시하고,버튼을 눌러야만 달력 표시됨. both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시됨.  
	        //   ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
	        //   ,buttonImageOnly: true   //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
	        //   ,buttonText: "선택"       //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
	            ,yearSuffix: "년"         //달력의 년도 부분 뒤에 붙는 텍스트
	            ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
	            ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
	            ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
	            ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
	        //  ,minDate: "-1M" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
	        //  ,maxDate: "+1M" //최대 선택일자(+1D:하루후, +1M:한달후, +1Y:일년후)                
	    });
	     
	     // 초기값을 오늘 날짜로 설정
	     $("input#datepicker").datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)
	
	
	
	    // === 전체 datepicker 옵션 일괄 설정하기 ===  
	    //     한번의 설정으로 $("input#fromDate"), $('input#toDate')의 옵션을 모두 설정할 수 있다.
	    $(function() {
	        //모든 datepicker에 대한 공통 옵션 설정
	        $.datepicker.setDefaults({
	             dateFormat: 'yy-mm-dd' //Input Display Format 변경
	            ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
	            ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
	            ,changeYear: true //콤보박스에서 년 선택 가능
	            ,changeMonth: true //콤보박스에서 월 선택 가능                
	         // ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시됨. both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시됨.  
	         // ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
	         // ,buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
	         // ,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
	            ,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
	            ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
	            ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
	            ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
	            ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
	         // ,minDate: "-1M" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
	         // ,maxDate: "+1M" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)                    
	        });
	     
	    });
 	     
	    // **** !!!! 중요 !!!! **** //
		 /*
		    선택자를 잡을때 선택자가 <body>태그에 직접 기술한 것이라면 선택자를 제대로 잡을수가 있으나
		    스크립트내에서 기술한 것이라면 선택자를 못 잡아올수도 있다.
		    이러한 경우는 아래와 해야만 된다.
		    $(document).on("이벤트종류", "선택자", function(){}); 으로 한다.
		 */
		$(document).on("click", "div.openList > img", function(){
			var $ul = $(this).parent().next("ul");
			
			if ($ul.is(".moreList")) {
				// ul에 moreList 클래스가 있는 경우
				$ul.removeClass("moreList");
				$(this).attr("src", "<%= ctxPath %>/resources/images/common/Approval/minus.png");
			}
			else{
				// moreList 클래스가 없는 경우
				$ul.addClass("moreList");
				$(this).attr("src", "<%= ctxPath %>/resources/images/common/Approval/plus.png");
			} 
		});
		    
		    /*
	         ===== 선택자의 class 명 알아오기 =====
	              선택자.attr('class')  또는  선택자.prop('class')  
	         
	         ===== 선택자의 id 명 알아오기 =====
	              선택자.attr('id')  또는  선택자.prop('id')
	                  
	         ===== 선택자의 name 명 알아오기 =====   
	             선택자.attr('name')  또는  선택자.prop('name')
	         
	                     
	          >>>> .prop() 와 .attr() 의 차이 <<<<            
	         .prop() ==> form 태그내에 사용되어지는 엘리먼트의 disabled, selected, checked 의 속성값 확인 또는 변경하는 경우에 사용함. 
	         .attr() ==> 그 나머지 엘리먼트의 속성값 확인 또는 변경하는 경우에 사용함.

	         */


	    /*   
	       선택자.toggleClass("클래스명1");
	         ==> 이것은 선택자에 "클래스명1" 이 이미 적용되어 있으면 선택자에 "클래스명1" 을 제거해주고, 
	             만약에 선택자에 "클래스명1" 이 적용되어 있지 않으면 선택자에 "클래스명1" 을 추가해주는 것.
	             
	         한마디로 addClass("클래스명1") 와 removeClass("클래스명1") 를 합친것 이라고 보면 된다.     
	     */  

	  //      $(e.target).toggleClass("changeCSSname");

	    // label 태그에 클릭을 했을때에 label 태그에 CSS 클래스 changeCSSname 이 
	       // 적용이 안되어진 상태이라면 label 태그에 CSS 클래스 changeCSSname 을 적용시켜주고,
	       // 이미 적용이 되어진 상태이라면 label 태그에 CSS 클래스 changeCSSname 을 해제시켜준다.
		$(document).on("click", "ul.approvalList > li", function(){
				
		});
		     
		
	});// end of $(document).ready(function(){})-----------
	
	
   ///////////////////////////////////////////////////////////////////////

</script>	


<div id="total_contatiner" style="display:flex;">
	<div id="leftside" class="col-md-4" style="width:90%; padding:0;">
		<div id="title"> 회의록</div>
		<table class="table left_table" id="title_table" >
			<tr>
				<th>문서번호</th>
				<td></td>
				<th>기안일자</th>
				<td>${requestScope.str_now}</td>
			</tr>
			<tr>
				<th>기안자</th>
				<td>${sessionScope.loginuser.name}</td>
				<th>부서</th>
				<td>${requestScope.dept_name}</td>		
			</tr>
		</table>
		<table class="table left_table" id="meeting" >
			<tr>
				<th>주관부서</th>
				<td><input type="text" name="meeting_room" size="30" maxlength="60" style="width : 100%;" /></td>
			</tr>
			<tr>
				<th>회의일자</th>
				<td>
					<input type="text" name="meeting_date" id="datepicker" maxlength="8" size="8" />
				</td>
			</tr>
			<tr>
				<th>회의장소</th>
				<td><input type="text" name="meeting_room" size="30" maxlength="60" style="width : 100%;" /></td>
			</tr>
			<tr>
				<th>회의 참여부서</th>
				<td><input type="text" name="meeting_room" size="30" maxlength="60" style="width : 100%;" /></td>
			</tr>
		</table>
		
		<div id="title2"> 결제라인
			<button type="button" class="btn btn-outline-secondary btn-sm" data-toggle="modal" style="margin-left:20%;" data-target="#selectLineModal" >선택하기</button>		
		</div> 
		
		<!-- Modal -->
		<!-- Modal 구성 요소는 현재 페이지 상단에 표시되는 대화 상자/팝업 창입니다. -->
		<div class="modal fade" id="selectLineModal">
			<div class="modal-dialog modal-dialog-centered modal-lg">
		  	<!-- .modal-dialog-centered 클래스를 사용하여 페이지 내에서 모달을 세로 및 가로 중앙에 배치합니다. .modal-dialog 클래스를 사용하여 <div> 요소에 크기 클래스를 추가합니다.-->
		    	<div class="modal-content">
		      <!-- Modal header -->
		      		<div class="modal-header">
		        		<h5 class="modal-title">결제자 선택</h5>
		        		<button type="button" class="close" data-dismiss="modal">&times;</button>
		      		</div>
		      
		      <!-- Modal body -->
		      		<div class="modal-body row">
		      			<div class="modal_left col-md-5">
			        		<ul>
			        			<li class="dept"><div class="openList" style="border: solid 1px red;"><img src="<%= ctxPath%>/resources/images/common/Approval/plus.png" />마케팅부서</div>
			        				<ul class="moreList approvalList">
			        					<li>김모씨</li>
			        					<li>박모씨</li>
			        					<li>이모씨</li>
			        					<li>최모씨</li>
			        					<li>제갈모씨</li>
			        				</ul>
			        			</li>
			        			
			        			<li class="dept">
			        				<div class="openList"><img src="<%= ctxPath%>/resources/images/common/Approval/plus.png" />test2</div>
			        				<ul class="moreList approvalList">
			        					<li>1</li>
			        					<li>2</li>
			        					<li>3</li>
			        					<li>4</li>
			        					<li>5</li>
			        				</ul>
			        			</li>
			        		</ul>	
		      			</div>	
		      			<div class="modal_right col-md-7">
		      				<table class="table">
		      					<tr style="text-align:center;">
									<th>순서</th>
									<th>소속</th>
									<th>직급</th>
									<th>성명</th>
								</tr>
		      					
		      				</table>
		      			
		      			</div>
		      		</div>
		      		<!-- Modal footer -->
		      		<div class="modal-footer">
		        		<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
		        		<button type="button" class="btn btn-primary">확인</button>
		      		</div>
		    	</div>
		  	</div>
		</div>
		
		
		
		
		<table class="table left_table" id="approval">
			<tr style="text-align:center;">
				<th>순서</th>
				<th>소속</th>
				<th>직급</th>
				<th>성명</th>
			</tr>
		</table>
	</div>
	<div class="col-md-6" style="margin:0; width: 100%">
		<form name="newDocFrm" enctype="multipart/form-data" > 
        <%-- 버튼이 form 태그 안에 있으면 무조건 get방식으로 submit되어진다. 유효성 검사를 하고 post방식으로 submit해주고 싶다면 무조건   type="button" 해야 한다. --%>
        
        	<table style="margin-left:5%;" class="table" id="newDoc">
	         	<tr>
	            	<th style="width:12%;">제목</th>
	            	<td>
	        			<input type="text" name="subject" size="85" maxlength="100" style="height:23pt;" /> 
	            	</td>
	            </tr>

	            <tr>
	            	<td colspan='2'>
	                	<textarea style="width: 100%; height: 500px;" name="content" id="content"></textarea>
	            	</td>
	         	</tr>
	         	<%-- === #170. 파일첨부 타입 추가하기 시작=== --%>
	         	
	         	<tr>
            		<th style="width:12%;">파일첨부</th>  
            		<td>
                		<input type="file" name="attach" />
            		</td>
         		</tr>
         		
         		<%-- === #170. 파일첨부 타입 추가하기 끝 === --%>

        	</table>
        	<div style="text-align:right; margin: 18px 0 18px 0;">
            	<button type="button" class="btn btn btn-dark btn-sm mr-4" id="btnWrite">작성완료</button>
            	<button type="button" class="btn btn-primary btn-sm" onclick="javascript:history.back()">취소</button>  
        	</div>
        	<input type="hidden" name="docTypeCode" value="100"/>
     	</form>
	</div>
</div>

</body>
</html>