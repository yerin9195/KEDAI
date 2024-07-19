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

import com.spring.app.common.FileManager;
import com.spring.app.common.Sha256;
import com.spring.app.domain.BusVO;
import com.spring.app.domain.CarVO;
import com.spring.app.domain.MemberVO;
import com.spring.app.reservation.service.CarService;

@Controller 
public class CarController {
	
	@Autowired
	private CarService service;
	
	@Autowired
	private FileManager fileManager;
	
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
		
        String fk_empid = loginuser.getEmpid();
		
//		System.out.println("~~~확인용 : "+ empid);
//		~~~확인용 : 2010400-001
        
		// car테이블에서 mycar정보 가져오기
		List<Map<String,String>> myCar = service.myCar(fk_empid);
		
		if(myCar == null) {
			mav.setViewName("tiles1/reservation/myCar.tiles");
		}
		
//		System.out.println("~~~ 확인용 : " + myCar);
		mav.addObject("myCar", myCar);
		mav.setViewName("tiles1/reservation/myCar.tiles");
		return mav;
		
	}
	
	// 마이페이지에서 나의 차량 정보 등록 클릭시 들어가는 페이지 만들기
	@PostMapping("/myCarEdit.kedai")
	public ModelAndView myCarEdit(HttpServletRequest request, ModelAndView mav) { // http://localhost:9099/final_project/bus.kedai
		
		mav.setViewName("tiles1/reservation/myCarEdit.tiles"); 
		return mav;
		
	}
	// 마이페이지에서 나의 차량 정보 등록 클릭시 들어가는 페이지 만들기
	@PostMapping("/myCarEditEnd.kedai")
	public ModelAndView myCarEditEnd(MultipartHttpServletRequest mrequest, CarVO cvo, ModelAndView mav) { // http://localhost:9099/final_project/bus.kedai

		Map<String, Object> paraMap = new HashMap<>();
        
		HttpSession session = mrequest.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
        String fk_empid = loginuser.getEmpid();
        
		MultipartFile attach = cvo.getAttach();
		
		if(attach != null) { // 첨부파일이 있는 경우
			
			// WAS 의 webapp 의 절대경로 알아오기
			String root = session.getServletContext().getRealPath("/"); 
			// C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\KEDAI\
			
			String path = root+"resources"+File.separator+"files";
			// C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\KEDAI\resources\files
			
			// 파일첨부를 위한 변수의 설정 및 값을 초기화 한 후 파일 올리기
			String newFileName = ""; // WAS(톰캣)의 디스크에 저장될 파일명
			byte[] bytes = null;     // 첨부파일의 내용물을 담는 것
			
			try {
				bytes = attach.getBytes(); 
				
				String originalFilename = attach.getOriginalFilename(); // 첨부파일명의 파일명
				
				newFileName = fileManager.doFileUpload(bytes, originalFilename, path); // 첨부되어진 파일을 업로드
				
				paraMap.put("newFileName", newFileName);
				paraMap.put("originalFilename", originalFilename);
				
			} catch (Exception e) {
				e.printStackTrace(); 
			}
			
		} // end of if(attach != null) ----------
		
		String car_type = mrequest.getParameter("car_type");
		String car_num = mrequest.getParameter("car_num");
		int max_num = Integer.parseInt(mrequest.getParameter("max_num"));
		int insurance = Integer.parseInt(mrequest.getParameter("insurance"));
		String license = mrequest.getParameter("license");
		String drive_year = mrequest.getParameter("drive_year");
		
	    System.out.println("~~~ 확인용 : "+ fk_empid);
		System.out.println("~~~ 확인용 : "+ car_type);
		System.out.println("~~~ 확인용 : "+ car_num);
		System.out.println("~~~ 확인용 : "+ max_num);
		System.out.println("~~~ 확인용 : "+ insurance);
		System.out.println("~~~ 확인용 : "+ drive_year);
		System.out.println("~~~ 확인용 : " + license);
		
		paraMap.put("fk_empid",fk_empid);
		paraMap.put("car_type",car_type);
		paraMap.put("car_num",car_num);
		paraMap.put("max_num",max_num);
		paraMap.put("insurance",insurance);
		paraMap.put("license",license);
		paraMap.put("drive_year",drive_year);
		
		
		/*
		 * try { int n = service.editMycar(cvo);
		 * 
		 * if(n ==1) { String message = "내 차 정보가 정상적으로 수정되었습니다."; String loc =
		 * mrequest.getContextPath()+"/index.kedai";
		 * 
		 * mav.addObject("message",message); mav.addObject("loc",loc);
		 * 
		 * mav.setViewName("msg");
		 * 
		 * } }catch(Exception e) { String message = "내 차 정보 수정이 실패했습니다. \\n 다시 시도해주세요.";
		 * String loc = "javascript:history.back()";
		 * 
		 * mav.addObject("message",message); mav.addObject("loc",loc);
		 * 
		 * mav.setViewName("msg");
		 * 
		 * 
		 * }
		 */
		return mav;
		
	}
	// 마이페이지에서 나의 차량 정보 등록 클릭시 들어가는 페이지 만들기
	@GetMapping("/myCarRegister.kedai")
	public ModelAndView myCarRegister(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) { // http://localhost:9099/final_project/bus.kedai
		
		mav.setViewName("tiles1/reservation/myCarRegister.tiles"); 
		return mav;
		
	}
	// 마이페이지에서 나의 차량 정보 등록  완료시
	@PostMapping("/myCarRegisterEnd.kedai")
	public ModelAndView myCarRegisterEnd(ModelAndView mav, CarVO cvo, MultipartHttpServletRequest mrequest) { // http://localhost:9099/final_project/bus.kedai
		
		String userid = mrequest.getParameter("userid");
		HttpSession session = mrequest.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
        String fk_empid = loginuser.getEmpid();
        
		MultipartFile attach = cvo.getAttach();
		
		if(attach != null) { // 첨부파일이 있는 경우
			
			// WAS 의 webapp 의 절대경로 알아오기
			String root = session.getServletContext().getRealPath("/"); 
			// C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\KEDAI\
			
			String path = root+"resources"+File.separator+"files";
			// C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\KEDAI\resources\files
			
			// 파일첨부를 위한 변수의 설정 및 값을 초기화 한 후 파일 올리기
			String newFileName = ""; // WAS(톰캣)의 디스크에 저장될 파일명
			byte[] bytes = null;     // 첨부파일의 내용물을 담는 것
			
			try {
				bytes = attach.getBytes(); 
				
				String originalFilename = attach.getOriginalFilename(); // 첨부파일명의 파일명
				
				newFileName = fileManager.doFileUpload(bytes, originalFilename, path); // 첨부되어진 파일을 업로드
				
				cvo.setCar_imgfilename(newFileName);
				cvo.setCar_orgimgfilename(originalFilename);
				
			} catch (Exception e) {
				e.printStackTrace(); 
			}
			
		} // end of if(attach != null) ----------
		
		String car_type = mrequest.getParameter("car_type");
		String car_num = mrequest.getParameter("car_num");
		int max_num = Integer.parseInt(mrequest.getParameter("max_num"));
		int insurance = Integer.parseInt(mrequest.getParameter("insurance"));
		String license = mrequest.getParameter("license");
		String drive_year = mrequest.getParameter("drive_year");
		
//	    System.out.println("~~~ 확인용 : "+ fk_empid);
//		System.out.println("~~~ 확인용 : "+ car_type);
//		System.out.println("~~~ 확인용 : "+ car_num);
//		System.out.println("~~~ 확인용 : "+ max_num);
//		System.out.println("~~~ 확인용 : "+ insurance);
//		System.out.println("~~~ 확인용 : "+ drive_year);
//		System.out.println("~~~ 확인용 : " + license);
		
		cvo.setFk_empid(fk_empid);
		cvo.setCar_type(car_type);
		cvo.setCar_num(car_num);
		cvo.setMax_num(max_num);
		cvo.setInsurance(insurance);
		cvo.setDrive_year(drive_year);
		cvo.setLicense(license);
		
		
		try {
			int n = service.addMycar(cvo);
			
			if(n ==1) {
				String message = "내 차 정보가 정상적으로 등록되었습니다.";
				String loc = mrequest.getContextPath()+"/index.kedai";
				
				mav.addObject("message",message);
				mav.addObject("loc",loc);
				
				mav.setViewName("msg");
				
			}
		}catch(Exception e) {
			String message = "내 차 정보 등록이 실패했습니다. \\n 다시 시도해주세요.";
			String loc = "javascript:history.back()";
			
			mav.addObject("message",message);
			mav.addObject("loc",loc);
			
			mav.setViewName("msg");
		
			
		}
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
