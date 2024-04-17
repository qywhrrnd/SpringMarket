<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../main/menu.jsp"%>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
$(function() {
   $("#btnDelete").click(function() {
      if(confirm("정말 삭제하시겠습니까?")==true) {
         document.form1.action = "/board/delete.do";
         document.form1.submit();
      }else{
    	  return false;
          
      }
});
   $("#btnUpdate").click(function() {
      let userid = '${sessionScope.userid}';   
      let subject = $("#subject").val();   
      let content = $("#content").val();
      
      if(subject == "") {
         alert("제목을 입력하세요");
         $("#subject").focus();
         return;
      }
      if(content == "") {
         alert("내용을 입력하세요");
         $("#content").focus();
         return;
      }
      document.form1.action = "/board/update.do";
      document.form1.submit();
   });
   
   $("#btnView").click(function(){
	   let num = $("#num").val();
	   if(confirm("저장안되는데 할거야?")) {
		   document.form1.action = "/board/back.do/" + num;
		   document.form1.submit();
	   }
   });
   
});

function back() {
	if(confirm("정말 돌아가시겠습니까?\n변경사항은 저장되지 않습니다.")) {
  	  location.href = "/board/list.do";
    }
}


</script>
<style>
   

.center-container {
    display: flex;
    justify-content: center;
    flex-direction: column;
}

._article {
    width: 80%;
    margin: 0 auto;
    padding: 20px;
    background-color: #fff;
    border: 1px solid #eaeaea;
    border-radius: 5px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.board-list {
    width: 80%;
    margin: 0 auto;
}

.board-list textarea {
    width: calc(100% - 22px);
    padding: 10px;
    border: 1px solid #eaeaea;
    border-radius: 5px;
    resize: none;
    margin: 10px 0;
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
  --bs-btn-disabled-border-color: #9523ff;
  --bs-gradient: none;
}

</style>
</head>
<body>
<div>
<article class="_article">
<form name="form1" method="post">
<table class="board-list" width="100%">
    <tr>
        <td>날짜: ${dto.reg_date}</td>
    </tr>
    <tr>
        <td colspan="4"><hr></td>
    </tr>
    <tr>
        <td colspan="3" name="userid" id="userid">${sessionScope.userid}</td>
    </tr>
    <tr>
        <td colspan="3" ><input name="subject" id="subject" value="${dto.subject}" size="60"></td>
    </tr>
    <tr>
        <td colspan="3"><textarea rows="5" cols="50" name="content" id="content">${dto.content}</textarea></td>
    </tr>
    <tr>
        <td colspan="4" align="center">
            <input type="hidden" name="num" id="num" value="${dto.num}">
        </td>
    </tr>
    <tr><td colspan="4" align="center">
            <button class="btn btn-outline-gagi" id="btnUpdate">수정</button>
            <button class="btn btn-outline-gagi" id="btnDelete" >삭제</button>
            <button class="btn btn-outline-gagi" id="btnView">돌아가기</button>
	</td></tr>
</table>
</form>


</article>
</div>
<br><br><br><br><br>
<%@ include file="../main/footer.jsp"%>
</body>
</html>