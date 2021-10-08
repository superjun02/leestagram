package com.leestagram.timeline;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.leestagram.timeline.bo.ContentBO;
import com.leestagram.timeline.model.Content;

@Controller
public class TimelineController {
	@Autowired
	private ContentBO contentBO;
	
	@RequestMapping("/timeline/timeline_view")
	public String timeline(Model model, HttpServletRequest request) {	
		HttpSession session = request.getSession();
		
//		if (session.getAttribute("userId") == null) {
//			session.setAttribute("userName", "unknown");	
//			session.setAttribute("userId", 0);
//		}
		Integer userId = (Integer) session.getAttribute("userId");
		
		List<Content> contentList = contentBO.getContentList(userId);
		
		model.addAttribute("contentList", contentList);
		model.addAttribute("viewName", "timeline/timeline");
		return "template/layout";
	}
}