package com.spring.app.member.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

@Repository
public class IndexDAO_imple implements IndexDAO {

	@Autowired
	@Qualifier("sqlsession")
	private SqlSessionTemplate sqlsession;

	@Override
	public int memberTotalCountJSON() {
		int totalCount = sqlsession.selectOne("index.memberTotalCountJSON");
		return totalCount;
	}
	
	@Override
	public int boardTotalCountJSON() {
		int totalCount = sqlsession.selectOne("index.boardTotalCountJSON");
		return totalCount;
	}
	
}
