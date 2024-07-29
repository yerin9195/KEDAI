package com.spring.app.approval.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.app.approval.model.ApprovalDAO;
import com.spring.app.domain.DeptVO;

@Service
public class ApprovalService_imple implements ApprovalService {
	
	// === #34. 의존객체 주입하기(DI: Dependency Injection) ===
	@Autowired  // Type에 따라 알아서 Bean 을 주입해준다.
	private ApprovalDAO dao;
	// Type 에 따라 Spring 컨테이너가 알아서 bean 으로 등록된 com.spring.board.model.BoardDAO_imple 의 bean 을  dao 에 주입시켜준다. 
	// 그러므로 dao 는 null 이 아니다.

	// 새로운 기안 서류 작성 시 작성자의 부서 이름 가져오기
	@Override
	public String getDeptNumber(Map<String, String> paraMap) {
		String deptNumber = dao.getDeptNumber(paraMap);
		return deptNumber;
	}
	
	// 결재 라인에서 찾을 모든 사원 목록 보기
	@Override
	public List<Map<String, String>> allEmployeeList(String login_empid) {
		List<Map<String, String>> allEmployeeList = dao.allEmployeeList(login_empid);
		return allEmployeeList;
	}

	// 현재 근무중인 사원이 있는 모든 부서 가져오기
	@Override
	public List<DeptVO> allDeptList() {
		List<DeptVO> allDeptList = dao.allDeptList();
		return allDeptList;
	}

	// 해당 부서에 근무중인 사원 정보 가져오기
	@Override
	public List<Map<String, String>> deptEmpList(Map<String, String> paraMap) {
		List<Map<String, String>> deptEmpList = dao.deptEmpList(paraMap);
		return deptEmpList;
	}
	
	/*
	 * // 각 부서별 당 인원수 가져오기
	 * 
	 * @Override public List<Map<String, String>> numByDept() { List<Map<String,
	 * String>> numByDept = dao.numByDept(); return numByDept; }
	 */

}
