<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="d-flex justify-content-center pt-3">
	<div class="col-6">
		<c:if test="${not empty userId}">
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
		</c:if>
		<c:forEach var="content" items="${contentList}">
			<div class="userNameBox bg-info w-100 d-flex justify-content-between mt-4">
				<div class="pt-2 pb-2 pl-3">
					<span class="font-weight-bold">${content.post.userName}</span>
				</div>
				<c:if test="${content.post.userName eq userName}">
				<div class="pr-2 pt-1">
					<!-- Button trigger modal -->
					<button type="button" class="more-btn btn btn-sm btn-info font-weight-bold" data-toggle="modal" 
					data-target="#exampleModal" data-post-id="${content.post.id}">
					  · · ·
					</button>
					
					<!-- Modal -->
					<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
					  <div class="modal-dialog" role="document">
					    <div class="modal-content">
					      <div class="modal-header">
					        <h5 class="modal-title" id="exampleModalLabel">게시글 삭제</h5>
					        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
					          <span aria-hidden="true">&times;</span>
					        </button>
					      </div>
					      <div class="modal-body">
					        게시글을 삭제 하시겠습니까?
					      </div>
					      <div class="modal-footer">
					        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
					        <button type="button" class="del-post btn btn-primary">삭제하기</button>
					      </div>
					    </div>
					  </div>
					</div>
				</div>
				</c:if>
			</div>
			
			<div class="imageBox mt-2">
				<c:if test="${not empty content.post.imagePath}">
					<div class="d-flex justify-content-center w-100">
						<img alt="" src="${content.post.imagePath}" width="94%" height="350">
					</div>
				</c:if>
				<div class="pt-2 pl-3 pr-3 d-flex">
					<c:if test="${not empty userId}">
						<a href="#" class="likeBtn" data-post-id="${content.post.id}">
							<c:if test="${content.likeYn eq true}">
								<img alt="like" src="\static\image\like.png" width="25" height="25">		
							</c:if>
							<c:if test="${content.likeYn eq false}">
								<img alt="heart" src="\static\image\heart.png" width="25" height="25">		
							</c:if>	
						</a>
					</c:if>
					<button type="button" class="d-none">.</button>
					<div class="pl-2 pt-1">
						좋아요 ${content.likeCount}개
					</div>
				</div>
				
				<div class="w-100 pl-3 pt-2 pr-3">
					<b>${content.post.userName}</b> ${content.post.content} 
				</div>
				
				<div class="pl-3 pr-3">
					<div class="bg-info w-100 d-flex justify-content-between mt-2">
						<div class="pt-1 pb-1 pl-2">
							<span class="font-weight-bold">댓글</span>
						</div>
					</div>
				</div>
				
				<div class="pt-1 pl-3 pr-3">
					<c:forEach var="reply" items="${content.commentList}">
						<div>
							<b>${reply.userName}</b> ${reply.content}
						</div>
					</c:forEach>
				</div>
				<c:if test="${not empty userId}">
					<div class="input-group pt-2 pl-3 pr-3">
						<input type="text" id="commentText${content.post.id}" class="form-control">
						<div class="input-group-prepend">
							<button type="button" class="commentBtn btn btn-primary" data-post-id="${content.post.id}">추가</button>
						</div>
					</div>
				</c:if>
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
		
		$('.more-btn').on('click', function() {
			let postId = $(this).data('post-id');
			
			$('#exampleModal').data('post-id', postId);
		});
		
		$('#exampleModal .del-post').on('click', function() {
			let postId = $('#exampleModal').data('post-id');
			
			$.ajax({
				type: 'delete'
				, url: '/post/delete'
				, data: {'postId':postId}
				, success: function(data) {
					if (data.result == 'success') {
						alert('삭제 되었습니다');
						location.href = '/timeline/timeline_view';
					}
				}, error: function(e) {
					alert("메모를 삭제하는데 실패했습니다. " + e);
				}
			});
		});
		
		$('.likeBtn').on('click', function(e) {
			e.preventDefault();
			
			let postId = $(this).data('post-id');
		
			$.ajax({
				type: 'post'
				, url: '/like'
				, data: {'postId':postId}
				, success: function(data) {
					if (data.result == 'success') {
						location.reload();
					}
				}, error: function(e) {
					alert("좋아요를 실패했습니다. " + e);
				}
			});
		});
		
		$('.commentBtn').on('click', function(e) {
			e.preventDefault();
			
			let postId = $(this).data('post-id');
			
			let commentText = $('#commentText' + postId).val();
			
			if (commentText == '') {
				alert("댓글을 입력하세요");
				return;
			}
			
			$.ajax({
				type: 'post'
				, url: '/comment/create'
				, data: {'postId':postId, 'commentText':commentText}
				, success: function(data) {
					if (data.result == 'success') {
						location.reload();
					}
				}, error: function(e) {
					alert("댓글쓰기를 실패했습니다. " + e);
				}
			});
		});
	});
</script>