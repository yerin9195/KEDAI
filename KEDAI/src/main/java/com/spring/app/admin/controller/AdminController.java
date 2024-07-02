package com.spring.app.admin.controller;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.admin.service.AdminService;
import com.spring.app.common.AES256;
import com.spring.app.common.Sha256;
import com.spring.app.domain.DeptVO;
import com.spring.app.domain.JobVO;
import com.spring.app.domain.MemberVO;

@Controller 
public class AdminController {

	@Autowired
	private AdminService service;
	
	@Autowired
	private AES256 aES256;

	// 부서&직급 목록 조회하기
	@RequestMapping("/admin/register.kedai")
	public ModelAndView dept_job_select(ModelAndView mav, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		if(loginuser != null && "admin".equals(loginuser.getNickname())) {
			List<DeptVO> deptList = service.dept_select();
			List<JobVO> jobList = service.job_select();
			
			mav.addObject("deptList", deptList); 
			mav.addObject("jobList", jobList); 
		
			mav.setViewName("tiles1/admin/register.tiles");
		}
		
		return mav;
	}
	
	// 아이디중복확인
	@ResponseBody
	@PostMapping(value="/idDuplicateCheck.kedai", produces="text/plain;charset=UTF-8")
	public String idDuplicateCheck(HttpServletRequest request) {
		
		String empid = request.getParameter("empid");
		
		String searchId = service.idDuplicateCheck(empid);
		
		boolean isExists = false;
		
		if(searchId != null) {
			isExists = true;
		}
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("isExists", isExists);
		
		return jsonObj.toString();
	}
	
	// 이메일중복확인
	@ResponseBody
	@PostMapping(value="/emailDuplicateCheck.kedai", produces="text/plain;charset=UTF-8")
	public String emailDuplicateCheck(HttpServletRequest request) {
		
		String email = request.getParameter("email");
		
		try {
			email = aES256.encrypt(email);
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}
		
		String searchEmail = service.emailDuplicateCheck(email);
		
		boolean isExists = false;
		
		if(searchEmail != null) {
			isExists = true;
		}
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("isExists", isExists);
		
		return jsonObj.toString();
	}
	
	// 사원정보 등록하기
	@PostMapping("/admin/empRegister.kedai")
	public ModelAndView empRegister(ModelAndView mav, MultipartHttpServletRequest mrequest, MemberVO mvo) {

		String jubun1 = mrequest.getParameter("jubun1");
		String jubun2 = mrequest.getParameter("jubun2");
		String jubun = jubun1 + jubun2;
		
		String hp1 = mrequest.getParameter("hp1");
		String hp2 = mrequest.getParameter("hp2");
		String hp3 = mrequest.getParameter("hp3");
		String mobile = hp1 + hp2 + hp3;
		
		String dept_name = mrequest.getParameter("dept_name");	
		String dept_tel = "";
		String fk_dept_code = "";

		if(dept_name.equals("인사부")) {
			fk_dept_code = "100";
			dept_tel = "070-1234-100";
		}
		else if(dept_name.equals("영업지원부")) {
			fk_dept_code = "200";
			dept_tel = "070-1234-200";
		}
		else if(dept_name.equals("회계부")) {
			fk_dept_code = "300";
			dept_tel = "070-1234-300";
		}
		else if(dept_name.equals("상품개발부")) {
			fk_dept_code = "400";
			dept_tel = "070-1234-400";
		}
		else if(dept_name.equals("마케팅부")) {
			fk_dept_code = "500";
			dept_tel = "070-1234-500";
		}
		else if(dept_name.equals("해외사업부")) {
			fk_dept_code = "600";
			dept_tel = "070-1234-600";
		}
		else if(dept_name.equals("해외사업부")) {
			fk_dept_code = "700";
			dept_tel = "070-1234-700";
		} 
		else  {
			fk_dept_code = "";
			dept_tel = "";
		}
	
		String job_name = mrequest.getParameter("job_name");
		String fk_job_code = "";
		
		if(job_name.equals("부장")) {
			fk_job_code = "1";
		}
		else if(job_name.equals("과장")) {
			fk_job_code = "2";
		}
		else if(job_name.equals("차장")) {
			fk_job_code = "3";
		}
		else if(job_name.equals("대리")) {
			fk_job_code = "4";
		}
		else if(job_name.equals("주임")) {
			fk_job_code = "5";
		}
		else if(job_name.equals("사원")) {
			fk_job_code = "6";
		}
		else {
			fk_job_code = "";
		}
		
		mvo = new MemberVO();
	//	mvo.setImgfilename(imgfilename);
		mvo.setEmpid(mrequest.getParameter("empid"));
		mvo.setPwd(Sha256.encrypt(mrequest.getParameter("pwd")));
		mvo.setName(mrequest.getParameter("name"));
		mvo.setNickname(mrequest.getParameter("nickname"));
		mvo.setJubun(jubun);
		try {
			mvo.setEmail(aES256.encrypt(mrequest.getParameter("email")));
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}
		try {
			mvo.setMobile(aES256.encrypt(mobile));
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}
		mvo.setPostcode(mrequest.getParameter("postcode"));
		mvo.setAddress(mrequest.getParameter("address"));
		mvo.setDetailaddress(mrequest.getParameter("detailaddress"));
		mvo.setExtraaddress(mrequest.getParameter("extraaddress"));
		mvo.setHire_date(mrequest.getParameter("hire_date"));
		mvo.setSalary(mrequest.getParameter("salary"));
		mvo.setFk_dept_code(fk_dept_code);
		mvo.setFk_job_code(fk_job_code);
		mvo.setDept_tel(dept_tel);
		
		try {
			int n = service.empRegister(mvo);
			
			if(n == 1) {
				String message = "사원정보가 정상적으로 등록되었습니다.";
				String loc = mrequest.getContextPath()+"/index.kedai";
	           
				mav.addObject("message", message);
				mav.addObject("loc", loc);
	           
				mav.setViewName("msg"); 
			}
			
		} catch (Exception e) {
			String message = "사원정보 등록이 실패하였습니다.\\n다시 시도해주세요.";
			String loc = "javascript:history.back()";
           
			mav.addObject("message", message);
			mav.addObject("loc", loc);
           
			mav.setViewName("msg"); 
		}

		return mav;
	}
	
	
	
	

}
