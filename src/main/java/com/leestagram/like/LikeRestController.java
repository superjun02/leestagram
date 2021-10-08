package com.leestagram.like;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.leestagram.like.bo.LikeBO;

@RestController
public class LikeRestController {
	@Autowired
	private LikeBO likeBO;
	
	@PostMapping("/like")
	public Map<String, Object> like(
			@RequestParam("postId") int postId
			,HttpServletRequest request) {
		Map<String, Object> result = new HashMap<>();
		HttpSession session = request.getSession();
		
		int userId = (int) session.getAttribute("userId");
		
		likeBO.changeLike(postId, userId);
		
		result.put("result", "success");
		return result;
	}
}
