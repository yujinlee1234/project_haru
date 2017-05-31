package kr.or.dgit.haru.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.interfaces.Claim;
import com.auth0.jwt.interfaces.DecodedJWT;

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
	@RequestMapping(value="/login", method = RequestMethod.POST)
	public String loginService(String uid, String upass, HttpSession session, RedirectAttributes rttr){		
		try{			
			AuthDTO auth = uService.login(uid, upass);
			
			if(auth != null){	
				session.setAttribute("auth", auth);
				rttr.addFlashAttribute("result", auth.getUid()+"님 반갑습니다.");
				rttr.addFlashAttribute("returnTo", "/board/list");
				
			}else{
				rttr.addFlashAttribute("result", "[ERROR] 로그인에 실패하였습니다.");
				rttr.addFlashAttribute("returnTo", "/member/login");
			}	
		}catch(Exception e){
			rttr.addFlashAttribute("result", "[ERROR] 로그인에 실패하였습니다.");
			rttr.addFlashAttribute("returnTo", "/member/login");
		}
		return "redirect:/";
	}
	/** login test를 위함 임시 페이지와 임시 method(login page 제공)
	 * */
	
	@RequestMapping(value="/login", method = RequestMethod.GET)
	public String loginService(){		
		return "/user/login";
	}
	
	/** login test를 위함 임시 페이지와 임시 method(login page 제공)
	 * */
	
	@RequestMapping(value="/join", method = RequestMethod.GET)
	public String joinService(){		
		return "/user/join";
	}
	

	/**
	 * 회원가입 시 사용할 함수
	 * 성공 시 Result 값으로 success값, login한 회원의 정보를 담고 있는 auth가 함께 넘어오고
	 * 실패 시 Result 값으로 fail값이 넘어온다.
	 * 진행과정에서 Exception 발생 시 BAD_REQUEST 반환
	 * */
	
	@RequestMapping(value="/join", method = RequestMethod.POST)
	public String joinService(UserVO uVO, RedirectAttributes rttr){
		try{
			uService.insertUser(uVO);			
			rttr.addFlashAttribute("result", "회원가입에 성공하였습니다.");
			rttr.addFlashAttribute("returnTo", "/member/login");
		
		}catch(Exception e){
			rttr.addFlashAttribute("result", "[ERROR]회원가입에 실패하였습니다.");
			rttr.addFlashAttribute("returnTo", "/member/join");
		}
		return "redirect:/";
	}
	
	/**
	 * 회원가입 시 사용할 함수
	 * 성공 시 Result 값으로 success값, login한 회원의 정보를 담고 있는 auth가 함께 넘어오고
	 * 실패 시 Result 값으로 fail값이 넘어온다.
	 * 진행과정에서 Exception 발생 시 BAD_REQUEST 반환
	 * */
	
	@RequestMapping(value="/logout", method = RequestMethod.GET)
	public String logoutService(HttpSession session, RedirectAttributes rttr){
		
		ResponseEntity<Map<String, Object>> result = null;
		
		session.removeAttribute("auth");
		rttr.addFlashAttribute("result", "로그아웃되었습니다.");
		rttr.addFlashAttribute("returnTo", "/member/login");
	
		return "redirect:/";
	}
	
	/**
	 * 중복 아이디 체크
	 * */
	@ResponseBody
	@RequestMapping(value="/check/{uid}", method = RequestMethod.GET)
	public String checkIDService(@PathVariable String uid, HttpSession session){
		String result = "";
		
		AuthDTO auth = uService.checkUser(uid);
		if(auth != null){
			result = "FAIL";
		}else{
			result = "SUCCESS";
		}
			
		return result;
	}
	
}
