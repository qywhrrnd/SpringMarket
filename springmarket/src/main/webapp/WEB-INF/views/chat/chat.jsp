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
			var roomnumber = $("#roomnumber").val();
			ws = new WebSocket("ws://" + location.host + "/chating/"
					+ roomnumber);
			wsEvt();
		}

		function wsEvt() {
			ws.onopen = function(data) {
				console.log("aaaa");
			}

			ws.onmessage = function(data) {
				var msg = data.data;
				if (msg != null && msg.trim() != '') {
					var d = JSON.parse(msg);
					if (d.type == "message") {
						var sessionId = $("#userid").val();
						if (d.userid == sessionId) {
							$("#chating").append(
									"<p class='me'>" + d.userid + " :"
											+ d.message + "</p>");
						} else {
							$("#chating").append(
									"<p class='others'>" + d.userid + " :"
											+ d.message + "</p>");
						}
						$("#chating").scrollTop($("#chating")[0].scrollHeight);
					}
				}
			}

			document.addEventListener("keypress", function(e) {
				if (e.keyCode == 13) { // enter press
					send();
				}
			});
		}
		
		function send() {
			var option = {
				type : "message",
				roomnumber : $("#roomnumber").val(),
				userid : $("#userid").val(),
				message : $("#message").val()
			}
			ws.send(JSON.stringify(option));
			$('#message').val("");
			$.ajax({
				url : "/chat/savechat.do",
				type : "GET",
				data : {
					roomnumber : option.roomnumber,
					userid : option.userid,
					message : option.message
				},
				success : function() {
					loadchat();
				}
			});
		}
		
		function loadchat() {
			var roomnumber = $("#roomnumber").val();
			var sessionId = $("#userid").val();
			if ($("#chating").is(':empty')) {
				$.ajax({
					url : "/chat/loadchat.do",
					type : "GET",
					data : {
						roomnumber : roomnumber
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
										"<p class='others'>" + row.userid
												+ " :" + row.message + "</p>");
							}
						});
						$("#chating").scrollTop($("#chating")[0].scrollHeight);
					}
				});
			}
		}
	</script>
</body>
</html>
