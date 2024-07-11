package com.spring.app.approval.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.spring.app.domain.DeptVO;

@Repository 
public class ApprovalDAO_imple implements ApprovalDAO {
	
	@Autowired
	@Qualifier("sqlsession")
	private SqlSessionTemplate sqlsession;
	// /board/src/main/webapp/WEB-INF/spring/root-context.xml 의  bean에서 id가 sqlsession 인 bean을 주입하라는 뜻이다. 
    // 그러므로 sqlsession 는 null 이 아니다.



	// 새로운 기안 서류 작성 시 작성자의 부서 이름 가져오기
	@Override
	public String getDeptNumber(Map<String, String> paraMap) {
		String deptNumber = sqlsession.selectOne("approval.getDeptNumber", paraMap);
		return deptNumber;
	}


	// 결재 라인에서 찾을 모든 사원 목록 보기
	@Override
	public List<Map<String, String>> allEmployeeList(String login_empid) {
		List<Map<String, String>> allEmployeeList = sqlsession.selectList("approval.allEmployeeList", login_empid);
		return allEmployeeList;
	}

	// 현재 근무중인 사원이 있는 모든 부서 가져오기
	@Override
	public List<DeptVO> allDeptList() {
		List<DeptVO> allDeptList = sqlsession.selectList("approval.allDeptList");
		return allDeptList;
	}

	// 해당 부서에 근무중인 사원 정보 가져오기
	@Override
	public List<Map<String, String>> deptEmpList(Map<String, String> paraMap) {
		List<Map<String, String>> deptEmpList = sqlsession.selectList("approval.deptEmpList", paraMap);		
		return deptEmpList;
	}

	// 각 부서별 당 인원수 가져오기
	/*
	 * @Override public List<Map<String, String>> numByDept() { List<Map<String,
	 * String>> numByDept = sqlsession.selectList("approval.numByDept"); return
	 * null; }
	 */

}