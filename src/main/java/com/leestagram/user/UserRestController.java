package com.leestagram.user;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.leestagram.common.EncryptUtils;
import com.leestagram.user.bo.UserBO;
import com.leestagram.user.model.User;

@RequestMapping("/user")
@RestController
public class UserRestController {
	@Autowired
	private UserBO userBo;
	
	
	@RequestMapping("/is_duplicated_id")
	public Map<String, Boolean> isDuplicatedId(
			@RequestParam("loginId") String loginId) {

		Map<String, Boolean> result = new HashMap<>();
		
		result.put("result", userBo.existLoginId(loginId));

		return result;
	}
	
	@PostMapping("/sign_up")
	public Map<String, Object> signUp(
			@RequestParam("loginId") String loginId,
			@RequestParam("password") String password,
			@RequestParam("name") String name,
			@RequestParam (value = "profileUrl", required = false) String profileUrl) {
		// 비밀번호 해싱
		String encryptPassword = EncryptUtils.md5(password);
		
		// DB user insert
		User user = new User();
		user.setLoginId(loginId);
		user.setName(name);
		user.setPassword(encryptPassword);
		user.setProfileUrl(profileUrl);
		
		userBo.addUser(user);
		// 응답값 생성 후 리턴
		Map<String, Object> result = new HashMap<>();
		
		result.put("result", "success");
		return result;
	}
}
