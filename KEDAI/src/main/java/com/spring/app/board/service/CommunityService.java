package com.spring.app.board.service;

import java.util.List;
import java.util.Map;

import com.spring.app.domain.CommentVO;
import com.spring.app.domain.CommunityCategoryVO;
import com.spring.app.domain.CommunityFileVO;
import com.spring.app.domain.CommunityVO;

public interface CommunityService {

	// 커뮤니티 카테고리 목록 조회하기
	List<CommunityCategoryVO> category_select();

	// 글번호 채번해오기
	int getCseqOfCommunity();

	// 글쓰기
	int add(CommunityVO cvo);

	// tbl_community_file 테이블에 첨부파일 등록하기
	int community_attachfile_insert(Map<String, Object> paraMap);

	// 총 게시물 건수(totalCount) 구하기
	int getTotalCount(Map<String, String> paraMap);

	// 글목록 가져오기(페이징처리를 했으며, 검색어가 있는 것 또는 검색어가 없는 것 모두 포함한 것)
	List<CommunityVO> communityListSearch_withPaging(Map<String, String> paraMap);

	// 검색어 입력 시 자동글 완성하기
	List<String> wordSearchShow(Map<String, String> paraMap);

	// 글 조회수 증가와 함께 글 1개를 조회하기
	CommunityVO getView(Map<String, String> paraMap);

	// 글 조회수 증가는 없고 단순히  글 1개만 조회하기
	CommunityVO getView_noIncrease_readCount(Map<String, String> paraMap);
	
	// 첨부파일명 조회하기
	List<String> getFilenameJSON(Map<String, String> paraMap);
	
	// 첨부파일 다운로드 받기
	CommunityFileVO getFilename(Map<String, String> paraMap);

	// 댓글쓰기(Transaction 처리)
	int addComment(CommentVO commentvo) throws Throwable; // java.lang.Throwable => java.lang.Exception, java.lang.Error 의 부모이다. => 어떠한 오류가 발생하던지 처리하겠다는 의미이다. 

	// 댓글 내용들을 페이징 처리하기
	List<CommentVO> getCommentList_Paging(Map<String, String> paraMap);

	// 페이징처리 시 보여주는 순번을 나타내기 위한 것
	int getCommentTotalCount(String fk_community_seq);

	// 댓글 수정하기(Ajax 로 처리)
	int updateComment(Map<String, String> paraMap);

}
