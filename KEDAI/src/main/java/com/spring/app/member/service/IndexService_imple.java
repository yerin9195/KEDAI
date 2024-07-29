package com.spring.app.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.app.member.model.IndexDAO;

@Service
public class IndexService_imple implements IndexService {

	@Autowired
	private IndexDAO dao;
	
	// 사원수 조회하기
	@Override
	public int memberTotalCountJSON() {
		int totalCount = dao.memberTotalCountJSON();
		return totalCount;
	}
	
	// 게시글수 조회하기
	@Override
	public int boardTotalCountJSON() {
		int totalCount = dao.boardTotalCountJSON();
		return totalCount;
	}
}
