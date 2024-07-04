package com.spring.app.approval.model;

import java.util.Map;

public interface ApprovalDAO {

	// 새로운 기안 서류 작성 시 작성자의 부서 이름 가져오기
	String getDeptNumber(Map<String, String> paraMap);

}
