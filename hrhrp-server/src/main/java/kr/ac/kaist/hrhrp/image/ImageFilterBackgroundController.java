package kr.ac.kaist.hrhrp.image;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class ImageFilterBackgroundController {
	@Resource(name="imageFilterBackgroundService")
	ImageFilterBackgroundService imageFilterBackgourndService;
	
	@RequestMapping(value = "/admin/imagefilter", method = RequestMethod.GET)
	public String getNewImage(Model model, HttpServletRequest request, HttpServletResponse response) throws JSONException {
		response.setContentType("text/plain");
		response.setCharacterEncoding("UTF-8");
		
		return "image_filter";
	}
}
