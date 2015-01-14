package kr.ac.kaist.hrhrp.quiz;

import java.util.Locale;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class QuizController {
	@RequestMapping(value = "/quiz", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		return "quiz";
	}
}
