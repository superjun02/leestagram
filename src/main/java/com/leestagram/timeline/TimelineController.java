package com.leestagram.timeline;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.leestagram.post.bo.PostBO;
import com.leestagram.post.model.Post;

@Controller
public class TimelineController {
	@Autowired
	private PostBO postBo;
	
	@RequestMapping("/timeline/timeline_view")
	public String timeline(Model model, HttpServletRequest request) {		
		List<Post> postList = postBo.getPostList();
		
		model.addAttribute("postList", postList);
		model.addAttribute("viewName", "timeline/timeline");
		return "template/layout";
	}
}