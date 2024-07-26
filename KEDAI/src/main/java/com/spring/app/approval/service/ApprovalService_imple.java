package com.spring.app.approval.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.app.approval.model.ApprovalDAO;
import com.spring.app.domain.DeptVO;
import com.spring.app.domain.DocVO;
import com.spring.app.domain.MinutesVO;

@Service
public class ApprovalService_imple implements ApprovalService {
	
	// === #34. 의존객체 주입하기(DI: Dependency Injection) ===
	@Autowired  // Type에 따라 알아서 Bean 을 주입해준다.
	private ApprovalDAO dao;
	// Type 에 따라 Spring 컨테이너가 알아서 bean 으로 등록된 com.spring.board.model.BoardDAO_imple 의 bean 을  dao 에 주입시켜준다. 
	// 그러므로 dao 는 null 이 아니다.

	// 새로운 기안 서류 작성 시 작성자의 부서 이름 가져오기
	@Override
	public String getDeptNumber(Map<String, String> paraMap) {
		String deptNumber = dao.getDeptNumber(paraMap);
		return deptNumber;
	}
	
	// 결재 라인에서 찾을 모든 사원 목록 보기
/*	@Override
	public List<Map<String, String>> allEmployeeList(String login_empid) {
		List<Map<String, String>> allEmployeeList = dao.allEmployeeList(login_empid);
		return allEmployeeList;
	}*/

	// 현재 근무중인 사원이 있는 모든 부서 가져오기
	@Override
	public List<DeptVO> allDeptList() {
		List<DeptVO> allDeptList = dao.allDeptList();
		return allDeptList;
	}
	
	// 해당 부서에 근무중인 사원 정보 가져오기
	@Override
	public List<Map<String, String>> deptEmpList(Map<String, String> paraMap) {
		List<Map<String, String>> deptEmpList = dao.deptEmpList(paraMap);
		return deptEmpList;
	}
	
	// 첨부파일이 없는 게시판 글쓰기
	@Override
	public int noFile_doc(Map<String, Object> paraMap) {
		
		int n1 = dao.noFile_newdoc(paraMap);
		int n2 = dao.noFile_minutes(paraMap);
		int n3 = 0;
		
		int lineNumber =(Integer) paraMap.get("lineNumber");
		
		for(int i=1; i<lineNumber+1; i++) {
			String level_no_key = "level_no_" + i;
			String level_no_value = (String) paraMap.get(level_no_key);
			
			paraMap.put("level_no", i);
			paraMap.put("empId", level_no_value);			
			
			n3 = dao.noFile_approval(paraMap);
			if(n3 != 1) {
				n3=0;
				break;
			}
		}
		
		int result = n1*n2*n3;
		return result;
	}
	
	// 첨부파일이 있을 때 첨부파일 insert하기
	@Override
	public int withFile_doc(Map<String, String> docFileMap) {
		int n = dao.withFile_doc(docFileMap);
		return n;
	}


		
	// doc_no와 approval_noSeq의 시퀀스 채번해오기
	@Override
	public Map<String, String> getDocSeq() {
		String doc_noSeq = dao.getDoc_noSeq();
		String approval_noSeq = dao.getApproval_noSeq();
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("doc_noSeq", doc_noSeq);
		paraMap.put("approval_noSeq", approval_noSeq);
		
		return paraMap;
	}

	// 서류 목록 가져오기
/*	@Override
	public List<Map<String, String>> myDocList(String loginEmpId) {
		List<Map<String, String>> myDocList = dao.myDocList(loginEmpId);
		return myDocList;
	}*/
	
	// 메인화면에 보여줄 기안문서 목록 가져오기
	@Override
	public List<DocVO> docListNoSearch(String loginEmpId) {
		List<DocVO> docListNoSearch = dao.docListNoSearch(loginEmpId);
	/*	List<Map<String, String>> myApprovalDoc = dao.myApprovalDoc(loginEmpId);
		
		List<Map<String, String>> resultList = new ArrayList<>();
	    resultList.addAll(myDocList);
	    resultList.addAll(myApprovalDoc);
	  */
		
		return docListNoSearch;
	}

	// 결재 할 문서의 정보 가져오기
	@Override
	public List<Map<String, String>> myapprovalinfo(String loginEmpId) {
		List<Map<String, String>> myapprovalinfo = dao.myapprovalinfo(loginEmpId);
		
		return myapprovalinfo;
	}

	// 나의 모든 기안문서 가져오기
	@Override
	public List<Map<String, String>> myDocListSearch(Map<String, String> paraMap) {
		List<Map<String, String>> myDocListSearch = dao.myDocListSearch(paraMap);
		return myDocListSearch;
	}

	// 나의 기안 문서에서 총 페이지 수 가져오기
	@Override
	public int getTotalMyDocCount(Map<String, String> paraMap) {
		int n = dao.getTotalMyDocCount(paraMap);
		return n;
	}
	
	// 나의 기안 문서에서 문서 한 개 보기
	@Override
	public DocVO getOneDocCommon(Map<String, String> paraMap) {
		DocVO getViewOneMyDoc = dao.getOneDocCommon(paraMap);
		return getViewOneMyDoc;
	}

	// 기안종류코드 100:연차신청서 101:회의록 102:야간근무신청
	@Override
	public MinutesVO getOneMinutes(Map<String, String> paraMap) {
		MinutesVO getOneMinutes = dao.getOneMinutes(paraMap);
		return getOneMinutes;
	}





		

	
	/*
	 * // 각 부서별 당 인원수 가져오기
	 * 
	 * @Override public List<Map<String, String>> numByDept() { List<Map<String,
	 * String>> numByDept = dao.numByDept(); return numByDept; }
	 */

}
