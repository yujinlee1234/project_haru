package kr.or.dgit.haru.domain;

import java.util.Date;

import kr.or.dgit.haru.util.ProjectHaru;

/**
 * 회원가입 시  사용할 user 정보를 담을 VO
 * */
public class UserVO {
	/* FIELDS */
	private String uid;
	private String umail;
	private String upass;
	private String upic;
	private String uname;
	private String ujoin;	//가입방법 - 기본 제공 방식/카카오/네이버 등 로그인이나 가입 서비스 제공 시 구분하기 위한 항목
	private boolean uadmin;
	private Date ujoindate;
	private Date uexitdate;
	
	/* GET/SET */
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getUmail() {
		return umail;
	}
	public void setUmail(String umail) {
		this.umail = umail;
	}
	public String getUpass() {
		return upass;
	}
	public void setUpass(String upass) {
		this.upass = upass;
	}
	public String getUpic() {
		return upic;
	}
	public void setUpic(String upic) {
		this.upic = upic;
	}
	public String getUname() {
		return uname;
	}
	public void setUname(String uname) {
		this.uname = uname;
	}
	public String getUjoin() {
		return ujoin;
	}
	public void setUjoin(String ujoin) {
		this.ujoin = ujoin;
	}
	public boolean isUadmin() {
		return uadmin;
	}
	public void setUadmin(boolean uadmin) {
		this.uadmin = uadmin;
	}
	public Date getUjoindate() {
		return ujoindate;
	}
	public void setUjoindate(Date ujoindate) {
		this.ujoindate = ujoindate;
	}
	public Date getUexitdate() {
		return uexitdate;
	}
	public void setUexitdate(Date uexitdate) {
		this.uexitdate = uexitdate;
	}
	/* METHODS */
	@Override
	public String toString() {
		return "UserVO [uid=" + uid + ", umail=" + umail + ", upass=" + upass + ", upic=" + upic + ", uname=" + uname
				+ ", ujoin=" + ujoin + ", uadmin=" + uadmin + ", ujoindate=" + ujoindate + ", uexitdate=" + uexitdate
				+ "]";
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((uid == null) ? 0 : uid.hashCode());
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
		UserVO other = (UserVO) obj;
		if (uid == null) {
			if (other.uid != null)
				return false;
		} else if (!uid.equals(other.uid))
			return false;
		return true;
	}
	/**
	 * 회원 가입 날짜 String으로 Format(yyyy-MM-dd)
	 * */
	public String getUjoindateForm() {
		String result = null;
		if(ujoindate != null){
			result = ProjectHaru.dateFormat.format(ujoindate);
		}
		return result;
	}
	/**
	 * 회원 탈퇴 날짜 String으로 Format(yyyy-MM-dd) - 탈퇴 후 물리 삭제 위해. 기본 타입 = null
	 * */	
	public String getUexitdateForm() {
		String result = null;
		if(uexitdate != null){
			result = ProjectHaru.dateFormat.format(uexitdate);
		}
		return result;
	}
	
	
}
