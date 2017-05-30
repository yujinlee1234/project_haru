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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

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
	@ResponseBody
	@RequestMapping(value="/login", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> loginService(String uid, String upass, HttpSession session){		
		ResponseEntity<Map<String, Object>> result = null;
		try{
			Map<String, Object> rMap = new HashMap<>();
			AuthDTO auth = uService.login(uid, upass);
			
			if(auth != null){	
				session.setAttribute("auth", auth);
				Algorithm algorithm = Algorithm.HMAC256("secret");
				Map<String, Object> headerClaims = new HashMap();
				headerClaims.put("uid", auth.getUid());
				headerClaims.put("uadmin", auth.isUadmin());
				headerClaims.put("upic", auth.getUid());
				
				String token = JWT.create()
				        .withHeader(headerClaims)
				        .sign(algorithm);
				
				System.out.println("TOKEN : "+token);
				
				DecodedJWT jwt = JWT.decode(token);
				Claim clain = jwt.getHeaderClaim("uid");
				
				System.out.println("DECODE TOKEN : "+jwt.getHeader());
				System.out.println("DECODE TOKEN uid : "+clain.asString());
				
				rMap.put("auth", token);
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
	
	/** login test를 위함 임시 페이지와 임시 method(login page 제공)
	 * */
	
	@RequestMapping(value="/join", method = RequestMethod.GET)
	public String joinService(){		
		return "jointest";
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
	
	/**
	 * 회원가입 시 사용할 함수
	 * 성공 시 Result 값으로 success값, login한 회원의 정보를 담고 있는 auth가 함께 넘어오고
	 * 실패 시 Result 값으로 fail값이 넘어온다.
	 * 진행과정에서 Exception 발생 시 BAD_REQUEST 반환
	 * */
	
	@RequestMapping(value="/logout", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> logoutService(HttpSession session){
		
		ResponseEntity<Map<String, Object>> result = null;
		try{
			session.removeAttribute("auth");
			
		}catch(Exception e){
			result = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return result;
	}
	
}
