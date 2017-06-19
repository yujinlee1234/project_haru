package kr.or.dgit.haru;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.or.dgit.haru.domain.BoardVO;
import kr.or.dgit.haru.mappers.BoardMapperImpl;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
public class BoardServiceTest {
	@Autowired 
	private BoardMapperImpl bDao;
	
	@Test
	public void selectListTest(){
/*//		List<BoardVO> bList = bDao.selectAllBoard();
//		assertNotNull(bList);
*/	}
	
	@Test
	public void selectOneTest(){
		BoardVO board = bDao.selectBoardByBno(0);
		assertNull(board);
	}
}
