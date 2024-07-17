package com.spring.app.board.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.spring.app.board.service.CommunityService;
import com.spring.app.common.FileManager;

@Controller
public class CommunityController {

	@Autowired
	private CommunityService service;
	
	@Autowired
	private FileManager fileManager;
}
