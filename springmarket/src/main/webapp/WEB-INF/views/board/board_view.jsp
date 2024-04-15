<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../main/menu.jsp"%>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
   // 돌아가기 버튼 클릭시!
   function btnList() {
      location.href = "/board/list.do";
   }

   // DOMContentLoaded를 이용해서 현재 문서로드시 btnEdit 실행 유무
   document.addEventListener('DOMContentLoaded', function() {
      let nowUserId = "${sessionScope.userid}";
      let postUserId = "${dto.userid}";
      let btnEdit = $("#btnEdit");

      if (nowUserId === postUserId) {
         btnEdit.prop("disabled", false).show();
         btnEdit.click(function() {
        	 let num = $("#num").val();
            location.href = "/board/edit.do/" + num;
         });
      } else {
         btnEdit.prop("disabled", true).hide();
      }
      
   });
   
   function formatDate(dateString) {
	    // dateString을 Date 객체로 변환
	    let date = new Date(dateString);
	    
	    // 날짜를 yyyy-MM-dd HH:mm:ss 형식으로 포맷팅
	    let formattedDate = date.getFullYear() + '-' + ('0' + (date.getMonth() + 1)).slice(-2) + '-' + ('0' + date.getDate()).slice(-2)
	        + ' ' + ('0' + date.getHours()).slice(-2) + ':' + ('0' + date.getMinutes()).slice(-2) + ':' + ('0' + date.getSeconds()).slice(-2);
	    
	    return formattedDate;
	}

   function btnWrite() { //댓글 작성
       let num = $("#num").val();
       let userid = '${sessionScope.userid}';
       let comment_content = $("#comment_content").val();

       if (comment_content.trim() === "") {
           alert("내용을 입력하세요");
           return; // 댓글 내용이 없으면 함수 종료
       }

       if (userid) { // userid가 있는 경우 (즉, 로그인 되어 있는 경우)
           $.ajax({
               url: '/comment/write.do',
               type: 'POST',
               data: {
                   "num": num,
                   "userid": userid,
                   "comment_content": comment_content,
               },
               success: function(data) {
                   // 성공적으로 댓글을 작성하면 댓글 목록을 다시 불러와서 업데이트
                   show_List();
               },
               error: function(xhr, status, error) {
                   console.error('댓글 작성에 실패했습니다:', status, error);
               }
           });
           $("#comment_content").val(""); // 댓글 작성 후 입력창 초기화
       } else {
           // userid가 없는 경우 (즉, 로그인 되어 있지 않은 경우)
           alert("로그인 후에 이용 가능합니다.");
           location.href = "/member/pagelogin.do"; // 로그인 페이지로 이동
       }
   }

   function show_List() {
      let num = '${dto.num}';
      let userid = '${sessionScope.userid}';
      let comment_content = '${comment.comment_content}';
      let comment_date = '${comment.comment_date}';

      $.ajax({
               url : '/comment/list.do', // 댓글 목록 서블릿
               type : 'GET',
               data : {
                  "num" : num,
                  "userid" : userid,
                  "comment_content" : comment_content,
                  "comment_date" : comment_date
               },
               dataType : 'json',
               success : function(data) { // data는 서버로부터 받은 JSON
                  $('#commentList').empty();
                  let row = "";
                  if (data.length < 1) {
                     row += '<div class="center-container" id="commentList">';
                     row += '<article class="_article">';
                     row += '<ul class="list-group">';
                     row += '<li class="list-group-item active" style="background-color: #bf7bff; border-color: #bf7bff;" >댓글</li>'
                     row += '<li class="list-group-item">등록된 댓글이 없습니다.</li>';
                     row += '</ul>';
                     row += '</article>';
                     row += '</div>';
                  } else {
                     row += '<div class="center-container" id="commentList">';
                     row += '<article class="_article">';
                     row += '<ul class="list-group">';
                     row += '<li class="list-group-item active" style="background-color: #bf7bff; border-color: #bf7bff;">댓글</li>'
                     data.forEach(function(comment) { // 댓글 하나씩 추가하기
                              row += '<li class="list-group-item">';
                              row += '<span style="font-size: 15px">아이디:' + comment.userid + '</span> '
                                    + '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
                                    row += '<span style="font-size: 12px">'
                                        + formatDate(comment.comment_date)
                                        + '</span>';
                              // 사용자와 댓글 작성자가 동일하면 수정/삭제 버튼 추가
                              if (comment.userid == '${sessionScope.userid}') {
                                 row += '<div style="font-size: 12px; float: right;">';
                                 row += '<button style="color: gray; background-color: transparent; border : 0px;" onclick="update_comment('
                                       + comment.comment_num
                                       + ')">수정</button>';
                                 row += '<button style="color: gray; background-color: transparent; border : 0px;" onclick="delete_comment('
                                       + comment.comment_num
                                       + ')">삭제</button>';
                                 row += '</div>';
                              }
                                    + '</span>' + '<br>';
                              row += '<br><br>';
                              row += '<span style="font-size: 18px">'+ comment.comment_content+'</span> ';
                              row += '</li>';
                           });
                     row += '</ul>';
                     row += '</article>';
                     row += '</div>';
                  }
                  // 댓글 목록을 추가
                  $('#commentList').append(row);
               },
               error : function(xhr, status, error) {
                  console.error('댓글 목록을 가져오는데 실패했습니다:', status, error);
               }
            });
   }

   $(document).ready(function() {
      show_List(); //board_view 켜지면 자동로드됙
   });

   function update_comment(comment_num) {
	   let userid = '${sessionScope.userid}';
      // Retrieve the comment content that needs to be updated
      let updated_content = prompt("수정할 내용을 입력하세요:", "");

      if (updated_content.trim() === "") {
         updated_content = null;
      }

      if (updated_content !== null) {
         // Perform an AJAX request to update the comment
         $.ajax({
            url : '/comment/update.do',
            type : 'POST',
            data : {
               "userid": userid,
               "comment_num" : comment_num,
               "comment_content" : updated_content
            },
            success : function(data) {
               // Reload the comment list after updating
               show_List();
            },
            error : function(xhr, status, error) {
               console.error('댓글 수정에 실패했습니다:', status, error);
            }
         });
      } else {
         alert("내용을 입력하세요");
      }
   }

   function delete_comment(comment_num) {
	   let num = $("#num").val();
      let userid = '${sessionScope.userid}';
      if (confirm("정말로 삭제하시겠습니까?")) {
         $.ajax({
            url : '/comment/delete.do',
            type : 'GET',
            data : {
               "userid" : userid,
               "comment_num" : comment_num,
               "num" : num
            },
            success : function(data) {
               // 댓글 삭제 후 댓글 목록 다시 로드
               show_List();
            },
            error : function(xhr, status, error) {
               console.error('댓글 삭제에 실패했습니다:', status, error);
            }
         });
      }
   }
