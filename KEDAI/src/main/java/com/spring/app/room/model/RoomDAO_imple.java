package com.spring.app.room.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.spring.app.domain.BusVO;
import com.spring.app.domain.MemberVO;
import com.spring.app.domain.RoomMainVO;

@Repository
public class RoomDAO_imple implements RoomDAO {

	@Autowired 				
	@Qualifier("sqlsession")		// auto일 경우에는 이와같이 qualifier를 해준다.
	private SqlSessionTemplate sqlsession;				// qualifier안해주면 오류

	@Override
	public List<RoomMainVO> roomMainView() {
		List<RoomMainVO> roomMainList = sqlsession.selectList("Room.roomMainView");
		return roomMainList;
		
	}




}
