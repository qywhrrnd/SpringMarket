<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>경매 올리기</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap">
<script src="/resources/ckeditor/ckeditor.js"></script>
<style>
body {
	font-family: 'Roboto', sans-serif;
	background-color: #f7f7f7;
	margin: 0;
	padding: 0;
}

#container {
	width: 60%;
	margin: 30px auto;
	background-color: #fff;
	padding: 20px;
	border-radius: 5px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

h2 {
	text-align: center;
	margin-bottom: 20px;
}

form {
	margin-top: 20px;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 15px;
}

th, td {
	padding: 12px;
	border-bottom: 1px solid #ddd;
}

th {
	text-align: left;
}

input[type="text"], input[type="number"], textarea {
	width: 100%;
	padding: 10px;
	box-sizing: border-box;
	border: 1px solid #ccc;
	border-radius: 4px;
	resize: none;
	margin-top: 6px;
}

input[type="file"] {
	width: 100%;
	padding: 10px;
	margin-top: 6px;
}

input[type="button"] {
	background-color: #4CAF50;
	color: white;
	padding: 12px 24px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	margin-right: 10px;
}

input[type="button"]:hover {
	background-color: #45a049;
}

.center {
	text-align: center;
}

/* 가운데 정렬 */
.product-description {
	text-align: center;
}
</style>
<script src="http://code.jquery.com/jquery-3.6.1.js"></script>
<script>
	function auction_write() {
		let form1 = $("#form1");
		let subject = $("#subject").val();
		let contents = $("#contents").val();
		let price = $("#price").val();

		if (subject == "") {
			alert("제목을 입력하세요");
			$("#subject").focus();
			return;
		}
		if (price == "") {
			alert("금액을 입력하세요");
			$("#price").focus();
			return;
		}
		
		form1.attr("action", "/auction/insert_auction.do");
		form1.submit();
	}
</script>
</head>
<body>
	<c:if test="${sessionScope.userid == 'admin'}">
		<%@ include file="../admin/admin_menu.jsp"%>
	</c:if>
	<c:if test="${sessionScope.userid != 'admin'}">
		<%@ include file="../main/menu.jsp"%>
	</c:if>
	<div class="container">
		<h2 align="center">경매 올리기</h2>
		<hr style="text-align: left; margin-left: 0">
		<form id="form1" method="post" enctype="multipart/form-data">
			<table>
				<tr>
					<th>제목</th>
				</tr>
				<tr>
					<td><input type="text" name="subject" id = "subject" placeholder="상품명(제목)"></td>
				</tr>
				<tr>
					<th>상품가격</th>
				</tr>
				<tr>
					<td><input type="number" name="price" id = "price" placeholder="상품가격"></td>
				</tr>
				<tr>
					<th>상품이미지</th>
				</tr>
				<tr>
					<td><input type="file" name="file1"></td>
				</tr>
				<tr>
					<th>상품설명</th>
				</tr>
				<tr>
					<td><textarea rows="5" cols="60" id="contents" name="contents"></textarea>
						<script>
							CKEDITOR
									.replace(
											"contents",
											{
												filebrowserUploadUrl : "/auction/imageUpload.do"
											});
						</script></td>
				</tr>
				<tr>
					<td colspan="2" align="center"><input type="button" value="등록"
						onclick="auction_write()"> <input type="button" value="취소"
						onclick="location.href='/market/at_servlet/list.do'"></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>