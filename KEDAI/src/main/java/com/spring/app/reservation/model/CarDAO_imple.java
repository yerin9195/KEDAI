package com.spring.app.reservation.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.spring.app.domain.BusVO;

@Repository
public class CarDAO_imple implements CarDAO {

	@Autowired 				
	@Qualifier("sqlsession")		// auto일 경우에는 이와같이 qualifier를 해준다.
	private SqlSessionTemplate sqlsession;				// qualifier안해주면 오류

	@Override
	public List<BusVO> getStationList(String bus_no) {
		List<BusVO> stationList = sqlsession.selectList("reservation.getStationList", bus_no);
		return stationList;
	}



}
