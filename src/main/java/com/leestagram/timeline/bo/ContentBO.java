package com.leestagram.timeline.bo;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.leestagram.comment.bo.CommentBO;
import com.leestagram.comment.model.Comment;
import com.leestagram.like.bo.LikeBO;
import com.leestagram.like.model.Like;
import com.leestagram.post.bo.PostBO;
import com.leestagram.post.model.Post;
import com.leestagram.timeline.model.Content;

@Service
public class ContentBO {
	@Autowired
	private PostBO postBO;
	
	@Autowired
	private LikeBO likeBO;
	
	@Autowired
	private CommentBO commentBO;

	public List<Content> getContentList(Integer userId) {
		List<Content> contentList = new ArrayList<>();
		
		List<Post> postList = postBO.getPostList();
		
		// 하나하나씩 postId를 추출해서
		Iterator<Post> itr = postList.iterator();
		
		while (itr.hasNext()) {
			Content content = new Content();
			Post post = itr.next();
			int postId = post.getId();
			
			// Post 삽입
			content.setPost(post);
			
			// 코멘트 리스트 삽입
			List<Comment> commentList = commentBO.getCommentList(postId);
			content.setCommentList(commentList);
			
			// 좋아요 개수 삽입
			List<Like> likeList = likeBO.getLikeList(postId);
			
			int likeCount = likeList.size();
			
			content.setLikeCount(likeCount);
			
			// 좋아요 상태 삽입
			if (userId != null) {
				content.setLikeYn(likeBO.getLikeYn(postId, userId));
			}
			
			
			contentList.add(content);
		}
		
		return contentList;
	}

	public List<Content> getContentList(Integer loginUserId, int userId) {
List<Content> contentList = new ArrayList<>();
		
		List<Post> postList = postBO.getPostListByUserId(userId);
		
		// 하나하나씩 postId를 추출해서
		Iterator<Post> itr = postList.iterator();
		
		while (itr.hasNext()) {
			Content content = new Content();
			Post post = itr.next();
			int postId = post.getId();
			
			// Post 삽입
			content.setPost(post);
			
			// 코멘트 리스트 삽입
			List<Comment> commentList = commentBO.getCommentList(postId);
			content.setCommentList(commentList);
			
			// 좋아요 개수 삽입
			List<Like> likeList = likeBO.getLikeList(postId);
			
			int likeCount = likeList.size();
			
			content.setLikeCount(likeCount);
			
			// 좋아요 상태 삽입
			if (loginUserId != null) {
				content.setLikeYn(likeBO.getLikeYn(postId, loginUserId));
			}
			
			
			contentList.add(content);
		}
		
		return contentList;
	}
	
}
