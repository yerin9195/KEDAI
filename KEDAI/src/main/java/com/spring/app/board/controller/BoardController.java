package com.spring.app.board.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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
@RequestMapping(value = "/board/*")
public class BoardController {
	
	@Autowired
	private BoardService service;
	
	@Autowired
	private FileManager fileManager;
	
	// 게시판 목록 보여주기
	@GetMapping("list.kedai")
	public ModelAndView list(ModelAndView mav, HttpServletRequest request) {
		
		mav.setViewName("tiles1/board/list.tiles");
		
		return mav;
	}
	
	// 게시판 글 등록하기 페이지 이동
	@RequestMapping("add.kedai")
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
	@PostMapping("addEnd.kedai")
	public ModelAndView pointPlus_addEnd(Map<String, String> paraMap, ModelAndView mav, BoardVO bvo, MultipartHttpServletRequest mrequest) {
	
		MultipartFile attach = bvo.getAttach();
		
		if(attach != null) { // 첨부파일이 있는 경우
			
		}
		
		return mav;
	}
}
