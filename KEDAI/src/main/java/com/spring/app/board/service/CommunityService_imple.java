package com.spring.app.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.app.board.model.CommunityDAO;
import com.spring.app.common.FileManager;
import com.spring.app.domain.CommunityCategoryVO;

@Service
public class CommunityService_imple implements CommunityService {

	@Autowired
	private CommunityDAO dao;
	
	@Autowired
	private FileManager fileManager;

	// 커뮤니티 카테고리 목록 조회하기
	@Override
	public List<CommunityCategoryVO> category_select() {
		List<CommunityCategoryVO> categoryList = dao.category_select();
		return categoryList;
	}
}
