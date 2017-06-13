package kr.or.dgit.haru.service;

import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.dgit.haru.domain.BoardVO;

@Service
public interface BoardService {
	/* board_table 사용 */
	/** 다이어리의 모든 게시물 return
	 * */
	public List<BoardVO> selectAllBoard(int dno);
	/** 게시물 번호로 게시물 return
	 * */
	public BoardVO selectBoardByBno(int bno);
	/** 년, 월을 변수로 하여 해당 년, 월에 작성된 게시물 return
	 * */
	public List<BoardVO> selectBoardByBDate(int year, int month, int dno);//다이어리를 년, 월 기준으로 검색
	
	public void insertBoard(BoardVO bVO);

	public void updateBoard(BoardVO bVO);
	
	public void deleteBoard(int bno);
	
	/* 다이어리 삭제 시 사용할 모든 게시물 삭제 Method */
	public void deleteAllBoard(int dno);
	
	/* board_scrap_table 사용 */
	public List<BoardVO> selectBoardScrap(String uid);//스크랩한 게시글을 가져오기 위해 사용

	public BoardVO selectBoardByDate(Date date, int dno);
}
