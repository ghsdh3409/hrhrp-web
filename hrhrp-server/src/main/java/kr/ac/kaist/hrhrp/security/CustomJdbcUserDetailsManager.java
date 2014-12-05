package kr.ac.kaist.hrhrp.security;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.PreparedStatementSetter;
import org.springframework.jdbc.core.simple.ParameterizedRowMapper;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserCache;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.core.userdetails.cache.NullUserCache;
import org.springframework.security.provisioning.JdbcUserDetailsManager;
import org.springframework.util.Assert;

public class CustomJdbcUserDetailsManager extends JdbcUserDetailsManager {

	public static final String DEF_CREATE_CUSTOM_USER_SQL =
			"insert into users (username, password, enabled) values (?,?,?,?)";
	
	public static final String DEF_INSERT_CUSTOM_AUTHORITY_SQL =
			"INSERT INTO user_roles (USER_ID, AUTHORITY) VALUES ((SELECT user_id FROM users WHERE USERNAME = ?) , ?)";

	public static final String DEF_DELETE_CUSTOM_USER_AUTHORITIES_SQL =
			"DELETE FROM user_roles WHERE user_id = (SELECT user_id FROM users WHERE USERNAME = ?)";
	
	public static final String DEF_UPDATE_CUSTOM_PASSWORD_SQL =
			"update users set password = ? where username = ?";

	public static final String DEF_USER_INFO_BY_USERNAME_SQL = 
			"select * from users where username = ?";
	
	private String createCustomUserSql = DEF_CREATE_CUSTOM_USER_SQL;
	private String createCustomAuthoritySql = DEF_INSERT_CUSTOM_AUTHORITY_SQL;
	private String deleteCustomUserAuthoritiesSql = DEF_DELETE_CUSTOM_USER_AUTHORITIES_SQL;
	private String updateCustomPasswordSql = DEF_UPDATE_CUSTOM_PASSWORD_SQL;
	private String userInfoByUsernameSql = DEF_USER_INFO_BY_USERNAME_SQL;


	private UserCache userCache = new NullUserCache();

	public Object loadUserInfoByUsername(final String username) throws UsernameNotFoundException, DataAccessException {

		Object params[] = {username};
		List<Object> usersInfo = getJdbcTemplate().query(userInfoByUsernameSql, params, new UserInfoMapper());
		Object userInfo = null;
		if (usersInfo.size() > 0) {
			userInfo = usersInfo.get(0);
		}			
		return userInfo;
	}

	private class UserInfoMapper implements ParameterizedRowMapper<Object> {

		@Override
		public Object mapRow(ResultSet rs, int arg1) throws SQLException {
			HashMap<String, Object> userInfo = new HashMap<String, Object>();

			userInfo.put("user_id", rs.getInt("id"));
			userInfo.put("email", rs.getString("username"));
			userInfo.put("realname", rs.getString("realname"));
		
			return userInfo;
		}

	}
		
	public void createUser(final UserDetails user, final HashMap<String, String> optionValue) {
		String insertAttrName = "username, password, enabled";
		String insertAttrValue = "?, ?, ?";

		for (String attrName : optionValue.keySet()) {
			insertAttrName = insertAttrName + "," + attrName;
			insertAttrValue = insertAttrValue + "," + "'" + optionValue.get(attrName) +"'";
		}
		this.createCustomUserSql = "INSERT INTO users (" + insertAttrName + ") values (" + insertAttrValue + ")";
		
		customValidateUserDetails(user);
		
		getJdbcTemplate().update(createCustomUserSql, new PreparedStatementSetter() {
			public void setValues(PreparedStatement ps) throws SQLException {
				ps.setString(1, user.getUsername());
				ps.setString(2, user.getPassword());
				ps.setBoolean(3, user.isEnabled());
			}			
		});

		if (getEnableAuthorities()) {
			customInsertUserAuthorities(user);
		}
	}

	public void updatePassword(final UserDetails user, final String password) {
		customValidateUserDetails(user);
		getJdbcTemplate().update(updateCustomPasswordSql, new PreparedStatementSetter() {
			public void setValues(PreparedStatement ps) throws SQLException {
				ps.setString(1, password);
				ps.setString(2, user.getUsername());
			}
		});

		if (getEnableAuthorities()) {
			customDeleteUserAuthorities(user.getUsername());
			customInsertUserAuthorities(user);
		}

		userCache.removeUserFromCache(user.getUsername());
	}

	public void setCreateCustomUserSql(String createCustomUserSql) {
		Assert.hasText(createCustomUserSql);
		this.createCustomUserSql = createCustomUserSql;
	}

	public void setCreateCustomAuthoritySql(String createCustomAuthoritySql) {
		Assert.hasText(createCustomAuthoritySql);
		this.createCustomAuthoritySql = createCustomAuthoritySql;
	}

	
	public void setDeleteCustomUserAuthoritiesSql(String deleteCustomUserAuthoritiesSql) {
		Assert.hasText(deleteCustomUserAuthoritiesSql);
		this.deleteCustomUserAuthoritiesSql = deleteCustomUserAuthoritiesSql;
	}

	private void customInsertUserAuthorities(UserDetails user) {
		for (GrantedAuthority auth : user.getAuthorities()) {
			getJdbcTemplate().update(createCustomAuthoritySql, user.getUsername(), auth.getAuthority());
		}
	}

	private void customDeleteUserAuthorities(String username) {
		getJdbcTemplate().update(deleteCustomUserAuthoritiesSql, new Object[] {username});
	}

	private void customValidateUserDetails(UserDetails user) {
		Assert.hasText(user.getUsername(), "Username may not be empty or null");
		customValidateAuthorities(user.getAuthorities());
	}

	private void customValidateAuthorities(Collection<? extends GrantedAuthority> collection) {
		Assert.notNull(collection, "Authorities list must not be null");

		for (GrantedAuthority authority : collection) {
			Assert.notNull(authority, "Authorities list contains a null entry");
			Assert.hasText(authority.getAuthority(), "getAuthority() method must return a non-empty string");
		}
	}

}
