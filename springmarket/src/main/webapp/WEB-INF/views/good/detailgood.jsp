<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>상품정보</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<style>
body {
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	background-color: #f5f5f5;
	margin: 0;
	padding: 0;
	color: #333;
}

h2 {
	text-align: center;
}

table {
	width: 80%;
	margin: 20px auto;
	border-collapse: collapse;
}

th, td {
	border: 1px solid #ddd;
	padding: 10px;
}

#img {
	max-width: 100%;
	height: 500px;
	border-radius: 8px;
}

#content {
	text-align: center;
}

.button-container {
	position: fixed;
	top: 50%;
	right: 10px;
	transform: translateY(-50%);
}

.button-container input {
	background-color: #e74c3c;
	color: #ffffff;
	border: none;
	padding: 10px 20px;
	border-radius: 5px;
	cursor: pointer;
	font-size: 16px;
}

.button-container input:hover {
	background-color: #c0392b;
}

.like-button {
	background-color: transparent;
	border: none;
	cursor: pointer;
	outline: none;
}

.hidden-button {
	visibility: hidden;
}

.like-icon {
	width: 32px;
	height: 32px;
	fill: none;
	stroke: red;
	stroke-width: 2;
	stroke-linecap: round;
	stroke-linejoin: round;
}

.like-selected .like-icon {
	fill: red;
}

.chat, .map {
	background-color: #F8F8FF;
	position: relative;
	border: 1;
	display: inline-block;
	padding: 15px 30px;
	border-radius: 15px;
	font-family: "paybooc-Light", sans-serif;
	text-decoration: none;
	font-weight: 600;
	transition: 0.25s;
}

.report {
	background-image: url('/resources/images/report.png');
	/* 이미지 경로를 입력하세요 */
	background-color: white;
	width: 40px; /* 버튼의 가로 크기 */
	height: 40px; /* 버튼의 세로 크기 */
	border: none; /* 테두리 제거 */
	background-size: cover; /* 배경 이미지를 버튼에 꽉 채우기 */
	cursor: pointer; /* 마우스 커서를 포인터로 변경하여 클릭 가능하도록 설정 */
}

.map:hover, .chat:hover {
	background-color: #996699;
}

.report:hover {
	background-image: url('/resources/images/report_red.png');
}
</style>
<script>
	function calculateTotalPrice() {
		var price = parseInt(document.getElementById("price").value);
		var quantity = document.getElementsByName("amount")[0].value;
		var totalPrice = price * quantity;
		document.getElementById("totalPrice").innerText = totalPrice
				.toLocaleString()
				+ '원';
	}
	// 페이지 로드 시 초기 가격 계산
	window.onload = calculateTotalPrice;
</script>
</head>
<body>
	<%@ include file="../main/menu.jsp"%>
	<!----------------------------------------------------------------------------------->
	<h2>상품정보</h2>
	<input type="hidden" id="price" value="${dto.price }">
	<table>
		<tr>
			<td align="right" width="642px"><img id="img"
				src="/resources/images/${dto.filename}" alt="상품 이미지"></td>
			<td>
				<table>
					<tr>
						<th width="300px" style="font-size: xx-large;">상품명 :
							${dto.goodname}</th>
					</tr>
					<tr>
						<th width="100px" style="font-size: xx-large;">가격 : <fmt:formatNumber
								value="${dto.price}" pattern="#,###" />원
						</th>
					</tr>
					<tr>
						<td><select name="amount" onchange="calculateTotalPrice()">
								<c:forEach begin="1" end="10" var="i">
									<option value="${i}">${i}</option>
								</c:forEach>
						</select> &nbsp; 개</td>
						<td id="totalPrice">0원</td>
					</tr>
					<tr>
						<td><input type="button" value="구매하기" onclick="buy()"></td>
						<td><input type="button" value="장바구니에 담기" onclick="cart()"></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<hr>
	<table align="center">
		<tr>
			<td></td>
			<td></td>
			<td id="content" style="text-align: left; width: 600px;">${dto.goodcontent}</td>
			<td></td>
		</tr>
	</table>

	<%@ include file="../main/footer.jsp"%>
</body>
</html>