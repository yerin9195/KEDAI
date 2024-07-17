package com.spring.app.reservation.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.common.Sha256;
import com.spring.app.domain.BusVO;
import com.spring.app.domain.MemberVO;
import com.spring.app.reservation.service.CarService;

@Controller 
public class CarController {
	
	@Autowired
	private CarService service;
	
	// sidebar에서 통근버스 클릭시 이동하는 페이지 만들기
	@GetMapping("/bus.kedai")
	public ModelAndView requiredLogin_bus(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) { // http://localhost:9099/final_project/bus.kedai
		
		mav.setViewName("tiles1/reservation/bus.tiles"); 
		return mav;
		
	}
	
	
	@ResponseBody			
	@GetMapping("/bus_select.kedai")
	public String requiredLogin_bus(HttpServletRequest request, HttpServletResponse response) { // http://localhost:9099/final_project/bus.kedai

		String bus_no = request.getParameter("bus_no");
		String pf_station_id = request.getParameter("pf_station_id");

		List<BusVO> stationList = service.getStationList(bus_no);
//			List<BusVO> stationTime = service.getStationTime(pf_station_id);
		
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
	public String requiredLogin_station(HttpServletRequest request, HttpServletResponse response) { // http://localhost:9099/final_project/bus.kedai
		String bus_no = request.getParameter("bus_no");
		String pf_station_id = request.getParameter("pf_station_id");
//			System.out.println("~~~ 확인용 pf_station_id : "+ pf_station_id);
//			System.out.println("~~~ 확인용 bus_no : "+ bus_no );
		
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
	
	
	// sidebar에서 카쉐어 클릭시 이동하는 페이지 만들기
	@GetMapping("/carShare.kedai")
	public ModelAndView requiredLogin_carShare(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) { // http://localhost:9099/final_project/carShare.kedai
		
		mav.setViewName("tiles1/reservation/carShare.tiles"); 
		return mav;
		
	}
	
	// 카쉐어 페이지에서 등록하기 버튼시 이동하는 페이지 만들기
	@GetMapping("/carRegister.kedai")
	public ModelAndView requiredLogin_carRegister(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) { // http://localhost:9099/final_project/carRegister.kedai
		
		mav.setViewName("tiles1/reservation/carRegister.tiles"); 
		return mav;
		
	}
	
	// 카쉐어 페이지에서 등록하기 버튼시 이동하는 페이지 만들기
	@PostMapping("/carRegisterEnd.kedai")
	public ModelAndView carRegisterEnd(ModelAndView mav, MemberVO mvo, HttpServletRequest request) { 
		
		Map<String, String> paraMap = new HashMap<>();
		
		String empid = request.getParameter("empid");
		String pwd = Sha256.encrypt(request.getParameter("pwd"));
		String name = request.getParameter("name");
		String nickname = request.getParameter("nickname");
		/*
		 * paraMap.put("empid", empid); paraMap.put("pwd", pwd); paraMap.put("name",
		 * name); paraMap.put("nickname", nickname); paraMap.put("email", email);
		 * paraMap.put("mobile", mobile); paraMap.put("postcode", postcode);
		 * paraMap.put("address", address); paraMap.put("detailaddress", detailaddress);
		 * paraMap.put("extraaddress", extraaddress);
		 * 
		 * try { int n = service.memberEditEnd(paraMap);
		 * 
		 * if(n == 1) { String message = name+"님의 정보가 정상적으로 수정되었습니다."; String loc =
		 * mrequest.getContextPath()+"/index.kedai";
		 * 
		 * mav.addObject("message", message); mav.addObject("loc", loc);
		 * 
		 * mav.setViewName("msg"); }
		 * 
		 * } catch (Exception e) { String message = "나의 정보 수정이 실패하였습니다.\\n다시 시도해주세요.";
		 * String loc = "javascript:history.back()";
		 * 
		 * mav.addObject("message", message); mav.addObject("loc", loc);
		 * 
		 * mav.setViewName("msg"); }
		 * 
		 */		return mav;
	}
	
	
	// 마이페이지에서 나의 차량 정보 등록 클릭시 들어가는 페이지 만들기
	@GetMapping("/myCar.kedai")
	public ModelAndView myCar(ModelAndView mav, HttpServletRequest request) { // http://localhost:9099/final_project/bus.kedai
		
		String userid = request.getParameter("userid");
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
        String empid = loginuser.getEmpid();
		
//		System.out.println("~~~확인용 : "+ empid);
//		~~~확인용 : 2010400-001
        
		// car테이블에서 mycar정보 가져오기
		List<Map<String,String>> myCar = service.myCar(empid);
		
		if(myCar == null) {
			mav.setViewName("tiles1/reservation/myCar.tiles");
		}
		
		mav.setViewName("tiles1/reservation/myCar.tiles");
		return mav;
		
	}
	
	// 마이페이지에서 나의 차량 정보 등록 클릭시 들어가는 페이지 만들기
	@GetMapping("/myCarEdit.kedai")
	public ModelAndView requiredLogin_myCarEdit(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) { // http://localhost:9099/final_project/bus.kedai
		
		mav.setViewName("tiles1/reservation/myCarEdit.tiles"); 
		return mav;
		
	}
	// 마이페이지에서 나의 차량 정보 등록 클릭시 들어가는 페이지 만들기
	@GetMapping("/myCarRegister.kedai")
	public ModelAndView myCarRegister(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) { // http://localhost:9099/final_project/bus.kedai
		
		mav.setViewName("tiles1/reservation/myCarRegister.tiles"); 
		return mav;
		
	}
	

	// 마이페이지에서 나의 카셰어링 예약 및 결제내역 클릭시 들어가는 페이지 만들기
	@GetMapping("/myCarReserveAndPay.kedai")
	public ModelAndView requiredLogin_myCarReserveAndPay(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) { // http://localhost:9099/final_project/bus.kedai
		
		mav.setViewName("tiles1/reservation/myCarReserveAndPay.tiles"); 
		return mav;
		
	}
	
	
	// 마이페이지에서 나의 카셰어링 예약 및 결제내역 클릭시 들어가는 페이지 만들기
	@GetMapping("/carApply_detail.kedai")
	public ModelAndView requiredLogin_carApply_detail(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) { // http://localhost:9099/final_project/bus.kedai
		
		mav.setViewName("tiles1/reservation/carApply_detail.tiles"); 
		return mav;
		
	}
	
	// 마이페이지에서 나의 카셰어링 예약 및 결제내역 클릭시 들어가는 페이지 만들기
	@GetMapping("/owner.kedai")
	public ModelAndView requiredLogin_owner(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) { // http://localhost:9099/final_project/bus.kedai
		
		mav.setViewName("tiles1/reservation/owner.tiles"); 
		return mav;
		
	}
	
	// 마이페이지에서 나의 카셰어링 예약 및 결제내역 클릭시 들어가는 페이지 만들기
	@GetMapping("/customer.kedai")
	public ModelAndView requiredLogin_customer(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) { // http://localhost:9099/final_project/bus.kedai
		
		mav.setViewName("tiles1/reservation/customer.tiles"); 
		return mav;
		
	}

}
