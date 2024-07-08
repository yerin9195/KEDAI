package com.spring.app.board.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.board.service.BoardService;
import com.spring.app.common.FileManager;

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
	
	// 게시판 글 등록하기
	
	
}
