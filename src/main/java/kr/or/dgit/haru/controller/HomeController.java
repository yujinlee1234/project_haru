package kr.or.dgit.haru.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.dgit.haru.domain.AuthDTO;
import kr.or.dgit.haru.domain.DiaryVO;
import kr.or.dgit.haru.service.DiaryService;
import kr.or.dgit.haru.util.MediaUtils;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Autowired
	private DiaryService dService;
	
	@Resource(name="uploadPath")
	private String uploadPath;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model, HttpSession session) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		AuthDTO auth = (AuthDTO) session.getAttribute("auth");
		
		List<DiaryVO> dList = dService.selectAllDiary();
		if(dList.size()>0){
			session.setAttribute("dList", dList);
		}
		
		
		return "home";
	}
	
	@ResponseBody
	@RequestMapping(value="/display")
	public ResponseEntity<byte[]> displayFile(String filename) throws IOException {
		InputStream in = null;
		ResponseEntity<byte[]> entity = null;
		
		logger.info("[displayFile] filename : "+filename);
		try{
			String format = filename.substring(filename.lastIndexOf(".")+1);//파일 확장자만 뽑기
			MediaType mType = MediaUtils.getMediaType(format);
			
			HttpHeaders headers = new HttpHeaders();
			headers.setContentType(mType);
			
			in = new FileInputStream(uploadPath+"/"+filename);
			
			//IOUtils.toByteArray(in);
			
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.CREATED);
		}catch(IOException e){
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}finally {
			in.close();
		}
		
		return entity;	
	}
	
}
