package com.leestagram.user.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.leestagram.user.dao.UserDAO;
import com.leestagram.user.model.User;

@Service
public class UserBO {
	@Autowired
	private UserDAO userDao;
	
	public boolean existLoginId(String loginId) {
		return userDao.existLoginId(loginId);
	}
	
	public void addUser(User user) {
		userDao.insertUser(user);
	}
}
