package kr.or.dgit.haru.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.dgit.haru.domain.BoardVO;
import kr.or.dgit.haru.domain.DiaryVO;

@Repository
public class DiaryDAOImpl implements DiaryDAO {
	private final String namespace = "kr.or.dgit.haru.mapper.DiaryMapper";
	
	@Autowired
	private SqlSession session;
	
	@Override
	public List<DiaryVO> selectAllDiary() {
		// TODO Auto-generated method stub
		return session.selectList(namespace+".selectAllDiary");
	}

	@Override
	public DiaryVO selectDiaryByDno(int dno) {
		// TODO Auto-generated method stub
		return session.selectOne(namespace+".selectDiaryByDno", dno);
	}

}
