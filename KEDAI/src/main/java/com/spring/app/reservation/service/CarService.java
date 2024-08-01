package com.spring.app.reservation.service;

import java.util.List;
import java.util.Map;

import com.spring.app.domain.BoardVO;
import com.spring.app.domain.BusVO;
import com.spring.app.domain.CarVO;
import com.spring.app.domain.Car_shareVO;
import com.spring.app.domain.Day_shareVO;

public interface CarService {

	List<BusVO> getStationList(String bus_no);

	List<BusVO> getStationTimeList(String pf_station_id, String bus_no);

	List<Map<String, String>> myCar(String fk_empid);

	CarVO myCar2(String fk_empid);

	int addMycar(CarVO cvo);

	int editMycar(Map<String, Object> paraMap);

	int addcarRegister(Map<String, Object> paraMap);

	List<Map<String, String>> carShareList();

	Day_shareVO day_shareInfo(int res_num);

	int addcarApply_detail(Map<String, Object> paraMap);

	int getTotalCount(Map<String, String> paraMap);

	List<Map<String, String>> carShareListSearch_withPaging(Map<String, String> paraMap);

	List<String> searchShow(Map<String, String> paraMap);

	List<Map<String, String>> owner_carShareList(String empid);

	List<Map<String, String>> owner_carShareListSearch_withPaging(Map<String, String> paraMap);

	int owner_getTotalCount(Map<String, String> paraMap);

	Car_shareVO owner_dateInfo(String date);

	List<String> searchShow_owner(Map<String, String> paraMap);


}
