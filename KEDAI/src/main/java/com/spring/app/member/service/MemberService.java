package com.spring.app.member.service;

import java.util.Map;

import com.spring.app.domain.MemberVO;

public interface MemberService {

	// 로그인 처리하기
	MemberVO getLoginMember(Map<String, String> paraMap);
 
	// 아이디 찾기
	String idFind(Map<String, String> paraMap);

	// 비밀번호 찾기
	String pwdFind(Map<String, String> paraMap);

}
