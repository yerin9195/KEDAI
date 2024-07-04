package com.spring.app.reservation.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.domain.BusVO;
import com.spring.app.reservation.service.CarService;

@Controller 
public class CarController {
	
	@Autowired
	private CarService service;
	
	// sidebar에서 카쉐어 클릭시 이동하는 페이지 만들기
	@GetMapping("/carShare.kedai")
	public ModelAndView carShare(ModelAndView mav) { // http://localhost:9099/final_project/carShare.kedai
		
		mav.setViewName("tiles1/reservation/carShare.tiles"); 
		return mav;
		
	}
	
	// 카쉐어 페이지에서 등록하기 버튼시 이동하는 페이지 만들기
	@GetMapping("/carRegister.kedai")
	public ModelAndView carRegister(ModelAndView mav) { // http://localhost:9099/final_project/carRegister.kedai
		
		mav.setViewName("tiles1/reservation/carRegister.tiles"); 
		return mav;
		
	}
	
	// sidebar에서 통근버스 클릭시 이동하는 페이지 만들기
	@GetMapping("/bus.kedai")
	public ModelAndView bus(ModelAndView mav) { // http://localhost:9099/final_project/bus.kedai
		
		mav.setViewName("tiles1/reservation/bus.tiles"); 
		return mav;
		
	}
	
	
	@ResponseBody			
	@GetMapping("/bus_select.kedai")
	public String bus(HttpServletRequest request) { // http://localhost:9099/final_project/bus.kedai

		String bus_no = request.getParameter("bus_no");
		String pf_station_id = request.getParameter("pf_station_id");

		List<BusVO> stationList = service.getStationList(bus_no);
//		List<BusVO> stationTime = service.getStationTime(pf_station_id);
		
		JSONArray jsonArr = new JSONArray();				// []
		
		if(stationList != null) {
			for(BusVO busvo : stationList) {
				JSONObject jsonObj = new JSONObject();		// {}
				jsonObj.put("bus_no", busvo.getBus_no());	
				jsonObj.put("pf_station_id", busvo.getPf_station_id());	
				jsonObj.put("station_name", busvo.getStation_name()); 
				jsonObj.put("way", busvo.getWay());		
				jsonObj.put("lat", busvo.getLat());	
				jsonObj.put("lng", busvo.getLng());
				jsonObj.put("zindex", busvo.getZindex());
				jsonObj.put("minutes_until_next_bus", busvo.getMinutes_until_next_bus());
				
				jsonArr.put(jsonObj);
			}//end of for-------------------------
		}
		
		
		return jsonArr.toString();
		
	}
	
	@ResponseBody
	@GetMapping("/station_select.kedai")
	public String station(HttpServletRequest request) { // http://localhost:9099/final_project/bus.kedai
		String bus_no = request.getParameter("bus_no");
		String pf_station_id = request.getParameter("pf_station_id");
		System.out.println("~~~ 확인용 pf_station_id : "+ pf_station_id);
		System.out.println("~~~ 확인용 bus_no : "+ bus_no );
		
		List<BusVO> stationTimeList = service.getStationTimeList(bus_no,pf_station_id);
		
		JSONArray jsonArr = new JSONArray();				// []
		
		if(stationTimeList != null) {
			for(BusVO busvo : stationTimeList) {
				JSONObject jsonObj = new JSONObject();		// {}
				jsonObj.put("bus_no", busvo.getBus_no());	
				jsonObj.put("pf_station_id", busvo.getPf_station_id());	
				jsonObj.put("station_name", busvo.getStation_name()); 
				jsonObj.put("way", busvo.getWay());		
				jsonObj.put("lat", busvo.getLat());	
				jsonObj.put("lng", busvo.getLng());
				jsonObj.put("zindex", busvo.getZindex());
				jsonObj.put("minutes_until_next_bus", busvo.getMinutes_until_next_bus());
				
				jsonArr.put(jsonObj);
			}//end of for-------------------------
		}
		
		
		return jsonArr.toString();
		
	}
	
}
