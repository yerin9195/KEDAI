package com.spring.app.board.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.board.service.CommunityService;
import com.spring.app.common.FileManager;
import com.spring.app.domain.CommunityCategoryVO;

@Controller
public class CommunityController {

	@Autowired
	private CommunityService service;
	
	@Autowired
	private FileManager fileManager;
	
	// 커뮤니티 글 등록하는 페이지 이동
	@GetMapping("/community/add.kedai")
	public ModelAndView add(ModelAndView mav, HttpServletRequest request) {
		
		List<CommunityCategoryVO> categoryList = service.category_select();
		
		mav.addObject("categoryList", categoryList);
		
		mav.setViewName("tiles1/community/add.tiles");	
		
		return mav;
	}
	
	// 게시판 목록 보여주기
	@GetMapping("/community/list.kedai")
	public ModelAndView list(ModelAndView mav, HttpServletRequest request) {
		
		mav.setViewName("tiles1/community/list.tiles");
		
		return mav;
	}
}
