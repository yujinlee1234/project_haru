package kr.or.dgit.haru.util;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.Calendar;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.FileCopyUtils;

public class UploadFileUtils {
	
	private static final Logger logger = LoggerFactory.getLogger(UploadFileUtils.class);
	
	public static String makeThumnbnail(String uploadPath, String filename) throws IOException{
		String thumbnailName = "";
		//원본 이미지 가져 오기
		BufferedImage sourceImg = ImageIO.read(new File(uploadPath, filename));
		
		
		//썸네일 이미지 데이터 만들기
		BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, 100, 100);// width, height 100으로 고정하려 했으나 안됨
		
		thumbnailName = uploadPath+"/"+"s_"+filename;
		
		File newFile = new File(thumbnailName);
		String format = filename.substring(filename.lastIndexOf(".")+1);//확장자 찾기
		
		//Thumbnail 경로/파일 이름에 resizing된 이미지를 넣는다.
		ImageIO.write(destImg, format.toUpperCase(), newFile);
		
		
		return "s_"+filename;
	}
	//Upload하면서 thumbnail이미지 만들도록
	public static String uploadFile(String uploadPath,// c:/zzz/upload 
									String originalName, 
									byte[] fileData) throws Exception{
		//Upload 부분
		UUID uid = UUID.randomUUID();
		String savedname = uid.toString()+"_"+originalName;
		
		//한 폴더에 저장할 수 있는 용량이 제한되어있으므로, 날짜별로 업로드가 되도록 처리한다.
		String savedPath = calcPath(uploadPath);//최종 저장될 날짜 폴더 return.
		
		File target = new File(uploadPath+savedPath, savedname);
		FileCopyUtils.copy(fileData, target);
		//Thumbnail 부분
		String thumbFile = makeThumnbnail(uploadPath+savedPath, savedname);
		
		
		//Thumbnail경로 return
		return savedPath+"/"+thumbFile;
	}
	
	
	private static String calcPath(String uploadPath){
		Calendar cal = Calendar.getInstance();
		
		String yearPath = "/"+cal.get(Calendar.YEAR);
		String monthPath = String.format("%s/%02d", yearPath, cal.get(Calendar.MONTH)+1);
		String datePath = String.format("%s/%02d", monthPath, cal.get(Calendar.DATE));
		
		makeDir(uploadPath, yearPath, monthPath, datePath);
		
		return datePath;//최종 파일이 저장될 경로, uploadPath는 빠져있음;
	}
	
	public static void makeDir(String uploadPath, String... paths){
		for(String path : paths){
			File dirPath = new File(uploadPath+path);
			
			if(!dirPath.exists()){
				dirPath.mkdirs();
			}
		}
	}
}
