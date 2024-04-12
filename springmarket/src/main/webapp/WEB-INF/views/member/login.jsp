<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="/resources/css/bootstrap.css">
<script src="/resources/js/bootstrap.js"></script>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function findid() {
		href = "/member/pagefindId.do";
	}

	function findpwd() {
		location.href = "../login/findpwd.jsp";
	}
</script>

<c:if test="${param.message == 'report' }">
	<script>
		alert("신고로 인해 로그인 불가 아이디입니다.");
	</script>
</c:if>
<!-- 아이디와 비밀번호 불일치시 뜨는 메시지 -->
<c:if test="${param.message == 'error' }">
	<script>
		alert("아이디 또는 비밀번호가 일치하지 않습니다.");
	</script>
</c:if>
<c:if test="${param.message == 'logout' }">
	<script>
		alert("로그아웃 되었습니다.");
	</script>
</c:if>
<link href="/resources/mycss/login.css" rel="stylesheet" />
<style>
a {
	text-decoration: none; /* 링크의 밑줄 제거 */
	color: inherit; /* 부모 요소의 색상 상속 */
}

.aaa {
	display: flex;
	justify-content: center;
	width: 100%; /* 전체 너비를 화면에 맞추기 위해 추가 */
	max-width: 800px; /* 최대 너비를 설정하여 화면이 너무 커지지 않도록 제한 */
	margin: 0 auto; /* 가운데 정렬을 위해 추가 */
	box-sizing: border-box; /* 너비와 패딩, 보더를 함께 계산하도록 설정 */
}

.aaa button:hover {
	text-decoration: underline;
}

.link_sign {
	list-style-type: none;
	color: grey;
}

.link_sign li {
	display: inline-block;
	margin: 0 20px 0 0;
}

.link_sign li #signin {
	float: left;
}

.link_sign li #signup {
	float: right;
}

.link_sign li #signin:hover {
	color: black;
	font-weight: bolder;
}

.link_sign li #signup:hover {
	color: black;
	font-weight: bolder;
}

.gagi {
	color: #9523ff;
	display: inline;
}

.market {
	color: #e91e63;
	display: inline;
}

.btn-outline-gagi {
	--bs-btn-color: #9523ff;
	--bs-btn-border-color: #9523ff;
	--bs-btn-hover-color: #fff;
	--bs-btn-hover-bg: #9523ff;
	--bs-btn-hover-border-color: #9523ff;
	--bs-btn-focus-shadow-rgb: 25, 135, 84;
	--bs-btn-active-color: #fff;
	--bs-btn-active-bg: #9523ff;
	--bs-btn-active-border-color: #9523ff;
	--bs-btn-active-shadow: inset 0 3px 5px rgba(0, 0, 0, 0.125);
	--bs-btn-disabled-color: #9523ff;
	--bs-btn-disabled-bg: transparent;
	--bs-btn-disabled-border-color: #9523ff;
	--bs-gradient: none;
	display: block;
	max-width: 680px;
	width: 92.5%;
	height: 50px;
	border-radius: 8px;
	margin: 0 auto;
	cursor: pointer;
	font-size: 14px;
	font-family: 'Montserrat', sans-serif;
	box-shadow: 0 15px 30px rgba(#e91e63, .36);
	transition: .2s linear;
	&:
	hover
	{
	box-shadow
	:
	0
	0
	0
	rgba(
	#e91e63
	,
	.0
	);
}
}
}
</style>
</head>
<body>
	<div class="container">
		<!-- Heading -->
		<a href="/main/pagemain.do">
		${alertScript}
			<div style="text-align: center;">
				<h1 class="gagi">🍆가지</h1>
				<h1 class="market">마켓🍆</h1>
			</div>
		</a> <br>
		<br>
		<br>
		<!-- Links -->
		<ul class="link_sign">
			<li><a id="signin">로그인</a></li>
			<li><a href='/member/pagejoin.do' id="signup">회원가입</a>
			</li>

		</ul>

		<!-- Form -->
		<form method="post" action="/member/login.do">
			<!-- 아이디 넣기 -->
			<div class="first-input input__block first-input__block">
				<input placeholder="아이디" class="input" id="userid" name="userid" />
			</div>
			<!-- 비밀번호 넣기 -->
			<div class="input__block">
				<input type="password" placeholder="비밀번호" class="input"
					id="password" name="passwd" />
			</div>
			<!-- 로그인 버튼 -->
			<button type="submit" value="로그인" class="btn btn-outline-gagi"
				style="font-size: 18px; font-weight: bold;">로그인</button>
		</form>
		<br>
		<br>
		<div class="aaa">
			<span style="color: gray; font-size: 13px;">만약 아이디가 기억나지 않는다면?</span>
			<a
				style="font-size: 13px; color: gray; background-color: transparent; border: 0px; display: block;"
				href='/member/pagefindId.do'> &nbsp;아이디 찾기</a>
				
		</div>
		<div class="aaa">
			<span style="color: gray; font-size: 13px;">만약 비밀번호가 기억나지
				않는다면?</span>
			<a
				style="font-size: 13px; color: gray; background-color: transparent; border: 0px; display: block;"
				href='/member/pagefindPwd.do'>&nbsp;비밀번호 찾기</a>
		</div>
	</div>

</body>
</html>