package kr.or.dgit.haru.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.dgit.haru.domain.BoardVO;
import kr.or.dgit.haru.domain.DiaryVO;
import kr.or.dgit.haru.persistence.BoardDAO;
import kr.or.dgit.haru.persistence.DiaryDAO;

@Repository
public class DiaryServiceImpl implements DiaryService {
	private final Logger logger = LoggerFactory.getLogger(DiaryServiceImpl.class);
	@Autowired
	private DiaryDAO dDao;

	@Override
	public List<DiaryVO> selectAllDiary() {
		// TODO Auto-generated method stub
		return dDao.selectAllDiary();
	}

	@Override
	public DiaryVO selectDiaryByDno(int dno) {
		// TODO Auto-generated method stub
		return dDao.selectDiaryByDno(dno);
	}

}
