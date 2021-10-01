package com.leestagram.post.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.leestagram.post.model.Post;

@Repository
public interface PostDAO {
	public List<Post> selectPostListByUserId(int userId);
}
