package com.spring.app.schedule.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.spring.app.domain.CalendarScheduleVO;
import com.spring.app.domain.CalendarSmallCategoryVO;

@Repository
public class ScheduleDAO_imple implements ScheduleDAO {
	
	@Resource
	private SqlSessionTemplate sqlsession;
	
	// 사내 캘린더에서 사내캘린더 소분류  보여주기 
	@Override
	public List<CalendarSmallCategoryVO> showCompanySmallCalendar() {
		List<CalendarSmallCategoryVO> calendarSmallCategoryVO_CompanyList = sqlsession.selectList("schedule.showCompanySmallCalendar");  
		return calendarSmallCategoryVO_CompanyList;
	}

	// 내 캘린더에서 내캘린더 소분류  보여주기
	@Override
	public List<CalendarSmallCategoryVO> showMySmallCalendar(String fk_empid) {
		List<CalendarSmallCategoryVO> calendarSmallCategoryVO_MyList = sqlsession.selectList("schedule.showMySmallCalendar", fk_empid);  
		return calendarSmallCategoryVO_MyList;
	}

	
	// 등록된 일정 가져오기
	@Override
	public List<CalendarScheduleVO> allSchedule(String fk_empid) {
		List<CalendarScheduleVO> allscheduleList = sqlsession.selectList("schedule.allSchedule", fk_empid);
		return allscheduleList;
	}
	
	// 일정 상세 보기 
	@Override
	public Map<String, String> detailSchedule(String scheduleno) {
		Map<String,String> map = sqlsession.selectOne("schedule.detailSchedule", scheduleno);
		return map;
	}

	// 사내 캘린더에 캘린더 소분류 명 존재 여부 알아오기
	@Override
	public int existComCalendar(String com_smcatgoname) {
		int m = sqlsession.selectOne("schedule.existComCalendar", com_smcatgoname);
		return m;
	}
	
	// 사내 캘린더에 캘린더 소분류 추가하기
	@Override
	public int addComCalendar(Map<String, String> paraMap) throws Throwable {
		int n = sqlsession.insert("schedule.addComCalendar", paraMap);
		return n;
	}

	// 수정된 (사내캘린더 또는 내캘린더)속의 소분류 카테고리명이 이미 해당 사용자가 만든 소분류 카테고리명으로 존재하는지 유무 알아오기  
	@Override
	public int existsCalendar(Map<String, String> paraMap) {
		int m = sqlsession.selectOne("schedule.existsCalendar", paraMap);
		return m;
	}

	// 총 일정 검색 건수(totalCount)
	@Override
	public int getTotalCount(Map<String, String> paraMap) {
		int n = sqlsession.selectOne("schedule.getTotalCount", paraMap);
		return n;
	}

	// 내 캘린더에 캘린더 소분류 명 존재 여부 알아오기
	@Override
	public int existMyCalendar(Map<String, String> paraMap) {
		int m = sqlsession.selectOne("schedule.existMyCalendar", paraMap);
		return m;
	}

	// 내 캘린더에 캘린더 소분류 추가하기
	@Override
	public int addMyCalendar(Map<String, String> paraMap) throws Throwable {
		int n = sqlsession.insert("schedule.addMyCalendar", paraMap);
		return n;
	}

	// (사내캘린더 또는 내캘린더)속의  소분류 카테고리인 서브캘린더 삭제하기 
	@Override
	public int deleteSubCalendar(String smcatgono) throws Throwable {
		int n = sqlsession.delete("schedule.deleteSubCalendar", smcatgono);
		return n;
	}
	
	// 페이징 처리한 캘린더 가져오기(검색어가 없다라도 날짜범위 검색은 항시 포함된 것임)
	@Override
	public List<Map<String, String>> scheduleListSearchWithPaging(Map<String, String> paraMap) {
		List<Map<String,String>> scheduleList = sqlsession.selectList("schedule.scheduleListSearchWithPaging", paraMap);
		return scheduleList;
	}
	
	// (사내캘린더 또는 내캘린더)속의 소분류 카테고리인 서브캘린더 수정하기 
	@Override
	public int editCalendar(Map<String, String> paraMap) {
		int n = sqlsession.update("schedule.editCalendar", paraMap);
		return n;
	}

	@Override
	public List<CalendarSmallCategoryVO> selectSmallCategory(Map<String, String> paraMap) {
		List<CalendarSmallCategoryVO> small_category_VOList = sqlsession.selectList("schedule.selectSmallCategory", paraMap);
		return small_category_VOList;
	}





}
