package kr.or.dgit.haru.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.dgit.haru.domain.AuthDTO;
import kr.or.dgit.haru.domain.DiaryVO;
import kr.or.dgit.haru.service.DiaryService;

@Controller
@RequestMapping(value="/diary")
public class DiaryController {
	
	private final Logger logger = LoggerFactory.getLogger(DiaryController.class);
	
	@Autowired
	private DiaryService dService;
	
	@ResponseBody
	@RequestMapping(value = "/create", method = RequestMethod.POST)
	public String createDiary(DiaryVO dVO, HttpServletRequest req){
		String result = "";
		try{
			AuthDTO auth = (AuthDTO)req.getSession().getAttribute("auth");
			logger.info("[AUTH ID]"+auth.getUid());
			System.out.println(auth.getUid());
			
			dService.insertDiary(auth.getUid(), dVO);
			result ="success";
		}catch (Exception e){
			result = "fail";
		}		
		return result;
	}
	
	
	@RequestMapping(value = "/create", method = RequestMethod.GET)
	public String createDiary(){		
		return "diaryExample";
	}
	
	
	
}
