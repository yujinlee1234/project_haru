package kr.or.dgit.haru.mappers;

import java.util.List;
import java.util.Map;

import kr.or.dgit.haru.domain.AuthDTO;
import kr.or.dgit.haru.domain.UserVO;

public interface UserMapper {
	/* board_like_table 사용 */
	public List<AuthDTO> selectBoardLikeUser(int bno);
	
	/* board_scrap_table 사용 */
	public List<AuthDTO> selectBoardScrapUser(int bno);//userDAO로 이동요망
	
	/**
	 * 관리자를 위한 모든 회원의 정보 확인
	 * */
	public List<UserVO> selectAllUser();
	
	/**
	 * 회원 정보 페이지
	 * */
	public UserVO selectUser(String uid);
	
	/** 로그인 시 사용할 함수
	 * 	사용자가 입력한 ID와 PASSWORD 값을 바탕으로 AuthDTO를 반환하게 하여 null이 아닐 경우 login
	 * */
	public AuthDTO login(String uid, String upass);
	
	/** 회원가입 시 사용할 함수 
	 * */
	public void insertUser(UserVO uVO);
	
	/** 회원 정보 수정시 사용할 함수
	 * */
	public void updateUser(UserVO uVO);
	
	/** 회원 탈퇴 시 사용할 함수
	 * */
	public void exitUser(String uid);
	
	/** 회원의 물리적 삭제를 위해 사용할 함수
	 * */
	public void deleteUser(String uid);
	
	/**아이디 중복 체크를 위한 함수
	 * */
	public AuthDTO checkUser(String uid);
	
}
