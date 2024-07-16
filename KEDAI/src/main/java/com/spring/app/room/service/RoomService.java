package com.spring.app.room.service;

import java.util.List;

import com.spring.app.domain.RoomMainVO;
import com.spring.app.domain.RoomSubVO;

public interface RoomService {

	List<RoomMainVO> roomMainListview();

	List<RoomSubVO> getRoomMainBySeq(Integer roomMainSeq);

	List<RoomSubVO> getroomall();


}
