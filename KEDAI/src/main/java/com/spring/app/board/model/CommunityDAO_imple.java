package com.spring.app.board.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.spring.app.domain.CommunityCategoryVO;

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
}
