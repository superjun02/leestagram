<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="d-flex justify-content-center pt-3">
	<div class="col-6">
		<div class="textarea-container">
			<textarea rows="6" id="content" class="form-control" placeholder="내용을 입력해주세요"></textarea>
			<div class="d-flex">
				<input type="file" id="file" class="d-none" accept=".jpg,.jpeg,.png,.gif">
				<a href="#" id="imgBtn" class="btn btn-secondary btn-sm">img</a>
				<div id="fileName">
				</div>
			</div>
			<div>
				<button type="button" id="addBtn" class="btn btn-primary btn-sm">업로드</button>
			</div>
		</div>
		<c:forEach var="post" items="${postList}">
			<div class="userNameBox bg-info w-100 d-flex justify-content-between mt-4">
				<div class="pt-2 pb-2 pl-3">
					<span class="font-weight-bold">${userName}</span>
				</div>
				<div class="pr-2 pt-1">
					<button type="button" class="btn btn-sm btn-info font-weight-bold" >· · ·</button>
				</div>
			</div>
			
			<div class="imageBox mt-2">
				<div class="d-flex justify-content-center w-100">
					<img alt="" src="${post.imagePath}" width="94%" height="350">
				</div>
				
				<div class="w-100 pl-3 pt-2">
					<b>${post.userName}</b> ${post.content} 
				</div>
			</div>
		</c:forEach>
	</div>
</div>
<script>
	$(document).ready(function() {
		$('#imgBtn').on('click', function(e) {
			e.preventDefault(); // 기본 작동 중지
			$('#file').click(); // input file을 클릭한 것과 같은 동작
		});
		
		$('#file').on('change', function(e) {
			var name = e.target.files[0].name;
			
			let file = $('#file').val();
			if (file != '') {
				let ext = file.split('.').pop().toLowerCase();
				if ($.inArray(ext, ['jpg', 'jpeg', 'png', 'gif']) == -1) {
					alert("이미지 파일만 업로드 할 수 있습니다.");
					
					$('#file').val('');
					return;
				}
			}
			 
			 $("#fileName").text(name);
		});
		
		$('#addBtn').on('click', function() {
			
			let content = $('#content').val();
			
			if (content == '') {
				alert("내용을 입력해주세요")
				return;
			}
			
			let file = $('#file').val();
			
			if (file != '') {
				let ext = file.split('.').pop().toLowerCase();
				if ($.inArray(ext, ['jpg', 'jpeg', 'png', 'gif']) == -1) {
					alert("이미지 파일만 업로드 할 수 있습니다.");
					
					$('#file').val('');
					return;
				}
			}
			
			// form 태그를 자바스크립트에서 만든다.
			var formData = new FormData();
			formData.append("content", content);
			formData.append("file", $('#file')[0].files[0]);
			
			// ajax
			$.ajax({
				type: 'POST'
				, url: '/post/create'
				, data: formData
				, enctype: 'multipart/form-data'      // 파일 업로드 필수 설정
				, processData: false      // 파일 업로드 필수 설정
				, contentType: false      // 파일 업로드 필수 설정
				, success: function(data) {
					if (data.result == 'success') {
						alert("게시글이 업로드되었습니다.");
						location.href = "/timeline/timeline_view";
					}
				}, error: function(e) {
					alert("게시글 업로드에 실패했습니다." + e);
				}
			});
		});
	});
</script>