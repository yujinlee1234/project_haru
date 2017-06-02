package kr.or.dgit.haru.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.dgit.haru.domain.AuthDTO;
import kr.or.dgit.haru.domain.BoardVO;
import kr.or.dgit.haru.domain.DiaryVO;
import kr.or.dgit.haru.service.BoardService;
import kr.or.dgit.haru.service.DiaryService;
import kr.or.dgit.haru.util.MediaUtils;
import kr.or.dgit.haru.util.UploadFileUtils;

@Controller
@RequestMapping(value="/board")
public class BoardController {
	private final Logger logger = LoggerFactory.getLogger(BoardController.class);
	@Resource(name="uploadPath")
	private String uploadPath;
	@Autowired
	private DiaryService dService;
	
	@Inject
	private BoardService bService;
	
	/**각 다이어리별 게시글 가져오는 메소드 현재는 회원 당 하나의 다이어리만 가능 하므로 
	 * 회원의 아이디를 통해 다이어리 dno 가져옴
	 * */
	
	@RequestMapping(value="/list", method=RequestMethod.GET)
	public String getAllBoardByDno(HttpSession session, Model model){
		AuthDTO auth = (AuthDTO) session.getAttribute("auth");
		
		List<DiaryVO> dList = dService.selectDiaryByUid(auth.getUid());
		List<BoardVO> bList = null;
		if(!dList.isEmpty()){
			bList = bService.selectAllBoard(dList.get(0).getDno());
			model.addAttribute("diary", dList.get(0));
			model.addAttribute("bList", bList);
		}		
		return "/board/list";
	}
	
	@RequestMapping(value="/add", method=RequestMethod.GET)
	public String createBoardService(){
		return "/board/register";
	}
	
	@RequestMapping(value="/add", method=RequestMethod.POST)
	public String createBoardService(HttpSession session, BoardVO bVO, MultipartFile imagefiles, RedirectAttributes rttr){
		
		try{
			System.out.println("BoardVO : "+bVO);
			System.out.println("imagefile : "+imagefiles);
			String files = setFileList(imagefiles);// 등록된 사진
			if(files != ""){
				bVO.setBpic(files);
			}
			AuthDTO auth = (AuthDTO) session.getAttribute("auth");
			List<DiaryVO> dList = dService.selectDiaryByUid(auth.getUid());
			if(dList.size()>0){
				DiaryVO diary = dList.get(0);
				bVO.setDno(diary.getDno());
				bService.insertBoard(bVO);
				rttr.addFlashAttribute("result", "SUCCESS");
			}else{
				rttr.addFlashAttribute("result", "[ERROR] 일기를 작성할 다이어리가 존재하지 않습니다.");
			}
			
		}catch(Exception e){
			rttr.addFlashAttribute("result", e.getMessage());
			e.printStackTrace();
			logger.info(e.getMessage());
		}		

		return "redirect:/board/list";
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
	
}
