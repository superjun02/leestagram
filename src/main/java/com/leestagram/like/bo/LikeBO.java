package com.leestagram.like.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.leestagram.like.dao.LikeDAO;
import com.leestagram.like.model.Like;

@Service
public class LikeBO {
	@Autowired
	private LikeDAO likeDAO;
	
	public List<Like> getLikeList(int postId) {
		return likeDAO.selectLikeList(postId);
	}
	
	public boolean getLikeYn(int postId, int userId) {
		return likeDAO.selectLikeYn(postId, userId);
	}
	
	public void changeLike(int postId, int userId) {
		
		if (getLikeYn(postId, userId)) {
			likeDAO.deleteLike(postId, userId);
			return;
		}
		
		likeDAO.insertLike(postId, userId);
	}
}
