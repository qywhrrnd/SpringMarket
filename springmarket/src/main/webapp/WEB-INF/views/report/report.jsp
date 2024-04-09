<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신고하기</title>
<script src="http://code.jquery.com/jquery-3.6.1.js"></script>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f4f4f4;
	margin: 0;
	padding: 0;
}

h2 {
	text-align: center;
}

form {
	width: 80%;
	margin: 0 auto;
	background-color: #fff;
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 20px;
}

th, td {
	padding: 10px;
	text-align: left;
}

input[type="text"], textarea {
	width: calc(100% - 20px);
	padding: 8px;
	border: 1px solid #ccc;
	border-radius: 4px;
	margin-bottom: 10px;
}

input[type="button"] {
	width: 100%;
	background-color: #3498db;
	color: #ffffff;
	border: none;
	padding: 10px 20px;
	border-radius: 5px;
	cursor: pointer;
	font-size: 16px;
}

input[type="button"]:hover {
	background-color: #2980b9;
}
</style>
<script>
	function report_detail() {
		let form1 = $("#form1");
		let subject = $("#subject").val();
		let contents = $("#contents").val();
		let userid = $("#userid").val();
		let link = $("#link").val();
		let reporter = $("#reporter").val();

		if (subject == "") {
			alert("제목을 입력하세요");
			$("#subject").focus();
			return;
		}
		if (contents == "") {
			alert("설명을 입력하세요");
			$("#contents").focus();
			return;
		}
		alert("신고되었습니다");
		form1.attr("action", "/report/report");
		form1.sumbit();
	}
</script>
</head>
<body>
	<h2>신고하기</h2>
	<form id="form1" name="form1" method="post">
		<table>
			<tr>
				<th>제목</th>
			</tr>
			<tr>
				<td><input type="text" id="subject" name="subject"
					placeholder="신고(제목)"></td>
			</tr>
			<tr>
				<th>신고할 사람</th>
			</tr>
			<tr>
				<td><input type="text" id="userid" name="userid"
					value="${map.userid}" readonly
					style="border: none; text-align: center;"></td>
			</tr>
			<tr>
				<th>신고 내용</th>
			</tr>
			<tr>
				<td><textarea rows="5" id="contents" name="contents"
						placeholder="신고 사유에 대해 설명해주세요"></textarea></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="text"
					value="${sessionScope.userid}" name="reporter" id="reporter">
					<input type="text" name="link" id="link" value="${map.link}">
					<input type="button" value="등록" onclick="report_detail()">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>