package com.spring.app.approval.model;

import java.util.List;
import java.util.Map;

import com.spring.app.domain.DeptVO;
import com.spring.app.domain.DocVO;
import com.spring.app.domain.MinutesVO;

public interface ApprovalDAO {

	// 새로운 기안 서류 작성 시 작성자의 부서 이름 가져오기
	String getDeptNumber(Map<String, String> paraMap);

	// 결재 라인에서 찾을 모든 사원 목록 보기
	List<Map<String, String>> allEmployeeList(String login_empid);
	/*
	 * // 각 부서별 당 인원수 가져오기 List<Map<String, String>> numByDept();
	 */

	// 현재 근무중인 사원이 있는 모든 부서 가져오기
	List<DeptVO> allDeptList();

	// 해당 부서에 근무중인 사원 정보 가져오기
	List<Map<String, String>> deptEmpList(Map<String, String> paraMap);

	// doc_no의 시퀀스 채번해오기
	String getDoc_noSeq();

	// approval_noSeq 시퀀스 채번해오기
	String getApproval_noSeq();
	
	// 첨부파일이 없는 서류 작성하기(tbl_doc)
	int noFile_newdoc(Map<String, Object> paraMap);

	// 첨부파일이 없는 서류 작성하기(tbl_minutes)
	int noFile_minutes(Map<String, Object> paraMap);

	// 첨부파일이 없는 서류 작성하기(tbl_approval)
	int noFile_approval(Map<String, Object> paraMap);

	// 첨부파일이 있을 때 첨부파일 insert하기
	int withFile_doc(Map<String, String> docFileMap);

	// 메인화면에 보여줄 내가 작성한 기안문서 목록 가져오기
	List<DocVO> docListNoSearch(String loginEmpId);

	// 메인화면에 보여줄 
//	List<Map<String, String>> myApprovalDoc(String loginEmpId);

	// 결재 할 문서의 정보 가져오기
	List<Map<String, String>> myapprovalinfo(String loginEmpId);

	// 나의 모든 기안문서 가져오기
	List<Map<String, String>> myDocListSearch(Map<String, String> paraMap);

	// 나의 기안 문서에서 총 페이지 수 가져오기
	int getTotalMyDocCount(Map<String, String> paraMap);

	// 나의 기안 문서에서 문서 한 개 보기
	DocVO getOneDocCommon(Map<String, String> paraMap);

	// 기안종류코드 100:연차신청서 101:회의록 102:야간근무신청
	MinutesVO getOneMinutes(Map<String, String> paraMap);

}
