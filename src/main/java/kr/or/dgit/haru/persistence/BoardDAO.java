package kr.or.dgit.haru.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.dgit.haru.domain.AuthDTO;
import kr.or.dgit.haru.domain.BoardVO;

@Repository
public interface BoardDAO {
	/* board_table 사용 */
	public List<BoardVO> selectAllBoard();
	public BoardVO selectBoardByBno(int bno);
	
	/* board_like_table 사용 */
	public int selectBoardLike(int bno);//좋아요 수를 가져오기 위해 사용
	public List<AuthDTO> selectBoardLikeUser(int bno);
	
	/* board_scrap_table 사용 */
	public List<BoardVO> selectBoardScrap(int bno);//스크랩한 게시글을 가져오기 위해 사용
	public List<AuthDTO> selectBoardScrapUser(int bno);
	
	
	
}
