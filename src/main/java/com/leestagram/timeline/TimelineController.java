package com.leestagram.timeline;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.leestagram.timeline.bo.ContentBO;
import com.leestagram.timeline.model.Content;

@Controller
public class TimelineController {
	@Autowired
	private ContentBO contentBO;
	
	@RequestMapping("/timeline/timeline_view")
	public String timeline(Model model, HttpServletRequest request
			, @RequestParam(value="userId", required = false) Integer userId) {	
		HttpSession session = request.getSession();
		
		Integer loginUserId = (Integer) session.getAttribute("userId");
		
		List<Content> contentList = contentBO.getContentList(loginUserId);
		
		if (userId != null) {
			model.addAttribute("profileUserId", userId);
		}
		model.addAttribute("contentList", contentList);

		model.addAttribute("viewName", "timeline/timeline");
		return "template/layout";
	}
}