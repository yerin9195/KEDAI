package com.spring.app.approval.service;

import java.util.Map;

public interface ApprovalService {

	// 새로운 기안 서류 작성 시 작성자의 부서 이름 가져오기
	String getDeptNumber(Map<String, String> paraMap);

}
