<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>채팅</title>
<style>
* {
	margin: 0;
	padding: 0;
}

.container {
	width: 500px;
	margin: 0 auto;
	padding: 25px;
}

.container h1 {
	text-align: left;
	padding: 5px 5px 5px 15px;
	color: #FFBB00;
	border-left: 3px solid #FFBB00;
	margin-bottom: 20px;
}

.chating {
	background-color: #000;
	width: 500px;
	height: 500px;
	overflow: auto;
}

.chating .me {
	color: #F6F6F6;
	text-align: right;
}

.chating .others {
	color: #FFE400;
	text-align: left;
}

input {
	width: 330px;
	height: 25px;
}
</style>
</head>
<body>

	<%@ include file="../main/menu.jsp"%>

	<div class="container">
		<h1>채팅방</h1>
		<input type="hidden" id="userid" value="${sessionScope.userid}">
		<input type="hidden" id="roomnumber" value="${roomNumber}">

		<div id="chating" class="chating"></div>

		<div id="yourMsg">
			<table class="inputTable">
				<tr>
					<th>메시지</th>
					<th><input id="message" name="message"
						placeholder="보내실 메시지를 입력하세요."></th>
					<th><button onclick="send()" id="sendBtn">보내기</button></th>
					<th><button onclick="location.href='/chat/room.do'">목록</button></th>
				</tr>
			</table>
		</div>
	</div>

	<script type="text/javascript">
		$(document).ready(function() {

			loadchat();
			wsOpen();

			$("#chating").scrollTop($("#chating")[0].scrollHeight);

		});

		var ws;

		function wsOpen() {
			var roomNumber = $("#roomnumber").val();
			ws = new WebSocket("ws://" + location.host + "/chating/"
					+ roomNumber);
			wsEvt();
		}

		function wsEvt() {
			ws.onopen = function(event) {
				console.log('WebSocket 연결 성공');
			}

			ws.onmessage = function(event) {
				console.log(event);
				var msg = event.data;
				if (msg != null && msg.trim() != '') {
					var d = JSON.parse(msg);

					var sessionid = $("#userid").val();
					if (typeof d.userid === "undefined") {

					} else {

						if (d.userid == sessionid) {
							$("#chating").append(
									"<p class='me'>" + sessionid + " :" + d.msg
											+ "</p>");
						} else {
							$("#chating").append(
									"<p class='others'>" + d.userid + " :"
											+ d.msg + "</p>");
						}
						$("#chating").scrollTop($("#chating")[0].scrollHeight);
					}
				}
			}

			document.addEventListener("keypress", function(e) {
				if (e.keyCode == 13) { // Enter 키 눌렀을 때
					send(); // send() 함수 호출
				}
			});
		}

		function send() {
			var option = {
				type : "message",
				roomNumber : $("#roomnumber").val(),
				userid : $("#userid").val(),
				msg : $("#message").val()
			}

			if ($("#message").val() == "") {
				alert("메세지를 입력하세요");
			} else {
				// WebSocket으로 메시지 전송
				ws.send(JSON.stringify(option));

				// AJAX를 사용하여 서버에 메시지 저장
				$.ajax({
					url : "/chat/savechat.do",
					type : "GET",
					data : {
						roomnumber : option.roomNumber,
						userid : option.userid,
						message : option.msg
					},
					success : function() {
						$('#message').val(""); // 메시지 입력란 초기화
						console.log("메시지 전송 및 저장 성공");
					},
					error : function(xhr, status, error) {
						console.error("에러 발생:", error);
					}
				});
			}
		}

		function loadchat() {
			var roomNumber = $("#roomnumber").val();
			var sessionId = $("#userid").val();

			$.ajax({
				url : "/chat/loadchat.do",
				type : "GET",
				data : {
					roomnumber : roomNumber
				},
				success : function(response) {
					console.log(response);
					$.each(response, function(index, row) {
						if (sessionId == row.userid) {
							$("#chating").append(
									"<p class='me'>" + row.userid + " :"
											+ row.message + "</p>");
						} else {
							$("#chating").append(
									"<p class='others'>" + row.userid + " :"
											+ row.message + "</p>");
						}
					});
					$("#chating").scrollTop($("#chating")[0].scrollHeight);
				}
			});

		}
	</script>
</body>
</html>