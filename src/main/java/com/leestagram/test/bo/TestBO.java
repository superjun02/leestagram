package com.leestagram.test.bo;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.leestagram.test.dao.TestDAO;

@Service
public class TestBO {
	@Autowired
	private TestDAO testDao;
	
	public List<Map<String, Object>> getUserList() {
		return testDao.selectUserList();
	}
}
