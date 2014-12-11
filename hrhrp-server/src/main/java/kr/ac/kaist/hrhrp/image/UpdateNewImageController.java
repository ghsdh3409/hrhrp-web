package kr.ac.kaist.hrhrp.image;

import java.io.UnsupportedEncodingException;

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
public class UpdateNewImageController {
	@Resource(name="updateNewImageService")
	UpdateNewImageService updateNewImageService;
	
	@RequestMapping(value = "/api/update_person", method = RequestMethod.GET)
	public String getNewImage(Model model, HttpServletRequest request, HttpServletResponse response) throws JSONException, UnsupportedEncodingException {
		JSONObject obj = new JSONObject();
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/plain");
		response.setCharacterEncoding("UTF-8");
		
		String personId = request.getParameter("person_id");
		String personName = request.getParameter("person_name");
		String personRelation = request.getParameter("relation");
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String ownerId = auth.getName();
		
		if (personId == null) {
			personId = "";
			obj.put("code", 0);
			obj.put("msg", "There is not person_id parameter.");
			
			model.addAttribute("updatePersonResult", obj.toString());
			return "update_person";
		}
		
		if (personName == null) {
			personName = "";
			obj.put("code", 0);
			obj.put("msg", "There is not person_name parameter.");
			
			model.addAttribute("updatePersonResult", obj.toString());
			return "update_person";
		}
		
		if (personRelation == null) {
			personRelation = "";
			obj.put("code", 0);
			obj.put("msg", "There is not relation parameter.");
			
			model.addAttribute("updatePersonResult", obj.toString());
			return "update_person";
		}
		
		try {
			updateNewImageService.updateNewImagePerson(ownerId, personId, personName);
			updateNewImageService.updateNewImageRelation(ownerId, personId, personRelation);
			
			obj.put("code", 1);
			obj.put("msg", "success");
			
			model.addAttribute("updatePersonResult", obj.toString());
		} catch (Exception e) {
			e.printStackTrace();
			
			obj.put("code", 1);
			obj.put("msg", e.getMessage());
			
			model.addAttribute("updatePersonResult", obj.toString());
		}
		
		return "update_person";
	}
}
