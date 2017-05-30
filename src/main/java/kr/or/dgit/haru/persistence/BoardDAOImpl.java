package kr.or.dgit.haru.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	public List<BoardVO> selectAllBoard(int dno) {
		// TODO Auto-generated method stub
		return session.selectList(namespace+".selectAllBoard", dno);
	}

	@Override
	public BoardVO selectBoardByBno(int bno) {
		// TODO Auto-generated method stub
		return session.selectOne(namespace+".selectBoardByBno", bno);
	}
	
	@Override
	public List<BoardVO> selectBoardByBDate(int year, int month) {
		// TODO Auto-generated method stub
		Map<String, Integer> dMap = new HashMap<>();
		dMap.put("year", year);
		dMap.put("month", month);
		return session.selectList(namespace+".selectBoardByBDate", dMap);
	}
	
	@Override
	public int insertBoard(BoardVO bVO) {
		// TODO Auto-generated method stub
		return session.insert(namespace+".insertBoard", bVO);
	}

// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	@Override
	public List<BoardVO> selectBoardScrap(String uid) {
		// TODO Auto-generated method stub
		return session.selectList(namespace+".selectBoardScrap", uid);
	}

	@Override
	public int insertBoardToday(BoardVO bVO) {
		// TODO Auto-generated method stub
		return session.insert(namespace+".insertBoardToday", bVO);
	}

	@Override
	public int updateBoard(BoardVO bVO) {
		// TODO Auto-generated method stub
		return session.update(namespace+".updateBoard", bVO);
	}

	@Override
	public int updateBoardToday(BoardVO bVO) {
		// TODO Auto-generated method stub
		return session.update(namespace+".updateBoardToday", bVO);
	}

	@Override
	public int deleteBoard(int bno) {
		// TODO Auto-generated method stub
		return session.delete(namespace+".deleteBoard", bno);
	}

	@Override
	public int deleteBoardToday(int bno) {
		// TODO Auto-generated method stub
		return session.delete(namespace+".deleteBoardToday", bno);
	}

	@Override
	public int deleteAllBoard(int dno) {
		// TODO Auto-generated method stub
		return session.delete(namespace+".deleteAllBoard", dno);
	}

	@Override
	public int deleteAllBoardToday(int dno) {
		// TODO Auto-generated method stub
		return session.delete(namespace+".deleteAllBoardToday", dno);
	}

}
