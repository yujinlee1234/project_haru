package kr.or.dgit.haru.domain;

import java.util.Date;

import kr.or.dgit.haru.util.ProjectHaru;
/**
 * 다이어리 게시글인 Board Object
 * */
public class BoardVO {
	/* FIELDS */
	private int bno;
	private String bpic;
	private String bcontent;
	private  Date bdate;	//게시글 작성 날짜
	private boolean bopen;	//게시글의 공개 여부를 boolean 형태로 결정 true-공개, false-비공개
	private boolean bcal;	//캘린더에 다이어리를 노출시킬지 여부를 boolean 형태로 결정 true-노출, false-숨기기
	private DiaryVO diary;
	/* METHODS */
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public String getBpic() {
		return bpic;
	}
	public void setBpic(String bpic) {
		this.bpic = bpic;
	}
	public String getBcontent() {
		return bcontent;
	}
	public void setBcontent(String bcontent) {
		this.bcontent = bcontent;
	}
	public Date getBdate() {
		return bdate;
	}
	public void setBdate(Date bdate) {
		this.bdate = bdate;
	}
	public boolean isBopen() {
		return bopen;
	}
	public void setBopen(boolean bopen) {
		this.bopen = bopen;
	}
	public boolean isBcal() {
		return bcal;
	}
	public void setBcal(boolean bcal) {
		this.bcal = bcal;
	}
	public DiaryVO getDiary() {
		return diary;
	}
	public void setDiary(DiaryVO diary) {
		this.diary = diary;
	}
	/* METHODS */
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + bno;
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		BoardVO other = (BoardVO) obj;
		if (bno != other.bno)
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "BoardVO [bno=" + bno + ", bpic=" + bpic + ", bcontent=" + bcontent + ", bdate=" + bdate + ", bopen="
				+ bopen + ", bcal=" + bcal + ", diary=" + diary + "]";
	}	
	/**
	 * 다이어리 작성 날짜 String으로 Format(yyyy-MM-dd)
	 * */
	public String getBdateForm() {
		return ProjectHaru.dateFormat.format(bdate);
	}
	/**
	 * 다이어리 작성 날짜 String으로 Format(yyyy-MM-dd a HH:mm)
	 * */
	public String getBdateTimeForm() {
		return ProjectHaru.dateTimeFormat.format(bdate);
	}
}
