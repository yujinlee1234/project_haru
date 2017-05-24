package kr.or.dgit.haru.persistence;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.dgit.haru.domain.AuthDTO;
import kr.or.dgit.haru.domain.UserVO;

@Repository
public class UserDAOImpl implements UserDAO{
	private final String namespace = "kr.or.dgit.haru.mapper.UserMapper";
	
	@Autowired
	private SqlSession session;

	@Override
	public List<AuthDTO> selectBoardLikeUser(int bno) {
		// TODO Auto-generated method stub
		return session.selectList(namespace+".selectBoardLikeUser", bno);
	}

	@Override
	public List<AuthDTO> selectBoardScrapUser(int bno) {
		// TODO Auto-generated method stub
		return session.selectList(namespace+".selectBoardScrapUser", bno);
	}

	@Override
	public List<UserVO> selectAllUser() {
		// TODO Auto-generated method stub
		return session.selectList(namespace+".selectAllUser");
	}

	@Override
	public AuthDTO login(Map<String, Object> lMap) {
		// TODO Auto-generated method stub
		return session.selectOne(namespace+".login", lMap);
	}

	@Override
	public void insertUser(UserVO uVO) {
		// TODO Auto-generated method stub
		session.insert(namespace+".insertUser", uVO);
	}

	@Override
	public void updateUser(UserVO uVO) {
		// TODO Auto-generated method stub
		session.update(namespace+".updateUser", uVO);
	}

	@Override
	public void exitUser(String uid) {
		// TODO Auto-generated method stub
		session.update(namespace+".exitUser", uid);
	}

	@Override
	public void deleteUser(String uid) {
		// TODO Auto-generated method stub
		session.delete(namespace+".deleteUser", uid);
	}

}
