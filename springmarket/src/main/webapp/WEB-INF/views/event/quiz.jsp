<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>퀴즈</title>
<link rel="stylesheet"
   href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>
body {
   font-family: 'Noto Sans KR', sans-serif;
   background-color: #f8f9fa;
}

.quiz-container {
   max-width: 800px;
   margin: 50px auto;
   padding: 20px;
   background-color: #ffffff;
   border-radius: 10px;
   box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

#h2 {
   color: #007bff;
   margin-bottom: 20px;
}

input[type="radio"] {
   margin-right: 10px;
}

input[type="button"] {
   background-color: #007bff;
   color: #ffffff;
   border: none;
   padding: 10px 20px;
   border-radius: 5px;
   cursor: pointer;
   font-size: 16px;
}

#img {
   float: left; /* 왼쪽 정렬 */
   margin-top: 300px; /* 상단 여백 조정 */
   max-width: 200px; /* 이미지 최대 너비 설정 */
   align-content: center;
   margin-left: 150px;
}
h1 {
    color: #007bff; /* 제목 색상을 파란색으로 설정 */
    font-size: 36px; /* 제목 글꼴 크기를 키웁니다. */
    text-shadow: 2px 2px 2px rgba(0, 0, 0, 0.2); /* 텍스트 그림자 추가 */
    margin-top: 20px; /* 제목 위 여백 조정 */
    margin-bottom: 30px; /* 제목 아래 여백 조정 */
}
</style>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
   function check() {
      // Loop through each question to check if an option is selected
      var quizIds = document.getElementsByName("quiz_idx");
      var isChecked = false;
      for (var i = 0; i < quizIds.length; i++) {
         var quizIdx = quizIds[i].value;
         var selectedOption = document.querySelector('input[name="num'
               + quizIdx + '"]:checked');
         if (!selectedOption) {
            isChecked = false;
            break;
         } else {
            isChecked = true;
         }
      }
      if (!isChecked) {
         alert("체크해주세요.");
         return;
      }

      // Show confirmation dialog
      var isConfirmed = confirm("정답을 제출하시겠습니까?");
      if (isConfirmed) {
         // If confirmed, submit the form
         document.form1.submit();
      }
   }
</script>
</head>
<body>
   <%@ include file="../main/menu.jsp"%>
   
   
   <h1 align="center">🍆퀴즈쇼🍆</h1>
   <br>
   
   
   <div class="quiz-container">
      <form method="post" name="form1"
         action="/market/quiz_servlet/insert.do">
         <c:forEach var="row" items="${items}">
            <h2 id="h2">${row.question}</h2>
            <div>
               <input type="radio" name="num${row.quiz_idx}" value="1">${row.ans1}
            </div>
            <div>
               <input type="radio" name="num${row.quiz_idx}" value="2">${row.ans2}
            </div>
            <div>
               <input type="radio" name="num${row.quiz_idx}" value="3">${row.ans3}
            </div>
            <div>
               <input type="radio" name="num${row.quiz_idx}" value="4">${row.ans4}
            </div>
            <input type="hidden" name="quiz_idx" value="${row.quiz_idx}">
            <br>
         </c:forEach>

         <div>
            <input type="button" value="확인" onclick="check()">
         </div>
      </form>
   </div>
</body>
</html>
