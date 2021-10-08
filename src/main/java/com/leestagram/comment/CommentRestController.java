package com.leestagram.comment;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.leestagram.comment.bo.CommentBO;

@RequestMapping("/comment")
@RestController
public class CommentRestController {
	@Autowired
	private CommentBO commentBO;
	
	@PostMapping("/create")
	public Map<String, Object> create(HttpServletRequest request
			,@RequestParam("commentText") String content
			,@RequestParam("postId") int postId) {
		HttpSession session = request.getSession();
		
		int userId = (int) session.getAttribute("userId");
		String userName = (String) session.getAttribute("userName");
		
		commentBO.insertComment(postId, content, userId, userName);
		
		Map<String, Object> result = new HashMap<>();
		result.put("result", "success");
		 
		return result;
	}
}
