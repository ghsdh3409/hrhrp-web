package kr.ac.kaist.hrhrp.user;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.HashMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class SignUpController {
	
	@Resource(name="signUpService")
	SignUpService signUpService;
	
	private static Log log = LogFactory.getLog(RegisterController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 * @throws JSONException 
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping(value = "/api/signup", method = RequestMethod.POST)
	public String signup(Model model, HttpServletRequest request, HttpServletResponse response) throws JSONException, UnsupportedEncodingException {

		request.setCharacterEncoding("UTF-8");
		
		response.setContentType("text/plain");
		response.setCharacterEncoding("UTF-8");
		
		/* Required */
		String email = request.getParameter("email");
		String passwd = request.getParameter("password");
		String name = request.getParameter("name");
	
		HashMap<String, String> optionValue = new HashMap<String, String>();
		
		if (email == null || email.length() < 1) {
			email="";
			JSONObject obj = new JSONObject();
			obj.put("code", "NO_EMAIL");
			obj.put("msg", "There is not email parameter");
			
			model.addAttribute("signUpResult", obj.toString());
			return "signup";
		}
		
		if (passwd == null || passwd.length() < 1) {
			passwd="";
			JSONObject obj = new JSONObject();
			obj.put("code", "NO_PASSWORD");
			obj.put("msg", "There is not password parameter");
			
			model.addAttribute("signUpResult", obj.toString());
			return "signup";
		}
		
		if (name == null || name.length() < 1) {
			name="";
			JSONObject obj = new JSONObject();
			obj.put("code", "NO_NAME");
			obj.put("msg", "There is no realname parameter");
			
			model.addAttribute("signUpResult", obj.toString());
			return "signup";
		}
		
		email = URLDecoder.decode(email, "UTF-8");		
		
		if (name != null && name.length() > 0) {
			name = URLDecoder.decode(name, "UTF-8");
			optionValue.put("realname", name);
			log.warn(name);
		}
		
		int createResult = -1;
		if (optionValue.isEmpty())
			createResult = signUpService.createUser(email, passwd);
		else {
			createResult = signUpService.createUser(email, passwd, optionValue);
		}
		
		if (createResult == 0) {
			JSONObject obj = new JSONObject();
			obj.put("code", "SAME_EMAIL");
			obj.put("err_msg", "Same email address exists already.");
			
			model.addAttribute("signUpResult", obj.toString());
		} else if (createResult == 1) {
		
			JSONObject obj = new JSONObject();
			obj.put("code", "SUCCESS");
			obj.put("msg", "Registration Success.");
				
			model.addAttribute("signUpResult", obj.toString());
				
		} else {
			JSONObject obj = new JSONObject();
			obj.put("code", "UNKNOWN");
			obj.put("err_msg", "Unknown Error.");
			
			model.addAttribute("signUpResult", obj.toString());
		}
		return "signup";
		
	}
	
}
