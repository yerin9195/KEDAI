package com.spring.app.board.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.app.board.model.BoardDAO;
import com.spring.app.domain.CategoryVO;

@Service
public class BoardService_imple implements BoardService {

	@Autowired
	private BoardDAO dao;

	// 카테고리 목록 조회하기
	@Override
	public List<CategoryVO> category_select() {
		List<CategoryVO> categoryList = dao.category_select();
		return categoryList;
	}

	// 특정 사원에게 특정 점수만큼 포인트를 증가하기
	@Override
	public void pointPlus(Map<String, String> paraMap) {
		dao.pointPlus(paraMap);
	}
	
}
