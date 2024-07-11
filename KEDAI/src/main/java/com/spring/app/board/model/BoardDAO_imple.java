package com.spring.app.board.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.spring.app.domain.BoardVO;
import com.spring.app.domain.CategoryVO;

@Repository
public class BoardDAO_imple implements BoardDAO {
	
	@Autowired
	@Qualifier("sqlsession")
	private SqlSessionTemplate sqlsession;

	@Override
	public List<CategoryVO> category_select() {
		List<CategoryVO> categoryList = sqlsession.selectList("board.category_select");
		return categoryList;
	}

	@Override
	public int getGroupnoMax() {
		int maxgrouno = sqlsession.selectOne("board.getGroupnoMax");
		return maxgrouno;
	}
	
	@Override
	public int add(BoardVO bvo) {
		int n = sqlsession.insert("board.add", bvo);
		return n;
	}

	@Override
	public int add_withFile(BoardVO bvo) {
		int n = sqlsession.insert("board.add_withFile", bvo);
		return n;
	}
	
	@Override
	public void pointPlus(Map<String, String> paraMap) {
		sqlsession.update("board.pointPlus", paraMap);
	}

	@Override
	public int getTotalCount(Map<String, String> paraMap) {
		int totalCount = sqlsession.selectOne("board.getTotalCount", paraMap);
		return totalCount;
	}

	@Override
	public List<BoardVO> boardListSearch_withPaging(Map<String, String> paraMap) {
		List<BoardVO> boardList = sqlsession.selectList("board.boardListSearch_withPaging", paraMap);
		return boardList;
	}

	

	
}
