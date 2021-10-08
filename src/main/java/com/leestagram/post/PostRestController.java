package com.leestagram.post;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.leestagram.post.bo.PostBO;

@RequestMapping("/post")
@RestController
public class PostRestController {
	@Autowired
	private PostBO postBO;
	
	@PostMapping("/create")
	public Map<String, Object> create(
			@RequestParam("content") String content,
			@RequestParam(value = "file", required = false) MultipartFile file,
			HttpServletRequest request) {
		
		
		HttpSession session = request.getSession();
		Integer userId = (Integer) session.getAttribute("userId");
		String userLoginId = (String) session.getAttribute("userLoginId");
		String userName = (String) session.getAttribute("userName");
		
		Map<String, Object> result = new HashMap<>();
		result.put("result", "error");
		
		int row = postBO.createPost(userId, userLoginId, userName, content, file);
		if (row > 0) {
			result.put("result", "success");
		}
		
		return result;
	}
	
	@DeleteMapping("/delete")
	public Map<String, Object> delete(
			@RequestParam("postId") int postId) {
		
		// db postId 데이터 삭제
		postBO.deletePost(postId);
		
		// 결과 리턴
		Map<String, Object> result = new HashMap<>();
		result.put("result", "success");

		return result;
	}
}
