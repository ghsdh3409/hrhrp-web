package kr.ac.kaist.hrhrp.image;


import kr.ac.kaist.hrhrp.Extractor;
import org.springframework.stereotype.Service;

@Service("updateNewImageService")
public class UpdateNewImageService {
	public void updateNewImagePerson(String ownerId, String personId, String personName) {
	
		Extractor ex = new Extractor();
		ex.updateNewPersons(ownerId, personId, personName);

	}
	
	public void updateNewImageRelation(String ownerId, String personId, String relationShip) {

		Extractor ex = new Extractor();
		ex.updateNewRalations(ownerId, personId, relationShip);

	}
}
