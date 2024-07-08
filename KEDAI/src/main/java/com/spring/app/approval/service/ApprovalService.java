package com.spring.app.approval.service;

import java.util.List;
import java.util.Map;

public interface ApprovalService {

	// 새로운 기안 서류 작성 시 작성자의 부서 이름 가져오기
	String getDeptNumber(Map<String, String> paraMap);

	// 결재 라인에서 찾을 모든 사원 목록 보기
	List<Map<String, String>> allEmployeeList();

}
