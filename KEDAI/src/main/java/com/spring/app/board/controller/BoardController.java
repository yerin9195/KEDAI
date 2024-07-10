package com.spring.app.board.controller;

import java.io.File;
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
import com.spring.app.domain.BoardVO;
import com.spring.app.domain.CategoryVO;
import com.spring.app.domain.MemberVO;

@Controller
public class BoardController {
	
	@Autowired
	private BoardService service;
	
	@Autowired
	private FileManager fileManager;
	
	// 게시판 목록 보여주기
	@GetMapping("/board/list.kedai")
	public ModelAndView list(ModelAndView mav, HttpServletRequest request) {
		
		mav.setViewName("tiles1/board/list.tiles");
		
		return mav;
	}
	
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
		
		
	
		
	}
	
}
