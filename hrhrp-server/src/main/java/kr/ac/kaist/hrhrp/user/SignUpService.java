package kr.ac.kaist.hrhrp.user;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import kr.ac.kaist.hrhrp.security.BatchUserCreator;
import kr.ac.kaist.hrhrp.security.CustomJdbcUserDetailsManager;

import org.springframework.security.authentication.encoding.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service("signUpService")
public class SignUpService {
	@Resource(name="jdbcUserService")
	private CustomJdbcUserDetailsManager userDetailsManager;
	@Resource(name="passwordEncoder")
	private PasswordEncoder passwordEncoder;
	
	public int createUser(String username, String password) {
		BatchUserCreator newUserCreator = new BatchUserCreator();
		newUserCreator.setUsername(username);
		newUserCreator.setPassword(password);
		newUserCreator.setEnabled(true);
		
		List<String> grantedAuthorities = new ArrayList<String>();
		grantedAuthorities.add("ROLE_USER");		
		newUserCreator.setGrantedAuthoritiesByName(grantedAuthorities);
		
		newUserCreator.setAccountNonExpired(true);
		newUserCreator.setAccountNonLocked(true);
		newUserCreator.setCredentialsNonExpired(true);
		
		newUserCreator.setUserDetailsManager(userDetailsManager);
		newUserCreator.setPasswordEncoder(passwordEncoder);
		
		return newUserCreator.createUser();
	}
	
	public int createUser(String username, String password, HashMap<String, String> optionValue) {
		BatchUserCreator newUserCreator = new BatchUserCreator();
		newUserCreator.setUsername(username);
		newUserCreator.setPassword(password);
		newUserCreator.setEnabled(true);
		
		List<String> grantedAuthorities = new ArrayList<String>();
		grantedAuthorities.add("ROLE_USER");		
		newUserCreator.setGrantedAuthoritiesByName(grantedAuthorities);
		
		newUserCreator.setAccountNonExpired(true);
		newUserCreator.setAccountNonLocked(true);
		newUserCreator.setCredentialsNonExpired(true);
		
		newUserCreator.setUserDetailsManager(userDetailsManager);
		newUserCreator.setPasswordEncoder(passwordEncoder);
		
		return newUserCreator.createUser(optionValue);
	}
}
