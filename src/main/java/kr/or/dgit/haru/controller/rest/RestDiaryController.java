package kr.or.dgit.haru.controller.rest;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.or.dgit.haru.domain.AuthDTO;
import kr.or.dgit.haru.domain.DiaryVO;
import kr.or.dgit.haru.service.DiaryService;
import kr.or.dgit.haru.util.HaruTokenService;
import kr.or.dgit.haru.util.UploadFileUtils;

@Controller
@RequestMapping(value="/rest/diary")
public class RestDiaryController {
	
	private final Logger logger = LoggerFactory.getLogger(RestDiaryController.class);
	
	@Autowired
	private DiaryService dService;
	
	@Resource(name="uploadPath")
	private String uploadPath;
	
	@ResponseBody
	@RequestMapping(value = "/", method = RequestMethod.POST)
	public ResponseEntity<DiaryVO> selectDiary(String token){
		ResponseEntity<DiaryVO> result = null;
		try{
			AuthDTO auth = HaruTokenService.decodeToAuth(token);
			logger.info("[AUTH ID]"+auth.getUid());
			System.out.println(auth.getUid());
			
			List<DiaryVO> dList = dService.selectDiaryByUid(auth.getUid());
			if(!dList.isEmpty()){
				result = new ResponseEntity<>(dList.get(0), HttpStatus.OK);
			}else{
				result = new ResponseEntity<>(null, HttpStatus.OK);
			}
			
		}catch (Exception e){
			result = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}		
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value = "/create", method = RequestMethod.POST)
	public String createDiary(DiaryVO dVO, String token, MultipartFile imagefiles){
		String result = "";
		try{
			if(imagefiles != null){
				String dpic_thumb = UploadFileUtils.uploadFile(uploadPath, dVO.getDpic(), imagefiles.getBytes());
				dVO.setDpic(dpic_thumb);
			}
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
	
}
