<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
	function showPostcode() {
		new daum.Postcode(
				{
					oncomplete : function(data) {
						let fullAddr = "";
						let extraAddr = "";
						if (data.userSelectedType === "R") {
							fullAddr = data.roadAddress;
						} else {
							fullAddr = data.jibunAddress;
						}
						if (data.userSelectedType === "R") {
							if (data.bname !== "") {
								extraAddr += data.bname;
							}
							if (data.buildingName !== "") {
								extraAddr += (extraAddr !== "" ? ", "
										+ data.buildingName : data.buildingName);
							}
							fullAddr += (extraAddr !== "" ? " (" + extraAddr
									+ ")" : "");
						}
						document.getElementById("post_code").value = data.zonecode;
						document.getElementById("address1").value = fullAddr;
						document.getElementById("address2").focus();
					}
				}).open();
	}
</script>



<script>
	function join() {
		let form1 = $("#form1");
		let userid = $("#userid").val();
		let passwd = $("#passwd").val();
		let passwd2 = $("#passwd2").val();
		let name = $("#name").val();
		let nickname = $("#nickname").val();
		let birth = $("#birth").val();
		let phone = $("#phone").val();
		let email = $("#email").val();
		let post_code = $("#post_code").val();
		let address1 = $("#address1").val();
		let address2 = $("#address2").val();

		if (userid == "") {
			alert("아이디를 입력하세요.");
			$("#userid").focus();
			return;
		}

		else if (userid.length<4 || userid.length>12) {
			alert("아이디는 4자에서 12자 사이여야 합니다");
			$("#userid").focus();
			return;
		} else if (passwd == "") {
			alert("비밀번호를 입력하세요.");
			$("#passwd").focus();
			return;
		} else if (passwd2 == "") {
			alert("비밀번호를 확인해주세요");
			$("#passwd2").focus();
			return;
		}

		else if (name == "") {
			alert("이름을 입력하세요.");
			$("#name").focus();
			return;
		} else if (nickname == "") {
			alert("닉네임을 입력하세요.");
			$("#nickname").focus();
			return;
		} else if (birth == "") {
			alert("생년월일을 입력하세요.");
			$("#birth").focus();
			return;
		} else if (birth.length != 6) {
			alert("생년월일은 6개의 숫자로 입력해주세요");
			$("#birth").focus();
			return;
		}

		else if (phone == "") {
			alert("핸드폰 번호를 입력하세요.");
			$("#phone").focus();
			return;
		}

		else if (email == "") {
			alert("이메일을 입력하세요.");
			$("#email").focus();
			return;
		} else if (post_code == "") {
			alert("주소를 입력하세요.");
			$("#post_code").focus();
			return;
		} else if (address1 == "") {
			alert("주소를 입력하세요.");
			$("#address1").focus();
			return;
		} else if (address2 == "") {
			alert("상세주소를 입력하세요.");
			$("#address2").focus();
			return;
		}
		$("#userid").prop("disabled", false);
		$("#email").prop("disabled", false);
		alert("회원가입이 완료되었습니다.");
		document.form1.action = "/member/join.do";
		document.form1.submit();
	}

	function check() {
		let userid = document.getElementById("userid").value;
		$.ajax({
			url : "/member/check.do",
			type : "POST",
			data : {
				userid : userid
			},
			dataType : "json",
			success : function(response) {
				console.log(response);
				if(response.count === "false"){
					$("#loginButton").prop("disabled", true);
					alert("아이디를 입력해주세요");
				}
				else if(userid.length<4 || userid.length>12){
					alert("아이디는 4자에서 12자 사이여야 합니다");
				}
				else if (response.count === userid) {
					// 중복된 아이디가 있으면 로그인 버튼 비활성화
					$("#loginButton").prop("disabled", true);
					alert("이미 사용 중인 아이디입니다.");
				} else if(response.count === "true"){
					// 사용 가능한 아이디일 때
					$("#loginButton").prop("disabled", false);
					alert("사용 가능한 아이디입니다.");
				}
			},
			error : function(xhr, status, error) {
				console.error("Error:", error);
			}
		});
	}

	function emailcheck() {
		let email = document.getElementById("email").value;
		$.ajax({
			url : "/member/emailcheck.do",
			type : "POST",
			data : {
				email : email
			},
			success : function(response) {
				console.log(response);
				//$("#emailresult").html(txt);

				if(response.count1 === "false"){
					$("#loginButton").prop("disabled", true);
					alert("이메일을 입력해주세요");
				}
				else if (response.count1 === email) {
					// 중복된 아이디가 있으면 로그인 버튼 비활성화
					$("#loginButton").prop("disabled", true);
					alert("이미 사용 중인 이메일입니다.");
				} else if(response.count1 === "true"){
					// 사용 가능한 아이디일 때
					$("#loginButton").prop("disabled", false);
					alert("사용 가능한 이메일입니다.");
				}
			}
		});
	}

	// 아이디 입력란이 변경될 때마다 로그인 버튼 상태를 확인
	$("#userid").on("input", function() {
		$("#loginButton").prop("disabled", false);
	});

	function checkpwd() {
		let password1 = document.getElementById("passwd").value;
		let password2 = document.getElementById("passwd2").value;
		let passwordresult = document.getElementById("passwordresult");
		if (password1 != password2) {
			passwordresult.innerHTML = "비밀번호가 일치하지 않습니다";
		} else {
			passwordresult.innerHTML = "비밀번호가 일치합니다.";
		}
	}
