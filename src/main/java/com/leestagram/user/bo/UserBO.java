package com.leestagram.user.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.leestagram.user.dao.UserDAO;
import com.leestagram.user.model.User;

@Service
public class UserBO {

	@Autowired
	private UserDAO userDAO;
	
	public int existLoginId(String loginId) {
		return userDAO.existLoginId(loginId);
	}
	
	public int insertUser(String loginId, String password, String name, String email) {
		return userDAO.insertUser(loginId, password, name, email);
	}
	
	public User getUser(String loginId, String password) {
		return userDAO.selectUserByLoginIdPassword(loginId, password);
	}
}
