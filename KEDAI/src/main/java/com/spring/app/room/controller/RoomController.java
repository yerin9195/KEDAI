package com.spring.app.room.controller;

import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.app.domain.RoomMainVO;
import com.spring.app.room.service.RoomService;

@Controller
public class RoomController {

	@Autowired
	private RoomService service;
	
	  @GetMapping(value = "/roommain.kedai", produces = "application/json;charset=UTF-8")
	  @ResponseBody 
	    public String roommain () {
	        List<RoomMainVO> roomMainList = service.roomMainListview();
	        System.out.println(roomMainList.toString());

	        JSONArray jsonArr = new JSONArray();

	        if(roomMainList != null) {
	            for(RoomMainVO vo : roomMainList) {
	                JSONObject jsonObj = new JSONObject();

	                jsonObj.put("roomMainSeq", vo.getRoomMainSeq());
	                jsonObj.put("roomMainName", vo.getRoomMainName());
	                jsonObj.put("roomMainDetail", vo.getRoomMainDetail());

	                jsonArr.put(jsonObj);
	            }
	        }

	        return jsonArr.toString();
	  }
}
