package com.spring.app.board.controller;

import java.io.File;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.board.service.BoardService;
import com.spring.app.common.FileManager;
import com.spring.app.common.MyUtil;
import com.spring.app.domain.BoardVO;
import com.spring.app.domain.CategoryVO;
import com.spring.app.domain.MemberVO;

@Controller
public class BoardController {
	
	@Autowired
	private BoardService service;
	
	@Autowired
	private FileManager fileManager;
	
	// 게시판 글 등록하기 페이지 이동
	@RequestMapping("/board/add.kedai")
	public ModelAndView add(ModelAndView mav, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		if(loginuser != null && "Admin".equals(loginuser.getNickname())) {
			List<CategoryVO> categoryList = service.category_select();
			
			mav.addObject("categoryList", categoryList);
			
			mav.setViewName("tiles1/board/add.tiles");
		}
		
		return mav;
	}
	
	// 게시판 글 등록하기
	@PostMapping("/board/addEnd.kedai")
	public ModelAndView pointPlus_addEnd(Map<String, String> paraMap, ModelAndView mav, BoardVO bvo, MultipartHttpServletRequest mrequest) {
	
		MultipartFile attach = bvo.getAttach();
		
		if(attach != null) { // 첨부파일이 있는 경우
			
			// WAS 의 webapp 의 절대경로 알아오기
			HttpSession session = mrequest.getSession();
			String root = session.getServletContext().getRealPath("/"); 
			// C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\KEDAI\
			
			String path = root+"resources"+File.separator+"files";
			// C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\KEDAI\resources\files
			
			// 파일첨부를 위한 변수의 설정 및 값을 초기화 한 후 파일 올리기
			String newFileName = ""; // WAS(톰캣)의 디스크에 저장될 파일명
			byte[] bytes = null;     // 첨부파일의 내용물을 담는 것
			long fileSize = 0;       // 첨부파일의 크기
			
			try {
				bytes = attach.getBytes(); 
				
				String originalFilename = attach.getOriginalFilename(); // 첨부파일명의 파일명
				
				newFileName = fileManager.doFileUpload(bytes, originalFilename, path); // 첨부되어진 파일을 업로드
				
				bvo.setFilename(newFileName);
				bvo.setOrgfilename(originalFilename);
				
				fileSize = attach.getSize(); // 첨부파일의 크기(단위는 byte 이다.)

				bvo.setFilesize(String.valueOf(fileSize));
			} catch (Exception e) {
				e.printStackTrace(); 
			}
		}
		
		String category_name = mrequest.getParameter("category_name");
		String fk_category_code = "";
		
		if(category_name.equals("사내공지")) {
			fk_category_code = "1";
		}
		else if(category_name.equals("팝업일정")) {
			fk_category_code = "2";
		}
		else if(category_name.equals("식단표")) {
			fk_category_code = "3";
		}
		
		bvo.setFk_category_code(fk_category_code);
		
		int n = 0;
		
		if(attach.isEmpty()) { // 파일첨부가 없는 경우
			n = service.add(bvo);
		}
		else { // 파일첨부가 있는 경우
			n = service.add_withFile(bvo);
		}
		
		if(n == 1) {
			mav.setViewName("redirect:/board/list.kedai");
		}
		else {
			String message = "게시판 글 등록이 실패하였습니다.\\n다시 시도해주세요.";
			String loc = "javascript:history.back()";
           
			mav.addObject("message", message);
			mav.addObject("loc", loc);
           
			mav.setViewName("msg"); 
		}
		
		paraMap.put("empid", bvo.getFk_empid());
		paraMap.put("point", "100");
		
		return mav;
	}
	
