<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트 추가</title>
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
	color: black;
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
	text-align: center;
}

input[type="text"], textarea {
	width: calc(100% - 20px);
	padding: 8px;
	border: 1px solid #ccc;
	border-radius: 4px;
	margin-bottom: 10px;
}

input[type="button"] {
	width: 48%;
	background-color:orange;;
	color: black;
	border: none;
	padding: 10px 20px;
	border-radius: 5px;
	cursor: pointer;
	font-size: 16px;
	margin-right: 2%;
}
</style>
<script>
function btnInsert() {
   let form1 = $("#form1");
   let question = $("#question").val();
   let ans1 = $("#ans1").val();
   let ans2 = $("#ans2").val();
   let ans3 = $("#ans3").val();
   let ans4 = $("#ans4").val();
   let status = $("#status").val();
   
   if (question == "") {
        alert("문제의 제목을 입력하세요");
        $("#question").focus();
        return;
     }
     if (ans1 == "") {
        alert("1번을 입력하세요");
        $("#ans1").focus();
        return;
     }
     if (ans2 == "") {
        alert("2번을 입력하세요");
        $("#ans2").focus();
        return;
     }
     if (ans3 == "") {
        alert("3번을 입력하세요");
        $("#ans3").focus();
        return;
     }
     if (ans4 == "") {
        alert("4번을 입력하세요");
        $("#ans4").focus();
        return;
     }
     status = parseInt(status);
     if (isNaN(status) || status < 1 || status > 4) {
         alert("정답은 1부터 4까지의 숫자여야 합니다");
         $("#status").focus();
         return;
     }
     alert("추가하였습니다.");
     form1.attr("action", "/market/quiz_servlet/quiz_Insert.do");
     form1.submit();
 }

</script>
</head>
<body>
	<h2>이벤트 추가</h2>
	<form id="form1" name="form1" method="post">
		<table>
			<tr>
				<th>문제</th>
			</tr>
			<tr>
				<td><input type="text" id="question" name="question"
					placeholder="문제 입력"> <input type="hidden" id="quiz_idx"
					name="quiz_idx"></td>
			</tr>
			<tr>
				<th>문제 목록 작성</th>
			</tr>
			<tr>
				<td><input type="text" id="ans1" name="ans1"
					placeholder="1번 문제"> <input type="text" id="ans2"
					name="ans2" placeholder="2번 문제"> <input type="text"
					id="ans3" name="ans3" placeholder="3번 문제"> <input
					type="text" id="ans4" name="ans4" placeholder="4번 문제"></td>
			</tr>
			<tr>
				<td><input type="text" id="status" name="status"
					placeholder="정답"></td>
			</tr>

			<tr>
				<td>
				<input type="button" value="등록" onclick="btnInsert()"></td>
			</tr>
			<tr>
				<td>
				<input type="button" value="취소" onclick="btnCancel()">

			</td>
		</tr>
		</table>
	</form>

</body>
</html>