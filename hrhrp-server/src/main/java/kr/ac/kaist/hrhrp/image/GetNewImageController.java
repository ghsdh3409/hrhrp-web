package kr.ac.kaist.hrhrp.image;

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
public class GetNewImageController {
	
	@Resource(name="getNewImageService")
	GetNewImageService getNewImageService;
	
	String groupName = "HRHRP_Test";
	
	@RequestMapping(value = "/api/new_persons", method = RequestMethod.GET)
	public String getNewImage(Model model, HttpServletRequest request, HttpServletResponse response) throws JSONException {
		response.setContentType("text/plain");
		response.setCharacterEncoding("UTF-8");
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String username = auth.getName();
		
		JSONObject newNamePersonObj = getNewImageService.getNewNamePersons(username);
		
		model.addAttribute("newImages", newNamePersonObj.toString());
		return "get_images";
	}

}
