<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="/resources/mycss/login.css" rel="stylesheet" />
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function findpwd_result() {
		let userid = $("#userid").val();
		document.form2.action = "/member/findPwd.do";
		document.form2.submit();
	}
</script>
</head>
<body>
	<%@ include file="../main/menu.jsp"%>
	${alertScript}
	<div class="container">
		<h1>비밀번호 찾기</h1>
		<form method="post" name="form2">
			<div class="first-input input__block first-input__block">
				<input placeholder="아이디를 입력하세요." class="input" id="userid"
					name="userid">
			</div>
			<!-- 비밀번호 넣기 -->
			<div>
				<button type="submit" class="signin__btn" onclick="findpwd_result()">비밀번호
					찾기</button>
			</div>
		</form>
	</div>
</body>
</html>