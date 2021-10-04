package com.leestagram.post.bo;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.leestagram.common.FileManagerService;
import com.leestagram.post.dao.PostDAO;
import com.leestagram.post.model.Post;

@Service
public class PostBO {
	@Autowired
	private PostDAO postDao;
	
	@Autowired
	private FileManagerService fileManagerService;
	
	public List<Post> getPostListByUserId(int userId) {
		return postDao.selectPostListByUserId(userId);
	}
	
	public int createPost(int userId, String userLoginId, String userName, String content, MultipartFile file) {
		String imagePath = null;
		
		if (file != null) {
			try {
				imagePath = fileManagerService.saveFile(userLoginId, file);
			} catch (IOException e) {
				imagePath = null;
			}
		}
		
		return postDao.insertPost(userId, userName, content, imagePath);
	}
}
