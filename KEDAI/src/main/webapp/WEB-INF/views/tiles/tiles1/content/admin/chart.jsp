<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
	//     /KEDAI
%>
<style type="text/css">


</style>

<script type="text/javascript">
	$(document).ready(function(){
		
		$("select#searchType").change(function(e){
		   func_choice($(this).val());
	   });
		
		$("select#searchType").val("deptname").trigger("change"); 
		
	}); // end of $(document).ready(function(){}) ----------
	
	function func_choice(searchTypeVal) {
		
		switch(searchTypeVal) {
		
			
		
		
		
		} // end of switch (searchTypeVal) ----------
		
	} // end of function func_choice(searchTypeVal) ----------
</script>
	
<%-- content start --%>	
<div style="border: 0px solid red; padding: 2% 3% 0 0;">
	<h3><span class="icon"><i class="fa-solid fa-seedling"></i></span>&nbsp;&nbsp;통계정보 조회하기</h3>

	<form name="searchFrm" style="margin: 50px 0 50px 0; ">
		<select name="searchType" id="searchType" style="height: 30px;">
			<option value="">통계를 선택하세요.</option>
			<option value="deptname">부서별 인원통계</option>
			<option value="gender">성별 인원통계</option>
			<option value="genderHireYear">성별 입사년도별 통계</option>
			<option value="deptnameGender">부서별 성별 인원통계</option>
			<option value="pageurlUsername">페이지별 사용자별 접속통계</option>
		</select>
	</form>
	
	<div id="chart_container"></div>
	<div id="table_container" style="margin: 40px 0 0 0;"></div>
</div>
<%-- content end --%>