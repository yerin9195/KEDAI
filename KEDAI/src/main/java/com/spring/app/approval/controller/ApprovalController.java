package com.spring.app.approval.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.approval.service.ApprovalService;
import com.spring.app.common.FileManager;
import com.spring.app.domain.DeptVO;
import com.spring.app.domain.DocVO;
import com.spring.app.domain.MemberVO;


@Controller 
//@RequestMapping(value="/approval/*") // 이렇게 하면 @GetMapping("/approval/newdoc.kedai")에서 /approval를 빼도 됨. /approval 가 붙는 효과가 있음.
public class ApprovalController {
	
	@Autowired  // Type에 따라 알아서 Bean 을 주입해준다.
	private ApprovalService service;
	
	@Autowired
	private FileManager fileManager;
	
	@GetMapping(value = "/approval/main.kedai")
	public ModelAndView approval(ModelAndView mav, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		String loginEmpId = loginuser.getEmpid();
		
		List<Map<String, String>> myapprovalinfo = service.myapprovalinfo(loginEmpId);
		System.out.println("확인용 myapprovalinfo" + myapprovalinfo);
		
		List<Map<String, String>> nowApproval = new ArrayList<>(); // 내가 지금 승인할 문서
		List<Map<String, String>> laterApproval = new ArrayList<>(); // 내가 나중에 승인할 문서
		for(Map<String, String> map : myapprovalinfo){
			if("1".equals(map.get("pre_status")) && "0".equals(map.get("doc_status"))) { //이전 레벨의 담당자가 승인하고, 반려되지 않은 기안서만  map에 담기
				nowApproval.add(map);
	        }
			else if((map.get("pre_status") == null)) {
				nowApproval.add(map);
			}
			
			else if("0".equals(map.get("pre_status")) && "0".equals(map.get("doc_status")) ) {//이전 레벨의 담당자가 승인하지 않고,반려되지 않은 기안서만  map에 담기(나중에 결재할문서)
				laterApproval.add(map);
			}
	    }
		
		System.out.println("확인용 nowApproval" + nowApproval);
		
		List<Map<String, String>> docList = service.docListNoSearch(loginEmpId);
		System.out.println("확인용 docList" + docList);
		
		List<Map<String, String>> myDocList = new ArrayList<>(); // 내가 작성한 기안서
		for(Map<String, String> map : docList){
			if(loginEmpId.equals(map.get("fk_empid"))) {
				myDocList.add(map);
	        }
	    }
		
		System.out.println(myDocList);
		System.out.println("확인용 laterApproval" + laterApproval);
		
		
		mav.addObject("nowApproval", nowApproval);
		mav.addObject("laterApproval", laterApproval);
		mav.addObject("myDocList", myDocList);

		
		mav.setViewName("tiles1/approval/main.tiles");
		// /WEB-INF/views/tiles/tiles1/content/approval/main.jsp
	//	/WEB-INF/views/tiles/tiles1/content/approval/main.tiles.jsp 페이지를 만들어야 한다.
		
		return mav;
	}
	
	@GetMapping(value = "/approval/newdoc.kedai")
	public ModelAndView newDoc(ModelAndView mav, HttpServletRequest request ) {
		
		String doctype_code = request.getParameter("doctype_code");

		Map<String, String> paraMap = new HashMap<>();
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		paraMap.put("dept_code", loginuser.getFk_dept_code());
		
		Date now = new Date(); // 현재시각
		SimpleDateFormat sdfmt = new SimpleDateFormat("yyyy-MM-dd");
		String str_now = sdfmt.format(now); // "2024-07-04"
		String dept_name = service.getDeptNumber(paraMap); // DB에서 부서번호 구해오기
		mav.addObject("str_now", str_now);
		mav.addObject("dept_name", dept_name);
		
		List<DeptVO> allDeptList = service.allDeptList();
		
		
		
		/*
		 * List<Map<String, String>> numByDept = service.numByDept(); // 각 부서별 당 인원수
		 * 가져오기
		 */		
	//	mav.addObject("allEmployeeList", allEmployeeList);
		mav.addObject("allDeptList", allDeptList);
		
		
		if(doctype_code.equals("100")) {
			mav.setViewName("tiles1/approval/newdayoff.tiles");
		}
		else if(doctype_code.equals("101")){
			
			mav.setViewName("tiles1/approval/newmeeting.tiles");
		}
			
		//	/WEB-INF/views/tiles/tiles1/content/approval/newdoc.jsp 페이지를 만들어야 한다.
		
		return mav;
	}
	
