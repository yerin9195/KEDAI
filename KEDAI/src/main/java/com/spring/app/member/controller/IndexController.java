package com.spring.app.member.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.domain.BoardVO;
import com.spring.app.member.service.IndexService;

@Controller 
public class IndexController {

	@Autowired
	private IndexService service;
	
	// 사원수 조회하기
	@ResponseBody
	@GetMapping(value="/index/memberTotalCountJSON.kedai", produces="text/plain;charset=UTF-8")
	public String memberTotalCountJSON(HttpServletRequest request) {
		
		int totalCount = service.memberTotalCountJSON();
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("totalCount", totalCount*100);
		
		return jsonObj.toString();
	}
	
	// 게시글수 조회하기
	@ResponseBody
	@GetMapping(value="/index/boardTotalCountJSON.kedai", produces="text/plain;charset=UTF-8")
	public String boardTotalCountJSON(HttpServletRequest request) {
		
		int totalCount = service.boardTotalCountJSON();
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("totalCount", totalCount*10);
		
		return jsonObj.toString();
	}
	
	// 메뉴 검색하기
	@GetMapping("/index/menuFind.kedai")
	public ModelAndView menuFind(HttpServletRequest request, ModelAndView mav) {
		
		String searchWord = request.getParameter("searchWord");
		
		if(searchWord.equals("전자결재")) {
			mav.setViewName("redirect:/approval/main.kedai");
		}
		else if(searchWord.equals("급여명세서")) {
			mav.setViewName("redirect:/pay_stub.kedai");
		}
		else if(searchWord.equals("회의실예약")) {
			mav.setViewName("redirect:/roomResercation.kedai");
		}
		else if(searchWord.equals("게시판")) {
			mav.setViewName("redirect:/board/list.kedai");
		}
		else if(searchWord.equals("커뮤니티")) {
			mav.setViewName("redirect:/community/list.kedai");
		}
		else if(searchWord.equals("카쉐어")) {
			mav.setViewName("redirect:/carShare.kedai");
		}
		else if(searchWord.equals("통근버스")) {
			mav.setViewName("redirect:/bus.kedai");
		}
		else if(searchWord.equals("사내연락망")) {
			mav.setViewName("redirect:/employee.kedai");
		}
		else if(searchWord.equals("거래처정보")) {
			mav.setViewName("redirect:/othercom_list.kedai");
		}
		else if(searchWord.equals("일정관리")) {
			mav.setViewName("redirect:");
		}
	
		return mav;
	}
	
	// 기상청 공공데이터(오픈데이터)를 가져와서 날씨 정보 보여주기
	@GetMapping("/weather/weatherXML.kedai")
	public String weatherXML() {
		
		return "weather/weatherXML";
	}
	
	// 기상청 공공데이터(오픈데이터)를 가져와서 날씨 정보 차트 그리기
	@ResponseBody
	@PostMapping(value="/weather/weatherXMLtoJSON.kedai", produces="text/plain;charset=UTF-8")
	public String weatherXMLtoJSON(HttpServletRequest request) {
		
		String str_jsonObjArr = request.getParameter("str_jsonObjArr"); // [{"locationName":"속초","ta":"29.4"}, ... ,{"locationName":"북부산","ta":"29.9"}]
	
		str_jsonObjArr = str_jsonObjArr.substring(1, str_jsonObjArr.length()-1); // {"locationName":"속초","ta":"29.4"}, ... ,{"locationName":"북부산","ta":"29.9"}
		
		String[] arr_str_jsonObjArr = str_jsonObjArr.split("\\},"); // }, 을 기준으로 자르는 것
		
		for(int i =0; i < arr_str_jsonObjArr.length; i++) {
			arr_str_jsonObjArr[i] += "}"; // {"locationName":"속초","ta":"29.4" => {"locationName":"속초","ta":"29.4"}	
		} // end of for ----------
		
		String[] locationArr = {"서울","인천","속초","춘천","강릉","전주","부산","여수","순천","제주","세종"};
		String result = "[";
		
		for(String jsonObj : arr_str_jsonObjArr) {
		
			for(int i=0; i<locationArr.length; i++) {
				if(jsonObj.indexOf(locationArr[i]) >= 0 && jsonObj.indexOf("북") == -1 && jsonObj.indexOf("서청주") == -1) { 
					// 원본데이터(jsonObj)에 "서울","인천", ... 라는 데이터(locationArr)가 존재하는 경우 && "북부산", "북강릉" 은 제외 && "서청주" 도 제외
					result += jsonObj+",";
					break;
				}
			} // end of for ----------
			
		} // end of for ----------
		
		result = result.substring(0, result.length()-1); // 마지막 , 삭제하기
		result = result + "]";
		// [{"locationName":"속초","ta":"33.9"},... ,{"locationName":"세종","ta":"29.0"}]
		
		return result;
	}
	
	// 게시판 글 조회하기
	@ResponseBody
	@GetMapping(value="/index/boardListJSON.kedai", produces="text/plain;charset=UTF-8")
	public String boardListJSON(HttpServletRequest request) {
		
		String category_code = request.getParameter("category_code");
		
		List<BoardVO> boardList = null;
		boardList = service.boardListJSON(category_code);
		
		JSONArray jsonArr = new JSONArray(); // []
		
		if(boardList != null) {
			for(BoardVO board : boardList) {
				JSONObject jsonObj = new JSONObject(); // {}
				
				jsonObj.put("category_name", board.getCategory_name());
				jsonObj.put("name", board.getName());
				jsonObj.put("subject", board.getSubject());
				jsonObj.put("registerday", board.getRegisterday());
				
				jsonArr.put(jsonObj); // [{}, {}, {}]
			} // end of for ----------
			
		} // end of if ----------
		
		return jsonArr.toString();
	}
	
	// 식단표 조회하기
	@ResponseBody
	@GetMapping(value="/index/boardMenuJSON.kedai", produces="text/plain;charset=UTF-8")
	public String boardMenuJSON() {
		
		BoardVO bvo = service.boardMenuJSON();
		
		JSONObject jsonObj = new JSONObject(); // {}
		
		jsonObj.put("content", bvo.getContent());
		jsonObj.put("filename", bvo.getFilename());
		
		return jsonObj.toString();
	}
}
