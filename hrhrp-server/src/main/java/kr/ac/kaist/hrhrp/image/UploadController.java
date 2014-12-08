package kr.ac.kaist.hrhrp.image;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.LinkedList;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Controller
public class UploadController {
	private final static String srcPath = "D:/temp/files/";
	LinkedList<FileMeta> files = new LinkedList<FileMeta>();
	FileMeta fileMeta = null;
	/***************************************************
	 * URL: upload  
	 * upload(): receives files
	 * @param request : MultipartHttpServletRequest auto passed
	 * @param response : HttpServletResponse auto passed
	 * @return LinkedList<FileMeta> as json format
	 ****************************************************/
	@RequestMapping(value="/upload", method = RequestMethod.POST)
	public @ResponseBody LinkedList<FileMeta> upload(MultipartHttpServletRequest request, HttpServletResponse response) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String username = auth.getName();
		try {

			LinkedList<FileMeta> files = new LinkedList<FileMeta>();

			//1. build an iterator
			Iterator<String> itr =  request.getFileNames();
			MultipartFile mpf = null;

			//2. get each file
			while(itr.hasNext()){

				//2.1 get next MultipartFile
				mpf = request.getFile(itr.next()); 
				System.out.println(mpf.getOriginalFilename() +" uploaded! "+files.size());

				//2.2 if files > 10 remove the first from the list
				if(files.size() >= 10)
					files.pop();

				//2.3 create new fileMeta
				fileMeta = new FileMeta();
				fileMeta.setFileName(mpf.getOriginalFilename());
				fileMeta.setFileSize(mpf.getSize()/1024+" Kb");
				fileMeta.setFileType(mpf.getContentType());
				fileMeta.setBytes(mpf.getBytes());

				Date d = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				String nowDate =  sdf.format(d);
				
				String filePath = srcPath + username + "/" + nowDate + "/";

				System.out.println(filePath);

				// copy file to local disk (make sure the path "e.g. D:/temp/files" exists)     

				File file = new File( filePath );

				if( file.exists() == false ) {
					file.mkdirs();
				}

				FileCopyUtils.copy(mpf.getBytes(), new FileOutputStream(filePath+mpf.getOriginalFilename()));

				//2.4 add to files
				files.add(fileMeta);

				// result will be like this
				// [{"fileName":"app_engine-85x77.png","fileSize":"8 Kb","fileType":"image/png"},...]
				return files;
			}
		} catch (Exception e) {
			e.printStackTrace();	
		}
		return files;
	}
	/***************************************************
	 * URL: /rest/controller/get/{value}
	 * get(): get file as an attachment
	 * @param response : passed by the server
	 * @param value : value from the URL
	 * @return void
	 ****************************************************/
	@RequestMapping(value = "/get/{value}", method = RequestMethod.GET)
	public void get(HttpServletResponse response,@PathVariable String value){
		FileMeta getFile = files.get(Integer.parseInt(value));
		try {      
			response.setContentType(getFile.getFileType());
			response.setHeader("Content-disposition", "attachment; filename=\""+getFile.getFileName()+"\"");
			FileCopyUtils.copy(getFile.getBytes(), response.getOutputStream());
		}catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@RequestMapping(value = "/uploader", method = RequestMethod.GET)
	public String login(HttpSession session) {
		return "images";
	}
}
