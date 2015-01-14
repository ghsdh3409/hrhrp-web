package kr.ac.kaist.hrhrp.quiz;

import java.io.UnsupportedEncodingException;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class UpdateQuizController {
	@Resource(name="updateQuizService")
	UpdateQuizService updateQuizService;
	@RequestMapping(value = "/api/update_quiz", method = RequestMethod.POST)
	public String getNewImage(Model model, HttpServletRequest request, HttpServletResponse response) throws JSONException, UnsupportedEncodingException {
		JSONObject obj = new JSONObject();

		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/plain");
		response.setCharacterEncoding("UTF-8");

		String quizIdParm = request.getParameter("quiz_id");
		String solvedParm = request.getParameter("solved");

		int quizId, solved;

		if (quizIdParm == null) {
			quizIdParm = "";
			obj.put("code", 0);
			obj.put("msg", "There is not quizn_id parameter.");

			model.addAttribute("updateQuizResult", obj.toString());
			return "update_quiz";
		} else {
			quizId = Integer.valueOf(quizIdParm);
		}

		if (solvedParm == null) {
			solvedParm = "";
			obj.put("code", 0);
			obj.put("msg", "There is not solved parameter.");

			model.addAttribute("updateQuizResult", obj.toString());
			return "update_quiz";
		} else {
			solved = Integer.valueOf(solvedParm);
		}
		
		try {
			updateQuizService.updateQuiz(quizId, solved);
			obj.put("code", 1);
			obj.put("msg", "success");

			model.addAttribute("updateQuizResult", obj.toString());
		} catch (Exception e) {
			e.printStackTrace();
			obj.put("code", 0);
			obj.put("msg", e.getMessage());

			model.addAttribute("updateQuizResult", obj.toString());
		}


		return "update_quiz";
	}
}
