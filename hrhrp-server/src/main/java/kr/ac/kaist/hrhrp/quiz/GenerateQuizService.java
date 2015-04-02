package kr.ac.kaist.hrhrp.quiz;


import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Service;

@Service("generateQuizService")
public class GenerateQuizService {
	public JSONObject generateQuiz(int quizNum, String username) throws JSONException {

		int quizCnt = -1;

		try {

			QuizGen guizGen = new QuizGen();
			quizCnt = guizGen.generateQuizset(quizNum, username);

		} catch (Exception e) {
			e.printStackTrace();
			quizCnt = -1;
		}
		
					
		JSONObject obj = new JSONObject();
		
		if (quizCnt > -1) {
			obj.put("quizCnt", quizCnt);
			obj.put("isSuccess", true);
		} else {
			obj.put("quizCnt", quizCnt);
			obj.put("isSuccess", false);
		}

		return obj;
	}
}