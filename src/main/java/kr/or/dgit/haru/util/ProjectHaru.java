package kr.or.dgit.haru.util;

import java.text.SimpleDateFormat;
/** 프로젝트 진행동안 필요한 객체들을 static으로 선언하여 모든 클래스에서 사용할수 있도록 만든 util Class
 * */
public class ProjectHaru {
	public static SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	public static SimpleDateFormat dateTimeFormat = new SimpleDateFormat("yyyy-MM-dd a HH:mm");
}
