package kr.ac.kaist.hrhrp.quiz;

import org.springframework.stereotype.Service;

@Service("updateQuizService")
public class UpdateQuizService {
	public void updateQuiz(int quizId, int solved) {
		
		QuizManager quizM = new QuizManager();
		quizM.updateQuizSolved(quizId, solved);
	}
}
