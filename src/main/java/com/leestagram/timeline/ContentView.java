package com.leestagram.timeline;

import java.util.List;

import com.leestagram.comment.model.Comment;
import com.leestagram.post.model.Post;

public class ContentView {
	// 글 1개
	private Post post;
	
	// 댓글 N개
	private List<Comment> commentList;
	
	// 내가 한 좋아요
	private boolean likeYn; // true 좋아요   false 좋아요 해제
	
	// 좋아요 총 개수
	private int likeCount;
}