</script>
<link href="/resources/mycss/login.css" rel="stylesheet" />
<style>
.zip-code-group {
	display: inline-flex;
	position: relative;
	left: 20px; /* 오른쪽으로 이동할 픽셀 수 (원하는 값으로 조정) */
}

a {
	text-decoration: none; /* 링크의 밑줄 제거 */
	color: inherit; /* 부모 요소의 색상 상속 */
}
</style>
<style>
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
</style>


</head>
<body>
	<div class="container">
		<a href="/market/mk_servlet/pop.do">
			<h1>가지마켓</h1>
		</a>
		<ul class="link_sign">
			<li><a href='/member/pagelogin.do' id="signin">로그인</a></li>
			<li><a href="#" id="signup">회원가입</a></li>
		</ul>


		<form name="form1" id="form1" method="post">
			<div class="first-input input__block first-input__block">
				<input placeholder="아이디" type="text" name="userid" id="userid">
				<div id="result"></div>
				<input type="button" value="중복확인" onclick="check()"> <br>
				<input placeholder="비밀번호" type="password" name="passwd" id="passwd"><br>
				<input placeholder="비밀번호확인" type="password" name="passwd2"
					id="passwd2" oninput="checkpwd()">
				<div id="passwordresult"></div>
				<br> <input placeholder="이름" type="text" name="name" id="name"><br>
				<input placeholder="닉네임" type="text" name="nickname" id="nickname"><br>
				<input placeholder="생년월일" type="number" name="birth" id="birth"><br>
				<input type="number" name="phone" id="phone"
					pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}" title="###-####-####"
					placeholder="예) 010-1234-5678"><br> <input
					placeholder="이메일" type="text" name="email" id="email"><br>
				<div id="emailresult"></div>
				<input type="button" style="border-bottom: 1px;" value="중복확인"
					onclick="emailcheck()"> <br>
				<div class="zip-code-group">
					<input placeholder="우편번호" name="zipcode" id="post_code" readonly>&nbsp;&nbsp;&nbsp;
					<input type="button" onclick="showPostcode()" value="우편번호 찾기">
				</div>
				<br> <br> <input placeholder="주소" name="address1"
					id="address1" size="60"> <br> <input
					placeholder="상세주소" name="address2" id="address2">
			</div>

			<br> <input class="signin__btn" type="button" value="회원가입"
				id="loginButton" onclick="join()" disabled>

		</form>
	</div>

</body>
</html>