package com.spring.app.reservation.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.spring.app.domain.BusVO;
import com.spring.app.domain.CarVO;

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

	@Override
	public List<BusVO> getStationTimeList(String pf_station_id, String bus_no) {
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("bus_no", bus_no);
		paraMap.put("pf_station_id", pf_station_id);
		
		List<BusVO> stationTimeList = sqlsession.selectList("reservation.getStationTimeList", paraMap);
		return stationTimeList;
	}

	@Override
	public List<Map<String, String>> getmyCar(String empid) {

		List<Map<String, String>> myCar = sqlsession.selectList("reservation.getmyCar", empid);
		return myCar;
	}

	// 내 차 정보 등록하기
	@Override
	public int addMycar(CarVO cvo) {
		int n = sqlsession.insert("reservation.addMyCar", cvo);
		return n;
	}








}
