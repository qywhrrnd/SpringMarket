<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Insert title here</title>

<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>

<script>
	function update_passwd(userid) {
		let form1 = $("#form1");
		let passwd1 = document.form1.passwd1.value;
		let passwd2 = document.form1.passwd2.value;
		let checkpasswd = document.form1.checkpasswd.value;

		if (passwd1 == "") {
			alert("기존 비밀번호를 입력하세요");
			document.form1.passwd1.focus();
			return;
		}
		if (passwd2 == "") {
			alert("새 비밀번호를 입력하세요");
			document.form1.passwd2.focus();
			return;
		}
		if (checkpasswd == "") {
			alert("새 비밀번호 확인을 입력하세요");
			document.form1.checkpasswd.focus();
			return;

		}

		if (passwd2 !== checkpasswd) {
			alert("비밀번호를 확인해주세요");
			document.form1.passwd2.focus();
			return;
		} else if (passwd1 == passwd2) {
			alert("기존 비밀번호와 다르게 해주세요");
			document.form1.passwd2.focus();
			return;
		} else {
			document.form1.action = "/member/changepasswd.do";
			document.form1.submit();
		}

	}

	function cancel() {
		if (confirm("변경을 취소하시겠습니까?")) {
			window.close();

		}
	}
</script>
<style>
body {
	font-family: 'Arial', sans-serif;
	background-color: #f5f5f5;
	margin: 0;
	padding: 0;
}

table {
	margin: 20px auto;
	background-color: white;
	border: 1px solid #ddd;
	border-collapse: collapse;
	width: 50%;
}

td {
	padding: 10px;
	border: 1px solid #ddd;
}

input {
	padding: 5px; /* 입력 필드의 여백을 줄임 */
	margin: 2px;
}

#result, #emailresult {
	color: red;
}

.zip-code-group {
	display: flex;
	align-items: center;
}

#post_code {
	flex: 1;
}

#updateButton, #loginButton {
	background-color: #4CAF50;
	color: white;
	border: none;
	padding: 8px 16px; /* 버튼의 크기를 작게 조절 */
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 14px; /* 버튼의 글자 크기를 작게 조절 */
	margin: 4px 2px;
	cursor: pointer;
	border-radius: 4px;
	margin-top: 10px; /* 버튼을 아래로 내림 */
}

/* 푸터 스타일 */
#footer {
	clear: both;
	text-align: center;
	padding: 5px;
	border-top: 1px solid #bcbcbc;
	position: relative; /* 푸터를 화면 하단에 고정시킴 */
	bottom: 0;
	width: 100%;
	background-color: white;
}
</style>

</head>
<body>
	<%@ include file="../main/menu.jsp"%>
	${alertScript}
	<form name="form1" method="post">
		<h2 align="center">비밀번호 변경</h2>
		<p align="center" style="color: red;">
			<em>다른 아이디/사이트에서 사용한 적 없는 비밀번호</em>
		<p align="center">
			<em style="color: red;">이전에 사용한 적 없는 비밀번호</em>가 안전합니다.
		<hr>
		<br>
		<table>
			<tr align="center">
				<td colspan="2"><input type="password" placeholder="기존비밀번호"
					name="passwd1"></td>
			</tr>
			<tr align="center">
				<td colspan="2"><input type="password" placeholder="새 비밀번호"
					name="passwd2"></td>
			</tr>
			<tr align="center">
				<td colspan="2"><input type="password" placeholder="새 비밀번호 확인"
					name="checkpasswd"></td>
			</tr>

			<tr align="center">
				<td colspan="2"><input type="hidden" name="userid"
					value="${userid}"> <input type="button" id="updateButton"
					value="수정" onclick="update_passwd()"> <input type="button"
					value="취소" onclick="cancel()"></td>
			</tr>

		</table>

	</form>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<div id="footer">
		<%@ include file="../main/footer.jsp"%>
	</div>
</body>
</html>