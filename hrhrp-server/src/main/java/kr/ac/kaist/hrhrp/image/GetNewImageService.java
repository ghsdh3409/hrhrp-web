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
		ex.close();
		
		for (Person person : newPersons) {
			JSONObject personObj = new JSONObject();
			JSONArray facesArr = new JSONArray();
			for (Face face : person.getFaces()) {
				String imgUrl = face.getImgUrl();
				JSONObject faceObj = new JSONObject();
				faceObj.put("face_id", face.getFaceId());
				faceObj.put("url", imgUrl);
				JSONObject posObj = new JSONObject();
				posObj.put("width", face.getPosition().getWidth());
				posObj.put("height", face.getPosition().getHeight());
				JSONObject centerObj = new JSONObject();
				centerObj.put("x", face.getPosition().getCenterX());
				centerObj.put("y", face.getPosition().getCenterY());
				posObj.put("center", centerObj);
				faceObj.put("position", posObj);
				facesArr.put(faceObj);
			}
			personObj.put("faces", facesArr);
			personObj.put("person_id", person.getPersonId());
			if (person.getPersonName() != null) {
				personObj.put("person_name", person.getPersonName());
			}
			if (person.getPersonRelation() != null) {
				personObj.put("person_relation", person.getPersonRelation());
			}
			personArr.put(personObj);
		}
		
		obj.put("persons", personArr);
		
		return obj;
	}
}
