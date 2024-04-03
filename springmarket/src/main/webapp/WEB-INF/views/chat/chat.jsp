<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.7.1.js"></script>
<style>
* {
   padding: 0;
   margin: 0;
   box-sizing: border-box;
}

a {
   text-decoration: none;
}

.wrap {
   padding-top: 120px;
   padding-bottom: 100px;
   position: absolute;
   top: 50%;
   left: 50%;
   transform: translate(-50%, -50%);
   background-color: #A8C0D6;
   width: 30%;
   max-height: 80vh; /* Set a maximum height for the chat container */
   overflow-y: auto; /* Enable vertical scrolling when needed */
}

.wrap .chat {
   display: flex;
   align-items: flex-start;
   padding: 20px;
}

.wrap .chat .icon {
   position: relative;
   overflow: hidden;
   width: 50px;
   height: 50px;
   border-radius: 50%;
   background-color: #eee;
}

.wrap .chat .icon i {
   position: absolute;
   top: 10px;
   left: 50%;
   font-size: 2.5rem;
   color: #aaa;
   transform: translateX(-50%);
}

.wrap .chat .textbox {
   position: relative;
   display: inline-block;
   max-width: calc(100% - 70px);
   padding: 10px;
   margin-top: 7px;
   font-size: 13px;
   border-radius: 10px;
}

.wrap .chat .textbox::before {
   position: absolute;
   display: block;
   top: 0;
   font-size: 1.5rem;
}

.wrap .ch1 .textbox {
   margin-left: 20px;
   background-color: #ddd;
}

.wrap .ch1 .textbox::before {
   left: -15px;
   content: "◀";
   color: #ddd;
}

.wrap .ch2 {
   flex-direction: row-reverse;
}

.wrap .ch2 .textbox {
   margin-right: 20px;
   background-color: #F9EB54;
}

.wrap .ch2 .textbox::before {
   right: -15px;
   content: "▶";
   color: #F9EB54;
}

.write {
   position: fixed; /* .wrap을 기준으로 위치를 지정합니다. */
   bottom: 0;
   left: 0;
   width: 100%;
   background-color: #fff;
   padding: 10px;
   box-shadow: 0px -2px 5px rgba(0, 0, 0, 0.1); /* 하단 그림자 추가 */
}

.menu {
   position: fixed;
   top: 0;
   width: 100%;
   background-color: #ffffff;
   z-index: 1000; /* 다른 요소 위에 표시되도록 설정합니다. */
}

.righttime {
   margin-top: 33px;
   margin-right: 6px;
   position: relative;
   font-size: 9px;
}

.lefttime {
   margin-top: 33px;
   margin-left: 6px;
   position: relative;
   font-size: 9px;
}
</style>


</head>

<body>
   <div class="menu">
      <%@ include file="../main/menu.jsp"%>
   </div>

   <div class="wrap">
      <c:forEach var="var" items="${list}">
         <c:if test="${var.fromid != sessionScope.userid}">
            <div class="chat ch1">
               <div class="icon">
                  <i class="fa-solid fa-user">${var.fromid}</i>
               </div>
               <div class="textbox">${var.chatcomment}</div>


               <div class="lefttime">${var.time}</div>
            </div>
         </c:if>

         <c:if test="${var.fromid == sessionScope.userid}">
            <div class="chat ch2">
               <div class="icon">
                  <i class="fa-solid fa-user">${var.fromid}</i>
               </div>
               <div class="textbox">${var.chatcomment}</div>

               <div class="righttime">${var.time}</div>
            </div>
         </c:if>

      </c:forEach>
   </div>




   <div class="write" align="center	">
      <form id="chatForm" action="#" method="post">
         <input type="text" name="content" id="content"> <input
            type="hidden" id="toid" value="${toid}"> <input
            type="submit" id="btnwrite" value="전송">
      </form>
   </div>

