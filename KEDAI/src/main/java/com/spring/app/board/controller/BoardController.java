package com.spring.app.board.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

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
	
	// 게시판 글 등록하는 페이지 이동
	@GetMapping("/board/add.kedai")
	public ModelAndView requiredLogin_add(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		// 답변 글쓰기가 추가된 경우
		String subject = "[답변] " + request.getParameter("subject");
		String groupno = request.getParameter("groupno");
		String fk_seq = request.getParameter("fk_seq");
		String depthno = request.getParameter("depthno");
		
		if(fk_seq == null) { // 원글은 groupno, fk_seq, depthno 모두 null 이다.
			fk_seq = "";
		}
		
		mav.addObject("subject", subject);
		mav.addObject("groupno", groupno);
		mav.addObject("fk_seq", fk_seq);
		mav.addObject("depthno", depthno);
		
		List<CategoryVO> categoryList = service.category_select();
		
		mav.addObject("categoryList", categoryList);
		
		mav.setViewName("tiles1/board/add.tiles");
		
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
			
			String path = root+"resources"+File.separator+"files"+File.separator+"board_attach_file";
			// C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\KEDAI\resources\files\board_attach_file
			
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
			mav.setViewName("tiles1/error.tiles"); 
		}
		
		paraMap.put("empid", bvo.getFk_empid());
		paraMap.put("point", "100");
		
		return mav;
	}
	
	// 스마트에디터 => 드래그앤드롭을 이용한 다중 사진 파일 업로드
	@RequestMapping("/image/multiplePhotoUpload.kedai")
	public void multiplePhotoUpload(HttpServletRequest request, HttpServletResponse response) {
		
		// WAS 의 webapp 의 절대경로 알아오기
		HttpSession session = request.getSession();
		String root = session.getServletContext().getRealPath("/"); 
		// C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\KEDAI\
		
		String path = root+"resources"+File.separator+"files"+File.separator+"photo_upload";
		// C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\KEDAI\resources\files\photo_upload
		
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
			strURL += "&sFileURL="+ctxPath+"/resources/files/photo_upload/"+newFilename;
			
			// 웹브라우저 상에 사진 이미지를 쓰기
			PrintWriter out = response.getWriter();
			out.print(strURL);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	// 게시판 목록 보여주기
	@GetMapping("/board/list.kedai")
	public ModelAndView empmanager_list(HttpServletRequest request, ModelAndView mav) {
		
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
			} catch (NumberFormatException e) { // "GET" 방식이므로 숫자가 아닌 문자를 입력하여 장난친 경우
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
        String url = "list.kedai";
        
        // [맨처음][이전] 만들기 
        if(pageNo != 1) { // 맨처음 페이지일 때는 보이지 않도록 한다.
        	pageBar += "<li style='display: inline-block; width: 70px; font-size: 12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo=1' style='color: #2c4459;'>[처음]</a></li>";
        	pageBar += "<li style='display: inline-block; width: 70px; font-size: 12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+(pageNo-1)+"' style='color: #2c4459;'>[이전]</a></li>";
        }
        
        while(!(loop > blockSize || pageNo > totalPage)) {
        	
        	if(pageNo == currentShowPageNo) {
        		pageBar += "<li style='display: inline-block; width: 30px; height: 30px; align-content: center; color: #fff; font-size: 12pt; border-radius: 50%; background: #e68c0e'>"+pageNo+"</li>";
        	}
        	else {
        		pageBar += "<li style='display: inline-block; width: 30px; font-size: 12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"' style='color: #2c4459;'>"+pageNo+"</a></li>";
        	}
        	
        	loop++;
        	pageNo++;
        } // end of while() ----------
        
        // [다음][마지막] 만들기
        if(pageNo <= totalPage) { // 맨마지막 페이지일 때는 보이지 않도록 한다.
        	pageBar += "<li style='display: inline-block; width: 70px; font-size: 12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"' style='color: #2c4459;'>[다음]</a></li>";
        	pageBar += "<li style='display: inline-block; width: 70px; font-size: 12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+totalPage+"' style='color: #2c4459;'>[마지막]</a></li>";
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
	
	// 검색어 입력 시 자동글 완성하기
	@ResponseBody
	@GetMapping(value="/board/wordSearchShow.kedai", produces="text/plain;charset=UTF-8")
	public String wordSearchShow(HttpServletRequest request) {
		
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
		
		List<String> wordList = service.wordSearchShow(paraMap);
		
		JSONArray jsonArr = new JSONArray(); // []
		
		if(wordList != null) {
			for(String word : wordList) {
				JSONObject jsonObj = new JSONObject();
				
				jsonObj.put("word", word);
				
				jsonArr.put(jsonObj); // [{}, {}, {}]
			} // end of for ----------
		}
		
		return jsonArr.toString();
	}
	
	// 글 1개를 보여주는 페이지 요청
	@RequestMapping("/board/view.kedai")
	public ModelAndView view(ModelAndView mav, HttpServletRequest request) {
		
		String board_seq = "";
		String goBackURL = "";
		String searchType = "";
		String searchWord = "";
		
		// redirect 되어서 넘어온 데이터가 있는지 꺼내어 와본다. => /board/view_2.kedai 에서 보내주었다.
		Map<String, ?> inputFlashMap = RequestContextUtils.getInputFlashMap(request);
		
		if(inputFlashMap != null) {  // redirect 되어서 넘어온 데이터가 있는 경우
			@SuppressWarnings("unchecked")
			Map<String, String> redirect_map = (Map<String, String>)inputFlashMap.get("redirect_map");
			// "redirect_map" 값은  /board/view_2.kedai 에서  redirectAttr.addFlashAttribute("키", 밸류값); 을 할 때 준 "키" 이다. 
		
			board_seq = redirect_map.get("board_seq");
			
			// 이전글제목, 다음글제목 보기
			searchType = redirect_map.get("searchType");
			try { 
				// sendredirect 되어서 넘어온 데이터를 한글로 복구한 후 mapper 로 넘겨줘야 한다.
				searchWord = URLDecoder.decode(redirect_map.get("searchWord"), "UTF-8");
				goBackURL = URLDecoder.decode(redirect_map.get("goBackURL"), "UTF-8");
						
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			
		}
		else { // redirect 되어서 넘어온 데이터가 아닌 경우 => sendRedirect 하지않고 직접 넘어온 경우
			board_seq = request.getParameter("board_seq"); // 조회하고자 하는 글번호 받아오기
			goBackURL = request.getParameter("goBackURL"); // 특정글을 조회한 후 "검색된결과목록보기" 버튼을 클릭했을 때 돌아갈 페이지를 만들기 위한 것
			
			// 글목록에서 검색되어진 글내용일 경우 이전글제목, 다음글제목은 검색되어진 결과물 내의 이전글과 다음글이 나오도록 하기 위한 것
			searchType = request.getParameter("searchType");
			searchWord = request.getParameter("searchWord");
			
			if(searchType == null) { // 검색조건이 없는 경우 원복한다.
				searchType = "";
			}
			
			if(searchWord == null) { // 검색어가 없는 경우 원복한다.
				searchWord = "";
			}
			
		}
		
		mav.addObject("goBackURL", goBackURL);
		
		try {
			Integer.parseInt(board_seq);
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
			
			String login_empid = "";
			if(loginuser != null) {
				login_empid = loginuser.getEmpid();
			}
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("board_seq", board_seq);
			paraMap.put("login_empid", login_empid);
					
			// 글목록에서 검색되어진 글내용일 경우 이전글제목, 다음글제목은 검색되어진 결과물 내의 이전글과 다음글이 나오도록 하기 위한 것
			paraMap.put("searchType", searchType);
			paraMap.put("searchWord", searchWord);
			
			// 웹브라우저에서 페이지 새로고침(F5)을 했을 때 select(글 1개 조회)만 해주고 DML문(글 조회수 증가인 update문)은 실행되지 않도록 하기
			BoardVO bvo = null;
			
			if("yes".equals((String)session.getAttribute("readCountPermission"))) { // 글목록보기인 /board/list.kedai 페이지를 클릭한 다음에 특정글을 조회해온 경우
				bvo = service.getView(paraMap); // 글 조회수 증가와 함께 글 1개를 조회해오는 것
				
				session.removeAttribute("readCountPermission"); // session 에 저장된 readCountPermission 을 삭제
			}
			else { // 글목록에서 특정 글제목을 클릭하여 본 상태에서 웹브라우저에서 새로고침(F5)을 클릭한 경우
				bvo = service.getView_noIncrease_readCount(paraMap); // 글 조회수 증가는 없고 단순히  글 1개만 조회해오는 것
			
				if(bvo == null) {
					mav.setViewName("redirect:/board/list.kedai");
					return mav;
				}
			}
			
			mav.addObject("bvo", bvo);
			mav.addObject("paraMap", paraMap); // 이전글제목, 다음글제목 보기
			
			mav.setViewName("tiles1/board/view.tiles");
			
		} catch (NumberFormatException e) {
			mav.setViewName("redirect:/board/list.kedai");
		}
		
		return mav;
	}
	
	// view.jsp 에서  "POST" 방식으로 보내준 것
	@PostMapping("/board/view_2.kedai")
	public ModelAndView view_2(ModelAndView mav, HttpServletRequest request, RedirectAttributes redirectAttr) {
	
		// 조회하고자하는 글번호
		String board_seq = request.getParameter("board_seq"); 
		
		// 이전글제목, 다음글제목 보기
		String goBackURL = request.getParameter("goBackURL");
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		
		// 보내야할 데이터에 한글이 포함되는 경우
		try {
			searchWord = URLEncoder.encode(searchWord, "UTF-8");
			goBackURL = URLEncoder.encode(goBackURL, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		HttpSession session = request.getSession();
		session.setAttribute("readCountPermission", "yes");
		
		// redirect(GET 방식) 시
		// 데이터를 넘길때 GET 방식이 아닌 POST 방식'처럼'(POST 방식이 아닌) 데이터를 넘기려면 RedirectAttributes 를 사용
		Map<String, String> redirect_map = new HashMap<>();
		redirect_map.put("board_seq", board_seq);
		redirect_map.put("goBackURL", goBackURL);
		redirect_map.put("searchType", searchType);
		redirect_map.put("searchWord", searchWord);
		
		redirectAttr.addFlashAttribute("redirect_map", redirect_map);
		// .addFlashAttribute() 는 오로지 1개의 데이터만 담을 수 있으므로 여러개의 데이터를 담으려면 Map 사용
		// 키값을 "redirect_map" 으로 담아서 "redirect:/board/view.kedai" 으로 보내는 것
		
		mav.setViewName("redirect:/board/view.kedai");
		
		return mav;
	}
	
	// 게시판 글 수정하는 페이지 이동
	@GetMapping("/board/edit.kedai")
	public ModelAndView requiredLogin_edit(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		// 수정하고자하는 글번호
		String board_seq = request.getParameter("board_seq");
		String message = "";
		
		try {
			Integer.parseInt(board_seq);
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("board_seq", board_seq);
			
			BoardVO bvo = service.getView_noIncrease_readCount(paraMap); // 글 조회수 증가는 없고 단순히  글 1개만 조회해오는 것
			
			if(bvo == null) {
				message = "글 수정이 불가합니다.";
			}
			else {
				HttpSession session = request.getSession();
				MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
				
				if(!loginuser.getEmpid().equals(bvo.getFk_empid())){ // 로그인한 사용자와 작성자가 다른 경우(다른 사람의 글을 수정하려고 하는 경우)
					message = "다른 사용자의 글은 수정이 불가합니다.";
				}
				else { // 자신의 글을 수정하려고 하는 경우
					List<CategoryVO> categoryList = service.category_select();
					
					mav.addObject("categoryList", categoryList);
					mav.addObject("bvo", bvo);
					
					mav.setViewName("tiles1/board/edit.tiles"); 
					
					return mav;
				}
			}
			
		} catch (NumberFormatException e) { // "GET" 방식으로 문자를 입력한 경우
			message = "글 수정이 불가합니다.";
		}
		
		String loc = "javascript:history.back()"; // 이전 페이지로 이동
		
		mav.addObject("message", message);
		mav.addObject("loc", loc);
		
		mav.setViewName("msg"); 
		
		return mav;
	}
	
	// 게시판 글 수정하기
	@PostMapping("/board/editEnd.kedai")
	public ModelAndView editEnd(ModelAndView mav, BoardVO bvo, MultipartHttpServletRequest mrequest) {
		
		MultipartFile attach = bvo.getAttach();
		
		if(attach != null) { // 첨부파일이 있는 경우
			
			// WAS 의 webapp 의 절대경로 알아오기
			HttpSession session = mrequest.getSession();
			String root = session.getServletContext().getRealPath("/"); 
			// C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\KEDAI\
			
			String path = root+"resources"+File.separator+"files"+File.separator+"board_attach_file";
			// C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\KEDAI\resources\files\board_attach_file
			
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
			n = service.edit(bvo);
		}
		else { // 파일첨부가 있는 경우
			n = service.edit_withFile(bvo);
		}
		
		if(n == 1) {
			mav.addObject("message", "게시판 글 수정이 성공되었습니다.");
			mav.addObject("loc", mrequest.getContextPath()+"/board/view.kedai?board_seq="+bvo.getBoard_seq()); // 수정되어진 글 1개를 보여주는 페이지로 이동
		
			mav.setViewName("msg");
		}
	
		return mav;
	}
	
	// 게시판 글 삭제하는 페이지 이동
	@GetMapping("/board/del.kedai")
	public ModelAndView requiredLogin_del(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		// 삭제하고자하는 글번호
		String board_seq = request.getParameter("board_seq");
		String message = "";
		
		try {
			Integer.parseInt(board_seq);
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("board_seq", board_seq);
			
			BoardVO bvo = service.getView_noIncrease_readCount(paraMap); // 글 조회수 증가는 없고 단순히  글 1개만 조회해오는 것
			
			if(bvo == null) {
				message = "글 삭제가 불가합니다.";
			}
			else {
				HttpSession session = request.getSession();
				MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
				
				if(!loginuser.getEmpid().equals(bvo.getFk_empid())){ // 로그인한 사용자와 작성자가 다른 경우(다른 사람의 글을 삭제하려고 하는 경우)
					message = "다른 사용자의 글은 삭제가 불가합니다.";
				}
				else { // 자신의 글을 삭제하려고 하는 경우
					mav.addObject("bvo", bvo);
					
					mav.setViewName("tiles1/board/del.tiles"); 
					
					return mav;
				}
			}
			
		} catch (NumberFormatException e) { // "GET" 방식으로 문자를 입력한 경우
			message = "글 삭제가 불가합니다.";
		}
		
		String loc = "javascript:history.back()"; // 이전 페이지로 이동
		
		mav.addObject("message", message);
		mav.addObject("loc", loc);
		
		mav.setViewName("msg"); 
		
		return mav;
	}
	
	// 게시판 글 삭제하기
	@PostMapping("/board/delEnd.kedai")
	public ModelAndView delEnd(ModelAndView mav, HttpServletRequest request) {
		
		// 삭제하고자하는 글번호
		String board_seq = request.getParameter("board_seq");
		
		// 파일첨부가 된 글이라면 글 삭제 시 먼저 첨부파일을 삭제해주어야 한다.
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("board_seq", board_seq);
		paraMap.put("searchType", "");
		paraMap.put("searchWord", "");
		
		BoardVO bvo = service.getView_noIncrease_readCount(paraMap); // 글 조회수 증가는 없고 단순히  글 1개만 조회해오는 것
		
		String fileName = bvo.getFilename();
		if(fileName != null && !"".equals(fileName)) { // 첨부파일이 있는 경우
			// WAS 의 webapp 의 절대경로 알아오기
			HttpSession session = request.getSession();
			String root = session.getServletContext().getRealPath("/"); 
			// C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\KEDAI\
			
			String path = root+"resources"+File.separator+"files"+File.separator+"board_attach_file";;
			// C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\KEDAI\resources\files\board_attach_file
		
			paraMap.put("path", path);
			paraMap.put("fileName", fileName);
		}
		
		int n = service.del(paraMap);
		
		if(n == 1) {
			mav.addObject("message", "게시판 글 삭제가 성공되었습니다.");
			mav.addObject("loc", request.getContextPath()+"/board/list.kedai"); // 글목록을 보여주는 페이지로 이동
		
			mav.setViewName("msg");
		}
		
		return mav;
	}
	
	// 첨부파일 다운로드 받기
	@GetMapping("/board/download.kedai")
	public void requiredLogin_download(HttpServletRequest request, HttpServletResponse response) {
	
		// 첨부파일이 있는 글번호
		String board_seq = request.getParameter("board_seq");
	
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("board_seq", board_seq);
		paraMap.put("searchType", "");
		paraMap.put("searchWord", "");
		
		// html 이 출력될 때 한글이 깨지지 않고 제대로 나올 수 있도록 설정하기
		response.setContentType("text/html; charset=UTF-8");
		
		PrintWriter out = null; // out 은 웹브라우저에 기술하는 대상체
		
		try {
			Integer.parseInt(board_seq);
			BoardVO bvo = service.getView_noIncrease_readCount(paraMap); // 글 조회수 증가는 없고 단순히  글 1개만 조회해오는 것
			
			if(bvo == null || (bvo != null && bvo.getFilename() == null)) { // DB 에서 파일을 삭제한 경우
				out = response.getWriter();
				out.println("<script type='text/javascript'>alert('존재하지 않는 글번호 이거나 첨부파일이 없으므로 파일다운로드가 불가합니다.'); history.back();</script>");
				return;
			}
			else { // 정상적으로 파일을 다운로드를 할 경우 
				String fileName = bvo.getFilename();
				String orgFilename = bvo.getOrgfilename();
				
				// WAS 의 webapp 의 절대경로 알아오기
				HttpSession session = request.getSession();
				String root = session.getServletContext().getRealPath("/"); 
				// C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\KEDAI\
				
				String path = root+"resources"+File.separator+"files"+File.separator+"board_attach_file";
				// C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\KEDAI\resources\files\board_attach_file
			
				boolean flag = false;
				flag = fileManager.doFileDownload(fileName, orgFilename, path, response);
				// file 다운로드 성공시 flag 는 true, 실패시 flag 는 false
				
				if(!flag) {
					out = response.getWriter();
					out.println("<script type='text/javascript'>alert('파일다운로드가 실패하였습니다.'); history.back();</script>");
				}
			
			}
			
		} catch (NumberFormatException | IOException e) { // 숫자가 아닌 경우 => "GET" 방식으로 조작한 경우
			try {
				out = response.getWriter();
				out.println("<script type='text/javascript'>alert('파일다운로드가 불가합니다.'); history.back();</script>");
			} catch (IOException e2) {
				e.printStackTrace();
			}
		}
	
	}
	
}
