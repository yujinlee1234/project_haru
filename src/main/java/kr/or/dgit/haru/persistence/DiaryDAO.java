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
	/** 회원 아이디를 기준으로 본인이 스크랩한 다이어리 return 
	 * */
	public List<DiaryVO> selectScrapedDiary(String uid);
	
	/** Diary insert
	 * */
	public void insertDiary(DiaryVO dVO);
	
	/** Diary update
	 * */
	public void updateDiary(DiaryVO dVO);
	
	/** Diary delete
	 * */
	public void deleteDiary(int dno);
	/** 회원별 마이 다이어리 화면 구성
	 * */
	public List<DiaryVO> selectDiaryByUid(String uid);
	
	/** 다이 어리 권한 부여 - ver.1 각 회원당 하나의 일기만 작성 가능 (향후 회원당 여러개의 일기, 여러명이 함께쓰는 일기 등을 위해 auth table 유지 필요)
	 * */
	public void insertDiaryAuth(Map<String, Object> aMap);
	/** 다이 어리 권한 삭제 - ver.1 각 회원당 하나의 일기만 작성 가능 - 삭제시 권한도 함께 삭제 (향후 회원당 여러개의 일기, 여러명이 함께쓰는 일기 등을 위해 auth table 유지 필요)
	 * */
	public void deleteDiaryAuth(Map<String, Object> aMap);
	
}