	@ResponseBody
	@PostMapping(value="/approval/newdoc.kedai", produces="text/plain;charset=UTF-8")
	public String newDoc(MultipartHttpServletRequest mtp_request, DocVO docvo) {
		
		List<MultipartFile> fileList = mtp_request.getFiles("file_arr"); // getFile는 단수 개, getFiles는 List로 반환
		// "file_arr" 은 /board/src/main/webapp/WEB-INF/views/tiles1/email/emailWrite.jsp 페이지의 314 라인에 보여지는 formData.append("file_arr", item); 의 값이다.
		// !!주의 !!복수개의 파일은 mtp_request.getFile이 아니라 mtp_request.getFiles이다.
		
		
		// MultipartFile interface는 Spring에서 업로드된 파일을 다룰 때 사용되는 인터페이스로 파일의 이름과 실제 데이터, 파일 크기 등을 구할 수 있다.
	       
	    /*
	         >>>> 첨부파일이 업로드 되어질 특정 경로(폴더)지정해주기
	                    우리는 WAS 의 webapp/resources/doc_attach_file 라는 폴더로 지정해준다.
	    */
	    // WAS 의 webapp 의 절대경로를 알아와야 한다.
		
		HttpSession session = mtp_request.getSession();
	    String root = session.getServletContext().getRealPath("/");
	    String path = root + "resources"+File.separator+"doc_attach_file";
	    // path 가 첨부파일들을 저장할 WAS(톰캣)의 폴더가 된다.
	      
	    //  System.out.println("~~~~ 확인용 path => " + path);
	    //~~~~ 확인용 path => C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp1\wtpwebapps\board\resources\doc_attach_file
	    // resources에 들어가면 doc_attach_file폴더가 아직 생성되지 않았다. 아래와 같이 생성해준다.
	    
	    File dir = new File(path); // 
	    if(!dir.exists()) {
	    	dir.mkdirs();
	    }
	    
	  //C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp1\wtpwebapps\board\resources\doc_attach_file 라는 폴더가 생성 되었는지 확인해준다.
		
		 // >>>> 첨부파일을 위의 path 경로에 올리기 <<<< //
		String[] arr_attachFilename = null; // 첨부파일명들을 기록하기 위한 용도
		String[] arr_attachFileSize = null;
		
		if(fileList != null && fileList.size() > 0){ // 파일 첨부가 있는 경우라면
			arr_attachFilename = new String[fileList.size()];
			arr_attachFileSize = new String[fileList.size()];	
			
		    for(int i=0; i<fileList.size(); i++) {
		    	MultipartFile mtfile = fileList.get(i);
		    	String fileName = mtfile.getOriginalFilename();
		    //	System.out.println("파일명 : " + mtfile.getOriginalFilename() + " / 파일크기 : " + mtfile.getSize());
		    		/*
		    		 파일명 : berkelekle심플라운드01.jpg / 파일크기 : 71317
					파일명 : Electrolux냉장고_사용설명서.pdf / 파일크기 : 791567
					파일명 : 쉐보레전면.jpg / 파일크기 : 131110
					*/
		    	// 서버에 저장할 새로운 파일명을 만든다.
                // 서버에 저장할 새로운 파일명이 동일한 파일명이 되지 않고 고유한 파일명이 되도록 하기 위해
                // 현재의 년월일시분초에다가 현재 나노세컨즈nanoseconds 값을 결합하여 확장자를 붙여서 만든다.
    			String newFilename = fileName.substring(0, fileName.lastIndexOf(".")); // 확장자를 뺀 파일명 알아오기
    			
    			newFilename += "_" + String.format("%1$tY%1$tm%1$td%1$tH%1$tM%1$tS", Calendar.getInstance());
    			newFilename += System.nanoTime();
    			newFilename += fileName.substring(fileName.lastIndexOf(".")); // 확장자 붙이기
    			
    			
		    	try {
		    			/*
		                   	File 클래스는 java.io 패키지에 포함되며, 입출력에 필요한 파일이나 디렉터리를 제어하는 데 사용된다.
		                    	파일과 디렉터리의 접근 권한, 생성된 시간, 경로 등의 정보를 얻을 수 있는 메소드가 있으며, 
		                    	새로운 파일 및 디렉터리 생성, 삭제 등 다양한 조작 메서드를 가지고 있다.
		               */		    		
		    		
		    			// === MultipartFile 을 File 로 변환하여 탐색기 저장폴더에 저장하기 시작 ===
		    		File attachFile = new File(path + File.separator + newFilename);
			    	mtfile.transferTo(attachFile); // // !!!!! 이것이 파일을 업로드해주는 것이다. !!!!!!
			    		/*
		                  form 태그로 부터 전송받은 MultipartFile mtfile 파일을 지정된 대상 파일(attachFile)로 전송한다.
		                                           만약에 대상 파일(attachFile)이 이미 존재하는 경우 먼저 삭제된다.
		               */
		               // 탐색기에서 C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp1\wtpwebapps\board\resources\doc_attach_file 폴더에 가보면
		               // 첨부한 파일이 생성되어져 있음을 확인할 수 있다.
			    		
			    //	arr_attachFilename[i] = mtfile.getOriginalFilename(); // 배열 속에 첨부파일명 들을 기록한다.
			    	arr_attachFilename[i] = newFilename; // 배열 속에 첨부파일명 들을 기록한다.
			    	
			    	arr_attachFileSize[i] = Long.toString(mtfile.getSize());
			    		
			    		
			    		// === MultipartFile 을 File 로 변환하여 탐색기 저장폴더에 저장하기 끝 ===
		    	} catch(Exception e) {
		    		e.printStackTrace();
		    	}
		    		
		    }// end of for---------------------
		}
		
		// === 첨부 이미지 파일을 저장했으니 그 다음으로 doc정보들을 테이블에 insert 해주어야 한다.  ===
		Map<String, String> docSeq = new HashMap<>();
		docSeq = service.getDocSeq();// seq들을 채번해 오는 함수
		
		Calendar currentDate = Calendar.getInstance();		// 현재날짜와 시간을 얻어온다.

		int year = currentDate.get(Calendar.YEAR);
		String year_new = String.valueOf(year).substring(2);
		String fk_doc_no = "KD" +year_new +"-"+ mtp_request.getParameter("fk_doctype_code") + "-" + docSeq.get("doc_noSeq");
		
		docvo.setDoc_no(fk_doc_no); 
		
		Map<String, Object> paraMap = new HashMap<>();
		paraMap.put("docvo", docvo); 
		//기안 종류 코드, 기안자 사원 아이디, 기안문서 제목, 기안문서내용, 서류 작성일자
		
		int lineNumber = Integer.parseInt(mtp_request.getParameter("lineNumber"));
		
		paraMap.put("fk_doc_no", fk_doc_no);
		paraMap.put("meeting_date", mtp_request.getParameter("meeting_date"));
		paraMap.put("attendees", mtp_request.getParameter("attendees"));
		paraMap.put("host_dept", mtp_request.getParameter("host_dept"));
		
		paraMap.put("approval_no", docSeq.get("approval_noSeq"));
		paraMap.put("lineNumber", lineNumber);
		
		int n1 = 0;
		int n2 = 0;
		
		for(int i=1; i<lineNumber+1; i++) {
			String level_no_key = "level_no_" + i; // 예: "level_no_1", "level_no_2", ...
			paraMap.put(level_no_key, mtp_request.getParameter(level_no_key));
		}
		/*
		paraMap.put("empId1", mtp_request.getParameter("level_no_1"));
		paraMap.put("empId2", mtp_request.getParameter("level_no_2"));
		paraMap.put("empId3", mtp_request.getParameter("level_no_3"));
		 	*/
		
		n1 = service.noFile_doc(paraMap); // 서류 작성 insert 하기
	/*	
		if(n1>0) {
			System.out.println("Document inserted successfully for empId: " + paraMap.get("empId"));
		}else {
	        // 삽입 실패 처리
	        System.out.println("Failed to insert document for empId: " + paraMap.get("empId"));
	    }
		*/
		

		int cnt = 0;
		if(n1 ==1 && fileList != null && fileList.size() > 0) {
			Map<String, String> docFileMap = new HashMap<>();
			
			docFileMap.put("fk_doc_no", fk_doc_no);
			
			for(int i=0; i<fileList.size(); i++) {
				docFileMap.put("doc_filename", arr_attachFilename[i]);
				docFileMap.put("doc_filesize", arr_attachFileSize[i]);
				docFileMap.put("doc_org_filename", arr_attachFilename[i].substring(0, arr_attachFilename[i].lastIndexOf("_")));
			
				int attach_insert_result = service.withFile_doc(docFileMap);
				
				System.out.println("~~!확인용 : "+ arr_attachFilename[i].substring(0, arr_attachFilename[i].lastIndexOf("_")));

				if(attach_insert_result == 1) {
        			cnt++;
        		}
			} // end of for----------------
			
			if(cnt == fileList.size()) {
				n2 = 1;
        	}
		}// end of if(n1 ==1 && fileList != null && fileList.size() > 0)-----------------------
		JSONObject jsonObj = new JSONObject();
		
		if(fileList != null && fileList.size() > 0) {
			jsonObj.put("result", n1*n2);
		}
		else {
			jsonObj.put("result", n1);
		}        
        return jsonObj.toString(); 
	}

	
	
