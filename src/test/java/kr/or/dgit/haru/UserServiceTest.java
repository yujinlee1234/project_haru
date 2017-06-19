package kr.or.dgit.haru;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.or.dgit.haru.domain.AuthDTO;
import kr.or.dgit.haru.mappers.UserMapperImpl;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
public class UserServiceTest {
	@Autowired
	private UserMapperImpl uDao;
	
	@Test
	public void loginTest(){
		
		AuthDTO auth = uDao.login("admin", "admin");
		assertNotNull(auth);
	}

}
