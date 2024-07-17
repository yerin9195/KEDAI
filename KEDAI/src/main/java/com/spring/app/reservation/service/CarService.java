package com.spring.app.reservation.service;

import java.util.List;
import java.util.Map;

import com.spring.app.domain.BusVO;

public interface CarService {

	List<BusVO> getStationList(String bus_no);

	List<BusVO> getStationTimeList(String pf_station_id, String bus_no);

	List<Map<String, String>> myCar(String empid);



}
