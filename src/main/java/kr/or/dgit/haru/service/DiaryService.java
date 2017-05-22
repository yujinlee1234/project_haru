package kr.or.dgit.haru.service;

import java.util.List;

import org.springframework.stereotype.Service;

import kr.or.dgit.haru.domain.BoardVO;
import kr.or.dgit.haru.domain.DiaryVO;

@Service
public interface DiaryService {
	public List<DiaryVO> selectAllDiary();
	
	public DiaryVO selectDiaryByDno(int dno);
}
