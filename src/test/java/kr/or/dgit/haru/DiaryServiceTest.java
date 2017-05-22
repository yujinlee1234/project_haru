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
import kr.or.dgit.haru.domain.DiaryVO;
import kr.or.dgit.haru.persistence.BoardDAOImpl;
import kr.or.dgit.haru.persistence.DiaryDAOImpl;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
public class DiaryServiceTest {
	@Autowired 
	private DiaryDAOImpl dDao;
	
	@Test
	public void selectListTest(){
		List<DiaryVO> dList = dDao.selectAllDiary();
		assertNotNull(dList);
	}
	
	@Test
	public void selectOneTest(){
		DiaryVO diary = dDao.selectDiaryByDno(0);
		assertNull(diary);
	}
}
