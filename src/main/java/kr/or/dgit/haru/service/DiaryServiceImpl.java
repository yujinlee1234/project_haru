package kr.or.dgit.haru.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.dgit.haru.domain.DiaryVO;
import kr.or.dgit.haru.persistence.DiaryDAO;

@Service
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

	@Override
	public List<DiaryVO> selectScrapedDiary(String uid) {
		// TODO Auto-generated method stub
		return dDao.selectScrapedDiary(uid);
	}

	@Transactional
	@Override
	public void insertDiary(String uid, DiaryVO dVO) {
		// TODO Auto-generated method stub
		try{
			int result = dDao.insertDiary(dVO);
			if(result > 0){
				int dno = dDao.lastInsertedID();
				dDao.insertDiaryAuth(uid, dno);
			}
		}catch(Exception e){
			logger.warn("insertDiary - "+e.getMessage());
		}
	}

	@Override
	public void updateDiary(DiaryVO dVO) {
		// TODO Auto-generated method stub
		try{
			dDao.updateDiary(dVO);				
		}catch(Exception e){
			logger.warn("updateDiary - "+e.getMessage());
		}
		
	}
	@Transactional
	@Override
	public void deleteDiary(String uid, int dno) {
		try{
			dDao.deleteDiaryAuth(uid, dno);	
			dDao.deleteDiary(dno);
		}catch(Exception e){
			logger.warn("deleteDiary - "+e.getMessage());
		}
	}

	@Override
	public List<DiaryVO> selectDiaryByUid(String uid) {
		// TODO Auto-generated method stub
		return dDao.selectDiaryByUid(uid);
	}



}
