package com.spring.app.reservation.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;


import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.domain.RoomMainVO;
import com.spring.app.domain.RoomSubVO;
import com.spring.app.domain.RoomVO;
import com.spring.app.reservation.service.RoomService;

@Controller
public class RoomController {

	@Autowired
	private RoomService service;
	
	 @GetMapping(value = "/roommain.kedai", produces = "application/json;charset=UTF-8")
	    @ResponseBody
	    public String roommain(@RequestParam(required = false) Integer roomMainSeq ) {
	        JSONArray jsonArr = new JSONArray();

	        if (roomMainSeq == null) {
	            // roomMainSeq가 없을 경우 모든 RoomMain 리스트를 반환
	            List<RoomMainVO> roomMainList = service.roomMainListview();

	            if (roomMainList != null) {
	                for (RoomMainVO vo : roomMainList) {
	                    JSONObject jsonObj = new JSONObject();

	                    jsonObj.put("roomMainSeq", vo.getRoomMainSeq());
	                    jsonObj.put("roomMainName", vo.getRoomMainName());
	                    jsonObj.put("roomMainDetail", vo.getRoomMainDetail());

	                    jsonArr.put(jsonObj);
	                }
	            }
	        } else {
	            // roomMainSeq가 있을 경우 해당하는 RoomSub 리스트를 반환
	            List<RoomSubVO> roomSubList = service.getRoomMainBySeq(roomMainSeq);

	            if (roomSubList != null) {
	                for (RoomSubVO vo : roomSubList) {
	                    JSONObject jsonObj = new JSONObject();
	                    jsonObj.put("roomSubSeq", vo.getRoomSubSeq());
	                    jsonObj.put("roomMainSeq", vo.getRoomMainSeq());
	                    jsonObj.put("roomSubName", vo.getRoomSubName());
	                    jsonObj.put("roomSub_detail", vo.getRoomSub_detail());
	                    jsonObj.put("room_status", vo.getRoom_status());
	                    jsonArr.put(jsonObj);
	                }
	            }
	        }

	        return jsonArr.toString();
	    }
	 
	 @GetMapping(value = "/roomall.kedai", produces = "application/json;charset=UTF-8")
	 @ResponseBody
	 public String roomall() {
		 List<RoomSubVO> roomSubList = service.getroomall();
		 JSONArray jsonArr = new JSONArray();
		 
         if (roomSubList != null) {
             for (RoomSubVO vo : roomSubList) {
                 JSONObject jsonObj = new JSONObject();
                 jsonObj.put("roomSubSeq", vo.getRoomSubSeq());
                 jsonObj.put("roomMainSeq", vo.getRoomMainSeq());
                 jsonObj.put("roomSubName", vo.getRoomSubName());
                 jsonObj.put("roomSub_detail", vo.getRoomSub_detail());
                 jsonObj.put("room_status", vo.getRoom_status());
                 jsonArr.put(jsonObj);
             }
         }
         return jsonArr.toString();
	 }
	 
	 @GetMapping(value = "/roomResercation.kedai")  // http://localhost:8090/board/pay_stub.action
	 public String roomResercation(HttpServletRequest request) {
		
		 return "tiles1/reservation/roomReservation.tiles";
	 }
	 
