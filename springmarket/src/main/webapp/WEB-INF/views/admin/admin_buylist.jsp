<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 내역</title>
<script src="http://code.jquery.com/jquery-3.7.1.js"></script>
<script>
	$(document).ready(function() {
		var totalPrice = 0; // 변수 초기화
		<c:forEach var="row" items="${list}">
		totalPrice += parseInt("${row.price}"); // 각 주문의 가격을 더함
		</c:forEach>
		$("#totalprice").val(totalPrice);
	});
</script>
</head>
<body>
	<%@ include file="../admin/admin_menu.jsp"%>
	<c:choose>
		<c:when test="${list.size() == 0}">
   구매한 상품이 없습니다.
   </c:when>
		<c:when test="${list.size() > 0}">
			<div align="center">
				<form method="post" name="form1">
					<h2 align="center">주문 내역</h2>

					<table border="1" style="width: 100%">

						<tr align="center">
							<th style="width: 200px">주문자</th>
							<th style="width: 200px">사진</th>
							<th style="width: 200px">제목(상품명)</th>
							<th style="width: 400px">베송지</th>
							<th style="width: 200px">주문개수</th>
							<th style="width: 200px">가격</th>
						</tr>

						<c:forEach var="row" items="${list}">

							<tr>
								<td align="center"><a> ${row.userid}</a></td>
								<td align="center"><img
									src="/resources/images/${row.filename}" width="100px"
									height="100px"></td>

								<td align="center"><a
									href="/good/detailgood.do?goodidx=${row.goodidx}">
										${row.goodname}</a></td>

								<td align="center"><a> ${row.address}</a></td>

								<td align="center"><fmt:formatNumber value="${row.amount}"
										pattern="#,###" /></td>

								<td align="center"><fmt:formatNumber value="${row.price}"
										pattern="#,###" />원</td>
							</tr>
						</c:forEach>
						<tr>
							<td colspan="6" align="right">총 매출액 : <input style="border: none; text-align : right;" type="number" id="totalprice"
								name="totalprice" readonly>원</td>
						</tr>
					</table>
				</form>
			</div>
		</c:when>
	</c:choose>
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