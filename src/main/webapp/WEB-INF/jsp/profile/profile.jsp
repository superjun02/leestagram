<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="d-flex justify-content-center pt-3">
	<div class="col-6">
		<div class="textarea-container">
			<div>
				${profileUserName }
			</div>
		</div>	
		<c:forEach var="content" items="${contentList}">
			<div class="userNameBox w-100 d-flex justify-content-between mt-4">
				<div class="pt-2 pb-2 pl-3">
					<span class="font-weight-bold">
						<a href="/profile/profile_view?userId=${content.post.userId}">
							${content.post.userName}
						</a>
					</span>
				</div>
				<c:if test="${content.post.userName eq userName}">
				<div class="pr-2 pt-1">
					<!-- Button trigger modal -->
					<button type="button" class="more-btn btn btn-sm font-weight-bold" data-toggle="modal" 
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
					<a href="/profile/profile_view?userId=${content.post.userId}">
						<b>${content.post.userName}</b> 
					</a>
					${content.post.content} 
				</div>
				<div class="pl-3 pr-3">
					<div class="replyBox w-100 d-flex justify-content-between mt-2">
						<div class="pt-1 pb-1 pl-2">
							<span class="font-weight-bold">댓글</span>
						</div>
					</div>
				</div>
				
				<div class="pt-1 pl-3 pr-3">
					<c:forEach var="reply" items="${content.commentList}">
						<div>
							<a href="/profile/profile_view?userId=${reply.userId}">
								<b>${reply.userName}</b> 
							</a>
							${reply.content}
						</div>
					</c:forEach>
				</div>
				<c:if test="${not empty userId}">
					<div class="input-group pt-2 pl-3 pr-3">
						<input type="text" id="commentText${content.post.id}" class="form-control">
						<div class="input-group-prepend">
							<a href="#" class="commentBtn" data-post-id="${content.post.id}">
								<img src="\static\image\plus.png" alt="plus" width="38" height="38">
							</a>
						</div>
					</div>
				</c:if>
			</div>
		</c:forEach>
	</div>
</div>
<script>
	$(document).ready(function() {		
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