	@GetMapping(value="/approval/newDocEnd.kedai")
	public String newDocEnd(ModelAndView mav, HttpServletRequest request ) {
		
		
		
		System.out.println(request.getParameter("meeting_date"));
		
		System.out.println();
	      
		return "tiles1/approval/newDocEnd.tiles";
	    //  /WEB-INF/views/tiles1/email/emailWrite_done.jsp 페이지를 만들어야 한다.
	}

	
	
	@GetMapping(value="/approval/newDocTest.kedai")
	public String newDocTest() {
	    
		//List<Map<String, String>> mapList = dao.get();
		
		
		
		
		return "tiles1/approval/newDocTest.tiles";
	    //  /WEB-INF/views/tiles1/email/emailWrite_done.jsp 페이지를 만들어야 한다.
	}
	
	
	
	 /*
    @ResponseBody 란?
	  메소드에 @ResponseBody Annotation이 되어 있으면 return 되는 값은 View 단 페이지를 통해서 출력되는 것이 아니라 
	 return 되어지는 값 그 자체를 웹브라우저에 바로 직접 쓰여지게 하는 것이다. 일반적으로 JSON 값을 Return 할때 많이 사용된다.
	 
	  >>> 스프링에서 json 또는 gson을 사용한 ajax 구현시 데이터를 화면에 출력해 줄때 한글로 된 데이터가 '?'로 출력되어 한글이 깨지는 현상이 있다. 
               이것을 해결하는 방법은 @RequestMapping 어노테이션의 속성 중 produces="text/plain;charset=UTF-8" 를 사용하면 
               응답 페이지에 대한 UTF-8 인코딩이 가능하여 한글 깨짐을 방지 할 수 있다. <<< 
  */ 
	@ResponseBody
	@PostMapping(value="/approval/deptEmpListJSON.kedai",  produces="text/plain;charset=UTF-8")
	public String deptEmpListJSON(HttpServletRequest request ){
				// @RequestParam은 request.getParameter()와 같은 것이다. defaultValue는 파라미터의 초기값을 설정해 줄 수 있는 것을 말한다. 위의 내용은 null대신 ""을 설정한 것이다. 
				//  form태그의 name값을 꼭 String 이름 이런 식으로 넣어주어야 한다.
		
		String dept_code = request.getParameter("dept_code");
		String loginuser_id = request.getParameter("loginuser_id");
		
		Map<String,String> paraMap = new HashMap<>();
		paraMap.put("dept_code", dept_code);
		paraMap.put("loginuser_id", loginuser_id);
		
		// 본인을 제외한 모든 사원의 정보 가져오기 - 부서번호가 없는 대표이사가 있기 때문에 dept_code도 같이 paraMap에 담는다.
		List<Map<String,String>> deptEmpList = service.deptEmpList(paraMap);
		
		JSONArray jsonArr = new JSONArray();
		if(deptEmpList != null) {
			for(Map<String,String> map : deptEmpList) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("empid", map.get("empid"));
				jsonObj.put("name", map.get("name"));
				jsonObj.put("fk_dept_code", map.get("fk_dept_code"));
				jsonObj.put("dept_name", map.get("dept_name"));
				jsonObj.put("job_code", map.get("job_code"));
				jsonObj.put("job_name", map.get("job_name"));

				jsonArr.put(jsonObj);
			}// end of for---------------
			
		//	System.out.println(jsonArr.toString());
			
		}
		
