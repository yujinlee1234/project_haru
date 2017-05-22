package kr.or.dgit.haru.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.or.dgit.haru.domain.DiaryVO;

@Repository
public interface DiaryDAO {
	
	public List<DiaryVO> selectAllDiary();
	
	public DiaryVO selectDiaryByDno(int dno);
	
}
