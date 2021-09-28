package com.leestagram.user.dao;

import org.springframework.stereotype.Repository;

import com.leestagram.user.model.User;

@Repository
public interface UserDAO {
	public boolean existLoginId(String loginId);
	
	public void insertUser(User user);
}
