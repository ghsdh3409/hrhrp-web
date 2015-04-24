package kr.ac.kaist.hrhrp.quiz;

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
public class UploadDiaryController {
	@Resource(name="uploadDiaryService")
	UploadDiaryService uploadDiaryService;
	@RequestMapping(value = "/api/upload_diary", method = RequestMethod.POST)
	public String getNewImage(Model model, HttpServletRequest request, HttpServletResponse response) throws JSONException, UnsupportedEncodingException {
		JSONObject obj = new JSONObject();

		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/plain");
		response.setCharacterEncoding("UTF-8");

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String user = auth.getName();
		
		String diary = request.getParameter("diary");

		if (diary == null || diary.length() == 0) {
			obj.put("code", 0);
			obj.put("msg", "There is not diary parameter.");

			model.addAttribute("uploadDiary", obj.toString());
			return "update_diary";
		}
		
		boolean result = uploadDiaryService.uploadDiary(user, diary);

		if (result) {
			obj.put("code", 1);
			obj.put("msg", "success");

			model.addAttribute("uploadDiary", obj.toString());
			
		} else {
			obj.put("code", 0);
			obj.put("msg", "fail");

			model.addAttribute("uploadDiary", obj.toString());
		}

		return "update_diary";
	}
}
