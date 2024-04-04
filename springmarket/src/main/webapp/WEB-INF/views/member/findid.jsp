<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="/resources/mycss/login.css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	// 문서가 준비되었을 때 실행
		function findid_result() {
			let name = document.getElementById("name").value;
			let birth = document.getElementById("birth").value;
			let phone = document.getElementById("phone").value;

			$.ajax({
				url : "/member/findId.do",
				type : "POST",
				data : {
					"name" : name,
					"birth" : birth,
					"phone" : phone
				},
				dataType : "json", // 서버로부터 받을 데이터 형식을 JSON으로 지정
				success : function(response) {
				
						alert(response.message);
						location.href = response.url;
				},
				error : function(xhr, status, error) {
					console.error("에러 발생:", status, error);
				}
			});
		}
</script>

<style>
</style>
</head>
<body>
	<%@ include file="../main/menu.jsp"%>
	<div class="container">
		<!-- Heading -->
		<h1>아이디 찾기</h1>
		<!-- 아이디 넣기 -->
		<form method="post">
			<div class="first-input input__block first-input__block">
				<input placeholder="이름" class="input" id="name" name="name" />
			</div>
			<!-- 비밀번호 넣기 -->
			<div class="input__block">
				<input type="number" placeholder="생년월일" class="input" id="birth"
					name="birth" />
			</div>


			<div class="input__block">
				<input type="text" placeholder="'-'를 빼고 입력해주세요" class="input"
					id="phone" name="phone" />
			</div>
			<!-- 아이디 찾기 버튼 -->
			<div>
				<button type="button" class="signin__btn" onclick="findid_result()">아이디
					찾기</button>
			</div>
		</form>
		<br>
	</div>

</body>
</html>