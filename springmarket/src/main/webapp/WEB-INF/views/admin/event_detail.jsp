<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>

function insert() {
	  var url = "/quiz/pagequiz";
   
    // 팝업 창 크기 설정
    var popupWidth = 600;
    var popupHeight = 700;

    // 화면 가운데에 위치 계산
    var left = (window.innerWidth - popupWidth) / 2;
    var top = (window.innerHeight - popupHeight) / 2;

    // 작은 팝업 창을 열기 위한 코드
    window.open(url,'_blank','width=' + popupWidth + ',height=' + popupHeight + ',left=' + left + ',top=' + top);
    window.close();
}
</script>
<style>
#main_content {
	width: 60%;
	height: auto;
	padding: 20px;
	margin: 0 auto; /* 가운데 정렬 */
	box-sizing: inherit; /* 패딩, 테두리를 요소의 크기에 포함시킴 */
}

body {
	font-family: Arial, sans-serif;
	background-color: #f4f4f4;
	margin: 0;
	padding: 0;
}

#h2 {
	text-align: left;
	color: #6C5B7B;
	width: 50%;
}

table {
	width: 70%;
	margin: 0 auto;
	border-collapse: collapse;
	margin-top: 20px;
}

td {
	padding: 1px;
	text-align: left;
}

input[type="button"] {
	width: 30%;
	background-color: #B2B2FF;
	color: white;
	border: none;
	padding: 10px 20px;
	border-radius: 5px;
	cursor: pointer;
	font-size: 16px;
	margin-right: 2%;
}
</style>

</head>
<body>
	<%@ include file="../admin/admin_menu.jsp"%>
	<div id="main_content" align="center">
		<form method="post" name="form1">
			<c:forEach var="row" items="${list}">
				<table>
					<tr >
						<td>
				<h2 style="display: inline;" id="h2">${row.quiz_idx}.${row.question}</h2>
				<h4 style="display: inline;">정답:${row.status}</h4>
						</td>
					</tr>
					<tr>
						<td>1. ${row.ans1}&nbsp;&nbsp;2. ${row.ans2}</td>

					</tr>
					<tr>
						<td>3. ${row.ans3}&nbsp;&nbsp;4. ${row.ans4}</td>
					</tr>
					<tr>
				</table>
			</c:forEach>

			<div>
				<input type="button" value="퀴즈추가" onclick="insert()">
			</div>
		</form>
	</div>
</body>
</html>