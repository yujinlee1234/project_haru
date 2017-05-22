package kr.or.dgit.haru.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.dgit.haru.domain.BoardVO;
import kr.or.dgit.haru.persistence.BoardDAO;

@Repository
public class BoardServiceImpl implements BoardService {
	private final Logger logger = LoggerFactory.getLogger(BoardServiceImpl.class);
	@Autowired
	private BoardDAO bDao;

	@Override
	public List<BoardVO> selectAllBoard() {
		// TODO Auto-generated method stub
		return bDao.selectAllBoard();
	}

	@Override
	public BoardVO selectBoardByBno(int bno) {
		// TODO Auto-generated method stub
		return bDao.selectBoardByBno(bno);
	}

}
