package kr.or.dgit.haru.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.dgit.haru.domain.AuthDTO;
import kr.or.dgit.haru.domain.DiaryVO;
import kr.or.dgit.haru.service.DiaryService;
import kr.or.dgit.haru.util.UploadFileUtils;

@Controller
@RequestMapping(value="/diary")
public class DiaryController {
	
	private final Logger logger = LoggerFactory.getLogger(DiaryController.class);
	
	@Autowired
	private DiaryService dService;
	
	@Resource(name="uploadPath")
	private String uploadPath;
	
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String selectDiary(Model model, HttpSession session){
		try{
			AuthDTO auth = (AuthDTO) session.getAttribute("auth");
			logger.info("[AUTH ID]"+auth.getUid());
			System.out.println(auth.getUid());
			
			List<DiaryVO> dList = dService.selectDiaryByUid(auth.getUid());
			if(!dList.isEmpty()){
				System.out.println(dList.get(0).getDpic());
				model.addAttribute("diary", dList.get(0));
			}
		}catch (Exception e){
			e.printStackTrace();
		}		
		return "/diary/list";
	}
	
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public String createDiary(DiaryVO dVO, MultipartFile imagefiles, HttpSession session, RedirectAttributes rttr){
		
		try{
			
			if(imagefiles != null){
				String thumb = UploadFileUtils.uploadFile(uploadPath, imagefiles.getOriginalFilename(), imagefiles.getBytes());
				dVO.setDpic(thumb);
			}
			
			AuthDTO auth = (AuthDTO) session.getAttribute("auth");
			logger.info("[AUTH ID]"+auth.getUid());
			System.out.println(auth.getUid());
			
			dService.insertDiary(auth.getUid(), dVO);
			rttr.addFlashAttribute("result", "다이어리를 성공적으로 등록하였습니다.");
			rttr.addFlashAttribute("returnTo", "diary/list");
		}catch (Exception e){
			rttr.addFlashAttribute("result", "[ERROR]다이어리 등록에 실패하였습니다.");
			rttr.addFlashAttribute("returnTo", "diary/list");
			e.printStackTrace();
		}		
		return "redirect:/";
	}
	
	
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String createDiary(){		
		return "/diary/register";
	}
	
	
	
}
