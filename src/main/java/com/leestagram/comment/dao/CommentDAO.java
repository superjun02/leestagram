package com.leestagram.comment.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import com.leestagram.comment.model.Comment;

@Service
public interface CommentDAO {

	public List<Comment> selectCommentList(int postId);

	public void insertComment(
			@Param("postId") int postId
			, @Param("content") String content
			, @Param("userId") int userId
			, @Param("userName") String userName);
}
