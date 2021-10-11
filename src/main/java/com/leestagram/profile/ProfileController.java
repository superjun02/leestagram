package com.leestagram.profile;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.leestagram.timeline.bo.ContentBO;
import com.leestagram.timeline.model.Content;
import com.leestagram.user.bo.UserBO;

@Controller
public class ProfileController {
	@Autowired
	private ContentBO contentBO;
	
	@Autowired
	private UserBO userBO;
	
	@GetMapping("/profile/profile_view")
	public String profile(@RequestParam("userId") int userId,
			Model model,
			HttpServletRequest request) {
		HttpSession session = request.getSession();
		Integer loginUserId = (Integer) session.getAttribute("userId");
		
		List<Content> contentList = contentBO.getContentList(loginUserId, userId);
		String userName = userBO.getUserNameByUserId(userId);
				
		model.addAttribute("contentList", contentList);
		model.addAttribute("viewName", "profile/profile");
		model.addAttribute("profileUserName", userName);
		
		return "template/layout";
	}
}
