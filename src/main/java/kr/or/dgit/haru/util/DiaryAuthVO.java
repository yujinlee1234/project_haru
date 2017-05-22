package kr.or.dgit.haru.util;

import java.util.List;
/**
 * 사용자 별 생성 다이어리를 List형태로 가지고 있는 Object
 * */
public class DiaryAuthVO {
	/* FIELDS */
	private String uid;
	private List<Diary> diary;
	/* GET/SET */
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public List<Diary> getDiary() {
		return diary;
	}
	public void setDiary(List<Diary> diary) {
		this.diary = diary;
	}	
	/* METHODS */
	@Override
	public String toString() {
		return "DiaryAuthVO [uid=" + uid + ", diary=" + diary + "]";
	}
	
	
}
