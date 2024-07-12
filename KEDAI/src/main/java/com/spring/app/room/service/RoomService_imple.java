package com.spring.app.room.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.common.AES256;
import com.spring.app.domain.BusVO;
import com.spring.app.domain.MemberVO;
import com.spring.app.domain.RoomMainVO;
import com.spring.app.reservation.model.CarDAO;
import com.spring.app.room.model.RoomDAO;

@Service
public class RoomService_imple implements RoomService {

	@Autowired			
	private RoomDAO dao;			
	
	@Override
	public List<RoomMainVO> roomMainListview() {
		List<RoomMainVO> roomMainList = dao.roomMainView();
		return roomMainList;
	}




}
