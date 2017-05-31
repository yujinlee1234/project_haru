package kr.or.dgit.haru.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.dgit.haru.domain.AuthDTO;
import kr.or.dgit.haru.domain.UserVO;
import kr.or.dgit.haru.persistence.UserDAO;

@Service
public class UserServiceImpl implements UserService {
	private final Logger logger = LoggerFactory.getLogger(UserServiceImpl.class);
	
	@Autowired
	private UserDAO uDao;
	
	@Override
	public List<AuthDTO> selectBoardLikeUser(int bno) {
		// TODO Auto-generated method stub
		return uDao.selectBoardLikeUser(bno);
	}

	@Override
	public List<AuthDTO> selectBoardScrapUser(int bno) {
		// TODO Auto-generated method stub
		return uDao.selectBoardScrapUser(bno);
	}

	@Override
	public List<UserVO> selectAllUser() {
		// TODO Auto-generated method stub
		return uDao.selectAllUser();
	}

	@Override
	public AuthDTO login(String uid, String upass) {
		// TODO Auto-generated method stub
		return uDao.login(uid, upass);
	}

	@Override
	public void insertUser(UserVO uVO) {
		// TODO Auto-generated method stub
		uDao.insertUser(uVO);
	}

	@Override
	public void updateUser(UserVO uVO) {
		// TODO Auto-generated method stub
		uDao.updateUser(uVO);
	}

	@Override
	public void exitUser(String uid) {
		// TODO Auto-generated method stub
		uDao.exitUser(uid);
	}

	@Override
	public void deleteUser(String uid) {
		// TODO Auto-generated method stub
		uDao.deleteUser(uid);
	}

	@Override
	public AuthDTO checkUser(String uid) {
		// TODO Auto-generated method stub
		return uDao.checkUser(uid);
	}

}