</script>
<style>
   body {
    margin: 20px;
}

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
  --bs-btn-disabled-border-color:    #9523ff;
  --bs-gradient: none;
}

</style>
</head>


<body>

  <div class="center-container" align = "center">
    <article class="_article">
        <table class="board-list">
            <tr>
                <td>날짜: ${dto.reg_date}</td>
                <td>조회수: ${dto.hit}</td>
            </tr>
            <tr><td colspan="4"><hr></td></tr>
            <tr>
                <td style="font-size: 20px;" colspan="3" >${dto.subject}</td>
            </tr>
            <tr>
                <td colspan="4">아이디: ${dto.userid}</td>
            </tr>
            <tr><td><br></td></tr>
            <tr><td><br></td></tr>
            <tr>
                <td colspan="4"><textarea rows="5" readonly>${dto.content}</textarea></td>
            </tr>
            <tr class="btn-container">
                <td colspan="4" align="center">
                    <input type="hidden" name="num" id="num" value="${dto.num}">
                    <button class="btn btn-outline-gagi" id="btnEdit">수정/삭제</button>
                    <button class="btn btn-outline-gagi" id="btnBack" onclick="btnList()">돌아가기</button>
                </td>
            </tr>
        </table>
    </article>
</div>

   <!-- 댓글목록 -->
      <div class="center-container" id="commentList"><article class="_article"></article></div>


  <!-- 댓글쓰기 -->
   <div class="center-container">
   <article class="_article">
         <table class="table table-bordered"
            style="text-align: center; border: 1px solid #dddddd">
            <tr>
               <td align="left">${userid}</td>
            </tr>
            <tr>
               <td><textarea class="form-control" placeholder="댓글 쓰기"
                     id="comment_content" style="width: 100%;"></textarea></td>
            </tr>
         </table>
         <input type="button" onclick="btnWrite()"
            class="btn btn-outline-gagi" value="댓글 쓰기">
            </article>
      </div>
   
   <br><br><br><br><br>
   <%@ include file="../main/footer.jsp"%>
</body>
</html>