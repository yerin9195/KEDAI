package com.spring.app.reservation.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.common.AES256;
import com.spring.app.domain.BusVO;
import com.spring.app.domain.CarVO;
import com.spring.app.reservation.model.CarDAO;

@Service
public class CarService_imple implements CarService {

	@Autowired			
	private CarDAO dao;			

    @Autowired
    private AES256 aES256;

	@Override
	public List<BusVO> getStationList(String bus_no) {
		List<BusVO> stationList = dao.getStationList(bus_no);
		return stationList;
	}

	@Override
	public List<BusVO> getStationTimeList(String pf_station_id, String bus_no) {
		List<BusVO> stationTimeList = dao.getStationTimeList(bus_no,pf_station_id);
		return stationTimeList;
	}

	@Override
	public List<Map<String, String>> myCar(String empid) {
		List<Map<String, String>> myCar = dao.getmyCar(empid);
		return myCar;
	}

	// 파일첨부가 없는 차량등록
	@Override
	public int addMycar(CarVO cvo) {
		int n = dao.addMycar(cvo);
		return n;
	}



}
