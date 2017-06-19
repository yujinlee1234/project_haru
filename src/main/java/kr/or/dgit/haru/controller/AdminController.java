package kr.or.dgit.haru.controller;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.dgit.haru.domain.AuthDTO;
import kr.or.dgit.haru.domain.BoardVO;
import kr.or.dgit.haru.domain.UserVO;
import kr.or.dgit.haru.service.BoardService;
import kr.or.dgit.haru.service.DiaryService;
import kr.or.dgit.haru.service.UserService;
import kr.or.dgit.haru.util.ProjectHaru;
import kr.or.dgit.haru.util.UploadFileUtils;

@Controller
@RequestMapping("/admin")
public class AdminController {
	private final Logger logger = LoggerFactory.getLogger(AdminController.class);
	@Resource(name="uploadPath")
	private String uploadPath;
	@Inject
	private UserService uService;
	
	@Inject
	private DiaryService dService;
	
	@Inject
	private BoardService bService;
	
	/**
	 * 로그인 시 사용할 함수
	 * 성공 시 Result 값으로 success값, login한 회원의 정보를 담고 있는 auth가 함께 넘어오고
	 * 실패 시 Result 값으로 fail값이 넘어온다.
	 * 진행과정에서 Exception 발생 시 BAD_REQUEST 반환
	 * */
	@RequestMapping(value="/list.do/{date}", method = RequestMethod.GET)
	public String boardService(@PathVariable long date, HttpSession session, Model model){		
			Date theDate = new Date(date);
			System.out.println();
			if(theDate.getTime() > new java.util.Date().getTime()){
				theDate = new Date();
			}
			List<BoardVO> bList = bService.selectBoardForAdmin(theDate);
			model.addAttribute("date", ProjectHaru.dateFormat.format(theDate));
			model.addAttribute("bList", bList);
			
		return "/board/list_admin_detail";
	}
	/** login test를 위함 임시 페이지와 임시 method(login page 제공)
	 * */
	
	@RequestMapping(value="/member", method = RequestMethod.GET)
	public String loginService(Model model){	
		List<UserVO> uList = uService.selectAllUser();
		model.addAttribute("uList",uList);
		return "/admin/list_member";
	}
	
	/** login test를 위함 임시 페이지와 임시 method(login page 제공)
	 * */
	@RequestMapping(value="/list.do", method = RequestMethod.GET)
	public String boardService2(HttpSession session, RedirectAttributes rttr){
		AuthDTO auth = (AuthDTO) session.getAttribute("auth");
		
		if(auth.isUadmin()==true){
			return "/board/list_admin";
		}else{
			rttr.addFlashAttribute("result","접근 권한이 없습니다.");
			rttr.addFlashAttribute("returnTo", "diary/list.do");
			rttr.addFlashAttribute("type", "warning");
			return "redirect:/empty";
		}
		
	}
}
