package kr.ac.kaist.hrhrp.image;


import kr.ac.kaist.hrhrp.Extractor;
import org.springframework.stereotype.Service;

@Service("updateNewImageService")
public class UpdateNewImageService {
	public void updateNewImagePersonRelation(String photoId, String ownerId, String personId, String personName, String relationShip, String faceId) {
		Extractor ex = new Extractor();
		ex.updateNewPersonRelation(photoId, ownerId, personId, personName, relationShip, faceId);
		ex.close();

	}
}
