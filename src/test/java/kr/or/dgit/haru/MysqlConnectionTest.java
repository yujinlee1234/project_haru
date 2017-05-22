package kr.or.dgit.haru;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;

public class MysqlConnectionTest {
	
	private static final String DRIVER = "com.mysql.jdbc.Driver";
	private static final String URL = "jdbc:mysql://127.0.0.1:3306/project_haru";
	private static final String USER = "user_haru";
	private static final String PW = "haruharu";
	
	@Test
	public void testConnection() throws ClassNotFoundException{
		Class.forName(DRIVER);
		
		try{
			Connection conn = DriverManager.getConnection(URL, USER, PW);
			System.out.println(conn);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}
