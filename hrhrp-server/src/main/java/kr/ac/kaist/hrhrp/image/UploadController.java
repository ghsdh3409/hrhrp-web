package kr.ac.kaist.hrhrp.image;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.ac.kaist.hrhrp.user.RegisterController;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.JSONException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class UploadController {
	private static Log log = LogFactory.getLog(RegisterController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 * @throws JSONException 
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping(value = "upload", method = RequestMethod.GET)
	public void signup(Model model, HttpServletRequest request, HttpServletResponse response) throws JSONException, UnsupportedEncodingException {

	}
}
