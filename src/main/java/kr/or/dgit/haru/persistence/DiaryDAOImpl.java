package kr.or.dgit.haru.persistence;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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

	@Override
	public List<DiaryVO> selectScrapedDiary(String uid) {
		// TODO Auto-generated method stub
		return session.selectList(namespace+".selectScrapedDiary", uid);
	}

	@Override
	public void insertDiary(DiaryVO dVO) {
		// TODO Auto-generated method stub
		session.insert(namespace+".insertDiary", dVO);
	}

	@Override
	public void updateDiary(DiaryVO dVO) {
		// TODO Auto-generated method stub
		session.update(namespace+".updateDiary", dVO);
	}

	@Override
	public void deleteDiary(int dno) {
		// TODO Auto-generated method stub
		session.delete(namespace+".deleteDiary", dno);
	}

	@Override
	public List<DiaryVO> selectDiaryByUid(String uid) {
		// TODO Auto-generated method stub
		return session.selectList(namespace+".selectDiaryByUid", uid);
	}

	@Override
	public void insertDiaryAuth(Map<String, Object> aMap) {
		// TODO Auto-generated method stub
		session.insert(namespace+".insertDiaryAuth", aMap);
	}

	@Override
	public void deleteDiaryAuth(Map<String, Object> aMap) {
		// TODO Auto-generated method stub
		session.delete(namespace+".deleteDiaryAuth", aMap);
	}

}
