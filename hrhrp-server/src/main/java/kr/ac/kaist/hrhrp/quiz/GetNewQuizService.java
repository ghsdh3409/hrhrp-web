package kr.ac.kaist.hrhrp.quiz;

import java.util.ArrayList;

import kr.ac.kaist.hrhrp.type.Face;
import kr.ac.kaist.hrhrp.type.Quiz;
import kr.ac.kaist.hrhrp.type.Selection;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Service;

@Service("getNewQuizService")
public class GetNewQuizService {
	public JSONObject getNewQuiz(String username) throws JSONException {
		JSONObject obj = new JSONObject();
		JSONArray quizArr = new JSONArray();

		QuizManager quizGetter = new QuizManager();
		ArrayList<Quiz> newQuizes = quizGetter.getQuizes(username);
		quizGetter.close();

		for (Quiz quiz : newQuizes) {
			JSONObject quizObj = new JSONObject();

			quizObj.put("quiz_id", quiz.getQuizId());
			quizObj.put("template_id", quiz.getTemplateId());
			quizObj.put("solver_id", quiz.getSolverId());

			JSONObject quizQuestion = new JSONObject();

			quizQuestion.put("quiz_text", quiz.getQuizText());
			quizQuestion.put("quiz_image", quiz.getQuizImageUrl());

			Face quizFace = quiz.getQuizFace();
			if (quizFace != null) {
				quizQuestion.put("face_id", quizFace.getFaceId());

				JSONObject posObj = new JSONObject();
				posObj.put("width", quizFace.getPosition().getWidth());
				posObj.put("height", quizFace.getPosition().getHeight());
				posObj.put("center_x", quizFace.getPosition().getCenterX());
				posObj.put("center_y", quizFace.getPosition().getCenterY());

				quizQuestion.put("position", posObj);
			}
			
			quizObj.put("quiz_info", quizQuestion);

			JSONArray selectionsArr = new JSONArray();

			int selNum = 1;
			for (Selection sel : quiz.getSelections()) {
				JSONObject selObj = new JSONObject();

				selObj.put("selection", sel.getSelection());
				selObj.put("type", sel.getSelectionType());
				
				Face selFace = sel.getSelectionFace();
				if (selFace != null) {
					selObj.put("face_id", selFace.getFaceId());
					JSONObject posObj = new JSONObject();
					posObj.put("width", selFace.getPosition().getWidth());
					posObj.put("height", selFace.getPosition().getHeight());
					posObj.put("center_x", selFace.getPosition().getCenterX());
					posObj.put("center_y", selFace.getPosition().getCenterY());

					selObj.put("position", posObj);
				}
				selObj.put("number", selNum);
				selNum++;

				selectionsArr.put(selObj);
			}

			quizObj.put("selections", selectionsArr);
			
			quizObj.put("answer", quiz.getAnswer());
			
			quizArr.put(quizObj);
		}

		obj.put("quiz", quizArr);

		return obj;
	}
	
	public JSONObject getQuizResult(String username) throws JSONException {
		JSONObject obj = new JSONObject();
		JSONArray quizArr = new JSONArray();

		QuizManager quizGetter = new QuizManager();
		ArrayList<Quiz> newQuizes = quizGetter.getQuizResult(username);
		quizGetter.close();

		for (Quiz quiz : newQuizes) {
			JSONObject quizObj = new JSONObject();

			quizObj.put("quiz_id", quiz.getQuizId());
			quizObj.put("template_id", quiz.getTemplateId());
			quizObj.put("solver_id", quiz.getSolverId());

			JSONObject quizQuestion = new JSONObject();

			quizQuestion.put("quiz_text", quiz.getQuizText());
			quizQuestion.put("quiz_image", quiz.getQuizImageUrl());

			Face quizFace = quiz.getQuizFace();
			if (quizFace != null) {
				quizQuestion.put("face_id", quizFace.getFaceId());

				JSONObject posObj = new JSONObject();
				posObj.put("width", quizFace.getPosition().getWidth());
				posObj.put("height", quizFace.getPosition().getHeight());
				posObj.put("center_x", quizFace.getPosition().getCenterX());
				posObj.put("center_y", quizFace.getPosition().getCenterY());

				quizQuestion.put("position", posObj);
			}
			
			quizObj.put("quiz_info", quizQuestion);

			JSONArray selectionsArr = new JSONArray();

			int selNum = 1;
			for (Selection sel : quiz.getSelections()) {
				JSONObject selObj = new JSONObject();

				selObj.put("selection", sel.getSelection());
				selObj.put("type", sel.getSelectionType());
				
				Face selFace = sel.getSelectionFace();
				if (selFace != null) {
					selObj.put("face_id", selFace.getFaceId());
					JSONObject posObj = new JSONObject();
					posObj.put("width", selFace.getPosition().getWidth());
					posObj.put("height", selFace.getPosition().getHeight());
					posObj.put("center_x", selFace.getPosition().getCenterX());
					posObj.put("center_y", selFace.getPosition().getCenterY());

					selObj.put("position", posObj);
				}
				selObj.put("number", selNum);
				selNum++;

				selectionsArr.put(selObj);
			}

			quizObj.put("selections", selectionsArr);
			
			quizObj.put("answer", quiz.getAnswer());
			
			quizObj.put("solved", quiz.getSolved());
			
			quizArr.put(quizObj);
		}

		obj.put("quiz", quizArr);

		return obj;
	}
}
