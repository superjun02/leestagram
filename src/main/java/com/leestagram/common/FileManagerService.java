package com.leestagram.common;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component    // 스프링 빈
public class FileManagerService {
	public final static String FILE_UPLOAD_PATH = "C:\\이상준\\6_spring_project\\quiz\\leestagram_workspace\\images/";

	public String saveFile(String loginId, MultipartFile file) throws IOException {
		
		String directoryName = loginId + "_" + System.currentTimeMillis() + "/";
		String filePath = FILE_UPLOAD_PATH + directoryName;
		
		File directory = new File(filePath);
		if (directory.mkdir() == false) {
			return null;
		} 
		
		byte[] bytes = file.getBytes();
		Path path = Paths.get(filePath + file.getOriginalFilename());
		Files.write(path, bytes);
		
		return "/images/" + directoryName + file.getOriginalFilename();
	}
	
	public void deleteFile(String imagePath) throws IOException {
		Path path = Paths.get(FILE_UPLOAD_PATH + imagePath.replace("/images/", ""));
		
		if (Files.exists(path)) {
			Files.delete(path);
		}
		path = path.getParent();
		if (Files.exists(path)) {
			Files.delete(path);
		}
	}
}