<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.7.1.js"></script>
<script>
/* $(function() {
   $("#btn_add").click(function() {
      location.href = "/jsp03/shop/product_write.jsp";
   });
}); */
	<%-- <c:if test="${sessionScope.admin_userid != null }">
   <button type="button" id="btn_add">상품등록</button>
</c:if> --%>
</script>
</head>
<body>
<%@ include file="../main/menu.jsp"%>
	<h2>내 판매게시물</h2>
	<table border="1">
		<tr align="center">
			<th style="width: 200px">제목(상품명)</th>
			<th style="width: 300px">사진</th>
			<th style="width: 100px">가격</th>
			<th style="width: 100px">&nbsp;</th>
		</tr>

		<c:forEach var="row" items="${list}">
			<c:if test="${row.userid eq sessionScope.userid}">
				<tr>
					<td align="center"><a
						href="/market/at_servlet/detail.do?auction_code=${row.auction_code}">
							${row.subject}</a></td>

					<td align="center"><img src="/market/images/${row.filename}"
						width="100px" height="100px"></td>

					<td align="center"><fmt:formatNumber value="${row.price}"
							pattern="#,###" />
					<c:if test="${sessionScope.userid != null}">
						
					<td align="center"><a href="/market/at_servlet/edit.do?auction_code=${row.auction_code}">[편집]</a></td>
					</c:if>
					</td>
				</tr>
			</c:if>
		</c:forEach>
	</table>
	<%@ include file="../main/footer.jsp"%>
</body>
</html>