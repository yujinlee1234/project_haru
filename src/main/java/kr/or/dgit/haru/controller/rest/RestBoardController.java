package kr.or.dgit.haru.controller.rest;

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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.or.dgit.haru.domain.AuthDTO;
import kr.or.dgit.haru.domain.BoardVO;
import kr.or.dgit.haru.domain.DiaryVO;
import kr.or.dgit.haru.service.BoardService;
import kr.or.dgit.haru.service.DiaryService;
import kr.or.dgit.haru.util.HaruTokenService;
import kr.or.dgit.haru.util.UploadFileUtils;

@Controller
@RequestMapping(value="/rest/board")
public class RestBoardController {
	private final Logger logger = LoggerFactory.getLogger(RestBoardController.class);
	
	@Autowired
	private DiaryService dService;
	
	@Inject
	private BoardService bService;
	
	@Resource(name="uploadPath")
	private String uploadPath;
	
	/**각 다이어리별 게시글 가져오는 메소드 현재는 회원 당 하나의 다이어리만 가능 하므로 
	 * 회원의 아이디를 통해 다이어리 dno 가져옴
	 * */
	@ResponseBody
	@RequestMapping(value="", method=RequestMethod.POST)
	public ResponseEntity<List<BoardVO>> getAllBoardByDno(String token){
		AuthDTO auth = (AuthDTO) HaruTokenService.decodeToAuth(token);
	
		ResponseEntity<List<BoardVO>> result = null;
		List<DiaryVO> dList = dService.selectDiaryByUid(auth.getUid());
		List<BoardVO> bList = null;
		if(!dList.isEmpty()){
			bList = bService.selectAllBoard(dList.get(0).getDno());
		}
		result = new ResponseEntity<List<BoardVO>>(bList, HttpStatus.OK);
		System.out.println("result : "+result.getBody());
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/add", method=RequestMethod.POST)
	public String createBoardService(BoardVO bVO, MultipartFile imagefiles, String token){		
		String result = null;
		
		try{
			AuthDTO auth = (AuthDTO) HaruTokenService.decodeToAuth(token);
			
			List<DiaryVO> dList = dService.selectDiaryByUid(auth.getUid());
			if(dList.size()>0){
				DiaryVO diary = dList.get(0);
				bVO.setDno(diary);
				String thumb = UploadFileUtils.uploadFile(uploadPath, bVO.getBpic(), imagefiles.getBytes());
				bVO.setBpic(thumb);
				
				bService.insertBoard(bVO);
				
				result = "일기를 성공적으로 등록하였습니다.";
			}else{
				
				result = "일기를 등록할 다이어리가 존재하지 않습니다.";
			}
			
		}catch(Exception e){
			result = "[ERROR] 오류가 발생하여 등록하지 못했습니다.";
		}		
		System.out.println("result : "+result);
		return result;
	}
	
	/**
	 * 특정 게시글 선택시 보이는 화면구성을 위한 함수 bno구분을 어떻게 할 것인지?
	 * */
	@ResponseBody
	@RequestMapping(value="/{bno}", method=RequestMethod.POST)
	public ResponseEntity<BoardVO> getBoardByBno(String token, @PathVariable int bno){
		ResponseEntity<BoardVO> result = null;
		BoardVO	bList = bService.selectBoardByBno(bno);
		result = new ResponseEntity<BoardVO>(bList, HttpStatus.OK);
		System.out.println("result : "+result.getBody());
		
		return result;
	}
}
