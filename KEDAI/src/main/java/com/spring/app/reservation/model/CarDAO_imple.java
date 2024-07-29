package com.spring.app.reservation.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.spring.app.domain.BoardVO;
import com.spring.app.domain.BusVO;
import com.spring.app.domain.CarVO;
import com.spring.app.domain.Day_shareVO;

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
	public List<Map<String, String>> getmyCar(String fk_empid) {

		List<Map<String, String>> myCar = sqlsession.selectList("reservation.getmyCar", fk_empid);
		return myCar;
	}
	
	@Override
	public CarVO getmyCar2(String fk_empid) {
		CarVO myCar2 = sqlsession.selectOne("reservation.getmyCar2", fk_empid);
		return myCar2;
	}
	// 내 차 정보 등록하기
	@Override
	public int addMycar(CarVO cvo) {
		int n = sqlsession.insert("reservation.addMyCar", cvo);
		return n;
	}

	@Override
	public int editMycar(Map<String, Object> paraMap) {
		int n = sqlsession.update("reservation.editMycar", paraMap);
		return n;
	}

	
	@Override
	public int addcarRegister(Map<String, Object> paraMap) {
		int n = sqlsession.insert("reservation.addcarRegister", paraMap);
		return n;
	}

	@Override
	public List<Map<String, String>> getcarShareList() {

		List<Map<String, String>> carShareList = sqlsession.selectList("reservation.getcarShareList");
		return carShareList;
	}

	@Override
	public Day_shareVO getday_shareInfo(int res_num) {
		Day_shareVO day_shareInfo = sqlsession.selectOne("reservation.getday_shareInfo", res_num);
		return day_shareInfo;
	}

	@Override
	public int addcarApply_detail(Map<String, Object> paraMap) {
		int n = sqlsession.insert("reservation.addcarApply_detail", paraMap);
		return n;
	}

	@Override
	public int getTotalCount(Map<String, String> paraMap) {
		int totalCount = sqlsession.selectOne("reservation.getTotalCount", paraMap);
		return totalCount;
	}

	@Override
	public List<Map<String, String>> carShareListSearch_withPaging(Map<String, String> paraMap) {
		List<Map<String, String>> carShareList = sqlsession.selectList("reservation.carShareListSearch_withPaging", paraMap);
		return carShareList;
	}

	@Override
	public List<String> searchShow(Map<String, String> paraMap) {
		List<String> wordList = sqlsession.selectList("reservation.searchShow", paraMap);
		return wordList;
	}

	@Override
	public List<Map<String, String>> getowner_carShareList(String empid) {
		List<Map<String, String>> owner_carShareList = sqlsession.selectList("reservation.getowner_carShareList", empid);
		return owner_carShareList;
	}

	@Override
	public List<Map<String, String>> owner_carShareListSearch_withPaging(Map<String, String> paraMap) {
		List<Map<String, String>> owner_carShareList = sqlsession.selectList("reservation.owner_carShareListSearch_withPaging", paraMap);
		return owner_carShareList;
	}

	@Override
	public int owner_getTotalCount(Map<String, String> paraMap) {
		int owner_totalCount = sqlsession.selectOne("reservation.owner_getTotalCount", paraMap);
		return owner_totalCount;
	}











}
