package com.leestagram.like.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.leestagram.like.model.Like;

@Repository
public interface LikeDAO {

	public List<Like> selectLikeList(int postId);

	public boolean selectLikeYn(
			@Param("postId") int postId
			, @Param("userId") int userId);

	public void deleteLike(
			@Param("postId") int postId
			, @Param("userId") int userId);

	public void insertLike(
			@Param("postId") int postId
			, @Param("userId") int userId);
}