package com.spring.app.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.app.common.AES256;
import com.spring.app.member.model.MemberDAO;

@Service
public class MemberService_imple implements MemberService {

	@Autowired
	private MemberDAO mdao;
	
	@Autowired
    private AES256 aES256;
	
}
