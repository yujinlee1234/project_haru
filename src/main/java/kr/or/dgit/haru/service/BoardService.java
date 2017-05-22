package kr.or.dgit.haru.service;

import java.util.List;

import org.springframework.stereotype.Service;

import kr.or.dgit.haru.domain.BoardVO;

@Service
public interface BoardService {
	public List<BoardVO> selectAllBoard();
	
	public BoardVO selectBoardByBno(int bno);
}
