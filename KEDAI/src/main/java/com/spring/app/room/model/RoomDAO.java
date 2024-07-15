package com.spring.app.room.model;

import java.util.List;

import com.spring.app.domain.RoomMainVO;
import com.spring.app.domain.RoomSubVO;

public interface RoomDAO {

	List<RoomMainVO> roomMainView();

	List<RoomSubVO> getRoomMainBySeq(Integer roomMainSeq);

	List<RoomSubVO> getRoomroomall();




}
