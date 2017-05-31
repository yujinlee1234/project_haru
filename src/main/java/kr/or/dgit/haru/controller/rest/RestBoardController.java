package kr.or.dgit.haru.controller.rest;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
import kr.or.dgit.haru.domain.BoardVO;
import kr.or.dgit.haru.domain.DiaryVO;
import kr.or.dgit.haru.service.BoardService;
import kr.or.dgit.haru.service.DiaryService;
import kr.or.dgit.haru.util.HaruTokenService;

@Controller
@RequestMapping(value="/rest/board")
public class RestBoardController {
	private final Logger logger = LoggerFactory.getLogger(RestBoardController.class);
	
	@Autowired
	private DiaryService dService;
	
	@Inject
	private BoardService bService;
	
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
	public ResponseEntity<Map<String, Object>> createBoardService(BoardVO bVO, String imagefiles, String token){
		
		
		ResponseEntity<Map<String, Object>> result = null;
		Map<String, Object> rMap = new HashMap<>();
		try{
			AuthDTO auth = (AuthDTO) session.getAttribute("auth");
			List<DiaryVO> dList = dService.selectDiaryByUid(auth.getUid());
			if(dList.size()>0){
				DiaryVO diary = dList.get(0);
				bVO.setDno(diary.getDno());
				bService.insertBoard(bVO);
				rMap.put("Result", "success");
				result = new ResponseEntity<>(rMap, HttpStatus.OK);
			}else{
				rMap.put("Result", "fail");
				result = new ResponseEntity<>(rMap, HttpStatus.BAD_REQUEST);
			}
			
		}catch(Exception e){
			rMap.put("Result", "fail");
			result = new ResponseEntity<>(rMap, HttpStatus.BAD_REQUEST);
		}		
		System.out.println("result : "+result.getBody());
		return result;
	}
	
}
