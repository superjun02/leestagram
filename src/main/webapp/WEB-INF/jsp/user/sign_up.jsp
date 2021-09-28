<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="h-100 col-4">
	<b>이름</b> <input type="text" class="form-control" name="name" placeholder="이름을 입력해주세요" autocomplete="off">
	<br>
	<div>
		<b>아이디</b> <input type="text" class="form-control" name="loginId" placeholder="아이디를 입력해주세요" autocomplete="off"><br>
		<div class="d-flex justify-content-end">
			<button type="button" id="urlCheckBtn" class="btn btn-info btn-sm">중복확인</button>
		</div>
	</div>
	<b>비밀번호</b> <input type="password" class="form-control" name="password" placeholder="비밀번호를 입력해주세요" autocomplete="off"><br> 
	<b>비밀번호 확인</b> <input type="password" class="form-control" name="passwordChk" placeholder="비밀번호를 다시 입력해주세요" autocomplete="off"><br> 
	<b>프로필 이미지</b> <input type="text" class="form-control" name="profileUrl" placeholder="이미지 주소를 입력해주세요(선택)" autocomplete="off"><br>
	<div class="d-flex justify-content-end">
		<button type="button" class="btn btn-secondary col-4">회원가입</button>
	</div>
</div>