		return jsonArr.toString();
		
	}
	
	
	@RequestMapping("approval/nowApprovalList.kedai")
	public ModelAndView nowApprovalList(ModelAndView mav, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		mav.addObject("loginuser", loginuser); // 모델에 loginuser 객체 추가
		mav.setViewName("tiles1/approval/nowApprval.tiles");
		
		return mav;
	}
	
	@RequestMapping("approval/showMyDocList.kedai")
	public ModelAndView showMyDocList(ModelAndView mav, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		String loginEmpId = loginuser.getEmpid();
		
		List<Map<String, String>> myAllDocList = null;
		
		//=== #122.페이징 처리를 한 검색어가 있는 전체 글목록 보여주기 == //
		
		/*  페이징 처리를 통한 글목록 보여주기는 
        
        	예를 들어 3페이지의 내용을 보고자 한다라면 
        	검색을 할 경우는 아래와 같이
 		list.action?searchType=subject&searchWord=안녕&currentShowPageNo=3 와 같이 해주어야 한다.
 
        	또는
 
        	검색이 없는 전체를 볼때는 아래와 같이 
		list.action 또는 
		list.action?searchType=&searchWord=&currentShowPageNo=3 또는 
		list.action?searchType=subject&searchWord=&currentShowPageNo=3 또는
		list.action?searchType=name&searchWord=&currentShowPageNo=3 와 같이 해주어야 한다.
		*/
		String searchType = request.getParameter("searchType"); // myDoclist.jsp의 form 태그 내의 name이 searchType가 넘어 온다. 
		String searchWord = request.getParameter("searchWord"); // myDoclist.jsp의 form 태그 내의 name이 searchType가 넘어 온다. 
		String str_currentShowPageNo = request.getParameter("currentShowPageNo");
		
		// System.out.println("~~ 확인용 str_currentShowPageNo : " + str_currentShowPageNo);
	    // ~~ 확인용 str_currentShowPageNo : null 
	    // ~~ 확인용 str_currentShowPageNo : 3
	    // ~~ 확인용 str_currentShowPageNo : dsfsdfdsfdsfㄴㄹㄴㅇㄹㄴ
	    // ~~ 확인용 str_currentShowPageNo : -3412
	    // ~~ 확인용 str_currentShowPageNo : 0
	    // ~~ 확인용 str_currentShowPageNo : 32546
	    // ~~ 확인용 str_currentShowPageNo : 35325234534623463454354534
		
		if(searchType == null) {
			searchType = "";
		}
		if(searchWord == null) {
			searchWord = "";
		}
		if(searchWord != null) {
			searchWord = searchWord.trim();
			// "		연습	" ==> "연습"
			// "		 	" ==> ""
		}
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);

		// 먼저, 총 게시물 건수(totalCount)를 구해와야 한다.
		// 총 게시물 건수(totalCount)는 검색조건이 있을 때와 없을 때로 나뉘어진다.
		
		int totalCount = 0;        // 총 게시물 건수
		int sizePerPage = 10;      // 한 페이지당 보여줄 게시물 건수 
		int currentShowPageNo = 0; // 현재 보여주는 페이지 번호로서, 초기치로는 1페이지로 설정함. 
		int totalPage = 0;         // 총 페이지수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바) 
		
		//총 게시물 건수(totalCount)
		totalCount = service.getTotalMyDocCount(paraMap);
		//System.out.println("~~확인용totalCount "+totalCount);
		//~~확인용totalCount 14
		// 글 제목에 검색어 입력하고 검색 했을 때 
		//~~확인용totalCount 5
		//~~확인용totalCount 2
		//~~확인용totalCount 3
		
		// 만약에 총 게시물 건수(totalCount)가 124 개 이라면 총 페이지수(totalPage)는 13 페이지가 되어야 한다.
        // 만약에 총 게시물 건수(totalCount)가 120 개 이라면 총 페이지수(totalPage)는 12 페이지가 되어야 한다.
		
		totalPage = (int) Math.ceil((double)totalCount/sizePerPage);  // 하나를 더블로 바꿔주면 소수점으로 값이 나옴.
		// (double)124/10 ==> 12.4 ==> Math.ceil(12.4) ==> 13.0 ==> (int)13.0 ==> 13
		// (double)120/10 ==> 12.0 ==> Math.ceil(12.0) ==> 12.0 ==> (int)12.0 ==> 12
		// Math.ceil을 이용해 1을 올려준다. 왜? 12.4가 나오면 13페이지 수가 나와야 하기 때문이다.
		
		
		if(str_currentShowPageNo == null) { // 게시판에 보여지는 초기화면
			currentShowPageNo = 1;
		}
		else {
			try {
				currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
				if(currentShowPageNo < 1 || currentShowPageNo > totalPage) {
					// 다른 사람이 장난 쳐 왔을 때(1보다 작고 토탈 페이지보다 클 때)
					currentShowPageNo = 1; 
					// get 방식이므로 사용자가 str_currentShowPageNo 에 입력한 값이 0 또는 음수를 입력하여 장난친 경우 
	                // get 방식이므로 사용자가 str_currentShowPageNo 에 입력한 값이 실제 데이터베이스에 존재하는 페이지수 보다 더 큰값을 입력하여 장난친 경우
				}
			}catch(NumberFormatException e) {
				// get 방식이므로 사용자가 str_currentShowPageNo 에 입력한 값이 숫자가 아닌 문자를 입력하여 장난친 경우
				currentShowPageNo = 1; 
			}
		}
		// **** 가져올 게시글의 범위를 구한다.(공식임!!!) **** 
         /*
              currentShowPageNo      startRno     endRno
             --------------------------------------------
                  1 page        ===>    1           10
                  2 page        ===>    11          20
                  3 page        ===>    21          30
                  4 page        ===>    31          40
                  ......                ...         ...
          */
		int startRno = ((currentShowPageNo - 1) * sizePerPage) + 1; // 시작 행번호 
        int endRno = startRno + sizePerPage - 1; // 끝 행번호
        
        paraMap.put("startRno", String.valueOf(startRno));
        paraMap.put("endRno", String.valueOf(endRno));
				
		
		
		
		myAllDocList = service.myDocListSearch(loginEmpId);
		
		mav.addObject("loginuser", loginuser); // 모델에 loginuser 객체 추가		
		mav.setViewName("tiles1/approval/myDocList.tiles");
		
		return mav;
	}
	
 //  	<definition name="*/*/*/*.tiles" extends="layout-tiles">
//  	<put-attribute name="content" value="/WEB-INF/views/tiles/{1}/content/{2}/{3}/{4}.jsp"/>
//	</definition>

//mav.setViewName("tiles1/approval/newDocEnd.tiles");
	//	return mav;
	

	
	
}
