<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta charset="UTF-8">
<script src="/resources/js/bootstrap.js"></script>
<script src="/resources/js/bootstrap.bundle.js"></script>
<link rel="stylesheet" href="/resources/css/bootstrap.css">
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>

<title>Market Main</title>

<nav class="navbar navbar-expand-lg bg-body-tertiary">
	<div class="container-fluid">
		<a class="navbar-brand" href="/main/pagemain.do"><img
			src="/resources/images/gaginame.png" id="image"></a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav me-auto mb-2 mb-lg-0">
				<li class="nav-item"><a class="nav-link" aria-current="page"
					href="/product/list">중고거래</a></li>
				<li class="nav-item"><a class="nav-link"
					href="../board_servlet/list.do">자유게시판</a></li>

				<c:choose>
					<c:when test="${sessionScope.userid != null}">
						<li class="nav-item dropdown"><a
							class="nav-link dropdown-toggle" href="#" role="button"
							data-bs-toggle="dropdown" aria-expanded="false">경매</a>
							<ul class="dropdown-menu">
								<li><a class="dropdown-item" href="/auction/list.do">경매
										게시판</a></li>
								<li><a class="dropdown-item"
									href="/auction/pageauctioninsert.do">경매 올리기</a></li>
							</ul></li>
					</c:when>
					<c:otherwise>
						<li class="nav-item"><a class="nav-link" href="#"
							onclick="showAlert()">경매</a></li>
					</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${sessionScope.userid != null}">
						<li class="nav-item"><a class="nav-link"
							href="/product/write">물품등록</a></li>
					</c:when>
					<c:otherwise>
						<script>
							function showAlert() {
								alert("로그인이 필요합니다.");
								window.location.href = '/member/pagelogin.do';
							}
						</script>
						<li class="nav-item"><a class="nav-link" href="#"
							onclick="showAlert()">물품등록</a></li>
					</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${sessionScope.userid != null}">
						<li class="nav-item"><a class="nav-link"
							href="/chat/chat.do">채팅</a></li>
					</c:when>
					<c:otherwise>
						<li class="nav-item"><a class="nav-link" href="#"
							onclick="showAlert()">채팅</a></li>
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test="${sessionScope.userid != null}">
						<li class="nav-item"><a class="nav-link"
							href="/quiz/quizlist.do">이벤트</a></li>
					</c:when>
					<c:otherwise>
						<li class="nav-item"><a class="nav-link" href="#"
							onclick="showAlert()">이벤트</a></li>
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test="${sessionScope.userid != null}">
						<li class="nav-item dropdown"><a
							class="nav-link dropdown-toggle" href="#" role="button"
							data-bs-toggle="dropdown" aria-expanded="false">내정보</a>
							<ul class="dropdown-menu">
								<li><a class="dropdown-item"
									onclick="location.href='/market/love_servlet/love_List.do?userid=${sessionScope.userid}'">관심목록</a></li>
								<li><a class="dropdown-item"
									onclick="location.href='/product/mylist?userid=${sessionScope.userid}'">판매내역</a></li>
								<li><hr class="dropdown-divider"></li>
								<li><a class="dropdown-item"
									onclick="location.href='/market/login_servlet/myPage.do?userid=${sessionScope.userid}'">마이페이지</a></li>
							</ul></li>
					</c:when>
					<c:otherwise>
						<li class="nav-item"><a class="nav-link" href="#"
							onclick="showAlert()">내정보</a></li>
					</c:otherwise>
				</c:choose>
			</ul>
			<form class="d-flex" role="search"
				action="/market/mk_servlet/search.do">
				<input class="form-control me-2" name="keyword" value="${keyword}"
					placeholder="물품을 검색하세요."> <input type="submit"
					class="btn btn-outline-success" style="background-color:"
					value="검색" id="btnSearch">

			</form>
			&nbsp;&nbsp;&nbsp;
			<div style="text-align: center;">
				<c:choose>
					<c:when test="${sessionScope.userid == null }">
						<article align="center">
							<a href="/member/pagelogin.do"
								style="margin-right: 10px; color: black; text-decoration: none;">
								로그인 <img src="/resources/images/power.png" width="20px"
								height="20px" alt="로그인">
							</a>
						</article>
					</c:when>
					<c:otherwise>
						<article align="center">
							${sessionScope.nickname}님 <a href="/member/logout.do"> <img
								src="/resources/images/power2.png" width="20px" height="20px"
								alt="로그아웃">
							</a>
						</article>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>

</nav>
<script>
	$(document).ready(function() {
		var nav = $('.navbar');
		var scrolled = false;

		$(window).scroll(function() {
			if ($(window).scrollTop() > nav.height()) {
				if (!scrolled) {
					nav.addClass('fixed-top');
					scrolled = true;
				}
			} else {
				if (scrolled) {
					nav.removeClass('fixed-top');
					scrolled = false;
				}
			}

		});
	});
</script>
<style>
#image {
	border-radius: 50%;
}

#home-main-first {
	width: 100%;
	height: 50%;
	float: right;
}

#home-main-second {
	width: 100%;
	height: 50%;
}

.navbar {
	position: fixed;
	width: 100%;
	z-index: 1000;
}

.navbar.fixed-top {
	position: fixed;
	width: 100%;
	top: 0;
	z-index: 1000;
}

.menu-container {form { box-sizing:border-box;
	height: 4rem;
	padding: 0.9rem 1.2rem;
	border: none;
	border-radius: 0.6rem;
}

body {
	padding-top: 0px; /* navbar height */
}
}
</style>
</head>
<body>
	<br>
	<br>
	<br>
	<br>
	<hr>
</body>