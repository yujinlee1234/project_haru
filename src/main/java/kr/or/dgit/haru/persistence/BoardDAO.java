package kr.or.dgit.haru.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.dgit.haru.domain.BoardVO;

@Repository
public interface BoardDAO {
	
	public List<BoardVO> selectAllBoard();
	
	public BoardVO selectBoardByBno(int bno);
	
}
