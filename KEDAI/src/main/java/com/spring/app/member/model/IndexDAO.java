package com.spring.app.member.model;

import java.util.List;

import com.spring.app.domain.BoardVO;

public interface IndexDAO {
	
	// 사원수 조회하기
	int memberTotalCountJSON();
	
	// 게시글수 조회하기
	int boardTotalCountJSON();

	// 게시판 글 조회하기
	List<BoardVO> boardListJSON(String category_code);
	
	// 식단표 조회하기
	BoardVO boardMenuJSON();

}
