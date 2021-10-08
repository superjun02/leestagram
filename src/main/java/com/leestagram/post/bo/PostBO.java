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
	private PostDAO postDAO;
	
	@Autowired
	private FileManagerService fileManagerService;
	
	public List<Post> getPostList() {
		return postDAO.selectPostList();
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
		
		return postDAO.insertPost(userId, userName, content, imagePath);
	}
	
	public Post getPost(int postId) {
		return postDAO.selectPost(postId);
	}
	
	public void deletePost(int postId) {
		// postId로 post를 가져온다.
		Post post = getPost(postId);
		if (post == null) {
			return;
		}
		
		// 그림이 있으면 삭제한다.
		String imagePath = post.getImagePath();
		
		if (imagePath != null) {	
			try {
				fileManagerService.deleteFile(imagePath);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		// 포스트를 삭제한다.
		postDAO.deletePost(postId);
	
	}
}
