package kr.or.dgit.haru.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.dgit.haru.domain.BoardVO;
import kr.or.dgit.haru.persistence.BoardDAO;

@Service
public class BoardServiceImpl implements BoardService {
	private final Logger logger = LoggerFactory.getLogger(BoardServiceImpl.class);
	@Autowired
	private BoardDAO bDao;

	@Override
	public List<BoardVO> selectAllBoard(int dno) {
		// TODO Auto-generated method stub
		return bDao.selectAllBoard(dno);
	}

	@Override
	public BoardVO selectBoardByBno(int bno) {
		// TODO Auto-generated method stub
		return bDao.selectBoardByBno(bno);
	}

	@Override
	public List<BoardVO> selectBoardByBDate(int year, int month) {
		// TODO Auto-generated method stub
		return bDao.selectBoardByBDate(year, month);
	}

	@Transactional
	@Override
	public void insertBoard(BoardVO bVO) {
		// TODO Auto-generated method stub
		try{
			int result = bDao.insertBoard(bVO);
			if(result>0){
				int bno = bVO.getBno();
				if(bno>0){
					bDao.insertBoardToday(bVO);
				}
			}
		}catch(Exception e){
			logger.warn("insertBoard - " + e.getMessage());
		}
		
	}
	@Transactional
	@Override
	public void updateBoard(BoardVO bVO) {
		// TODO Auto-generated method stub
		try{
			bDao.updateBoard(bVO);
			bDao.updateBoardToday(bVO);
		}catch(Exception e){
			logger.warn("updateBoard - " + e.getMessage());
		}
	}
	@Transactional
	@Override
	public void deleteBoard(int bno) {
		// TODO Auto-generated method stub
		try{
			bDao.deleteBoardToday(bno);
			bDao.deleteBoard(bno);
		}catch(Exception e){
			logger.warn("deleteBoard - " + e.getMessage());
		}
	}
	@Transactional
	@Override
	public void deleteAllBoard(int dno) {
		// TODO Auto-generated method stub
		try{
			bDao.deleteAllBoardToday(dno);
			bDao.deleteAllBoard(dno);
		}catch(Exception e){
			logger.warn("deleteAllBoard - " + e.getMessage());
		}
	}

	@Override
	public List<BoardVO> selectBoardScrap(String uid) {
		// TODO Auto-generated method stub
		return bDao.selectBoardScrap(uid);
	}

}
