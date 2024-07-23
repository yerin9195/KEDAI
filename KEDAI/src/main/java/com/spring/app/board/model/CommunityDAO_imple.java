package com.spring.app.board.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.spring.app.domain.CommunityCategoryVO;
import com.spring.app.domain.CommunityVO;

@Repository
public class CommunityDAO_imple implements CommunityDAO {

	@Autowired
	@Qualifier("sqlsession")
	private SqlSessionTemplate sqlsession;

	@Override
	public List<CommunityCategoryVO> category_select() {
		List<CommunityCategoryVO> categoryList = sqlsession.selectList("community.category_select");
		return categoryList;
	}

	@Override
	public int getCseqOfCommunity() {
		int community_seq = sqlsession.selectOne("community.getCseqOfCommunity");
		return community_seq;
	}

	@Override
	public int add(CommunityVO cvo) {
		int n = sqlsession.insert("community.add", cvo);
		return n;
	}

	@Override
	public int community_attachfile_insert(Map<String, Object> paraMap) {
		int attach_insert_result = sqlsession.insert("community.community_attachfile_insert", paraMap);
		return attach_insert_result;
	}

	@Override
	public int getTotalCount(Map<String, String> paraMap) {
		int totalCount = sqlsession.selectOne("community.getTotalCount", paraMap);
		return totalCount;
	}

	@Override
	public List<CommunityVO> communityListSearch_withPaging(Map<String, String> paraMap) {
		List<CommunityVO> communityList = sqlsession.selectList("community.communityListSearch_withPaging", paraMap);
		return communityList;
	}

	@Override
	public List<String> wordSearchShow(Map<String, String> paraMap) {
		List<String> wordList = sqlsession.selectList("community.wordSearchShow", paraMap);
		return wordList;
	}

	@Override
	public CommunityVO getView(Map<String, String> paraMap) {
		CommunityVO cvo = sqlsession.selectOne("community.getView", paraMap);
		return cvo;
	}

	@Override
	public int increase_readCount(String community_seq) {
		int n = sqlsession.update("community.increase_readCount", community_seq);
		return n;
	}
}
