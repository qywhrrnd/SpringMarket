<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.7.1.js"></script>
<style>
body {
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	background-color: #f5f5f5;
	margin: 0;
	padding: 0;
	color: #333;
}

h2 {
	text-align: center;
}

table {
	width: 80%;
	margin: 20px auto;
	border-collapse: collapse;
}

th, td {
	border: 1px solid #ddd;
	padding: 10px;
}

#img {
	max-width: 100%;
	height: 500px;
	border-radius: 8px;
	width: 70%;
}

#content {
	text-align: center;
}

.button-container {
	position: fixed;
	top: 50%;
	right: 10px;
	transform: translateY(-50%);
}

.button-container input {
	background-color: #e74c3c;
	color: #ffffff;
	border: none;
	padding: 10px 20px;
	border-radius: 5px;
	cursor: pointer;
	font-size: 16px;
}

.button-container input:hover {
	background-color: #c0392b;
}

.like-button {
	background-color: transparent;
	border: none;
	cursor: pointer;
	outline: none;
}

.hidden-button {
	visibility: hidden;
}

.like-icon {
	width: 32px;
	height: 32px;
	fill: none;
	stroke: red;
	stroke-width: 2;
	stroke-linecap: round;
	stroke-linejoin: round;
}

.like-selected .like-icon {
	fill: red;
}

.chat, .report, .reload, .buy {
	background-color: #3498db;
	color: #ffffff;
	border: none;
	padding: 10px 20px;
	border-radius: 5px;
	cursor: pointer;
	font-size: 16px;
	margin-right: 10px;
	text-decoration: none;
	display: inline-block;
	text-align: center;
}

.chat:hover, .report:hover {
	background-color: #2980b9;
}

.reload:hover {
	background-color: #2980b9;
}

.report:hover {
	background-color: red;
}
</style>
<script>

$(document).ready(function(){
    $(".chat").click(function(){
        var toid = "${dto.userid}";
        location.href = "/market/chat_servlet/chat.do?toid=" + toid +"&userid="+"${sessionScope.userid}";   
    });
});
</script>
<script>
function delete_product(auction_code) {
   if (confirm("삭제하시겠습니까?")) {
      location.href = "/market/at_servlet/admin_auction.do?auction_code="
            + auction_code;
   }
}
</script>

</head>
<body>
	<c:if test="${sessionScope.userid == 'admin'}">
		<%@ include file="../admin/admin_menu.jsp"%>
	</c:if>
	<c:if test="${sessionScope.userid != 'admin'}">
		<%@ include file="../main/menu.jsp"%>
	</c:if>
	<h2 align="center">경매 상품정보</h2>


	<table align="center">
		<tr>
			<td align="right"><img id="img"
				src="/resources/images/${dto.filename}"></td>
			<td align="center">

				<table>
					<tr>

						<th width="700px" style="font-size: xx-large;">${dto.subject}</th>
					</tr>

					<tr>

						<th width="100px" id="price" style="font-size: xx-large;"><span
							id="formattedPrice">${dto.price}</span>원
					</tr>
					<tr>

						<td id="bid2userid">판매자:&nbsp;${dto.biduserid}</td>
					</tr>
					<tr>
						<td>입찰가 : <input type="number" min="${dto.price}" id="bidnum"></td>
						<td><input type="hidden" id="bid1userid"
							style="background-color: transparent; border: 0px"
							value="${sessionScope.userid}" readonly></td>
					</tr>

					<tr>
						<td colspan="3">
							<form name="form1" method="post"
								action="/market/at_servlet/bid.do">
								<input type="hidden" name="userid" value="${dto.userid}">
								<input type="hidden" name="auction_code"
									value="${dto.auction_code}"> <input type="button"
									class="buy" id="btnbid" value="입찰">
								<c:if test="${sessionScope.userid == dto.userid}">
									<input type="hidden" class="chat" id="btnchat" value="채팅">
								</c:if>
								<c:if test="${sessionScope.userid != dto.userid}">
									<input type="button" class="chat" id="btnchat"
										style="background-color: #d3d3d3; color: #888;" value="채팅"
										disabled="disabled">
								</c:if>
								<input type="button" class="reload" value="새로고침"
									onclick="location.href='/market/at_servlet/detail.do?auction_code=${dto.auction_code}'">

								<c:if
									test="${sessionScope.userid == 'admin' || sessionScope.userid == dto.userid}">

									<input type="button" class="report"
										onclick="delete_product('${dto.auction_code}')" value="삭제">

								</c:if>
							</form>
						</td>
					</tr>
					<tr>
						<td>
							<div id="demo"></div>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<hr style="border: 2">
	<table align="center">
		<tr>
			<td id="content">${dto.contents}</td>

		</tr>

	</table>


	<script>
