package com.spring.app.approval.service;

import java.util.List;
import java.util.Map;

import com.spring.app.domain.ApprovalVO;
import com.spring.app.domain.DeptVO;
import com.spring.app.domain.DocVO;
import com.spring.app.domain.DocfileVO;
import com.spring.app.domain.MemberVO;
import com.spring.app.domain.MinutesVO;

public interface ApprovalService {

	// 새로운 기안 서류 작성 시 작성자의 부서 이름 가져오기
	String getDeptNumber(Map<String, String> paraMap);

	// 현재 근무중인 사원이 있는 모든 부서 가져오기
	List<DeptVO> allDeptList();
	
	// 해당 부서에 근무중인 사원 정보 가져오기
	List<Map<String, String>> deptEmpList(Map<String, String> paraMap);

	// 첨부파일이 없는 기안 작성하기
	int noFile_doc(Map<String, Object> paraMap);

	// doc_no와 approval_noSeq의 시퀀스 채번해오기
	Map<String, String> getDocSeq();

	// 첨부파일이 있을 때 첨부파일 insert하기
	int withFile_doc(Map<String, String> docFileMap);

	// 해당 서류 가져오기
//	List<Map<String, String>> myDocList(String loginEmpId);

	// 메인화면에 보여줄 기안문서 목록 가져오기
	List<DocVO> docListNoSearch(String loginEmpId);

	// 결재 할 문서의 정보 가져오기
	List<Map<String, String>> myapprovalinfo(String loginEmpId);

	// 나의 기안 문서에서 총 페이지 수 가져오기
	int getTotalMyDocCount(Map<String, String> paraMap);
	
	// 나의 결재 문서에서 총 페이지수 가져오기
	int getTotalMyApprovalCount(Map<String, String> paraMap);

	// 나의 모든 기안문서 가져오기
	List<Map<String, String>> myDocListSearch(Map<String, String> paraMap);
	
	// 나의 모든 결재 대기 문서 가져오기
	List<Map<String, String>> myNowApprovalListSearch(Map<String, String> paraMap);

	// 나의 기안 문서에서 문서 한 개 보기
	DocVO getOneDoc(Map<String, String> paraMap);
	
	// 첨부 파일 목록 가져오기
	List<DocfileVO> getDocfiletList(String doc_no);

	// 첨부 파일 다운로드
	DocfileVO getDocfileOne(String fileNo);







	


}
