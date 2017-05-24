package kr.or.dgit.haru.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.dgit.haru.domain.BoardVO;

@Repository
public interface BoardDAO {
	/* board_table 사용 */
	/** 다이어리의 모든 게시물 return
	 * */
	public List<BoardVO> selectAllBoard();
	/** 게시물 번호로 게시물 return
	 * */
	public BoardVO selectBoardByBno(int bno);
	/** 년, 월을 변수로 하여 해당 년, 월에 작성된 게시물 return
	 * */
	public List<BoardVO> selectBoardByBDate(int year, int month);//다이어리를 년, 월 기준으로 검색
	/** 게시물 insert
	 * */
	public void insertBoard(BoardVO bVO);
	/**태그 insert
	 * */
	public void insertBoardToday(BoardVO bVO);
	/** 게시물 update
	 * */
	public void updateBoard(BoardVO bVO);
	/**태그 update
	 * */
	public void updateBoardToday(BoardVO bVO);
	/** 게시물 delete
	 * */
	public void deleteBoard(int bno);
	/**태그 delete
	 * */
	public void deleteBoardToday(int bno);
	
	/* 다이어리 삭제 시 사용할 모든 게시물 삭제 Method */
	 
	/** 모든 게시물 delete
	 * */
	public void deleteAllBoard();
	/** 모든 태그 delete
	 * */
	public void deleteAllBoardToday();
	
	/* board_like_table 사용 */
	/** 좋아요 수 return
	 * */
	public int selectBoardLike(int bno);//좋아요 수를 가져오기 위해 사용
	
	
	/* board_scrap_table 사용 */
	/** 본인이 스크랩한 게시글 목록 return
	 * */
	public List<BoardVO> selectBoardScrap(String uid);//스크랩한 게시글을 가져오기 위해 사용
	
	
	
	
}
