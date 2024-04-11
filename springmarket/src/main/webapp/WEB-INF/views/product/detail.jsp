<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>상품정보</title>
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

.chat, .map {
	background-color: #F8F8FF;
	position: relative;
	border: 1;
	display: inline-block;
	padding: 15px 30px;
	border-radius: 15px;
	font-family: "paybooc-Light", sans-serif;
	text-decoration: none;
	font-weight: 600;
	transition: 0.25s;
}

.report {
	background-image: url('/resources/images/report.png');
	/* 이미지 경로를 입력하세요 */
	background-color: white;
	width: 40px; /* 버튼의 가로 크기 */
	height: 40px; /* 버튼의 세로 크기 */
	border: none; /* 테두리 제거 */
	background-size: cover; /* 배경 이미지를 버튼에 꽉 채우기 */
	cursor: pointer; /* 마우스 커서를 포인터로 변경하여 클릭 가능하도록 설정 */
}

.map:hover, .chat:hover {
	background-color: #996699;
}

.report:hover {
	background-image: url('/resources/images/report_red.png');
}
</style>
<script>
function openReport() {
   
	var userId = "${dto.userid}";
	var linkParam = encodeURIComponent("<%=request.getContextPath()%>/product/detail/" + "${dto.write_code}");
	var url = "/report/pagereport?userid=" + userId + "&link=" + linkParam;

   
    // 팝업 창 크기 설정
    var popupWidth = 600;
    var popupHeight = 700;

    // 화면 가운데에 위치 계산
    var left = (window.innerWidth - popupWidth) / 2;
    var top = (window.innerHeight - popupHeight) / 2;

    // 작은 팝업 창을 열기 위한 코드
    window.open(url, '신고', 'width=' + popupWidth + ',height=' + popupHeight + ',left=' + left + ',top=' + top);
    }



function delete_product(write_code) {
   if (confirm("삭제하시겠습니까?")) {
      location.href = "/product/delete?write_code="
       			+ write_code;
   }
}
</script>
<script>

function address() {
   
   var userid = "${dto.userid}";
    var url = "/product/map?userid=" + userid;
   
    // 팝업 창 크기 설정
    var popupWidth = 600;
    var popupHeight = 700;

    // 화면 가운데에 위치 계산
    var left = (window.innerWidth - popupWidth) / 2;
    var top = (window.innerHeight - popupHeight) / 2;

    // 작은 팝업 창을 열기 위한 코드
    window.open(url, '신고', 'width=' + popupWidth + ',height=' + popupHeight + ',left=' + left + ',top=' + top);
    }


</script>
</head>
<body>
	<%-- <c:if test="${sessionScope.userid == 'admin'}">
      <%@ include file="../admin/admin_menu.jsp"%>
   </c:if>
   
   <c:if test="${sessionScope.userid != 'admin'}">
      <%@ include file="../main/menu.jsp"%>
   </c:if> --%>

	<%@ include file="../main/menu.jsp"%>
	<!----------------------------------------------------------------------------------->
	<h2>상품정보</h2>
	<c:if
		test="${sessionScope.userid == 'admin' || sessionScope.userid == dto.userid}">
		<div class="button-container">
			<input type="button" onclick="delete_product('${dto.write_code}')"
				value="삭제">
		</div>
	</c:if>
	<table>
		<tr>
			<td align="right" width="642px"><img id="img"
				src="/resources/images/${dto.filename}" alt="Product Image"></td>
			<td>
				<form name="form1" method="post">
					<table>
						<table>
							<tr>
								<td width="300px" style="font-size: xx-large;">${dto.subject}</td>
								<td><button type="button" class="like-button"
										id="likeButton" style="margin-left: 10px;">
										<svg class="like-icon" viewBox="0 0 24 24">
                <path
												d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z" />
            </svg>
									</button></td>

							</tr>


							<tr>

								<th width="100px" style="font-size: xx-large;"><fmt:formatNumber
										value="${dto.price}" pattern="#,###" /></th>
							</tr>
							<tr>
								<td colspan="1" style="color: gray;"><hr></td>
							</tr>

							<tr>
								<td style="color: #2f4f4f; padding-left: 10px;">판매자&nbsp;
									${dto.userid}</td>
							</tr>
							<tr>
								<td width="50px"><input type="button" class="map"
									onclick="address()" value="희망거래장소"></td>
							</tr>
							<tr>
								<td><input type="hidden" name="userid"
									value="${dto.userid}"> <input type="hidden"
									value="${dto.write_code}"> <c:choose>
										<c:when test="${sessionScope.userid == null}">
											<input type="hidden" class="chat" value="구매자와 채팅하기">
										</c:when>
										<c:when test="${sessionScope.userid == dto.userid}">
											<input type="hidden" class="chat" value="구매자와 채팅하기">
										</c:when>
										<c:when test="${sessionScope.userid != dto.userid}">
											<input type="button" class="chat" value="구매자와 채팅하기">
										</c:when>
									</c:choose></td>
								<td><c:choose>
										<c:when test="${sessionScope.userid == 'admin'}">
											<button class="hidden-button" id="noButton"></button>
										</c:when>
										<c:when test="${sessionScope.userid == null}">
											<button class="hidden-button" id="noButton"></button>
										</c:when>

									</c:choose></td>
							</tr>

							<tr>
								<td colspan="2"><input type="hidden" name="link"
									value="<%= request.getContextPath() %>/product/detail/?write_code=${dto.write_code}">
									<c:choose>
										<c:when test="${sessionScope.userid == 'admin'}">
											<input type="hidden" class="report">
										</c:when>
										<c:when test="${sessionScope.userid == null}">
											<input type="hidden" class="report">
										</c:when>
										<c:when test="${sessionScope.userid == dto.userid}">
											<input type="hidden" class="report">
										</c:when>
										<c:when test="${sessionScope.userid != dto.userid}">
											<input type="button" class="report" onclick="openReport()">
										</c:when>
									</c:choose></td>
							</tr>
						</table>
					</table>
				</form>
			</td>
		</tr>
	</table>
	<hr>
	<table align="center">

		<tr>
			<td></td>
			<td></td>
			<td id="content" style="text-align: left; width: 600px;">${dto.contents}</td>
			<td></td>
		</tr>
	</table>

	<script>

   $(document).ready(function(){
       $(".chat").click(function(){
    	   var otherid = "${dto.userid}";
			location.href = "/chat/createchatbox.do?userid="+"${sessionScope.userid}"+"&otherid="+ otherid;
       });
       const likeButton = document.getElementById("likeButton");
       /* let write_code = '${dto.write_code}'; */
       
       likeButton.addEventListener("click", function() {
     	  console.log("click");
           if (likeButton.classList.contains("like-selected")) {
                       $.ajax({
                           url: "/love/love_clear",
                           type: "POST",
                           data: {
                               write_code: ${dto.write_code},
                               userid: "${sessionScope.userid}"
                           },
                           success: function (txt) {
                         	  console.log(txt);
                         	  if (txt == "success")
                               likeButton.classList.remove("like-selected");
                           },
                       });
                  
           }else {
                    $.ajax({
                        url: "/love/love_apply",
                        type: "POST",
                        data: {
                            write_code: ${dto.write_code},
                            userid: "${sessionScope.userid}"
                        },
                        success: function (txt) {
                     	   if (txt == "success")
                            likeButton.classList.add("like-selected");
                        },
                      });
                  }
              });
       
       
       if ("${sessionScope.check}" == 1) {
          likeButton.classList.add("like-selected");
       }       
   });
   

      
   </script>
	<%@ include file="../main/footer.jsp"%>
</body>
</html>