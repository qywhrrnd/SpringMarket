<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>


<meta charset="UTF-8">
<script src="/resources/js/bootstrap.js"></script>
<script src="/resources/js/bootstrap.bundle.js"></script>
<link rel="stylesheet" href="/resources/css/bootstrap.css">
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>

<title>관리자 페이지</title>

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
					href="/board/list.do">자유게시판</a></li>
				<li class="nav-item"><a class="nav-link"
					href="/auction/list.do">경매게시판</a></li>
				<c:choose>
					<c:when test="${sessionScope.userid != null}">
						<li class="nav-item"><a class="nav-link" href="/chat/room.do">채팅</a></li>
					</c:when>
					<c:otherwise>
						<li class="nav-item"><a class="nav-link" href="#"
							onclick="showAlert()">채팅</a></li>
					</c:otherwise>
				</c:choose>



				<li class="nav-item"><a class="nav-link"
					href="/report/report_list">신고</a></li>

				<li class="nav-item"><a class="nav-link" href="/member/info.do">회원정보</a></li>

				<li class="nav-item"><a class="nav-link"
					href="/quiz/adminquizlist">이벤트 목록</a></li>
				<li class="nav-item"><a class="nav-link"
					href="/buy/adminbuylist.do">주문 목록</a></li>

			</ul>
			<form class="d-flex" role="search" action="/product/search">
				<input class="form-control me-2" name="keyword" value="${keyword}"
					placeholder="물품을 검색하세요."> <input type="submit"
					class="btn btn-outline-success" value="검색" id="btnSearch">

			</form>
		</div>
	</div>
	<div style="text-align: right;">
		<c:choose>
			<c:when test="${sessionScope.userid == null }">
				<a href="/market/login/login.jsp" style="margin-right: 10px;"> <img
					src="/resources/images/power.png" width="20px" height="20px"
					alt="로그인">
				</a>
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
</nav>
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

.admin_menu-container {form { box-sizing:border-box;
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