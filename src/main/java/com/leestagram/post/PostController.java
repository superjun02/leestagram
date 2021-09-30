package com.leestagram.post;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/post")
@Controller
public class PostController {
	@RequestMapping("/my_post")
	public String myPost() {
		return "template/post_layout";
	}
}