	// 스마트에디터 => 드래그앤드롭을 이용한 다중 사진 파일 업로드
	@PostMapping("/image/multiplePhotoUpload.kedai")
	public void multiplePhotoUpload(HttpServletRequest request, HttpServletResponse response) {
		
		// WAS 의 webapp 의 절대경로 알아오기
		HttpSession session = request.getSession();
		String root = session.getServletContext().getRealPath("/"); 
		// C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\KEDAI\
		
		String path = root+"resources"+File.separator+"photo_upload";
		// C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\KEDAI\resources\photo_upload
		
		File dir = new File(path);
		
		if(!dir.exists()) { // 폴더가 없는 경우
			dir.mkdirs(); // 서브 폴더 만들기
		}
		
		try {
			String filename = request.getHeader("file-name");
			// 네이버 스마트에디터를 사용한 파일업로드 시 멀티파일업로드는 파일명이 header 속에 담겨져 넘어오게 되어있다. 
			
			InputStream is = request.getInputStream(); 
			// is 는 네이버 스마트 에디터를 사용하여 사진첨부하기 된 이미지 파일이다.
			
			String newFilename = fileManager.doFileUpload(is, filename, path);
			
			String ctxPath = request.getContextPath(); //  /KEDAI
			
			String strURL = "";
			strURL += "&bNewLine=true&sFileName="+newFilename; 
			strURL += "&sFileURL="+ctxPath+"/resources/photo_upload/"+newFilename;
			
			// 웹브라우저 상에 사진 이미지를 쓰기
			PrintWriter out = response.getWriter();
			out.print(strURL);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	// 게시판 목록 보여주기
	@GetMapping("/board/list.kedai")
	public ModelAndView list(ModelAndView mav, HttpServletRequest request) {
		
		List<BoardVO> boardList = null;
		
		// 글조회수(readCount)증가 => 새로고침(F5)을 했을 경우에는 증가가 되지 않도록 해야 한다. => session 을 사용하여 처리하기
		HttpSession session = request.getSession();
		session.setAttribute("readCountPermission", "yes");
		
		// 페이징 처리를 한 검색어가 있는 전체 글목록 보여주기
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		String str_currentShowPageNo = request.getParameter("currentShowPageNo");
		
		if(searchType == null) {
			searchType = "";
		}
		
		if(searchWord == null) {
			searchWord = "";
		}
		
		if(searchWord != null) {
			searchWord = searchWord.trim();
		}
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
		
		int totalCount = 0;        // 총 게시물 건수
		int sizePerPage = 10; 	   // 한 페이지 당 보여줄 게시물 건수
		int currentShowPageNo = 0; // 현재 보여주는 페이지 번호, 초기값는 1페이지로 설정 
		int totalPage = 0; 		   // 총 페이지수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)
		
		// 총 게시물 건수(totalCount)
		totalCount = service.getTotalCount(paraMap);
		
		totalPage = (int)Math.ceil((double)totalCount/sizePerPage);
		// (double)124/10 => 12.4 ==> Math.ceil(12.4) => 13.0 ==> (int)13.0 ==> 13
		
		if(str_currentShowPageNo == null) {
			currentShowPageNo = 1; // 게시판에 보여지는 초기화면
		}
		else {
			try {
				currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
				
				if(currentShowPageNo < 1 || currentShowPageNo > totalPage) { // "GET" 방식이므로 0 또는 음수나 실제 데이터베이스에 존재하는 페이지수 보다 더 큰값을 입력하여 장난친 경우
					currentShowPageNo = 1;
				}
			} catch (Exception e) { // "GET" 방식이므로 숫자가 아닌 문자를 입력하여 장난친 경우
				currentShowPageNo = 1;
			}
		}
		
		// 가져올 게시글의 범위 => 공식 적용하기
		int startRno = ((currentShowPageNo - 1) * sizePerPage) + 1; // 시작 행번호 
        int endRno = startRno + sizePerPage - 1; // 끝 행번호
        
        paraMap.put("startRno", String.valueOf(startRno));
        paraMap.put("endRno", String.valueOf(endRno));
        
        boardList = service.boardListSearch_withPaging(paraMap);
        
        mav.addObject("boardList", boardList);
        
        // 검색 시 검색조건 및 검색어 값 유지시키기	
        if("subject".equals(searchType) ||
           "content".equals(searchType) ||
           "subject_content".equals(searchType) ||
           "name".equals(searchType)) {
        	mav.addObject("paraMap", paraMap);
        }
        
        // 페이지바 만들기
        int blockSize = 5; // 1개 블럭(토막)당 보여지는 페이지번호의 개수
        int loop = 1;      // 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수[지금은 5개(== blockSize)] 까지만 증가하는 용도
        int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1; 
        // 공식 
        // 첫번째 블럭의 페이지번호 시작값(pageNo)은    1 => ((1-1)/5)*5+1  => 1
        // 두번째 블럭의 페이지번호 시작값(pageNo)은    6 => ((6-1)/5)*5+1  => 6
        // 세번째 블럭의 페이지번호 시작값(pageNo)은  11 => ((11-1)/5)*5+1 => 11
        
        String pageBar = "<ul style='list-style: none;'>";
        String url = "board/list.kedai";
        
        // [맨처음][이전] 만들기 
        if(pageNo != 1) { // 맨처음 페이지일 때는 보이지 않도록 한다.
        	pageBar += "<li style='display: inline-block; width: 70px; font-size: 12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo=1'>[처음]</a></li>";
        	pageBar += "<li style='display: inline-block; width: 70px; font-size: 12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
        }
        
        while(!(loop > blockSize || pageNo > totalPage)) {
        	
        	if(pageNo == currentShowPageNo) {
        		pageBar += "<li style='display: inline-block; width: 30px; height: 30px; align-content: center; font-size: 12pt; border-radius: 50%; background: #e68c0e'>"+pageNo+"</li>";
        	}
        	else {
        		pageBar += "<li style='display: inline-block; width: 30px; font-size: 12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
        	}
        	
        	loop++;
        	pageNo++;
        } // end of while() ----------
        
        // [다음][마지막] 만들기
        if(pageNo <= totalPage) { // 맨마지막 페이지일 때는 보이지 않도록 한다.
        	pageBar += "<li style='display: inline-block; width: 70px; font-size: 12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
        	pageBar += "<li style='display: inline-block; width: 70px; font-size: 12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+totalPage+"'>[마지막]</a></li>";
        }
        
        pageBar += "</ul>";
        
        mav.addObject("pageBar", pageBar);
        
        // 특정 글제목을 클릭하여 상세내용을 본 이후 사용자가 "검색된결과목록보기" 버튼을 클릭했을 때 돌아갈 페이지를 알려주기 위해 현재 페이지 주소를 뷰단으로 넘겨준다.
        String goBackURL = MyUtil.getCurrentURL(request);
        mav.addObject("goBackURL", goBackURL);
        
        // 페이징처리 시 순번을 나타내기 위한 것
        mav.addObject("totalCount", totalCount);
        mav.addObject("currentShowPageNo", currentShowPageNo);
        mav.addObject("sizePerPage", sizePerPage);
		
		mav.setViewName("tiles1/board/list.tiles");
		
		return mav;
	}
	
	
	
}
