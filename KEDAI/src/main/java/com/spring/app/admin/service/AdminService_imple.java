package com.spring.app.admin.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.app.admin.model.AdminDAO;

@Service
public class AdminService_imple implements AdminService {

	@Autowired
	private AdminDAO dao;
	
}