	 @PostMapping("/reserve.kedai")
	    public ResponseEntity<Map<String, Object>> reserveRoom(@RequestBody Map<String, Object> reservationData) {
	        Map<String, Object> response = new HashMap<>();
	        try {
	            RoomVO roomVO = new RoomVO();
	            roomVO.setFk_empid((String) reservationData.get("reserver"));
	            roomVO.setFk_room_name((String) reservationData.get("roomname")); 
	            roomVO.setContent((String) reservationData.get("purpose"));

	            // 입력된 날짜와 시간의 형식
	            SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm", Locale.KOREAN);
	            SimpleDateFormat dbDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");

	            String startDateTime = (String) reservationData.get("startDateTime");
	            String endDateTime = (String) reservationData.get("endDateTime");

	            // 디버깅을 위한 출력
	            System.out.println("Received startDateTime: " + startDateTime);
	            System.out.println("Received endDateTime: " + endDateTime);

	            Date startDate = inputFormat.parse(startDateTime);
	            Date endDate = inputFormat.parse(endDateTime);

	            // 디버깅을 위한 출력
	            System.out.println("Parsed startDate: " + startDate);
	            System.out.println("Parsed endDate: " + endDate);

	            // TO_DATE 형식과 일치하도록 문자열로 포맷
	            String formattedStartTime = dbDateFormat.format(startDate);
	            String formattedEndTime = dbDateFormat.format(endDate);

	         
	            roomVO.setStart_time(formattedStartTime);
	            roomVO.setEnd_time(formattedEndTime);

	            String formattedRegisterDay = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
	            roomVO.setRegisterday(formattedRegisterDay);
	            roomVO.setReservation_status(1);

	            // 서비스 호출
	            service.insertreserve(roomVO);

	            ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
	            String contextPath = attributes.getRequest().getContextPath();
	            String redirectUrl = contextPath + "/roomResercation.kedai";
	            
	            response.put("success", true);
	            response.put("redirectUrl", redirectUrl);
	        } catch (ParseException e) {
	            response.put("success", false);
	            response.put("message", "날짜 형식이 잘못되었습니다: " + e.getMessage());
	        } catch (Exception e) {
	            response.put("success", false);
	            response.put("message", e.getMessage());
	        }
	        
	        return ResponseEntity.ok(response);
	    }

	

	  @GetMapping("/getRoomData.kedai")
	    public ResponseEntity<?> getRoomData(@RequestParam String subroom) {
		    try {
	            List<RoomSubVO> roomData = service.getRoomData(subroom);
	            return ResponseEntity.ok(roomData);
	        } catch (Exception e) {
	            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error fetching room data");
	        }
	    }
	  
	  @GetMapping(value = "/getReservations.kedai", produces = "application/json;charset=UTF-8")
	    @ResponseBody
	    public ResponseEntity<String> getReservations() {
	        if (service == null) {
	            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Service is not available");
	        }

	        List<RoomVO> reservations = service.getAllReservations();
	        
	        JSONArray jsonArr = new JSONArray();

	        for (RoomVO reservation : reservations) {
	            JSONObject jsonObj = new JSONObject();
	            jsonObj.put("reservation_seq", reservation.getReservation_seq());
	            jsonObj.put("roomName", reservation.getFk_room_name());
	            jsonObj.put("reserver", reservation.getFk_empid());
	            jsonObj.put("startTime", reservation.getStart_time());
	            jsonObj.put("endTime", reservation.getEnd_time());
	            jsonObj.put("purpose", reservation.getContent());
	            jsonObj.put("status", reservation.getReservation_status());
	            jsonArr.put(jsonObj);
	        }

	        return ResponseEntity.ok(jsonArr.toString());
	    }
	  
	  @GetMapping("/reservation_detail.kedai")
	  public String getReservationDetail(@RequestParam("reservation_seq") String reservation_seq, Model model) {
	      RoomVO reservation = service.getReservations(reservation_seq);
	      
	      if (reservation != null) {
	          String formattedStartDate = "";
	          String formattedStartTime = "";
	          String formattedEndDate = "";
	          String formattedEndTime = "";
	          String startTimeString = reservation.getStart_time(); // Assume this is a String
	          String endTimeString = reservation.getEnd_time(); // Assume this is a String

	          // Define the expected date format
	          SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); // Adjust this pattern as needed
	          SimpleDateFormat outputDateFormat = new SimpleDateFormat("yyyy-MM-dd (E)");
	          SimpleDateFormat outputTimeFormat = new SimpleDateFormat("HH:mm");
	          
	          try {
	              Date startTime = inputFormat.parse(startTimeString);
	              Date endTime = inputFormat.parse(endTimeString);
	              formattedStartDate = outputDateFormat.format(startTime);
	              formattedStartTime = outputTimeFormat.format(startTime);
	              formattedEndDate = outputDateFormat.format(endTime);
	              formattedEndTime = outputTimeFormat.format(endTime);
	              
	          } catch (ParseException e) {
	              e.printStackTrace(); // Log the error for debugging
	          }

	          model.addAttribute("reservation", reservation);
	          model.addAttribute("formattedStartDate", formattedStartDate);
	          model.addAttribute("formattedStartTime", formattedStartTime);
	          model.addAttribute("formattedEndDate", formattedEndDate);
	          model.addAttribute("formattedEndTime", formattedEndTime);
	      }

