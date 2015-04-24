package kr.ac.kaist.hrhrp.quiz;

import kr.ac.kaist.hrhrp.db.DBHandler;

import org.json.JSONException;
import org.springframework.stereotype.Service;

@Service("uploadDiaryService")
public class UploadDiaryService {
	public boolean uploadDiary(String user, String diary) throws JSONException {
		
		DBHandler dbTemplate = new DBHandler();
		
		boolean result = dbTemplate.uploadDiary(user, diary);
		
		if(dbTemplate != null) {
			dbTemplate.close();
		}
		
		return result;
	}
}
