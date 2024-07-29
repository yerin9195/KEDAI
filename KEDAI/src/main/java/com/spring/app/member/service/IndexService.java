package com.spring.app.member.service;

public interface IndexService {

	// 사원수 조회하기
	int memberTotalCountJSON();
	
	// 게시글수 조회하기
	int boardTotalCountJSON();
}
