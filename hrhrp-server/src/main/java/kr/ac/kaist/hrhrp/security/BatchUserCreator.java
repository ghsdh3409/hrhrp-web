package kr.ac.kaist.hrhrp.security;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.security.authentication.dao.SaltSource;
import org.springframework.security.authentication.encoding.PasswordEncoder;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.provisioning.JdbcUserDetailsManager;

public class BatchUserCreator {
	private static Log log = LogFactory.getLog(BatchUserCreator.class);
	private CustomJdbcUserDetailsManager userDetailsManager;
	private SaltSource saltSource = null;
	private PasswordEncoder passwordEncoder = null;

	private UserDetails user;

	private String username;
	private String password;
	private boolean enabled;
	private boolean accountNonExpired;
	private boolean credentialsNonExpired;
	private boolean accountNonLocked;
	private List<GrantedAuthority> grantedAuthorities;

	public JdbcUserDetailsManager getUserDetailsManager()
	{
		return userDetailsManager;
	}

	public void setUserDetailsManager(CustomJdbcUserDetailsManager userDetailsManager)
	{
		this.userDetailsManager = userDetailsManager;
	}

	public SaltSource getSaltSource()
	{
		return saltSource;
	}

	public void setSaltSource(SaltSource saltSource)
	{
		this.saltSource = saltSource;
	}

	public PasswordEncoder getPasswordEncoder()
	{
		return passwordEncoder;
	}

	public void setPasswordEncoder(PasswordEncoder passwordEncoder)
	{
		this.passwordEncoder = passwordEncoder;
	}

	public String getUsername()
	{
		return username;
	}

	public void setUsername(String username)
	{
		this.username = username;
	}

	public String getPassword()
	{
		return password;
	}

	public void setPassword(String password)
	{
		this.password = password;
	}

	public boolean isEnabled()
	{
		return enabled;
	}

	public void setEnabled(boolean enabled)
	{
		this.enabled = enabled;
	}

	public boolean isAccountNonExpired()
	{
		return accountNonExpired;
	}

	public void setAccountNonExpired(boolean accountNonExpired)
	{
		this.accountNonExpired = accountNonExpired;
	}

	public boolean isCredentialsNonExpired()
	{
		return credentialsNonExpired;
	}

	public void setCredentialsNonExpired(boolean credentialsNonExpired)
	{
		this.credentialsNonExpired = credentialsNonExpired;
	}

	public boolean isAccountNonLocked()
	{
		return accountNonLocked;
	}

	public void setAccountNonLocked(boolean accountNonLocked)
	{
		this.accountNonLocked = accountNonLocked;
	}

	public List<GrantedAuthority> getGrantedAuthorities()
	{
		return grantedAuthorities;
	}

	public void setGrantedAuthorities(List<GrantedAuthority> grantedAuthorities)
	{
		this.grantedAuthorities = grantedAuthorities;
	}

	public void setGrantedAuthoritiesByName(List<String> grantedAuthorities)
	{
		ArrayList<GrantedAuthority> definitiveList = new ArrayList<GrantedAuthority>();

		Iterator<String> itAuthString = grantedAuthorities.iterator();
		while( itAuthString.hasNext() )
		{
			String roleName = itAuthString.next();

			definitiveList.add( new SimpleGrantedAuthority( roleName ) );
		} // while

			this.grantedAuthorities = definitiveList;
	}

	public UserDetails createUserInit() {
		if( log.isWarnEnabled() )
		{
			log.warn(password);
			log.warn(credentialsNonExpired);
			log.warn(enabled);
			log.warn(accountNonExpired);
			log.warn(accountNonLocked);
			log.warn( "Creating user with name " + username ); 
			log.warn( "Authorities: " );
			Iterator<GrantedAuthority> itAuth = grantedAuthorities.iterator();
			while( itAuth.hasNext() )
			{
				GrantedAuthority auth = itAuth.next();
				log.warn( auth.getAuthority() );
			} // while
		} // log.isWarnEnabled()

		Object salt = null; 

		user = new User( username, 
				password, 
				enabled, 
				accountNonExpired, 
				credentialsNonExpired, 
				accountNonLocked, 
				grantedAuthorities );

		log.warn(user);

		if( this.saltSource != null )
		{
			salt = this.saltSource.getSalt( user );
		}

		log.warn(user.getPassword());

		// calculate what hashedPassword would be in this configuration
		String hashedPassword = passwordEncoder.encodePassword( user.getPassword(), salt );

		log.warn(hashedPassword);


		// create a new user with the hashed password 
		UserDetails userHashedPassword = new User( username, 
				hashedPassword, 
				enabled, 
				accountNonExpired, 
				credentialsNonExpired, 
				accountNonLocked, 
				grantedAuthorities );
		return userHashedPassword;
	}

	public int createUser() {
		UserDetails userHashedPassword = createUserInit();

		// if the user exists, delete it 
		if( userDetailsManager.userExists( userHashedPassword.getUsername() ) ) {
			return 0;
		}

		// and finally, create the user 
		try {
			userDetailsManager.createUser(userHashedPassword);
			log.warn("CREATE_USER_SUCCESS");
			return 1;
		} catch (Exception e) {
			log.warn("CREATE_USER_ERROR : " + e.getMessage());
			return -1;
		}

	}

	public int createUser(HashMap<String, String> optionValue) {
		UserDetails userHashedPassword = createUserInit();

		// if the user exists, delete it 
		if( userDetailsManager.userExists( userHashedPassword.getUsername() ) ) {
			return 0;
		}

		// and finally, create the user 
		try {
			userDetailsManager.createUser(userHashedPassword, optionValue);
			log.warn("CREATE_USER_SUCCESS");
			return 1;
		} catch (Exception e) {
			log.warn("CREATE_USER_ERROR" + e.getMessage());
			return -1;
		}
	}

}
