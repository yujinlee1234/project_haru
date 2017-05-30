package kr.or.dgit.haru.persistence;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.or.dgit.haru.domain.DiaryVO;

@Repository
public interface DiaryDAO {
	
	/** 각 다이어리의 가장 최신 게시글의 시간을 기준으로 내림차순한 결과 return - test필요 Data가 많아 졌을 때 처리 방법 고민필요
	 * */
	public List<DiaryVO> selectAllDiary();
	
	/** 다이어리 번호로 다이어리 return
	 * */
	public DiaryVO selectDiaryByDno(int dno);
	
	/** 회원별 마이 다이어리 화면 구성
	 * */
	public List<DiaryVO> selectDiaryByUid(String uid);
	
	/** 회원 아이디를 기준으로 본인이 스크랩한 다이어리 return 
	 * */
	public List<DiaryVO> selectScrapedDiary(String uid);
	
	/** Diary insert
	 * */
	public int insertDiary(DiaryVO dVO);
	
	/** Diary update
	 * */
	public int updateDiary(DiaryVO dVO);
	
	/** Diary delete
	 * */
	public int deleteDiary(int dno);	
}
