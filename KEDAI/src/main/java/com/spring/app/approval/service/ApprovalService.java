package com.spring.app.approval.service;

import java.util.List;
import java.util.Map;

import com.spring.app.domain.DeptVO;
import com.spring.app.domain.DocVO;
import com.spring.app.domain.MinutesVO;

public interface ApprovalService {

	// 새로운 기안 서류 작성 시 작성자의 부서 이름 가져오기
	String getDeptNumber(Map<String, String> paraMap);

	// 결재 라인에서 찾을 모든 사원 목록 보기
	List<Map<String, String>> allEmployeeList(String login_empid);
	/*
	 * // 각 부서별 당 인원수 가져오기 List<Map<String, String>> numByDept();
	 */

	// 현재 근무중인 사원이 있는 모든 부서 가져오기
	List<DeptVO> allDeptList();

	// 해당 부서에 근무중인 사원 정보 가져오기
	List<Map<String, String>> deptEmpList(Map<String, String> paraMap);

	// 첨부파일이 없는 기안 작성하기
	int noFile_doc(Map<String, Object> paraMap);

	// doc_no와 approval_noSeq의 시퀀스 채번해오기
	Map<String, String> getDocSeq();

	


}
