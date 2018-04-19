package lets.eat.cancho.editor.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import lets.eat.cancho.editor.util.FileService;
import lets.eat.cancho.editor.util.ImageFileManager;
import lets.eat.cancho.editor.util.test;


/**
 * Handles requests for the application home page....
 */

@Controller
public class editController {
	
	int Cnt = 0;
	HashMap<String, String> deleteMap = new HashMap<String, String>();
	
	/*사용자에 토모로그 폴더 생기게*/
	
	final String uploadPath = "C:\\tomolog\\temp\\";	//파일 업로드 경로
	final String extractPath = "C:\\tomolog\\extract\\";	// 추출된 이미지 경로
	
	@RequestMapping(value = "/editor", method = RequestMethod.GET)
	public String home() {
		return "videoEditor/editor";
	}
	
	@ResponseBody
	@RequestMapping(value = "extract", method = RequestMethod.GET)
	public HashMap<String, Object> extract(String fileName){
		HashMap<String, Object> rtn  = new HashMap<>();
		String originPath = "tomolog\\extract\\";
		String videoPath = "C:\\tomolog\\extract\\"+fileName+"\\";
		System.out.println(videoPath);
		int count = test.findFileNum(videoPath) - 1;
		rtn.put("count", count);
		rtn.put("originPath", originPath);
		return rtn;
	}
	
	@ResponseBody
	@RequestMapping(value="fileupload", method = RequestMethod.POST)
	public String fileupload(MultipartHttpServletRequest request, HttpServletResponse response, String selectedType) {
		Iterator<String> itr =  request.getFileNames();
        String fileType = request.getParameter("fileType");
        String savedfile = "";
        String fileName = "";
        if(itr.hasNext()) {
            MultipartFile mpf = request.getFile(itr.next());
            if (!mpf.isEmpty()) {
				savedfile = FileService.saveFile(mpf, uploadPath);
				
				// 파일 종류 판별
				int fileLength = savedfile.length();
				String ext;
				int lastIndex = savedfile.lastIndexOf('.');
				fileName = savedfile.substring(0, lastIndex);
				String extName = savedfile.substring(lastIndex+1, fileLength);	//	확장자 구하기
				
				/*// 페이지에 넘겨줄 파일경로가 담긴 리스트
				case "mp4": videoList.add(savedfile); break;
				case "ogg": videoList.add(savedfile); break;
				case "webm": videoList.add(savedfile); break;
				case "mp3": audioList.add(savedfile); break;
				case "jpg": imageList.add(savedfile); break;
				case "jpeg": imageList.add(savedfile); break;
				case "png": imageList.add(savedfile); break;
				}*/
				if(extName.equals("mp4") || extName.equals("ogg") || extName.equals("webm")) {
					ImageFileManager.extractVideo(fileName, fileName);
				}
			}
        } 
        return fileName;
    }
	
	@ResponseBody
	@RequestMapping(value = "getFileList", method = RequestMethod.POST)
	public File[] getFileList(String selectedType) {
		String type = selectedType;
		File path = new File("C:/tomolog/temp/");
		File[] fileList = path.listFiles(); 
			return fileList;
		}
	
	@RequestMapping(value = "download", method = RequestMethod.GET)
	public void fileDownload(HttpServletResponse response, String origin , String saved){
		try {
			response.setHeader("Content-Disposition", " attachment;filename="+ URLEncoder.encode(origin, "UTF-8"));
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		String fullPath = uploadPath + "/" + saved;
		//서버의 파일을 읽을 입력 스트림과 클라이언트에게 전달할 출력스트림
		FileInputStream filein = null;
		ServletOutputStream fileout = null;
		
		try {
			filein = new FileInputStream(fullPath);
			fileout = response.getOutputStream();
			
			//Spring의 파일 관련 유틸
			FileCopyUtils.copy(filein, fileout);
			
			filein.close();
			fileout.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/*@ResponseBody
	@RequestMapping(value = "deleteIndiFile", method = RequestMethod.POST)
	public void deleteIndiFile(String indiFileName) {
		String delFileName = indiFileName;
		
		String fullpath = uploadPath + delFileName;
		
		
		String ext;
		int lastIndex = delFileName.lastIndexOf('.');
		int fileLength = delFileName.length();
		String extName = delFileName.substring(lastIndex+1, fileLength);
		String realName = delFileName.substring(0, lastIndex);
		
		String fullpathEx = extractPath + realName;
		System.out.println(fullpathEx);
		
		deleteMap.put("fullpath", fullpath);
		
		if(extName.equals("mp4") || extName.equals("ogg") || extName.equals("webm")) {
			deleteMap.put("fullpathEx", fullpathEx);
		}
		else {
			deleteMap.put("fullpathEx", "notVideo");
		}
		
		boolean del = FileService.deleteFile(deleteMap);
		
		if(del) {
			switch(extName) {
			
				case "mp4": videoList.remove(delFileName); break;
				case "ogg": videoList.remove(delFileName); break;
				case "webm": videoList.remove(delFileName); break;
				case "mp3": audioList.remove(delFileName); break;
				case "jpg": imageList.remove(delFileName); break;
				case "jpeg": imageList.remove(delFileName); break;
				case "png": imageList.remove(delFileName); break;
				
			}
		}
		
	}
	
	@ResponseBody
	@RequestMapping(value = "deleteAllFiles", method = RequestMethod.GET)
	public void deleteAllFiles(String deleteMess) {
		 File file = new File("C:/dir");
         
	        if( file.exists() ){ //파일존재여부확인
	             
	            if(file.isDirectory()){ //파일이 디렉토리인지 확인
	                 
	                File[] files = file.listFiles();
	                 
	                for( int i=0; i<files.length; i++){
	                    if( files[i].delete() ){
	                        System.out.println(files[i].getName()+" 삭제성공");
	                    }else{
	                        System.out.println(files[i].getName()+" 삭제실패");
	                    }
	                }
	                 
	            }
	            if(file.delete()){
	                System.out.println("파일삭제 성공");
	            }else{
	                System.out.println("파일삭제 실패");
	            }
	             
	        }else{
	            System.out.println("파일이 존재하지 않습니다.");
	        }
	}*/

}
