<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>판매게시물 수정</title>

<script>
	function update_product() {
		let subject = document.form1.subject.value;
		let price = document.form1.price.value;
		let contents = document.form1.contents.value;
		if (subject == "") {
			alert("상품명을 입력하세요");
			document.form1.subject.focus();
			return;
		}
		if (price == "") {
			alert("가격을 입력하세요");
			document.form1.price.focus();
			return;
		}
		if (contents == "") {
			alert("설명을 입력하세요");
			document.form1.contents.focus();
			return;
		}
		document.form1.action = "/market/mk_servlet/update.do";
		document.form1.submit();
	}
</script>
</head>
<body>
<%@ include file="../main/menu.jsp"%>
<div align="center">
	<form name="form1" method="post" enctype="multipart/form-data">
		<table>
			<tr>
				<th>제목(상품명)</th>
			</tr>
			<tr>
				<td><input name="subject" value="${dto.subject}"></td>
			</tr>
			<tr>
				<th>가격</th>
			</tr>
			<tr>
				<td><input name="price" value="${dto.price}"></td>
			</tr>
			<tr>
				<th>상품설명</th>
			</tr>
			<tr>
				<td><textarea rows="7" cols="60" name="contents" style="resize: none;">${dto.contents}</textarea></td>
			</tr>

			<tr>
				<th>상품 이미지</th>
			</tr>
			<tr>
				<td><img src="/market/images/${dto.filename}" width="300px"
					height="300px"> <br> <input type="file" name="file1">
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="hidden"name="write_code" value="${dto.write_code}"> 
				<input type="button" value="수정" onclick="update_product()"> 
				<input type="button" value="목록" onclick="location.href='/market/mk_servlet/myList.do'"></td>
			</tr>

		</table>
	</form>
</div>
<%@ include file="../main/footer.jsp"%>
</body>
</html>