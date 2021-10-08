package com.leestagram.timeline.model;

import java.util.List;

import com.leestagram.comment.model.Comment;
import com.leestagram.post.model.Post;

public class Content {
	// 글 1개
	private Post post;

	// 댓글 N개
	private List<Comment> commentList;

	// 내가 한 좋아요
	private boolean likeYn; // true 좋아요 false 좋아요 해제

	// 좋아요 총 개수
	private int likeCount;

	public Post getPost() {
		return post;
	}

	public void setPost(Post post) {
		this.post = post;
	}

	public List<Comment> getCommentList() {
		return commentList;
	}

	public void setCommentList(List<Comment> commentList) {
		this.commentList = commentList;
	}

	public boolean isLikeYn() {
		return likeYn;
	}

	public void setLikeYn(boolean likeYn) {
		this.likeYn = likeYn;
	}

	public int getLikeCount() {
		return likeCount;
	}

	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}
}
