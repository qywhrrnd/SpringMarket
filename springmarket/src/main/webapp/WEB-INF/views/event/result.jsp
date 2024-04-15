<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
	$(document).ready(function() {
		var floatMenu = $("#floatMenu");
		var floatPosition = parseInt(floatMenu.css('top'));

		$(window).scroll(function() {
			var scrollTop = $(window).scrollTop();
			var newPosition = scrollTop + floatPosition + "px";

			floatMenu.stop().animate({
				"top" : newPosition
			}, 500);
		}).scroll();
	});
</script>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#floatMenu {
	position: absolute;
	width: 200px;
	height: 600px;
	left: 50px;
	top: 200px; /* 조절된 top 위치 */
	background-color: #606060;
	color: #fff;
	padding: 10px; /* 내용과 상하좌우 여백 */
	border-radius: 10px; /* 둥근 테두리 */
}

#floatMenu img {
	max-width: 100%;
	height: auto;
}

.close-btn {
	cursor: pointer;
	color: #fff;
	text-align: right;
}

.center-link {
	text-align: center;
}

h1 a {
	display: inline-block;
	padding: 10px 20px;
	background-color: #007bff;
	color: #fff;
	text-decoration: none;
	border-radius: 5px;
	margin: 10px;
}

h1 a:hover {
	background-color: #0056b3;
}
</style>
</head>
<body>
	<%@ include file="../main/menu.jsp"%>

	<div class="center-link">
		<c:choose>
			<c:when test="${result=='정답입니다.'}">
				<h1>
					<a href="/quiz/send.do?userid=${sessionScope.userid }">이메일 전송</a>
				</h1>
				<img src="/resources/images/good.png" alt="Your Image">
			</c:when>
			<c:otherwise>
				<h1>
					<a href="/market/mk_servlet/pop.do">메인 화면으로 이동</a>
				</h1>
				<img src="/resources/images/bad.png" alt="Your Image">
			</c:otherwise>
		</c:choose>
	</div>

	<div></div>

	<div id="floatMenu">
		<div class="close-btn" onclick="closeFloatMenu()">닫기</div>
		<a href="https://www.youtube.com/watch?v=jy_UiIQn_d0"><img
			style="height: 500px" src="../images/jongsin.jpg"
			alt="Floating Image"></a>
		<p>윤종신의 세로 라이브 지금 보고싶다면 배너를...</p>
	</div>

	<script>
		function closeFloatMenu() {
			$("#floatMenu").hide();
		}
	</script>
	<%@ include file="../main/footer.jsp"%>
</body>
</html>
