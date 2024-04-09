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

.bubble {
	max-width: 70%;
	padding: 10px;
	margin: 5px;
	border-radius: 10px;
	word-wrap: break-word;
}

.me {
	color: #F6F6F6;
	text-align: right;
	background-color: #007bff; /* Your bubble color for 'me' */
	align-self: flex-end;
	margin-left: 350px; /* Added to push the bubble to the right */
}

.others {
	color: #FFE400;
	text-align: left;
	background-color: #28a745; /* Your bubble color for 'others' */
	align-self: flex-start; /* Added for consistency */
	margin-right: 350px; /* Added to push the bubble to the left */
}

.messageInput {
	width: 300px;
	height: 25px;
	padding: 5px;
	border: 1px solid #ccc;
	border-radius: 5px;
}

.sendButton, .listButton {
	width: 60px;
	height: 25px;
	margin-top: 10px;
	margin-left: 10px;
	padding: 5px;
	font-size: 14px;
	color: #fff;
	background-color: #007bff;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}

.sendButton:hover, .listButton:hover {
	background-color: #0056b3;
}

.listButton {
	background-color: #28a745;
}

.listButton:hover {
	background-color: #218838;
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
					<th><input id="message" name="message" class="messageInput"
						placeholder="보내실 메시지를 입력하세요."></th>
					<th><button onclick="send()" id="sendBtn" class="sendButton">보내기</button></th>
					<th><button onclick="location.href='/chat/room.do'"
							class="listButton">목록</button></th>
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
									"<div class='bubble me'>" + d.userid
											+ " : " + d.msg + "</div>");
						} else {
							$("#chating").append(
									"<div class='bubble others'>" + d.userid
											+ " : " + d.msg + "</div>");
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
									"<div class='bubble me'>" + row.userid
											+ " : " + row.message + "</div>");
						} else {
							$("#chating").append(
									"<div class='bubble others'>" + row.userid
											+ " : " + row.message + "</div>");
						}
					});
					$("#chating").scrollTop($("#chating")[0].scrollHeight);
				}
			});

		}
	</script>
</body>
</html>