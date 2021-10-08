package com.leestagram.comment.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.leestagram.comment.dao.CommentDAO;
import com.leestagram.comment.model.Comment;

@Service
public class CommentBO {
	@Autowired
	private CommentDAO commentDAO;
	
	public List<Comment> getCommentList(int postId) {
		return commentDAO.selectCommentList(postId);
	}

	public void insertComment(int postId, String content, int userId, String userName) {
		commentDAO.insertComment(postId, content, userId, userName);
	}
	
}
