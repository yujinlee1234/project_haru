package kr.or.dgit.haru.controller.rest;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.interfaces.Claim;
import com.auth0.jwt.interfaces.DecodedJWT;

import kr.or.dgit.haru.controller.HomeController;
import kr.or.dgit.haru.domain.AuthDTO;
import kr.or.dgit.haru.domain.UserVO;
import kr.or.dgit.haru.service.UserService;
import kr.or.dgit.haru.util.HaruTokenService;
import kr.or.dgit.haru.util.MediaUtils;

@Controller
@RequestMapping("/rest/member")
public class RestMemberController {
	private final Logger logger = LoggerFactory.getLogger(RestMemberController.class);
	
	@Resource(name="uploadPath")
	private String uploadPath;
	
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
	
	/**
	 * 로그인 시 사용할 함수
	 * 성공 시 Result 값으로 success값, login한 회원의 정보를 담고 있는 auth가 함께 넘어오고
	 * 실패 시 Result 값으로 fail값이 넘어온다.
	 * 진행과정에서 Exception 발생 시 BAD_REQUEST 반환
	 * */
	@ResponseBody
	@RequestMapping(value="/info", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> getUserService(String token, HttpSession session){		
		ResponseEntity<Map<String, Object>> result = null;
		try{
			
			Map<String, Object> rMap = new HashMap<>();
			AuthDTO auth = HaruTokenService.decodeToAuth(token);
			System.out.println(auth);
			UserVO user = uService.selectUser(auth.getUid());
			
			if(auth != null){	
				System.out.println(auth);
				rMap.put("user", auth);
				if(auth.getUpic()!= null){
					rMap.put("user_img", displayFile(user.getUpic()));
					System.out.println(displayFile(user.getUpic()).toString());
				}
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

	/**
	 * 회원가입 시 사용할 함수
	 * 성공 시 Result 값으로 success값, login한 회원의 정보를 담고 있는 auth가 함께 넘어오고
	 * 실패 시 Result 값으로 fail값이 넘어온다.
	 * 진행과정에서 Exception 발생 시 BAD_REQUEST 반환
	 * */
	@ResponseBody
	@RequestMapping(value="/join", method = RequestMethod.POST)
	public String joinService(UserVO uVO){
		String result = null;
		try{
			uService.insertUser(uVO);			
			result = "success";
		
		}catch(Exception e){
			result = "fail";
		}
		return result;
	}	
	
	public byte[] displayFile(String filename) throws IOException {
		InputStream in = null;
		byte[] result = null;
		
		logger.info("[displayFile] filename : "+filename);
		try{
			String format = filename.substring(filename.lastIndexOf(".")+1);//파일 확장자만 뽑기
			MediaType mType = MediaUtils.getMediaType(format);
			
			HttpHeaders headers = new HttpHeaders();
			headers.setContentType(mType);
			
			in = new FileInputStream(uploadPath+"/"+filename);
			
			//IOUtils.toByteArray(in);
			
			result = IOUtils.toByteArray(in);
		}catch(IOException e){
			e.printStackTrace();
		}finally {
			in.close();
		}
		
		return result;	
	}
}
