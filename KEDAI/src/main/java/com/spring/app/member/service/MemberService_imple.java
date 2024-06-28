package com.spring.app.member.service;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.common.AES256;
import com.spring.app.domain.MemberVO;
import com.spring.app.member.model.MemberDAO;

@Service
public class MemberService_imple implements MemberService {

	@Autowired
	private MemberDAO dao;
	
	@Autowired
    private AES256 aES256;

	@Override
	public MemberVO getLoginMember(Map<String, String> paraMap) {
		MemberVO loginuser = dao.getLoginMember(paraMap);
		
		if(loginuser != null && loginuser.getPwdchangegap() >= 3) { // 마지막으로 암호를 변경한 날짜가 현재시각으로 부터 3개월이 지난 경우 
			loginuser.setRequirePwdChange(true); 
		}
		
		if(loginuser != null) {
			try {
				String email = aES256.decrypt(loginuser.getEmail());   // 복호화해서 넘겨준다.
				String mobile = aES256.decrypt(loginuser.getMobile()); // 복호화해서 넘겨준다.
				
				loginuser.setEmail(email);   // 복호화되어진 email 을 넣어준다.
				loginuser.setMobile(mobile); // 복호화되어진 mobile 을 넣어준다.
			} catch (UnsupportedEncodingException | GeneralSecurityException e) {
				e.printStackTrace();
			} 
			
			dao.insert_tbl_loginhistory(paraMap); // paraMap 에는 로그인하고자하는 id 와 ip 주소가 담겨져 있다. 
		}
		
		return loginuser;
	}
	
}
