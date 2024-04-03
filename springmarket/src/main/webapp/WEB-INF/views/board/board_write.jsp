<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<!DOCTYPE html>
<html>
<head>
<%@ include file="../main/menu.jsp"%>
<meta charset="UTF-8">
<title>게시글 작성</title>

<script>
function returnBtn() {
   location.href = "/market/board_servlet/list.do";
}
</script>
<style>
body {
padding-top: 20px;
font-family: Arial, sans-serif;
}
.container {
max-width: 600px;
margin: 0 auto;
}
h2 {
margin-bottom: 30px;
}
.form-control {
margin-bottom: 15px;
}

        
  /* 푸터 스타일 */
#footer {
    position: absolute; /* 절대 위치 설정 */
    bottom: 0; /* 아래로부터 0px 위치 */
    width: 100%; /* 전체 너비 설정 */
    text-align: center; /* 가운데 정렬 */
    padding: 20px;
    border-top: 1px solid #bcbcbc;
    }
    
.btn-outline-gagi {
  --bs-btn-color:   #9523ff;
  --bs-btn-border-color:    #9523ff;
  --bs-btn-hover-color: #fff;
  --bs-btn-hover-bg:    #9523ff;
  --bs-btn-hover-border-color:    #9523ff;
  --bs-btn-focus-shadow-rgb: 25, 135, 84;
  --bs-btn-active-color: #fff;
  --bs-btn-active-bg:    #9523ff;
  --bs-btn-active-border-color:    #9523ff;
  --bs-btn-active-shadow: inset 0 3px 5px rgba(0, 0, 0, 0.125);
  --bs-btn-disabled-color:    #9523ff;
  --bs-btn-disabled-bg: transparent;
  --bs-btn-disabled-border-color:    #9523ff;
  --bs-gradient: none;
}
</style>
</head>
<body>
    <div class="container">
        <h2>게시글 작성</h2>
        <form name="form1" class="form-control" style="width: 100%;" method="post" action="/market/board_servlet/insert.do" style>
            <div class="form-group">
                <label for="subject">제목</label>
                <input type="text" class="form-control" style="width: 100%;" id="subject" name="subject" required>
            </div>
            <div class="form-group">
                <label for="nickname">닉네임</label>
                <input type="text" class="form-control" style="width: 100%;" id="nickname" name="nickname" value="${sessionScope.nickname}" readonly>
            </div>
            <div class="form-group">
                <label for="content">내용</label>
                <textarea class="form-control" style="width: 100%;" id="content" name="content" rows="5" placeholder="내용을 입력해주세요" required></textarea>
            </div>
            <div class="form-group text-center">
                <button type="submit" class="btn btn-outline-gagi">확인</button>
                <button type="button" class="btn btn-outline-gagi" onclick="returnBtn()">나가기</button>
            </div>
        </form>
    </div>
    
<div id="footer">
<%@ include file="../main/footer.jsp"%>
</div>
</body>
</html>