</body>
<script>
   $(document)
         .ready(
               function() {
                  // 페이지가 로드될 때 스크롤을 가장 아래로 이동합니다.
                  $(".wrap").scrollTop($(".wrap")[0].scrollHeight);

                  // 폼 제출(submit) 이벤트 처리
                  $("#chatForm").submit(function(event) {
                     event.preventDefault(); // 기본 동작(페이지 새로고침)을 막습니다.

                     sendMessage(); // 메시지를 전송하는 함수 호출
                  });

                  // 메시지를 전송하는 함수
                  function sendMessage() {
                     var chatcomment = $("#content").val();
                     var toid = $("#toid").val();
                     var time = getCurrentTime();

                     // 현재 시간을 반환하는 함수
                     function getCurrentTime() {
                        var now = new Date();
                        var month = now.getMonth() + 1;
                        var day = now.getDate();
                        var hour = now.getHours();
                        var minute = now.getMinutes();
                        var second = now.getSeconds(); // 초 추가

                        // 달, 일, 시, 분, 초가 한 자리 수인 경우 앞에 0을 붙입니다.
                        month = month < 10 ? "0" + month : month;
                        day = day < 10 ? "0" + day : day;
                        hour = hour < 10 ? "0" + hour : hour;
                        minute = minute < 10 ? "0" + minute : minute;
                        second = second < 10 ? "0" + second : second;

                        // 포맷된 날짜 및 시간을 반환합니다.
                        return month + "/" + day + " " + hour + ":"
                              + minute + ":" + second;
                     }
                     if (chatcomment.trim() === "") {
                        chatcomment = null;
                     }
                     if (chatcomment !== null) {
                        $
                              .ajax({
                                 url : "/market/chat_servlet/chatwrite.do",
                                 type : "GET",
                                 data : {
                                    toid : toid,
                                    fromid : "${sessionScope.userid}",
                                    chatcomment : chatcomment,
                                    time : time
                                 },
                                 success : function() {
                                    var newChatMessage = '<div class="chat ch2"><div class="icon"><i class="fa-solid fa-user">'
                                          + "${sessionScope.userid}"
                                          + '</i></div><div class="textbox">'
                                          + chatcomment
                                          + '</div><div class="righttime">'
                                          + time + '</div></div>';
                                    $(".wrap").append(
                                          newChatMessage);

                                    $(".wrap")
                                          .scrollTop(
                                                $(".wrap")[0].scrollHeight);

                                    $("#content").val("");
                                 },
                              });
                     }else{
                        alert("내용을 입력하세요");
                     }
                  }
               });
</script>



<script>
   function updateChat() {
      var toid = $("#toid").val();
      var time2 = getFiveCurrentTime();

      // 현재 시간을 반환하는 함수
      function getFiveCurrentTime() {
         var now = new Date();
         now.setSeconds(now.getSeconds() - 3);
         var month = now.getMonth() + 1;
         var day = now.getDate();
         var hour = now.getHours();
         var minute = now.getMinutes();
         var second = now.getSeconds(); // 초 추가

         // 달, 일, 시, 분, 초가 한 자리 수인 경우 앞에 0을 붙입니다.
         month = month < 10 ? "0" + month : month;
         day = day < 10 ? "0" + day : day;
         hour = hour < 10 ? "0" + hour : hour;
         minute = minute < 10 ? "0" + minute : minute;
         second = second < 10 ? "0" + second : second;

         // 포맷된 날짜 및 시간을 반환합니다.
         return month + "/" + day + " " + hour + ":" + minute + ":" + second;
      }

      $.ajax({
         url : "/market/chat_servlet/update.do",
         type : "GET",
         data : {
            fromid : toid,
            time : time2
         },
         success : function(response) {

            // 서버로부터 받아온 데이터(response)를 이용하여 화면에 채팅 메시지를 추가합니다.
            for (var i = 0; i < response.length; i++) {
               var chat = response[i];
               var chatMessage = '<div class="chat ch1">'
                     + '<div class="icon"><i class="fa-solid fa-user">'
                     + chat.fromid + '</i></div>'
                     + '<div class="textbox">' + chat.chatcomment
                     + '</div>' + '<div class="lefttime">' + chat.time
                     + '</div>' + '</div>';
               $(".wrap").append(chatMessage);
            }

            // 새로운 채팅이 추가된 후에 스크롤을 아래로 이동
            $(".wrap").scrollTop($(".wrap")[0].scrollHeight);
         },
         error : function(xhr, status, error) {
            // 요청이 실패한 경우 처리
            console.error("Failed to update chat:", error);
         }
      });
   }

   // 주기적으로 채팅 업데이트 요청을 보내는 타이머 설정
   var updateInterval = setInterval(updateChat, 3000);

   // 페이지를 떠날 때 타이머 제거
   $(window).on('beforeunload', function() {
      clearInterval(updateInterval);
   });
</script>


</html>