package com.spring.app.board.service;

import java.util.List;

import com.spring.app.domain.CommunityCategoryVO;

public interface CommunityService {

	// 커뮤니티 카테고리 목록 조회하기
	List<CommunityCategoryVO> category_select();

}
