package kr.or.dgit.haru.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.dgit.haru.domain.AuthDTO;
import kr.or.dgit.haru.domain.BoardVO;
import kr.or.dgit.haru.domain.DiaryVO;
import kr.or.dgit.haru.domain.UserVO;
import kr.or.dgit.haru.service.DiaryService;
import kr.or.dgit.haru.service.UserService;
import kr.or.dgit.haru.util.ProjectHaru;
import kr.or.dgit.haru.util.UploadFileUtils;

@Controller
@RequestMapping("/member")
public class MemberController {
	private final Logger logger = LoggerFactory.getLogger(MemberController.class);
	@Resource(name="uploadPath")
	private String uploadPath;
	@Inject
	private UserService uService;
	
	@Inject
	private DiaryService dService;
	
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
			List<DiaryVO> diary = dService.selectDiaryByUid(auth.getUid());
			
			if(auth != null){	
				session.setAttribute("auth", auth);
				
				rttr.addFlashAttribute("result", auth.getUid()+"님 반갑습니다.");
				rttr.addFlashAttribute("type", "success");
				if(!diary.isEmpty()){
					rttr.addFlashAttribute("returnTo", "board/list.do");
				}else{
					rttr.addFlashAttribute("returnTo", "diary/list.do");
				}
				
				return "redirect:/";
			}else{
				rttr.addFlashAttribute("result", "로그인에 실패하였습니다.");
				rttr.addFlashAttribute("returnTo", "member/login.do");
				rttr.addFlashAttribute("type", "error");
			}	
		}catch(Exception e){
			rttr.addFlashAttribute("result", "로그인에 실패하였습니다.");
			rttr.addFlashAttribute("returnTo", "member/login.do");
			rttr.addFlashAttribute("type", "error");
		}
		return "redirect:/empty";
	}
	/** login test를 위함 임시 페이지와 임시 method(login page 제공)
	 * */
	
	@RequestMapping(value="/login", method = RequestMethod.GET)
	public String loginService(){		
		return "/user/login";
	}
	
	/** login test를 위함 임시 페이지와 임시 method(login page 제공)
	 * */
	@RequestMapping(value="/login.do", method = RequestMethod.GET)
	public String loginService2(){		
		return "/user/login2";
	}

	/** 회원 정보 조회 페이지
	 * */
	@RequestMapping(value="/info.do", method = RequestMethod.GET)
	public String infoService( HttpSession session, Model model){	
		AuthDTO auth = (AuthDTO) session.getAttribute("auth");
		UserVO uVO = uService.selectUser(auth.getUid());
		model.addAttribute("user", uVO);
		
		return "/user/info";
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
	public String joinService(UserVO uVO, MultipartFile imagefiles, RedirectAttributes rttr){
		try{
			if(imagefiles.getSize()>0){
				String files = setFileList(imagefiles);// 등록된 사진
				if(files != ""){
					uVO.setUpic(files);
				}
			}
			uService.insertUser(uVO);			
			rttr.addFlashAttribute("result", "회원가입에 성공하였습니다.");
			rttr.addFlashAttribute("returnTo", "member/login.do");
			rttr.addFlashAttribute("type", "success");
			
		}catch(Exception e){
			rttr.addFlashAttribute("result", "회원가입에 실패하였습니다.");
			rttr.addFlashAttribute("returnTo", "member/join");
			rttr.addFlashAttribute("type", "error");
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
		session.removeAttribute("diary");
		rttr.addFlashAttribute("result", "로그아웃되었습니다.");	
		rttr.addFlashAttribute("type", "success");
		return "redirect:/";
	}
	
	/**
	 * 회원탈퇴 시 사용할 함수
	 * */	
	@RequestMapping(value="/exit", method = RequestMethod.GET)
	public String exitService(HttpSession session, RedirectAttributes rttr){
		AuthDTO auth = (AuthDTO) session.getAttribute("auth");
		uService.exitUser(auth.getUid());
		session.removeAttribute("auth");
		session.removeAttribute("diary");
		rttr.addFlashAttribute("result", "정상적으로 탈퇴되었습니다.\n 그동안 사용해 주셔서 감사합니다.");	
		rttr.addFlashAttribute("type", "success");
		return "redirect:/";
	}
	
	/**
	 * 회원탈퇴 시 사용할 함수
	 * */	
	@RequestMapping(value="/exit", method = RequestMethod.POST)
	public String exitServiceForAdmin(HttpSession session, RedirectAttributes rttr){
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		
		try{
			String[] uList = request.getParameterValues("delFiles");
			for(String user: uList){
				System.out.println(user);
				UserVO userVO = uService.selectUser(user);				
				deleteFile(userVO);
				uService.deleteUser(user);
			}
			
			rttr.addFlashAttribute("result", "회원을 탈퇴 시켰습니다.");
			rttr.addFlashAttribute("type", "success");
		}catch(Exception e){
			e.printStackTrace();
			rttr.addFlashAttribute("result", "회원을 탈퇴시키지 못했습니다. 잠시 후 다시 시도해 주세요.");
			rttr.addFlashAttribute("type", "error");
		}
		rttr.addFlashAttribute("returnTo", "admin/member");
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
	
	/**
	 * 중복 아이디 체크
	 * */
	@ResponseBody
	@RequestMapping(value="/check", method = RequestMethod.POST)
	public String checkPassService(String upass, HttpSession session){
		System.out.println("=========================CHECK PASSWORD");
		String result = "";
		
		AuthDTO auth = uService.login(((AuthDTO)session.getAttribute("auth")).getUid(), upass);
		System.out.println(auth);
		if(auth == null){
			result = "FAIL";
		}else{
			result = "SUCCESS";
		}
			
		return result;
	}
	
	/**
	 * 중복 아이디 체크
	 * */
	@ResponseBody
	@RequestMapping(value="/mod", method = RequestMethod.PUT)
	public String modifyService(UserVO uVO, HttpSession session){
		
		String result = "";
		
		AuthDTO auth = (AuthDTO)session.getAttribute("auth");
		UserVO user = uService.selectUser(auth.getUid());
		
		UserVO modUser = setUserVO(user, uVO);
		try{
			uService.updateUser(modUser);
			result = "SUCCESS";
		}catch(Exception e){
			e.printStackTrace();
			result = "FAIL";
		}
		
		return result;
	}
	
	/**
	 * 중복 아이디 체크
	 * */
	@RequestMapping(value="/mod", method = RequestMethod.POST)
	public String modifyFileService(UserVO uVO, MultipartFile imagefiles, HttpSession session, Model model){		
		AuthDTO auth = (AuthDTO)session.getAttribute("auth");
			
		if(auth.getUid().equals(uVO.getUid())){
			try{
				UserVO modUser = uService.selectUser(auth.getUid());
				if(imagefiles.getSize()>0){
					String files = setFileList(imagefiles);// 등록된 사진
					if(files != ""){
						deleteFile(modUser);
						modUser.setUpic(files);
					}
				}
				uService.updateUser(modUser);
				model.addAttribute("user", uService.selectUser(modUser.getUid()));
				auth.setUpic(modUser.getUpic());
				session.setAttribute("auth", auth);
			}catch(Exception e){
				e.printStackTrace();
			}
		}		
		return "/user/info";
	}
	
	private UserVO setUserVO(UserVO user, UserVO uVO) {
		// TODO Auto-generated method stub
		if(uVO.getUpass() != null){
			user.setUpass(uVO.getUpass());
		}
		
		if(uVO.getUmail() != null){
			user.setUmail(uVO.getUmail());
		}
		
		if(uVO.getUname() != null){
			user.setUname(uVO.getUname());
		}
		
		if(uVO.getUpic() != null){
			user.setUpic(uVO.getUpic());
		}		
		return user;
	}
	private String setFileList(MultipartFile imagefiles) throws IOException, Exception {
		// TODO Auto-generated method stub
		String filenames = "";
		
		logger.info("ORIGINAL NAME : "+imagefiles.getOriginalFilename());
		logger.info("SIZE : "+imagefiles.getSize());
		logger.info("CONTENT TYPE : "+imagefiles.getContentType());
		if(imagefiles.getOriginalFilename() != null && imagefiles.getOriginalFilename() != ""){
			String savedName = UploadFileUtils.uploadFile(uploadPath, imagefiles.getOriginalFilename(), imagefiles.getBytes());
			filenames = savedName;
		}	
		
		return filenames;
	}
	
	private void deleteFile(UserVO uvo) {
		// 실제로 저장 되어있는 썸네일과 사진 삭제
		if(uvo.getUpic()==null){
			return;
		}
		
		String oPath = uvo.getOriginalname();
		String tPath = uvo.getUpic();
		
		File oFile = new File(uploadPath+oPath);
		File tFile = new File(uploadPath+tPath);
		
		if(oFile.exists()){
			oFile.delete();
		}
		if(tFile.exists()){
			tFile.delete();
		}
	}
	
	
}
