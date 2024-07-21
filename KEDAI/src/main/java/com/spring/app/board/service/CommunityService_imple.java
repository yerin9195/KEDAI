package com.spring.app.board.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.app.board.model.CommunityDAO;
import com.spring.app.domain.CommunityCategoryVO;
import com.spring.app.domain.CommunityVO;

@Service
public class CommunityService_imple implements CommunityService {

	@Autowired
	private CommunityDAO dao;

	// 커뮤니티 카테고리 목록 조회하기
	@Override
	public List<CommunityCategoryVO> category_select() {
		List<CommunityCategoryVO> categoryList = dao.category_select();
		return categoryList;
	}

	// 글번호 채번해오기
	@Override
	public int getCseqOfCommunity() {
		int community_seq = dao.getCseqOfCommunity();
		return community_seq;
	}

	// 글쓰기
	@Override
	public int add(CommunityVO cvo) {
		int n = dao.add(cvo);
		return n;
	}

	// tbl_community_file 테이블에 첨부파일 등록하기
	@Override
	public int community_attachfile_insert(Map<String, Object> paraMap) {
		int attach_insert_result = dao.community_attachfile_insert(paraMap);
		return attach_insert_result;
	}

	// 총 게시물 건수(totalCount) 구하기
	@Override
	public int getTotalCount(Map<String, String> paraMap) {
		int totalCount = dao.getTotalCount(paraMap);
		return totalCount;
	}

	// 글목록 가져오기(페이징처리를 했으며, 검색어가 있는 것 또는 검색어가 없는 것 모두 포함한 것)
	@Override
	public List<CommunityVO> communityListSearch_withPaging(Map<String, String> paraMap) {
		List<CommunityVO> communityList = dao.communityListSearch_withPaging(paraMap);
		return communityList;
	}

	// 검색어 입력 시 자동글 완성하기
	@Override
	public List<String> wordSearchShow(Map<String, String> paraMap) {
		List<String> wordList = dao.wordSearchShow(paraMap);
		return wordList;
	}

	// 글 조회수 증가와 함께 글 1개를 조회하기
	@Override
	public CommunityVO getView(Map<String, String> paraMap) {
		CommunityVO cvo = dao.getView(paraMap);
		
		String login_empid = paraMap.get("login_empid");
		
		if(login_empid != null && cvo != null && !login_empid.equals(cvo.getFk_empid())) {
			int n = dao.increase_readCount(cvo.getCommunity_seq());
		
			if(n == 1) {
				cvo.setRead_count(String.valueOf(Integer.parseInt(cvo.getRead_count())+1));
			}
		}
		
		return cvo;
	}

	// 글 조회수 증가는 없고 단순히  글 1개만 조회하기
	@Override
	public CommunityVO getView_noIncrease_readCount(Map<String, String> paraMap) {
		CommunityVO cvo = dao.getView(paraMap);
		return cvo;
	}

	
	
}
