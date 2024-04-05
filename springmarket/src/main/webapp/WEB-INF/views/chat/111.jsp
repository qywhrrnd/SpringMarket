<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>Chating</title>
<style>
* {
	margin: 0;
	padding: 0;
}

.container {
	width: 500px;
	margin: 0 auto;
	padding: 25px
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

<script>
	$(document).ready(function() {
		// 페이지가 로드될 때 스크롤을 가장 아래로 이동합니다.
		$("#chating").scrollTop($("#chating")[0].scrollHeight);
	});
</script>

<script type="text/javascript">
	wsOpen();

	var ws;

	function wsOpen() {
		ws = new WebSocket("ws://" + location.host + "/chating");
		wsEvt();
	}

	function wsEvt() {
		sessionId: $("#sessionId").val();
		ws.onopen = function(data) {
			//소켓이 열리면 동작
		}

		ws.onmessage = function(data) {
			//메시지를 받으면 동작
			var msg = data.data;
			
			if (msg != null && msg.trim() != '') {
				var d = JSON.parse(msg);
				if (d.type == "message") {
					if (d.sessionId == $("#sessionId").val()) {
						$("#chating").append(
								"<p class='me'>" + d.sessionId + " :" + d.msg
										+ "</p>");
						$(document).ready(
								function() {
									// 페이지가 로드될 때 스크롤을 가장 아래로 이동합니다.
									$("#chating").scrollTop(
											$("#chating")[0].scrollHeight);
								});
					} else {
						$("#chating").append(
								"<p class='others'>" + d.sessionId + " :"
										+ d.msg + "</p>");
						$(document).ready(
								function() {
									// 페이지가 로드될 때 스크롤을 가장 아래로 이동합니다.
									$("#chating").scrollTop(
											$("#chating")[0].scrollHeight);
								});
					}

				} else {
					console.warn("unknown type!");
				}
			}
		}

		document.addEventListener("keypress", function(e) {
			if (e.keyCode == 13) { //enter press
				send();
			}
		});
	}

	function send() {
		var option = {
			type : "message",
			sessionId : $("#sessionId").val(),

			msg : $("#chatting").val()
		}
		ws.send(JSON.stringify(option))
		$('#chatting').val("");

	}
</script>
<body>
	<div id="container" class="container">
		<h1>채팅</h1>
		<input type="text" id="sessionId" value="${sessionScope.userid}">

		<div id="chating" class="chating"></div>
		<div id="yourMsg">
			<table class="inputTable">
				<tr>
					<th>메시지</th>
					<th><input id="chatting" placeholder="보내실 메시지를 입력하세요."></th>
					<th><button onclick="send()" id="sendBtn">보내기</button></th>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>