// 가격과 현재 입찰자 정보를 업데이트하는 함수
function updatePriceAndBidder() {
    // 세션 ID 또는 사용자 ID를 서버로 전달하기 위한 변수
    var sessionUserId = "${sessionScope.userid}";

    $.ajax({
        url: "/auction/updatePriceAndBidder.do",
        type: "GET",
        data: {
            auction_code: "${dto.auction_code}",
            sessionUserId: sessionUserId // 세션 ID 또는 사용자 ID를 요청에 추가
        },
        success: function(response) {
            var formattedPrice = new Intl.NumberFormat('ko-KR', { style: 'currency', currency: 'KRW' }).format(response.price);
            $("#formattedPrice").text(formattedPrice);
            $("#bid2userid").text(response.bidder);
            var seconds = response.time;
            var minutes = Math.floor(seconds / 60);
            var remainingSeconds = seconds % 60;
            $("#demo").text(minutes + "분 " + remainingSeconds + "초");
            if (minutes === 0 && remainingSeconds === 0) {
                $("#demo").text("시간초과");
                var biduserid = response.bidder; // 변경
                var userid = response.userid;
                // 서버에서 응답으로 받은 값과 사용자의 세션 ID 또는 사용자 ID를 비교
                if (sessionUserId === biduserid) {
                    $("#btnchat").prop("disabled", false).css({"background-color": "#3498db", "color": "#ffffff"});
                }
                $("#btnbid").prop("disabled", true).css({"background-color": "#d3d3d3", "color": "#888"});
            }
        },
    });
}


// 일정한 시간 간격으로 업데이트 함수 호출
var updateInterval = setInterval(updatePriceAndBidder, 1000); // 5초마다 업데이트

// 페이지를 닫을 때 업데이트 간격을 멈추도록 합니다.
$(window).on('beforeunload', function(){
    clearInterval(updateInterval);
});





const btnbid = document.getElementById("btnbid");

btnbid.addEventListener("click", function() {
    // 사용자가 입력한 입찰가를 가져옵니다.
    var bidPrice = $("#bidnum").val();
    var bid1Userid = $("#bid1userid").val();
    
    
    // AJAX를 사용하여 현재 상품의 가격을 업데이트하고, 비교를 수행합니다.
    $.ajax({
        url: "/market/at_servlet/updatePriceAndBidder.do",
        type: "GET",
        data: {
            auction_code: "${dto.auction_code}"
        },
        success: function(response) {
            // AJAX 요청에서 받은 최신 가격을 가져와 비교합니다.
            var currentPrice = response.price;
            
            // 사용자가 입력한 입찰가와 현재 상품의 가격을 비교합니다.
            if (bidPrice <= parseInt(currentPrice)) {
                alert("기존 가격보다 높은 가격을 입력해주세요");
                return;
            } else {
                // AJAX 요청의 데이터로 사용자가 입력한 입찰가를 전달합니다.
                $.ajax({
                    url: "/market/at_servlet/bid.do",
                    type: "GET",
                    data: {
                        bidPrice: bidPrice,
                        auction_code: ${dto.auction_code},
                        biduserid: bid1Userid
                    },
                    success: function(response) {
                        // AJAX 요청에 대한 응답에서 새로운 입찰자 정보를 가져와 업데이트합니다.
                         $("#formattedPrice").text(new Intl.NumberFormat('ko-KR', { style: 'currency', currency: 'KRW' }).format(bidPrice));
                        $("#bid2userid").text(bid1Userid);
                        $("#bidnum").val('');
                    },
                });
            }
        },
    });
});
</script>




	<%@ include file="../main/footer.jsp"%>
</body>
</html>