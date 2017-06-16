package kr.or.dgit.haru.controller;

import java.io.File;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.dgit.haru.domain.AuthDTO;
import kr.or.dgit.haru.domain.BoardVO;
import kr.or.dgit.haru.domain.DiaryVO;
import kr.or.dgit.haru.domain.UserVO;
import kr.or.dgit.haru.service.BoardService;
import kr.or.dgit.haru.service.DiaryService;
import kr.or.dgit.haru.util.UploadFileUtils;

@Controller
@RequestMapping(value="/diary")
public class DiaryController {
	
	private final Logger logger = LoggerFactory.getLogger(DiaryController.class);
	
	@Autowired
	private DiaryService dService;
	
	@Autowired
	private BoardService bService;
	
	@Resource(name="uploadPath")
	private String uploadPath;
	/** 오늘의 일기 탭으로 진입시 보여줄 화면 return 
	 * */
	@RequestMapping(value = "/list.do", method = RequestMethod.GET)
	public String selectDiaryAll(Model model, HttpSession session){
		try{
			List<DiaryVO> dList = dService.selectAllDiary();
			if(dList.size()>0){
				model.addAttribute("dList", dList);
			}
		}catch (Exception e){
			e.printStackTrace();
		}		
		return "/diary/list2";
	}
	
	/** 오늘의 일기 탭으로 진입시 보여줄 화면 return 
	 * */
	@RequestMapping(value = "/mylist.do", method = RequestMethod.GET)
	public String selectMyDiary(Model model, HttpSession session){
		try{
			AuthDTO auth = (AuthDTO) session.getAttribute("auth");
			
			List<DiaryVO> dList = dService.selectDiaryByUid(auth.getUid());
			
			if(dList.size()>0){
				model.addAttribute("diary",dList.get(0));
			}
		}catch (Exception e){
			e.printStackTrace();
		}		
		return "/diary/info";
	}
	
	/** 오늘의 일기 탭으로 진입시 보여줄 화면 return 
	 * */
	@RequestMapping(value = "/mod.do", method = RequestMethod.GET)
	public String modMyDiary(Model model, HttpSession session){
		try{
			AuthDTO auth = (AuthDTO) session.getAttribute("auth");
			
			List<DiaryVO> dList = dService.selectDiaryByUid(auth.getUid());
			
			if(dList.size()>0){
				model.addAttribute("diary",dList.get(0));
			}
		}catch (Exception e){
			e.printStackTrace();
		}		
		return "/diary/modify";
	}
	
	@RequestMapping(value = "/mod", method = RequestMethod.POST)
	public String modifyDiary(DiaryVO dVO, MultipartFile imagefiles, HttpSession session, RedirectAttributes rttr){
		System.out.println(imagefiles.getSize());
		try{
			DiaryVO diary = dService.selectDiaryByDno(dVO.getDno());
			if(diary.getDpic() != null && (dVO.getDpic() == null || imagefiles.getSize() > 0)){
				deleteFile(diary);
			}
			System.out.println(dVO.isDopen());
			if(imagefiles.getSize() > 0){
				String thumb = UploadFileUtils.uploadFile(uploadPath, imagefiles.getOriginalFilename(), imagefiles.getBytes());
				dVO.setDpic(thumb);
			}
			
			AuthDTO auth = (AuthDTO) session.getAttribute("auth");
			logger.info("[AUTH ID]"+auth.getUid());
			System.out.println(auth.getUid());
			
			dService.updateDiary(dVO);
			
			rttr.addFlashAttribute("result", "다이어리를 성공적으로 수정하였습니다.");
			rttr.addFlashAttribute("returnTo", "board/list.do");
		}catch (Exception e){
			rttr.addFlashAttribute("result", "[ERROR]다이어리 수정에 실패하였습니다.");
			rttr.addFlashAttribute("returnTo", "diary/mylist.do");
			e.printStackTrace();
		}		
		return "redirect:/";
	}
	
	@Transactional
	@RequestMapping(value = "/del", method = RequestMethod.POST)
	public String modifyDiary(int dno, RedirectAttributes rttr){
		try{
			List<BoardVO> bList = bService.selectAllBoard(dno);
			for(BoardVO board:bList){
				deleteFile(board);
			}
			DiaryVO diary = dService.selectDiaryByDno(dno);
			deleteFile(diary);
			
			bService.deleteAllBoard(dno);
			dService.deleteDiary("", dno);
			
			rttr.addFlashAttribute("result", "다이어리를 성공적으로 삭제하였습니다.");
			rttr.addFlashAttribute("returnTo", "diary/list.do");
		}catch (Exception e){
			rttr.addFlashAttribute("result", "[ERROR]다이어리 삭제에 실패하였습니다.");
			rttr.addFlashAttribute("returnTo", "diary/mylist.do");
			e.printStackTrace();
		}		
		return "redirect:/";
	}
	
	@RequestMapping(value = "/add.do", method = RequestMethod.GET)
	public String createDiary2(){		
		return "/diary/register";
	}
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
			dVO.isDopen();
			if(imagefiles != null){
				String thumb = UploadFileUtils.uploadFile(uploadPath, imagefiles.getOriginalFilename(), imagefiles.getBytes());
				dVO.setDpic(thumb);
			}
			
			AuthDTO auth = (AuthDTO) session.getAttribute("auth");
			logger.info("[AUTH ID]"+auth.getUid());
			System.out.println(auth.getUid());
			
			dService.insertDiary(auth.getUid(), dVO);
			rttr.addFlashAttribute("result", "다이어리를 성공적으로 등록하였습니다.");
			rttr.addFlashAttribute("returnTo", "board/list.do");
		}catch (Exception e){
			rttr.addFlashAttribute("result", "[ERROR]다이어리 등록에 실패하였습니다.");
			rttr.addFlashAttribute("returnTo", "board/list.do");
			e.printStackTrace();
		}		
		return "redirect:/";
	}
	
	
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String createDiary(){		
		return "/diary/register";
	}
	
	private void deleteFile(DiaryVO object) {
		// 실제로 저장 되어있는 썸네일과 사진 삭제
		if(object.getDpic()==null){
			return;
		}
		
		String oPath = object.getOriginalname();
		String tPath = object.getDpic();
		
		File oFile = new File(uploadPath+oPath);
		File tFile = new File(uploadPath+tPath);
		
		if(oFile.exists()){
			oFile.delete();
		}
		if(tFile.exists()){
			tFile.delete();
		}
	}
	private void deleteFile(BoardVO object) {
		// 실제로 저장 되어있는 썸네일과 사진 삭제
		if(object.getBpic()==null){
			return;
		}
		
		String oPath = object.getOriginalname();
		String tPath = object.getBpic();
		
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
