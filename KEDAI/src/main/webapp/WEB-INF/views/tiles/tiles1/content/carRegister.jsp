<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	// 컨텍스트 패스명(context path name)을 알아오고자 한다.
	String ctxPath = request.getContextPath();

%>
<style type="text/css">
	table#tblProdInput {border: solid #c180ff 1px; 
	                    border-collapse: collapse; }
	                    
    table#tblProdInput td {border: solid #c180ff 1px; 
	                       padding-left: 10px;
	                       height: 50px; }
	                       
    .prodInputName {background-color: #e6ccff; 
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


<div align="center" style="margin-bottom: 20px;">

	<div style="border: solid #c180ff 2px; width: 250px; margin-top: 20px; padding-top: 10px; padding-bottom: 10px; border-left: hidden; border-right: hidden;">       
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
					<input type="text" name="postcode" id="postcode" size="6" maxlength="5" />&nbsp;&nbsp;
                    <%-- 우편번호 찾기 --%>
                    <img src="/images/b_zipcode.gif" id="zipcodeSearch" />
                    <span class="error">우편번호 형식에 맞지 않습니다.</span><br>
					<input type="text" name="address" id="address" size="40" maxlength="200" placeholder="주소" /><br>
                    <input type="text" name="detailaddress" id="detailAddress" size="40" maxlength="200" placeholder="상세주소" />&nbsp;<input type="text" name="extraaddress" id="extraAddress" size="40" maxlength="200" placeholder="참고항목" />            
                    <span class="error">주소를 입력하세요.</span><span class="error">필수입력</span>
				</td>
			</tr>
			<tr>
				<td width="25%" class="prodInputName">도착지</td>
				<td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
				    <input type="text" name="postcode" id="postcode" size="6" maxlength="5" />&nbsp;&nbsp;
                    <%-- 우편번호 찾기 --%>
                    <img src="/images/b_zipcode.gif" id="zipcodeSearch" />
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
