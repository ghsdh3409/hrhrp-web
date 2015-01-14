package kr.ac.kaist.hrhrp.quiz;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class GetNewQuizController {
	
	@Resource(name="getNewQuizService")
	GetNewQuizService getNewQuizService;
	
	@RequestMapping(value = "/api/get_quiz", method = RequestMethod.GET)
	public String getNewImage(Model model, HttpServletRequest request, HttpServletResponse response) throws JSONException {
		response.setContentType("text/plain");
		response.setCharacterEncoding("UTF-8");
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String username = auth.getName();
		
		JSONObject newQuizObj = getNewQuizService.getNewQuiz(username);
		
		model.addAttribute("newQuiz", newQuizObj.toString());
		return "get_quiz";
	}
}
