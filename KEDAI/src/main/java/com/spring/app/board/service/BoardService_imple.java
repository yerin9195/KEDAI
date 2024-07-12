package com.spring.app.board.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.app.board.model.BoardDAO;
import com.spring.app.domain.BoardVO;
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

	// 파일첨부가 없는 글쓰기
	@Override
	public int add(BoardVO bvo) {
		
		// 원글쓰기인지 답변글쓰기인지 구분
		if("".equals(bvo.getFk_seq())) { // 원글쓰기인 경우
			int groupno = dao.getGroupnoMax()+1;
			bvo.setGroupno(String.valueOf(groupno));
		}
		
		int n = dao.add(bvo);
		return n;
	}
	
	// 파일첨부가 있는 글쓰기
	@Override
	public int add_withFile(BoardVO bvo) {
		
		// 원글쓰기인지 답변글쓰기인지 구분
		if("".equals(bvo.getFk_seq())) { // 원글쓰기인 경우
			int groupno = dao.getGroupnoMax()+1;
			bvo.setGroupno(String.valueOf(groupno));
		}
		
		int n = dao.add_withFile(bvo);
		return n;
	}
	
	// 특정 사원에게 특정 점수만큼 포인트를 증가하기
	@Override
	public void pointPlus(Map<String, String> paraMap) {
		dao.pointPlus(paraMap);
	}

	// 총 게시물 건수(totalCount) 구하기
	@Override
	public int getTotalCount(Map<String, String> paraMap) {
		int totalCount = dao.getTotalCount(paraMap);
		return totalCount;
	}

	// 글목록 가져오기(페이징처리를 했으며, 검색어가 있는 것 또는 검색어가 없는 것 모두 포함한 것)
	@Override
	public List<BoardVO> boardListSearch_withPaging(Map<String, String> paraMap) {
		List<BoardVO> boardList = dao.boardListSearch_withPaging(paraMap);
		return boardList;
	}

	// 검색어 입력 시 자동글 완성하기 
	@Override
	public List<String> wordSearchShow(Map<String, String> paraMap) {
		List<String> wordList = dao.wordSearchShow(paraMap);
		return wordList;
	}

	// 글 조회수 증가와 함께 글 1개를 조회하기
	@Override
	public BoardVO getView(Map<String, String> paraMap) {
		BoardVO bvo = dao.getView(paraMap);
		return bvo;
	}

	

	
	
}
