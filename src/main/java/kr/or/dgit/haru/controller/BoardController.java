package kr.or.dgit.haru.controller;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
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
import kr.or.dgit.haru.service.BoardService;
import kr.or.dgit.haru.service.DiaryService;
import kr.or.dgit.haru.util.ProjectHaru;
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
	
	@RequestMapping(value="/list.do", method=RequestMethod.GET)
	public String getAllBoardByDno2(HttpSession session, Model model){
		AuthDTO auth = (AuthDTO) session.getAttribute("auth");
		
		List<DiaryVO> dList = dService.selectDiaryByUid(auth.getUid());
		List<BoardVO> bList = null;
		if(!dList.isEmpty()){
			bList = bService.selectAllBoard(dList.get(0).getDno());
			System.out.println(bList);
			model.addAttribute("diary", dList.get(0));
			model.addAttribute("bList", bList);
		}		
		return "/board/list_final";
	}
	
	@ResponseBody
	@RequestMapping(value="/list.do/{dno}", method=RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> getAllBoardByDno3(HttpSession session, @PathVariable int dno, int year, int month){
		ResponseEntity<Map<String, Object>> result = null;
		try{
			Map<String, Object> rMap = new HashMap<>();
			
			List<BoardVO> bList = null;
			DiaryVO diary = dService.selectDiaryByDno(dno);
			bList = bService.selectBoardByBDate(year, month, dno);
			if(session.getAttribute("auth") == null){
				List<BoardVO> boardList = new ArrayList<>();
				for(BoardVO vo:bList){
					if(vo.isBopen() == true){
						boardList.add(vo);
					}
				}
				rMap.put("bList", boardList);
			}else{
				rMap.put("bList", bList);
			}
			rMap.put("diary", diary);
			result = new ResponseEntity<Map<String, Object>>(rMap, HttpStatus.OK);
		}catch(Exception e){
			e.printStackTrace();
			result = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return result;
	}
	
	@RequestMapping(value="/add.do", method=RequestMethod.GET)
	public String createBoardService2(HttpSession session, Model model, RedirectAttributes rttr, long date){	
		Date today = null;
		try{
			today = new Date(date);
		}catch(Exception e){
			today = new Date();
		}
		
		AuthDTO auth = (AuthDTO) session.getAttribute("auth");
		List<DiaryVO> dList = dService.selectDiaryByUid(auth.getUid());
		if(dList.isEmpty()){
			rttr.addFlashAttribute("result","일기를 작성할 다이어리가 없습니다. 다이어리를 생성해 주세요.");
			rttr.addFlashAttribute("returnTo", "diary/add.do");
			rttr.addFlashAttribute("type", "warning");
			return "redirect:/empty";
		}else{
			model.addAttribute("date", ProjectHaru.dateFormat.format(today));
			model.addAttribute("diary", dList.get(0));
			return "/board/register2";
		}		
	}
	
	@RequestMapping(value="/mod.do/{bno}", method=RequestMethod.GET)
	public String modifyBoardService(HttpSession session, Model model, RedirectAttributes rttr, @PathVariable int bno){	
		try{
			BoardVO board = bService.selectBoardByBno(bno);
			AuthDTO auth = (AuthDTO) session.getAttribute("auth");
			
			List<DiaryVO> dList = dService.selectDiaryByUid(auth.getUid());
			if(dList.isEmpty()){
				rttr.addFlashAttribute("result","일기를 수정할 다이어리가 없습니다. 다이어리를 생성해 주세요.");
				rttr.addFlashAttribute("returnTo", "diary/add.do");
				rttr.addFlashAttribute("type", "warning");
				return "redirect:/empty";
			}else{
				if(dList.get(0).getDno() == board.getDno().getDno()){
					model.addAttribute("board", board);
					return "/board/modify";
				}else{
					rttr.addFlashAttribute("result","일기를 수정할 권한이 없습니다.");
					rttr.addFlashAttribute("returnTo", "board/list.do/"+board.getDno());
					rttr.addFlashAttribute("type", "warning");
					return "redirect:/empty";
				}
				
				
			}		
		}catch(Exception e){
			e.printStackTrace();
			rttr.addFlashAttribute("result","잠시후 다시 시도해 주세요.");
			rttr.addFlashAttribute("type", "error");
			return "redirect:/empty";
		}
		
	}
	
	@RequestMapping(value="/mod", method=RequestMethod.POST)
	public String modifyBoardServicePost(HttpSession session, String date, BoardVO bVO, int diaryNo ,MultipartFile imagefiles, RedirectAttributes rttr){	
		try{
			AuthDTO auth = (AuthDTO) session.getAttribute("auth");
			
			List<DiaryVO> dList = dService.selectDiaryByUid(auth.getUid());
			if(dList.isEmpty()){
				rttr.addFlashAttribute("result","일기를 수정할 다이어리가 없습니다. 다이어리를 생성해 주세요.");
				rttr.addFlashAttribute("returnTo", "diary/add.do");
				rttr.addFlashAttribute("type", "warning");
				return "redirect:/";
			}else{
				if(dList.get(0).getDno() == diaryNo){
					DiaryVO dVo = new DiaryVO();
					dVo.setDno(diaryNo);
					bVO.setDno(dVo);
					String files = setFileList(imagefiles);// 등록된 사진
					if(files != ""){
						deleteFile(bVO);
						bVO.setBpic(files);
					}
					
					if(bVO.getBpic()==""){
						bVO.setBpic(null);
					}
					
					bService.updateBoard(bVO);
					rttr.addFlashAttribute("result","일기를 성공적으로 수정하였습니다.");
					rttr.addFlashAttribute("returnTo", "board/list.do");
					rttr.addFlashAttribute("type", "success");
					return "redirect:/empty";
				}else{
					rttr.addFlashAttribute("result","일기를 수정할 권한이 없습니다.");
					rttr.addFlashAttribute("returnTo", "board/list.do/");
					rttr.addFlashAttribute("type", "warning");
					return "redirect:/empty";
				}
				
				
			}		
		}catch(Exception e){
			e.printStackTrace();
			rttr.addFlashAttribute("result","잠시후 다시 시도해 주세요.");
			rttr.addFlashAttribute("returnTo", "diary/list.do");
			rttr.addFlashAttribute("type", "error");
			return "redirect:/empty";
		}
		
	}
	
	@RequestMapping(value="/del.do",method=RequestMethod.GET)
	public String getAllDel(HttpSession session, RedirectAttributes rttr){//전체 삭제
		try{
			AuthDTO auth = (AuthDTO) session.getAttribute("auth");
			
			List<DiaryVO> dList = dService.selectDiaryByUid(auth.getUid());
			if(dList.isEmpty()){
				rttr.addFlashAttribute("result","일기를 삭제할 다이어리가 없습니다. 다이어리를 생성해 주세요.");
				rttr.addFlashAttribute("returnTo", "diary/add.do");
				rttr.addFlashAttribute("type", "warning");
				return "redirect:/empty";
			}else{
				List<BoardVO> bList = bService.selectAllBoard(dList.get(0).getDno());
				for(BoardVO board : bList){
					deleteFile(board);
					bService.deleteBoard(board.getBno());
				}
				rttr.addFlashAttribute("result", "일기를 모두 삭제되었습니다.");
				rttr.addFlashAttribute("type", "success");
			}			
		}catch(Exception e){
			e.printStackTrace();
			rttr.addFlashAttribute("result", "일기가 삭제되지 못했습니다.");
			rttr.addFlashAttribute("type", "error");
		}
		rttr.addFlashAttribute("returnTo", "board/list.do");
		
		return "redirect:/empty";		
	}
	
	private void deleteFile(BoardVO board) {
		// 실제로 저장 되어있는 썸네일과 사진 삭제
		if(board.getBpic()==null){
			return;
		}
		
		String oPath = board.getOriginalname();
		String tPath = board.getBpic();
		
		File oFile = new File(uploadPath+oPath);
		File tFile = new File(uploadPath+tPath);
		
		if(oFile.exists()){
			oFile.delete();
		}
		if(tFile.exists()){
			tFile.delete();
		}
	}
	
	@RequestMapping(value="del.do",method=RequestMethod.POST)
	public String postSelDel(RedirectAttributes rttr){//선택 삭제
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		try{
			String[] fileList = request.getParameterValues("delFiles");
			for(String file: fileList){
				System.out.println(file);
				BoardVO board = bService.selectBoardByBno(Integer.parseInt(file));				
				deleteFile(board);
				bService.deleteBoard(board.getBno());
			}
			rttr.addFlashAttribute("result", "선택한 일기를 삭제하였습니다.");
			rttr.addFlashAttribute("type", "success");
		}catch(Exception e){
			rttr.addFlashAttribute("result", "선택된 일기가 삭제되지 못했습니다.");
			rttr.addFlashAttribute("type", "error");
		}
		rttr.addFlashAttribute("returnTo", "board/list.do");
		
		return "redirect:/empty";		
	}
	
	
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
	
	@RequestMapping(value="/list/{dno}", method=RequestMethod.GET)
	public String getAllBoardByDno(HttpSession session, Model model, @PathVariable int dno){
		List<BoardVO> bList = null;
		DiaryVO diary = dService.selectDiaryByDno(dno);
		bList = bService.selectAllBoard(dno);
		List<BoardVO> boardList = new ArrayList<>();
		for(BoardVO vo:bList){
			if(vo.isBopen() == true){
				boardList.add(vo);
			}
		}
		model.addAttribute("diary", diary);
		model.addAttribute("bList", boardList);
				
		return "/board/list_final";
	}
	
	@RequestMapping(value="/add", method=RequestMethod.GET)
	public String createBoardService(){
		return "/board/register";
	}
	
	@RequestMapping(value="/add", method=RequestMethod.POST)
	public String createBoardService(HttpSession session, String date, BoardVO bVO, MultipartFile imagefiles, RedirectAttributes rttr){
		
		try{
			Calendar bdate = Calendar.getInstance();
			bdate.setTime(ProjectHaru.dateFormat.parse(date));
			Calendar cal = Calendar.getInstance();
			cal.set(Calendar.YEAR, bdate.get(Calendar.YEAR));
			cal.set(Calendar.MONTH, bdate.get(Calendar.MONTH));
			cal.set(Calendar.DATE, bdate.get(Calendar.DATE));
			bVO.setBdate(cal.getTime());
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
				bVO.setDno(diary);
				bService.insertBoard(bVO);
				rttr.addFlashAttribute("result", "일기를 성공적으로 등록하였습니다.");
				rttr.addFlashAttribute("type", "success");
			}else{
				rttr.addFlashAttribute("result", "[ERROR] 일기를 작성할 다이어리가 존재하지 않습니다.");
			}
			
		}catch(Exception e){
			rttr.addFlashAttribute("result", "일기를 등록하지 못하였습니다.");
			rttr.addFlashAttribute("type", "error");
			e.printStackTrace();
			logger.info(e.getMessage());
		}		
		rttr.addFlashAttribute("returnTo", "board/list.do");
		return "redirect:/empty";
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
	
	@ResponseBody
	@RequestMapping(value="/modifyOpen/{bno}", method=RequestMethod.POST)
	public String changeOpen(@PathVariable int bno, HttpSession session, Model model){		
		String result = "";
		BoardVO bVO = bService.selectBoardByBno(bno);
		bVO.setBopen(!bVO.isBopen());
		
		try{
			bService.updateBoard(bVO);
			result = bVO.isBopen()+"";			
		}catch(Exception e){
			e.printStackTrace();
			result="fail";
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/checkDate/{date}", method=RequestMethod.GET)
	public String changeOpen(@PathVariable String date, HttpSession session, Model model){		
		String result = "";
		AuthDTO auth = (AuthDTO) session.getAttribute("auth");
		List<DiaryVO> dList = dService.selectDiaryByUid(auth.getUid());
		if(!dList.isEmpty()){
			int dno = dList.get(0).getDno();
			Date date2;
			try {
				date2 = ProjectHaru.dateFormat.parse(date);
				BoardVO bVO = bService.selectBoardByDate(date2, dno);
				if(bVO==null){
					result = "success";
				}else{
					result = "fail";
				}
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				result = "datefail";
				e.printStackTrace();
			}			
		}
		return result;
	}
}
