<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="d-flex justify-content-center pt-3">
	<div class="col-6">
		<div class="textarea-container mb-4">
			<textarea rows="6" name="foo" class="form-control">내용을 입력해주세요</textarea>
			<div>
				<a href="#" id="imgBtn" class="btn btn-secondary btn-sm">img</a>
			</div>
			<div>
				<button id="addBtn" class="btn btn-primary btn-sm">업로드</button>
			</div>
		</div>
		
		<div class="userNameBox bg-info w-100 d-flex justify-content-between">
			<div class="pt-2 pb-2 pl-3">
				<span class="font-weight-bold">${userName}</span>
			</div>
			<div class="pr-2 pt-1">
				<button type="button" class="btn btn-sm btn-info font-weight-bold" >· · ·</button>
			</div>
		</div>
		
		<div class="imageBox mt-2">
			<c:forEach var="post" items="${postList}">
				<div class="d-flex justify-content-center w-100">
					<img alt="" src="${post.imagePath}" width="94%" height="350">
				</div>
				
				<div class="w-100 pl-3 pt-2">
					<b>${post.userName}</b> ${post.content} 
				</div>
			</c:forEach>
		</div>
	</div>
</div>