	      return "tiles1/reservation/reservation_detail.tiles";
	  }
	  
	  @PostMapping("/update_reservation.kedai")
	  public ResponseEntity<Map<String, Object>> reservationDataupdateReservation(
	            @RequestParam("reservation_seq") int reservationSeq,
	            @RequestBody Map<String, Object> reservationData) {
	        Map<String, Object> response = new HashMap<>();
	        try {
	            RoomVO roomVO = new RoomVO();
	            roomVO.setReservation_seq(reservationSeq);
	            roomVO.setFk_empid((String) reservationData.get("reserver"));
	            roomVO.setFk_room_name((String) reservationData.get("roomname")); 
	            roomVO.setContent((String) reservationData.get("purpose"));

	            // 입력된 날짜와 시간의 형식
	            SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm", Locale.KOREAN);
	            SimpleDateFormat dbDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");

	            String startDateTime = (String) reservationData.get("startDateTime");
	            String endDateTime = (String) reservationData.get("endDateTime");

	            // 디버깅을 위한 출력
	            System.out.println("Received startDateTime: " + startDateTime);
	            System.out.println("Received endDateTime: " + endDateTime);

	            Date startDate = inputFormat.parse(startDateTime);
	            Date endDate = inputFormat.parse(endDateTime);

	            // 디버깅을 위한 출력
	            System.out.println("Parsed startDate: " + startDate);
	            System.out.println("Parsed endDate: " + endDate);

	            // TO_DATE 형식과 일치하도록 문자열로 포맷
	            String formattedStartTime = dbDateFormat.format(startDate);
	            String formattedEndTime = dbDateFormat.format(endDate);

	         
	            roomVO.setStart_time(formattedStartTime);
	            roomVO.setEnd_time(formattedEndTime);

	            String formattedRegisterDay = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
	            roomVO.setRegisterday(formattedRegisterDay);
	            roomVO.setReservation_status(1);
	            
	            // 서비스 호출
	            service.updateReservation(roomVO);

	            ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
	            String contextPath = attributes.getRequest().getContextPath();
	            String redirectUrl = contextPath + "/roomResercation.kedai";
	            
	            response.put("success", true);
	            response.put("redirectUrl", redirectUrl);
	        } catch (ParseException e) {
	            response.put("success", false);
	            response.put("message", "날짜 형식이 잘못되었습니다: " + e.getMessage());
	        } catch (Exception e) {
	            response.put("success", false);
	            response.put("message", e.getMessage());
	        }
	        
	        return ResponseEntity.ok(response);
	    }
	  
	  
	  @PostMapping("/delete_reservation.kedai")
	  public ResponseEntity<Map<String, Object>> delete_reservation( @RequestParam("reservation_seq") int reservationSeq) {
		  Map<String, Object> response = new HashMap<>();
		  try {
	            service.deleteReservation(reservationSeq);

	            ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
	            String contextPath = attributes.getRequest().getContextPath();
	            String redirectUrl = contextPath + "/roomResercation.kedai";
	            
	            response.put("success", true);
	            response.put("redirectUrl", redirectUrl);
	        
	        } catch (Exception e) {
	            response.put("success", false);
	            response.put("message", e.getMessage());
	        }
	        
	        return ResponseEntity.ok(response);
	    
	  }
}