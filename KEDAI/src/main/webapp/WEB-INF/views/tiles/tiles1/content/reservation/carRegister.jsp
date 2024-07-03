<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	// 컨텍스트 패스명(context path name)을 알아오고자 한다.
	String ctxPath = request.getContextPath();

%>
<style type="text/css">
	table#tblProdInput {border: solid #2c4459; 1px; 
	                    border-collapse: collapse; }
	                    
    table#tblProdInput td {border: solid #2c4459; 1px; 
	                       padding-left: 10px;
	                       height: 50px; }
	                       
    .prodInputName {background-color: #e68c0e; 
                    font-weight: bold; }	                       	                    
	
	.error {color: red; font-weight: bold; font-size: 9pt;}
	
	div.fileDrop{ display: inline-block; 
                  width: 100%; 
                  height: 100px;
                  overflow: auto;
                  background-color: #fff;
                  padding-left: 10px;}
                 
    div.fileDrop > div.fileList > span.delete{display:inline-block; width: 20px; border: solid 1px gray; text-align: center;} 
    div.fileDrop > div.fileList > span.delete:hover{background-color: #000; color: #fff; cursor: pointer;}
    div.fileDrop > div.fileList > span.fileName{padding-left: 10px;}
    div.fileDrop > div.fileList > span.fileSize{padding-right: 20px; float:right;} 
    span.clear{clear: both;} 
   
</style>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
function address() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("extraAddress").value = extraAddr;
            
            } else {
                document.getElementById("extraAddress").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('sample6_postcode').value = data.zonecode;
            document.getElementById("sample6_address").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("sample6_detailAddress").focus();
        }
    }).open();
}

</script>
<div align="center" style="margin-bottom: 20px;">

	<div style="border: solid #2c4459; 2px; width: 250px; margin-top: 20px; padding-top: 10px; padding-bottom: 10px; border-left: hidden; border-right: hidden;">       
		<span style="font-size: 15pt; font-weight: bold;">카셰어링&nbsp;등록</span>	
	</div>
	<br/>
	
	<%-- !!!!! ==== 중요 ==== !!!!! --%>
	<%-- 폼에서 파일을 업로드 하려면 반드시 method 는 POST 이어야 하고 
	     enctype="multipart/form-data" 으로 지정해주어야 한다.!! --%>
	<form name="prodInputFrm" enctype="multipart/form-data"> 
	      
		<table id="tblProdInput" style="width: 80%;">
		<tbody>
			<tr>
				<td width="25%" class="prodInputName" style="padding-top: 10px;">정원</td>
				<td width="75%" align="left" style="padding-top: 10px;" >
					<select name="fk_cnum" class="infoData">
						<option value="">:::선택하세요:::</option>
						<%-- 
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
						--%> 
						    <c:forEach var="cvo" items="${requestScope.categoryList}">
						        <option value="${cvo.cnum}">${cvo.cname}</option>
						    </c:forEach>
					</select>
					<span class="error">필수입력</span>
				</td>	
			</tr>
			<tr>
				<td width="25%" class="prodInputName">사원명</td>		<!-- readonly로 받아올것 -->
				<td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;" >
					<input type="text" style="width: 300px;" name="pname" class="box infoData" />
				</td>
			</tr>
                <tr>
                    <td  class="prodInputName">기간</td>
                    <td>
                       <input type="text" name="start" id="datepicker" maxlength="10" /><span>&nbsp;~&nbsp;</span>
                       <input type="text" name="last" id="datepicker" maxlength="10" />
                       <span class="error">기간은 마우스로만 클릭하세요.</span>
                    </td>
                </tr>
			<tr>
				<td width="25%" class="prodInputName">출발지</td>
				<td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
					<input type="text" name="postcode" id="postcode" size="6" maxlength="5" placeholder="우편번호" readonly/>&nbsp;&nbsp;
                    <%-- 우편번호 찾기 --%>
                    <button onclick="address()" style="background-color: white;"><i class="fa-solid fa-magnifying-glass"></i></button>
                    <span class="error">우편번호 형식에 맞지 않습니다.</span><br>
					<input type="text" name="address" id="address" size="40" maxlength="200" placeholder="주소" readonly/><br>
                    <input type="text" name="detailaddress" id="detailAddress" size="40" maxlength="200" placeholder="상세주소" readonly/>&nbsp;<input type="text" name="extraaddress" id="extraAddress" size="40" maxlength="200" placeholder="참고항목" readonly/>            
                    <span class="error">주소를 입력하세요.</span><span class="error">필수입력</span>
				</td>
			</tr>
			<tr>
				<td width="25%" class="prodInputName">도착지</td>
				<td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
				    <input type="text" name="postcode" id="postcode" size="6" maxlength="5" />&nbsp;&nbsp;
                    <%-- 우편번호 찾기 --%>
                    <button onclick="address()" style="background-color: white;"><i class="fa-solid fa-magnifying-glass"></i></button>
                    <span class="error">우편번호 형식에 맞지 않습니다.</span><br>
					<input type="text" name="address" id="address" size="40" maxlength="200" placeholder="주소" /><br>
                    <input type="text" name="detailaddress" id="detailAddress" size="40" maxlength="200" placeholder="상세주소" />&nbsp;<input type="text" name="extraaddress" id="extraAddress" size="40" maxlength="200" placeholder="참고항목" />            
                    <span class="error">주소를 입력하세요.</span><span class="error">필수입력</span>
				</td>
			</tr>
			<tr>
				<td width="25%" class="prodInputName">유의사항(선택)</td>
				<td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
					<textarea name="pcontent" rows="5" cols="60"></textarea>
				</td>
			</tr>
			<tr style="height: 70px;">
				<td colspan="2" align="center" style="border-left: hidden; border-bottom: hidden; border-right: hidden; padding: 50px 0;">
				    <input type="button" value="제품등록" id="btnRegister" style="width: 120px;" class="btn btn-info btn-lg mr-5" /> 
				    <input type="reset" value="취소"  style="width: 120px;" class="btn btn-danger btn-lg" />	
				</td>
			</tr>
		</tbody>
		</table>
		
	</form>

</div>
