package com.spring.app.board.model;

import java.util.List;
import java.util.Map;

import com.spring.app.domain.CategoryVO;

public interface BoardDAO {

	// 카테고리 목록 조회하기
	List<CategoryVO> category_select();

	// 특정 사원에게 특정 점수만큼 포인트를 증가하기 
	void pointPlus(Map<String, String> paraMap);

}
