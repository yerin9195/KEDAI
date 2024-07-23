package com.spring.app.reservation.model;

import java.util.List;
import java.util.Map;

import com.spring.app.domain.BusVO;
import com.spring.app.domain.CarVO;
import com.spring.app.domain.Day_shareVO;

public interface CarDAO {

	List<BusVO> getStationList(String bus_no);

	List<BusVO> getStationTimeList(String pf_station_id, String bus_no);

	List<Map<String, String>> getmyCar(String fk_empid);

	int addMycar(CarVO cvo);

	int editMycar(Map<String, Object> paraMap);

	int addcarRegister(Map<String, Object> paraMap);

	CarVO getmyCar2(String fk_empid);

	List<Map<String, String>> getcarShareList();

	Day_shareVO getday_shareInfo(int res_num);

	int addcarApply_detail(Map<String, Object> paraMap);

	int getTotalCount(Map<String, String> paraMap);

	List<Map<String, String>> carShareListSearch_withPaging(Map<String, String> paraMap);

	List<String> searchShow(Map<String, String> paraMap);






}
