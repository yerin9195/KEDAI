package com.spring.app.member.service;

import java.util.List;

import com.spring.app.domain.BoardVO;

public interface IndexService {

	// 사원수 조회하기
	int memberTotalCountJSON();
	
	// 게시글수 조회하기
	int boardTotalCountJSON();

	// 게시판 글 조회하기
	List<BoardVO> boardListJSON(String category_code);
	
}
