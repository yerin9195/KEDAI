package com.spring.app.reservation.service;
import java.util.List;

import com.spring.app.domain.MemberVO; 
import com.spring.app.domain.RoomMainVO; import com.spring.app.domain.RoomSubVO;
import com.spring.app.domain.SalaryVO;
 
public interface RoomService2 {

 	List<RoomMainVO> roomMainListview();

 	List<RoomSubVO> getRoomMainBySeq(Integer roomMainSeq);
 	
 	List<RoomSubVO> getroomall();

 	//급여명세서 직원목록 불러오기 
 	List<MemberVO> memberListView();

	// 급여명세서 계산 
 	int salaryCal(SalaryVO salaryvo);
 
}
