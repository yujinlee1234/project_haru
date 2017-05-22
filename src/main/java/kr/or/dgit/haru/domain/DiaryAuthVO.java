package kr.or.dgit.haru.domain;

import java.util.List;
/**
 * 사용자 별 생성 다이어리를 List형태로 가지고 있는 Object
 * */
public class DiaryAuthVO {
	/* FIELDS */
	private String uid;
	private List<DiaryVO> diary;
	/* GET/SET */
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public List<DiaryVO> getDiary() {
		return diary;
	}
	public void setDiary(List<DiaryVO> diary) {
		this.diary = diary;
	}	
	/* METHODS */
	@Override
	public String toString() {
		return "DiaryAuthVO [uid=" + uid + ", diary=" + diary + "]";
	}
	
	
}
