package kr.or.dgit.haru.domain;

import java.util.Date;

import kr.or.dgit.haru.util.ProjectHaru;
/**
 * 다이어리 글 작성을 위한 상위 Category의 Diary Object
 * */
public class DiaryVO {
	/* FIELDS */
	private int dno;
	private String dtitle;
	private String dpic;	//대표사진 경로
	private Date dDate;		//다이어리 생성 날짜
	private boolean dOpen;	//다이어리 전체 공개 여부 true=공개, false=비공개
	/* GET/SET */
	public int getDno() {
		return dno;
	}
	public void setDno(int dno) {
		this.dno = dno;
	}
	public String getDtitle() {
		return dtitle;
	}
	public void setDtitle(String dtitle) {
		this.dtitle = dtitle;
	}
	public String getDpic() {
		return dpic;
	}
	public void setDpic(String dpic) {
		this.dpic = dpic;
	}
	public Date getdDate() {
		return dDate;
	}
	public void setdDate(Date dDate) {
		this.dDate = dDate;
	}
	public boolean isdOpen() {
		return dOpen;
	}
	public void setdOpen(boolean dOpen) {
		this.dOpen = dOpen;
	}
	/* MEHTODS */
	@Override
	public String toString() {
		return "Diary [dno=" + dno + ", dtitle=" + dtitle + ", dpic=" + dpic + ", dDate=" + dDate + ", dOpen=" + dOpen
				+ "]";
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + dno;
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
		DiaryVO other = (DiaryVO) obj;
		if (dno != other.dno)
			return false;
		return true;
	}
	/**
	 * 다이어리 생성 날짜 String으로 Format(yyyy-MM-dd)
	 * */
	public String getdDateForm() {
		return ProjectHaru.dateFormat.format(dDate);
	}
	/**
	 * 다이어리 생성 날짜 String으로 Format(yyyy-MM-dd a HH:mm)
	 * */
	public String getdDateTimeForm() {
		return ProjectHaru.dateTimeFormat.format(dDate);
	}
}
