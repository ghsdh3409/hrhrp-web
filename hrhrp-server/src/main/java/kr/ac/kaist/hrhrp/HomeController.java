package kr.ac.kaist.hrhrp;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONException;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String username = null;
		if (auth != null) {
			username = auth.getName();
		}
		logger.info("Welcome login! {}", username);
		model.addAttribute("username", username);
		
		return "login";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public void login(Model model, HttpSession session) { // If a type of method is void, a url is same to view name.
		logger.info("Welcome login! {}", session.getId());
	}
	
	@RequestMapping(value = "/api/signin_fail")
	public String signinFail(Model model, HttpServletRequest request, HttpServletResponse response) throws JSONException {
		
		response.setContentType("text/plain");
		response.setCharacterEncoding("UTF-8");
		
		String errorMsg = RequestContextHolder.getRequestAttributes().getAttribute("SPRING_SECURITY_LAST_EXCEPTION", RequestAttributes.SCOPE_SESSION).toString();
		
		JSONObject obj = new JSONObject();
		obj.put("err_msg", errorMsg);
		
		model.addAttribute("signInFail", obj);

		return "signin_fail";
	}
}
