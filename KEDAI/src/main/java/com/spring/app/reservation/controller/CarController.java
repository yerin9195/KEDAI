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
		
		mav.setViewName("tiles1/carShare.tiles"); 
		return mav;
		
	}
	
	// 카쉐어 페이지에서 등록하기 버튼시 이동하는 페이지 만들기
	@GetMapping("/carRegister.kedai")
	public ModelAndView carRegister(ModelAndView mav) { // http://localhost:9099/final_project/carRegister.kedai
		
		mav.setViewName("tiles1/carRegister.tiles"); 
		return mav;
		
	}
	
	// sidebar에서 통근버스 클릭시 이동하는 페이지 만들기
	@GetMapping("/bus.kedai")
	public ModelAndView bus(ModelAndView mav) { // http://localhost:9099/final_project/bus.kedai
		
		mav.setViewName("tiles1/bus.tiles"); 
		return mav;
		
	}
	
	
	@ResponseBody			
	@GetMapping("/bus_select.kedai")
	public String bus(HttpServletRequest request) { // http://localhost:9099/final_project/bus.kedai

		String bus_no = request.getParameter("bus_no");

		List<BusVO> stationList = service.getStationList(bus_no);

		
		JSONArray jsonArr = new JSONArray();				// []
		
		if(stationList != null) {
			for(BusVO busvo : stationList) {
				JSONObject jsonObj = new JSONObject();		// {}
				jsonObj.put("pf_station_id", busvo.getPf_station_id());	
				jsonObj.put("station_name", busvo.getStation_name()); 
				jsonObj.put("way", busvo.getWay());		
				jsonObj.put("lat", busvo.getLat());	
				jsonObj.put("lng", busvo.getLng());
				jsonObj.put("time_gap", busvo.getTime_gap());
				jsonObj.put("zindex", busvo.getZindex());
				
				
				jsonArr.put(jsonObj);
			}//end of for-------------------------
		}
		
		
		return jsonArr.toString();
		
	}
	
}
