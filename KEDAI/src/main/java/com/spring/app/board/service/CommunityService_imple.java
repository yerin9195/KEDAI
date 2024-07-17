package com.spring.app.board.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.app.board.model.CommunityDAO;
import com.spring.app.common.FileManager;

@Service
public class CommunityService_imple implements CommunityService {

	@Autowired
	private CommunityDAO dao;
	
	@Autowired
	private FileManager fileManager;
}
