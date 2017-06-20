package kr.or.dgit.haru.mappers;

import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.dgit.haru.domain.BoardVO;

@Repository
public interface BoardMapper {
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
	/** 게시물 insert
	 * */
	public int insertBoard(BoardVO bVO);
	/**태그 insert
	 * */
	public int insertBoardToday(BoardVO bVO);
	/** 게시물 update
	 * */
	public int updateBoard(BoardVO bVO);
	/**태그 update
	 * */
	public int updateBoardToday(BoardVO bVO);
	/** 게시물 delete
	 * */
	public int deleteBoard(int bno);
	/**태그 delete
	 * */
	public int deleteBoardToday(int bno);
	
	/* 다이어리 삭제 시 사용할 모든 게시물 삭제 Method */
	 
	/** 모든 게시물 delete
	 * */
	public int deleteAllBoard(int dno);
	/** 모든 태그 delete
	 * */
	public int deleteAllBoardToday(int dno);	
	
	/* board_scrap_table 사용 */
	/** 본인이 스크랩한 게시글 목록 return
	 * */
	public List<BoardVO> selectBoardScrap(String uid);//스크랩한 게시글을 가져오기 위해 사용	
	
	/**	스크랩 여부 확인
	 * */
	public BoardVO selectBoardScrapByBno(String uid, int bno);//스크랩한 게시글을 가져오기 위해 사용	
	
	/**	스크랩 
	 * */
	public int insertScrap(String uid, int bno);//스크랩한 게시글을 가져오기 위해 사용	
	
	/**	비스크랩 
	 * */
	public int deleteScrap(String uid, int bno);//스크랩한 게시글을 가져오기 위해 사용
	
	/** 게시물 번호로 게시물 return
	 * */
	public BoardVO selectBoardByDate(Date date, int dno);
	
	public List<BoardVO> selectBoardForAdmin(Date date);
	
}
