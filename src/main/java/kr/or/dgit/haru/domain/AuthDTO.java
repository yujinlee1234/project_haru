package kr.or.dgit.haru.domain;

public class AuthDTO {
	//로그인됐을 때 생성할 Object - 사용자 id, 관리자 여부, 프로필 사진경로 포함
	/* FILEDS */
	private String uid;
	private boolean uadmin;
	private String upic;
	/* GET/SET */
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public boolean isUadmin() {
		return uadmin;
	}
	public void setUadmin(boolean uadmin) {
		this.uadmin = uadmin;
	}
	public String getUpic() {
		return upic;
	}
	public void setUpic(String upic) {
		this.upic = upic;
	}
	/* METHODS */
	@Override
	public String toString() {
		return "AuthDTO [uid=" + uid + ", uadmin=" + uadmin + ", upic=" + upic + "]";
	}
	
	
}
