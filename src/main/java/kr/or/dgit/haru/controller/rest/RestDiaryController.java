package kr.or.dgit.haru.controller.rest;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.dgit.haru.domain.AuthDTO;
import kr.or.dgit.haru.domain.DiaryVO;
import kr.or.dgit.haru.service.DiaryService;
import kr.or.dgit.haru.util.HaruTokenService;

@Controller
@RequestMapping(value="/rest/diary")
public class RestDiaryController {
	
	private final Logger logger = LoggerFactory.getLogger(RestDiaryController.class);
	
	@Autowired
	private DiaryService dService;
	
	@ResponseBody
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ResponseEntity<List<DiaryVO>> selectDiary(String token){
		ResponseEntity<List<DiaryVO>> result = null;
		try{
			AuthDTO auth = HaruTokenService.decodeToAuth(token);
			logger.info("[AUTH ID]"+auth.getUid());
			System.out.println(auth.getUid());
			
			List<DiaryVO> dList = dService.selectDiaryByUid(auth.getUid());
			if(!dList.isEmpty()){
				result = new ResponseEntity<>(dList, HttpStatus.OK);
			}else{
				result = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
			}
			
		}catch (Exception e){
			result = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}		
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value = "/create", method = RequestMethod.POST)
	public String createDiary(DiaryVO dVO, String token){
		String result = "";
		try{
			AuthDTO auth = HaruTokenService.decodeToAuth(token);
			logger.info("[AUTH ID]"+auth.getUid());
			System.out.println(auth.getUid());
			
			dService.insertDiary(auth.getUid(), dVO);
			result ="success";
		}catch (Exception e){
			result = "fail";
			e.printStackTrace();
		}		
		return result;
	}
	
	
	@RequestMapping(value = "/create", method = RequestMethod.GET)
	public String createDiary(){		
		return "diaryExample";
	}
	
	
	
}
