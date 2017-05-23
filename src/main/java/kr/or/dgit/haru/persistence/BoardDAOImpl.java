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
// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	@Override
	public int selectBoardLike(int bno) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<AuthDTO> selectBoardLikeUser(int bno) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<BoardVO> selectBoardScrap(int bno) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<AuthDTO> selectBoardScrapUser(int bno) {
		// TODO Auto-generated method stub
		return null;
	}

}
