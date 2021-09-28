<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="h-100 col-4">
	<form id="signUpForm" method="post" action="/user/sign_up">
		<b>이름</b> <input type="text" class="form-control" id="name" name="name" placeholder="이름을 입력해주세요" autocomplete="off">
		<br>
		<div>		
			<b>아이디</b> <input type="text" class="form-control" id="loginId" name="loginId" placeholder="아이디를 입력해주세요" autocomplete="off">
			<div class="d-flex">
				<div class="w-75">
					<div id="idCheckLength" class="small text-danger d-none">ID를 4자 이상 입력해주세요.</div>
					<div id="idCheckDuplicated" class="small text-danger d-none">이미 사용중인 ID입니다.</div>
					<div id="idCheckOk" class="small text-success d-none">사용 가능한 ID 입니다.</div>
				</div>
				<button type="button" id="idCheckBtn" class="btn btn-info btn-sm w-25">중복확인</button>
			</div>
		</div>
		<b>비밀번호</b> <input type="password" class="form-control" id="password" name="password" placeholder="비밀번호를 입력해주세요" autocomplete="off"><br> 
		<b>비밀번호 확인</b> <input type="password" class="form-control" id="passwordChk" name="passwordChk" placeholder="비밀번호를 입력해주세요" autocomplete="off"><br> 
		<b>프로필 이미지</b> <input type="text" class="form-control" id="profileUrl" name="profileUrl" placeholder="이미지 주소를 입력해주세요" autocomplete="off"><br>
		<div class="d-flex justify-content-end">
			<button type="button" class="btn btn-secondary col-4" id="signUpBtn">회원가입</button>
		</div>
	</form>
</div>

<script>
	$(document).ready(function() {
		var idData = "";

		$('#idCheckBtn').on('click', function() {
			let loginId = $('#loginId').val().trim();
			
			if (loginId.length < 4) {
				$('#idCheckLength').removeClass('d-none'); // 경고문구 노출
				$('#idCheckDuplicated').addClass('d-none');
				$('#idCheckOk').addClass('d-none');
				return;
			}
			
			$.ajax({
				type: 'get'
				, url: '/user/is_duplicated_id'
				, data: {'loginId':loginId}
				, success: function(data) {
					
					if (data.result) {
						// 중복이다.
						$('#idCheckDuplicated').removeClass('d-none');
						$('#idCheckLength').addClass('d-none');
						$('#idCheckOk').addClass('d-none');
					} else {
						// 중복이 아니다
						$('#idCheckOk').removeClass('d-none');
						$('#idCheckDuplicated').addClass('d-none');
						$('#idCheckLength').addClass('d-none');
					}
				}, error: function(e) {
					alert("아이디 중복확인에 실패했습니다. 관리자에게 문의해주세요.")
				}
			});
			
			idData = loginId;
		})
		
		$('#signUpBtn').on('click', function() {
			let name = $('#name').val().trim();
			let loginId = $('#loginId').val().trim();
			let password = $('#password').val().trim();
			let passwordChk = $('#passwordChk').val().trim();
			let profileUrl = $('#profileUrl').val().trim();
			
			if (name == '') {
				alert("이름을 입력해주세요");
				return;
			}
			
			if (loginId == '') {
				alert("아이디를 입력해주세요.");
				return;
			}
			
			if (password == '' || passwordChk == '') {
				alert("비밀번호를 입력해주세요.");
				return;
			}
			
			if (password != passwordChk) {
				alert("비밀번호가 일치하지 않습니다.");
				$('#password').val('');
				$('#passwordChk').val('');				
				return;
			}
			
			if ($('#idCheckOk').hasClass('d-none') || idData != loginId) {
				alert("아이디 중복확인을 해주세요");
				return;
			}
			
			var url = "/user/sign_up";
			var data = $('#signUpForm').serialize();
			
			$.post(url, data)
			.done(function(data) {
				if (data.result == "success") {
					alert("가입을 환영합니다!!! 로그인을 해주세요.");				
					location.href="/user/sign_in_view";
				} else {
					alert("가입에 실패했습니다. 다시 시도해주세요.");
				}
			});
		});
	});
</script>