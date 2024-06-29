package com.spring.app.reservation.service;

import java.util.List;

import com.spring.app.domain.BusVO;

public interface CarService {

	List<BusVO> getStationList(String bus_no);


}
