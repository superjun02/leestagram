package com.leestagram.test;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.leestagram.test.bo.TestBO;

@Controller
public class TestController {
	@Autowired
	private TestBO testBo;

	@ResponseBody
	@RequestMapping("/test1")
	public String helloWorld() {
		return "Hello world!";
	}

	// DB 연동 테스트
	@RequestMapping("/test2")
	@ResponseBody
	public List<Map<String, Object>> test2() {
		return testBo.getUserList();
	}

	// jsp 연동 테스트
	@RequestMapping("/test3")
	public String test3() {
		return "test/test";
	}
}
