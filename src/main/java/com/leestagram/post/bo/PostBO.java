package com.leestagram.post.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.leestagram.post.dao.PostDAO;
import com.leestagram.post.model.Post;

@Service
public class PostBO {
	@Autowired
	private PostDAO postDao;
	
	public List<Post> getPostListByUserId(int userId) {
		return postDao.selectPostListByUserId(userId);
	}
}
