package kr.or.dgit.haru.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.dgit.haru.domain.AuthDTO;
import kr.or.dgit.haru.domain.UserVO;
import kr.or.dgit.haru.service.UserService;

@Controller
@RequestMapping("/member")
public class MemberController {
	private final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Inject
	private UserService uService;
	
	/**
	 * 로그인 시 사용할 함수
	 * 성공 시 Result 값으로 success값, login한 회원의 정보를 담고 있는 auth가 함께 넘어오고
	 * 실패 시 Result 값으로 fail값이 넘어온다.
	 * 진행과정에서 Exception 발생 시 BAD_REQUEST 반환
	 * */
	@ResponseBody
	@RequestMapping(value="/login", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> loginService(String uid, String upass, HttpServletRequest req){		
		ResponseEntity<Map<String, Object>> result = null;
		try{
			Map<String, Object> rMap = new HashMap<>();
			AuthDTO auth = uService.login(uid, upass);
			
			if(auth != null){	
				req.getSession().setAttribute("auth", auth);
				rMap.put("auth", auth);
				rMap.put("Result", "success");
				result = new ResponseEntity<Map<String,Object>>(rMap, HttpStatus.OK);
			}else{
				rMap.put("Result", "fail");
				result = new ResponseEntity<Map<String,Object>>(rMap, HttpStatus.OK);
			}	
		}catch(Exception e){
			result = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return result;
	}
	/** login test를 위함 임시 페이지와 임시 method(login page 제공)
	 * */
	
	@RequestMapping(value="/login", method = RequestMethod.GET)
	public String loginService(){		
		return "logintest";
	}
	

	/**
	 * 회원가입 시 사용할 함수
	 * 성공 시 Result 값으로 success값, login한 회원의 정보를 담고 있는 auth가 함께 넘어오고
	 * 실패 시 Result 값으로 fail값이 넘어온다.
	 * 진행과정에서 Exception 발생 시 BAD_REQUEST 반환
	 * */
	@ResponseBody
	@RequestMapping(value="/join", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> joinService(UserVO uVO){
		
		ResponseEntity<Map<String, Object>> result = null;
		try{
			Map<String, Object> rMap = new HashMap<>();
			uService.insertUser(uVO);
			
			rMap.put("Result", "success");
			result = new ResponseEntity<Map<String,Object>>(rMap, HttpStatus.OK);
		
		}catch(Exception e){
			result = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return result;
	}
	
}
