package kr.ac.kaist.hrhrp.image;

import java.util.ArrayList;

import kr.ac.kaist.hrhrp.Extractor;
import kr.ac.kaist.hrhrp.type.Face;
import kr.ac.kaist.hrhrp.type.Person;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Service;

@Service("getNewImageService")
public class GetNewImageService {
	
	public JSONObject getNewNamePersons(String username) throws JSONException {
		JSONObject obj = new JSONObject();
		JSONArray personArr = new JSONArray();
		Extractor ex = new Extractor();
		ArrayList<Person> newPersons = ex.getNewPersons(username);
		
		for (Person person : newPersons) {
			JSONObject personObj = new JSONObject();
			JSONArray facesArr = new JSONArray();
			for (Face face : person.getFaces()) {
				String imgUrl = face.getImgUrl();
				JSONObject faceObj = new JSONObject();
				faceObj.put("url", imgUrl);
				facesArr.put(faceObj);
			}
			personObj.put("faces", facesArr);
			personObj.put("person_id", person.getPersonId());
			personArr.put(personObj);
		}
		
		obj.put("persons", personArr);
		
		return obj;
	}
	
	/*
	public JSONObject getNewRelations(String username) {
		Extractor ex = new Extractor();
		ArrayList<Person> newPersons = ex.getNewRelations(username);
		return newPersons;
	}
	*/	
}
