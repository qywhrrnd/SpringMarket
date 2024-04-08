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
	function cancel() {
		if (confirm("변경을 취소하시겠습니까?")) {
			location.href = "/market/login_servlet/myPage.do?userid="
					+ '${sessionScope.userid}';
					
		}
	}
	
	function change_passwd(userid){
		var userId = "${dto.userid}";
	    var url = "/member/detail_passwd.do?userid=" + userId;
		
	    // 팝업 창 크기 설정
	    var popupWidth = 600;
	    var popupHeight = 700;

	    // 화면 가운데에 위치 계산
	    var left = (window.innerWidth - popupWidth) / 2;
	    var top = (window.innerHeight - popupHeight) / 2;

	    // 작은 팝업 창을 열기 위한 코드
	    window.open(url, '비밀번호 변경', 'width=' + popupWidth + ',height=' + popupHeight + ',left=' + left + ',top=' + top);
	    }
	
	
	
	
	function update_mypage(userid) {
		let form1 = $("#form1");
		let name = document.form1.name.value;
		let nickname = document.form1.nickname.value;
		let birth = document.form1.birth.value;
		let phone = document.form1.phone.value;
		let email = document.form1.email.value;
		let address1 = document.form1.address1.value;
		let address2 = document.form1.address2.value;

		if (name == "") {
			alert("이름을 입력하세요");
			document.form1.name.focus();
			return;
		}
		if (nickname == "") {
			alert("닉네임을 입력하세요");
			document.form1.nickname.focus();
			return;
		}
		if (birth == "") {
			alert("생년월일을 입력하세요");
			document.form1.birth.focus();
			return;

		} else if (birth.length != 6) {
			alert("생년월일은 6개의 숫자로 입력해주세요");
			$("#birth").focus();
			return;
		}
		if (phone == "") {
			alert("전화번호를 입력하세요");
			document.form1.phone.focus();
			return;

		} else if (phone.length != 11) {
			alert("전화번호는 11개의 숫자로 입력해주세요");
			$("#phone").focus();
			return;
		}

		if (email == "") {
			alert("이메일을 입력하세요");
			document.form1.email.focus();
			return;
		}
		if (address1 == "") {
			alert("주소를 입력하세요");
			document.form1.address.focus();
			return;
		}
		if (confirm("변경하시겠습니까?")) {
			document.form1.action = "/member/mypage_update.do";
			document.form1.submit();
			alert("변경이 완료되었습니다.")
		}  else {
			location.href = "/member/mypage.do"
					
		}  
	}
	function check() {
		let nickname = document.getElementById("nickname").value;
		console.log("nickname:", nickname);
		$.ajax({
			url : "/market/login_servlet/nicknamecheck.do",
			type : "GET",
			data : {
				nickname : nickname
			},
			success : function(txt) {
				$("#result").html(txt);
				console.log("result:", txt);
				if (txt.includes("중복된 닉네임입니다.")) {
					$("#updateButton").prop("disabled", true);
				} else {
					$("#updateButton").prop("disabled", false);
				}
			}
		});
	}
	function emailcheck() {
		let email = document.getElementById("email").value;
		$.ajax({
			url : "/market/login_servlet/EmailCheck.do",
			type : "GET",
			data : {
				email : email
			},
			success : function(txt) {
				$("#emailresult").html(txt);

				if (txt.includes("중복된 이메일입니다.")) {
					$("#updateButton").prop("disabled", true);
				} else {
					$("#updateButton").prop("disabled", false);
				}
			}
		});
	}
</script>
<style>
body {
	font-family: 'Arial', sans-serif;
	background-color: #f5f5f5;
	margin: 0;
	padding: 0;
}

table {
	margin: 20px auto;
	background-color: white;
	border: 1px solid #ddd;
	border-collapse: collapse;
	width: 50%;
}

td {
	padding: 10px;
	border: 1px solid #ddd;
}

input {
	padding: 5px; /* 입력 필드의 여백을 줄임 */
	margin: 2px;
}

#result, #emailresult {
	color: red;
}

.zip-code-group {
	display: flex;
	align-items: center;
}

#post_code {
	flex: 1;
}

#updateButton, #loginButton {
	background-color: #4CAF50;
	color: white;
	border: none;
	padding: 8px 16px; /* 버튼의 크기를 작게 조절 */
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 14px; /* 버튼의 글자 크기를 작게 조절 */
	margin: 4px 2px;
	cursor: pointer;
	border-radius: 4px;
	margin-top: 10px; /* 버튼을 아래로 내림 */
}

/* 푸터 스타일 */
#footer {
	clear: both;
	text-align: center;
	padding: 5px;
	border-top: 1px solid #bcbcbc;
	position: relative; /* 푸터를 화면 하단에 고정시킴 */
	bottom: 0;
	width: 100%;
	background-color: white;
}
</style>

</head>
<body>
	<%@ include file="../main/menu.jsp"%>



	<form name="form1" method="post">
		<table>
			<tr>
				<td align="center">이름&nbsp;</td>
				<td><input name="name" value="${dto.name}"></td>

			</tr>
			<tr>
				<td align="center">닉네임&nbsp;</td>
				<td><input name="nickname" id="nickname"
					value="${dto.nickname}">

			</tr>
			<tr>
				<td></td>
				<td colspan="2"><div id="result"></div></td>
			</tr>
			<tr>
				<td align="center">생년월일&nbsp;</td>
				<td><input name="birth" value="${dto.birth}"></td>
			</tr>
			<tr>
				<td align="center">휴대폰&nbsp;</td>
				<td><input name="phone" value="${dto.phone}"></td>
			</tr>
			<tr>
				<td align="center">이메일&nbsp;</td>
				<td><input name="email" value="${dto.email}" id="email">
					<input type="button" value="중복확인" onclick="emailcheck()"></td>
			</tr>
			<tr>
				<td></td>
				<td colspan="2"><div id="emailresult"></div></td>
			</tr>

			<tr>
				<td align="center">주소&nbsp;</td>
				<td><div class="zip-code-group">
						<input placeholder="우편번호" name="zipcode" id="post_code" readonly>&nbsp;&nbsp;&nbsp;
						<input type="button" onclick="showPostcode()" value="우편번호 찾기">
					</div></td>
			</tr>

			<tr>
				<td></td>
				<td><input placeholder="주소" name="address1" id="address1"
					size="60" value="${dto.address}"> <br> <input
					placeholder="상세주소" name="address2" id="address2"></td>
			</tr>


			<tr>
				<td>&nbsp;</td>
				<td colspan="2">
				<input type="button" id="updateButton" value="수정" onclick="update_mypage('${dto.userid}')">
					 <input type="button" id="updateButton" value="비밀번호변경" onclick="change_passwd('${dto.userid}')">

				<input type="button" value="취소" onclick="cancel()">
				</td>
			</tr>

		</table>

	</form>
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