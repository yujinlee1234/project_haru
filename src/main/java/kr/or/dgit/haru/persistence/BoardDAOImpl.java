package kr.or.dgit.haru.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.dgit.haru.domain.AuthDTO;
import kr.or.dgit.haru.domain.BoardVO;

@Repository
public class BoardDAOImpl implements BoardDAO {
	private final String namespace = "kr.or.dgit.haru.mapper.BoardMapper";
	
	@Autowired
	private SqlSession session;
	
	@Override
	public List<BoardVO> selectAllBoard() {
		// TODO Auto-generated method stub
		return session.selectList(namespace+".selectAllBoard");
	}

	@Override
	public BoardVO selectBoardByBno(int bno) {
		// TODO Auto-generated method stub
		return session.selectOne(namespace+".selectBoardByBno", bno);
	}
	
	@Override
	public List<BoardVO> selectBoardByBDate(int year, int month) {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public void insertBoard(BoardVO bVO) {
		// TODO Auto-generated method stub
		session.insert(namespace+".insertBoard", bVO);
	}

// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	@Override
	public int selectBoardLike(int bno) {
		// TODO Auto-generated method stub
		
		return session.selectOne(namespace+".selectBoardLike", bno);
	}

	@Override
	public List<BoardVO> selectBoardScrap(String uid) {
		// TODO Auto-generated method stub
		return session.selectList(namespace+".selectBoardScrap", uid);
	}

	@Override
	public void insertBoardToday(BoardVO bVO) {
		// TODO Auto-generated method stub
		session.insert(namespace+".insertBoardToday", bVO);
	}

	@Override
	public void updateBoard(BoardVO bVO) {
		// TODO Auto-generated method stub
		session.update(namespace+".updateBoard", bVO);
	}

	@Override
	public void updateBoardToday(BoardVO bVO) {
		// TODO Auto-generated method stub
		session.update(namespace+".updateBoardToday", bVO);
	}

	@Override
	public void deleteBoard(int bno) {
		// TODO Auto-generated method stub
		session.delete(namespace+".deleteBoard", bno);
	}

	@Override
	public void deleteBoardToday(int bno) {
		// TODO Auto-generated method stub
		session.delete(namespace+".deleteBoardToday", bno);
	}

	@Override
	public void deleteAllBoard() {
		// TODO Auto-generated method stub
		session.delete(namespace+".deleteAllBoard");
	}

	@Override
	public void deleteAllBoardToday() {
		// TODO Auto-generated method stub
		session.delete(namespace+".deleteAllBoardToday");
	}
}
