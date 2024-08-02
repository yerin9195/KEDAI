package com.spring.app.board.model;

import java.util.List;
import java.util.Map;

import com.spring.app.domain.CommentVO;
import com.spring.app.domain.CommunityCategoryVO;
import com.spring.app.domain.CommunityFileVO;
import com.spring.app.domain.CommunityVO;

public interface CommunityDAO {

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

	// 글조회수 1 증가하기
	int increase_readCount(String community_seq);
	
	// 첨부파일 조회하기
	List<CommunityFileVO> getAttachFileList(String fk_community_seq);
	
	// 첨부파일 다운로드 받기
	CommunityFileVO getFilename(Map<String, String> paraMap);
	
	// 커뮤니티 첨부파일 삭제하기
	int community_attachfile_delete(String community_seq);
	
	// 커뮤니티 글 수정하기
	int edit(CommunityVO cvo);
	
	// 커뮤니티 글 삭제하기
	int del(String fk_community_seq);

	// 댓글쓰기(Transaction 처리)
	int addComment(CommentVO commentvo); // 댓글쓰기(tbl_comment 테이블에 insert)
	int updateCommentCount(String fk_community_seq); // tbl_board 테이블에 commentCount 컬럼이 1증가(update)
	int updateMemberPoint(Map<String, String> paraMap); // tbl_employees 테이블의 point 컬럼의 값을 50점 증가(update)

	// 댓글 내용들을 페이징 처리하기
	List<CommentVO> getCommentList_Paging(Map<String, String> paraMap);

	// 페이징처리 시 보여주는 순번을 나타내기 위한 것
	int getCommentTotalCount(String fk_community_seq);

	// 댓글 수정하기(Ajax 로 처리)
	int updateComment(Map<String, String> paraMap);

	// 댓글 삭제하기(Ajax 로 처리)
	int deleteComment(String comment_seq);

	// 댓글삭제 시 tbl_community 테이블에 comment_count 컬럼이 1감소(update)
	int updateCommentCount_decrease(String fk_community_seq);

	// 좋아요 누르기
	int likeAdd(Map<String, String> paraMap);

	// 좋아요 취소하기
	int likeMinus(Map<String, String> paraMap);

}
