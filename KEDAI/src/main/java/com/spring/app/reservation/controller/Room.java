package com.spring.app.reservation.controller;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.app.domain.RoomMainVO;
import com.spring.app.domain.RoomSubVO;
import com.spring.app.reservation.service.RoomService2;


//	qwe
//@Controller
public class Room {

	@Autowired
	private RoomService2 service;
	
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
}