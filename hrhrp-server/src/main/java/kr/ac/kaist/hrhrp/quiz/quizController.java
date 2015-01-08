package kr.ac.kaist.hrhrp.quiz;

import java.util.Locale;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class quizController {
	
	@RequestMapping(value = "/quiz", method = RequestMethod.GET)
	public String register(Locale locale, Model model) {
		return "quiz_person";
	}
}
