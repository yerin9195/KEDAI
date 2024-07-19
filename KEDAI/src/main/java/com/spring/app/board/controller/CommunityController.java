package com.spring.app.board.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.board.service.CommunityService;
import com.spring.app.common.FileManager;
import com.spring.app.domain.CommunityCategoryVO;
import com.spring.app.domain.CommunityVO;

@Controller
public class CommunityController {

	@Autowired
	private CommunityService service;
	
	@Autowired
	private FileManager fileManager;
	
	// 커뮤니티 글 등록하는 페이지 이동
	@GetMapping("/community/add.kedai")
	public ModelAndView add(ModelAndView mav) {
		
		List<CommunityCategoryVO> categoryList = service.category_select();
	
		mav.addObject("categoryList", categoryList);
		
		mav.setViewName("tiles1/community/add.tiles");	
		
		return mav;
	}
	
	// 커뮤니티 글 등록하기
	@ResponseBody
	@PostMapping(value="/community/add.kedai", produces="text/plain;charset=UTF-8")
	public String add(MultipartHttpServletRequest mrequest) {
		
		String category_name = mrequest.getParameter("category_name");
		String fk_category_code = "";
		
		if(category_name.equals("동호회")) {
			fk_category_code = "1";
		}
		else if(category_name.equals("건의함")) {
			fk_category_code = "2";
		}
		else if(category_name.equals("사내소식")) {
			fk_category_code = "3";
		}
		
		List<MultipartFile> fileList = mrequest.getFiles("file_arr");
		
		// WAS 의 webapp 의 절대경로 알아오기
		HttpSession session = mrequest.getSession();
		String root = session.getServletContext().getRealPath("/");
		String path = root+"resources"+File.separator+"attach_file";
		
		File dir = new File(path);
		
		if(!dir.exists()) { // 폴더가 없는 경우
			dir.mkdirs(); // 서브 폴더 만들기
		}
		
		String[] arr_attachFilename = null; // 첨부파일명들을 기록하기 위한 용도
		
		if(fileList != null && fileList.size() > 0) {
			arr_attachFilename = new String[fileList.size()];
			
			for(int i=0; i<fileList.size(); i++) {
				MultipartFile mtfile = fileList.get(i);
				
				try {
					File attachFile = new File(path+File.separator+mtfile.getOriginalFilename());
					mtfile.transferTo(attachFile); // 파일을 업로드해주는 것이다. 
					
					arr_attachFilename[i] = mtfile.getOriginalFilename(); // 배열 속에 첨부파일명들을 기록한다.
				} catch (Exception e) {
					e.printStackTrace();
				}
				
			} // end of for ----------
			
		} // end of if ----------
		
		
		
		JSONObject jsonObj = new JSONObject();
		Map<String, Object> paraMap = new HashMap<>();
		
		if(fileList != null && fileList.size() > 0) {
			
			
			paraMap.put("arr_attachFilename", arr_attachFilename); 
		}
		
		try {
			
			jsonObj.put("result", 1); // 성공된 경우
		} catch (Exception e) {
			e.printStackTrace();
			jsonObj.put("result", 0); // 실패된 경우
		}
		
		
		return jsonObj.toString();
	}
	
	// 게시판 목록 보여주기
	@GetMapping("/community/list.kedai")
	public ModelAndView list(ModelAndView mav, HttpServletRequest request) {
		
		mav.setViewName("tiles1/community/list.tiles");
		
		return mav;
	}
}
