package kr.ac.kaist.hrhrp.user;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

public class SigninSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler { 
	 private static final Logger logger = LoggerFactory.getLogger(SigninSuccessHandler.class);

     @Override
     public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication auth) throws IOException, ServletException {

         response.setContentType("application/json");
         response.setCharacterEncoding("utf-8");
         String defaultUrl = this.getDefaultTargetUrl();
         String redirectUrl = request.getParameter(this.getTargetUrlParameter());
         String targetUrl = defaultUrl;

         if (redirectUrl != null) {
        	 targetUrl = redirectUrl;
         }
         
         targetUrl = request.getContextPath() + targetUrl;
         
         logger.info(targetUrl);
         
         String data = StringUtils.join(new String[] {
              " {\"err_msg\" : false, \"target_url\" : \"" + targetUrl +"\" } "
         });

         PrintWriter out = response.getWriter();
         out.print(data);
         out.flush();
         out.close();
         
     }
}
