<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../main/menu.jsp"%>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.7.1.js"></script>
<script>
$(function() {   
   $("#btnWrite").click(function() {
      if("${sessionScope.userid}" != ""){
      location.href="/board/write.do";
      }else{
         alert("로그인 후에 이용 가능합니다.");
      location.href="/member/pagelogin.do";
      }
   });
});
function list(page){
   location.href="/board/list.do?cur_page=" 
         + page + "&search_option=${search_option}&keyword=${keyword}";
}   

$(function() {
   $(".article-row").click(function() {
      let row = $(this).attr("data-id");
      location.href = "/board/view.do/" + row
   });
});


</script>
<style>
.page_wrap {
   text-align: center;
   font-size: 10px;
   margin-bottom: 50px;
}

.page_nation {
   display: inline-block;
}

.page_nation .none {
   display: none;
}

.page_nation a {
   display: block;
   margin: 0 3px;
   float: left;
   border: 1px solid #e6e6e6;
   width: 28px;
   height: 28px;
   line-height: 28px;
   text-align: center;
   background-color: #fff;
   font-size: 13px;
   color: #999999;
   text-decoration: none;
}

.page_nation .arrow {
   border: 1px solid #ccc;
}

.page_nation .pprev {
   background: #f8f8f8 url('/resources/images/page_pprev.png') no-repeat
      center center;
   margin-left: 0;
}

.page_nation .prev {
   background: #f8f8f8 url('/resources/images/page_prev.png') no-repeat
      center center;
   margin-right: 7px;
}

.page_nation .next {
   background: #f8f8f8 url('/resources/images/page_next.png') no-repeat
      center center;
   margin-left: 7px;
}

.page_nation .nnext {
   background: #f8f8f8 url('/resources/images/page_nnext.png') no-repeat
      center center;
   margin-right: 0;
}

.page_nation a.active {
   background-color: #42454c;
   color: #fff;
   border: 1px solid #42454c;
}

.table-fixed {
    table-layout: fixed;
    width: 100%; /* 테이블 전체 너비를 100%로 설정 */
    word-break: break-all;
    height: auto;
    border: 1px solid #bcbcbc;
}
.board-list {
   margin: 30px auto;
}
 
.size01 { 
   width:9%;
}

.size02 {
   width: 30%;
}

.size03 {
   width: 15%;
}

.size04 {
   width: 7%;
}
/* 사이드바 스타일 */
.sidebar {
    width: 15%;
    padding: 20px;
}

/* 본문 스타일 */
#main_content {
    width: 70%;
    height: auto;
    padding: 20px;
    margin: 0 auto; /* 가운데 정렬 */
    box-sizing: inherit; /* 패딩, 테두리를 요소의 크기에 포함시킴 */
    
}

/* 푸터 스타일 */
#footer {
    clear: both; /* 사이드바와 본문의 밑에 푸터를 위치시키기 위해 clear 속성 추가 */
    text-align: center; /* 가운데 정렬 */
    padding: 20px;
    border-top: 1px solid #bcbcbc;
}

.button {
    display: inline-block;
    padding: 1px 2px;
    background-color: #f0f0f0;
    color: #333;
    border: 1px solid #ccc;
    border-radius: 4px;
    cursor: pointer;
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
.page-link {
    color: #9523ff;
}
.page-link:hover {
   color: white;
     background-color:  #9523ff;
     border-color: #9523ff;
}

</style>
</head>
<body>
<div class="sidebar" style="float: left;">
      </div>
      
<div id="main_content">
<h2>게시판</h2>
<form name="form1" id="selectForm" method="post" action="/board/search.do">
<div class="btn-group" style="text-align: center">
<select name="search_option" aria-expanded="false">
<c:choose>
   <c:when test="${search_option == null || search_option == 'all'}">
      <option value="all" selected>전체검색</option>
      <option value="nickname" >작성자</option>
      <option value="subject" >제목</option>
      <option value="content" >내용</option>
   </c:when>
   <c:when test="${search_option == 'nickname'}">
      <option value="all" >전체검색</option>
      <option value="nickname" selected>작성자</option>
      <option value="subject" >제목</option>
      <option value="content" >내용</option>
   </c:when>
   <c:when test="${search_option == 'subject'}">
      <option value="all" >전체검색</option>
      <option value="nickname" >작성자</option>
      <option value="subject" selected>제목</option>
      <option value="content" >내용</option>
   </c:when>
   <c:when test="${search_option == 'content'}">
      <option value="all" >전체검색</option>
      <option value="nickname" >작성자</option>
      <option value="subject" >제목</option>
      <option value="content" selected>내용</option>
   </c:when>
</c:choose>
</select>
</div>
<input id="keyword" name="keyword" value="${map.keyword}">
<input type="submit" value="검색" class="btn btn-outline-gagi" id="btn_Search" onclick="nokeyword()" > 
<button type="button" id="btnWrite" class="btn btn-outline-gagi" >게시글 작성</button>
</form>
<article>   
   <table class="board-list table-fixed">
      <tr align="center" style="background-color: write; ">
         <th class="size04">번호</th>
         <th class="size01">작성자</th>
         <th class="size02">제목</th>
         <th class="size03">날짜</th>
         <th class="size03">조회수</th>
      </tr>
      <c:forEach var="dto" items="${map.list}" varStatus="s">
      <c:choose>
      <c:when test="${dto.nickname == '관리자'}">
         <tr align="center" class="article-row" data-id="${dto.num}" style="background-color: #F2F2F2; cursor: pointer;" >
            <td><span class="button">공지</span></td>  
            <td><span>관리자</span></td>
            <td>${dto.subject}</td>
            <td>${dto.reg_date}</td>
            <td>${dto.hit}</td>
         </tr>
         <tr>
         <td></td>
         </tr>
         </c:when>
         <c:otherwise>
         <tr align="center" class="article-row" data-id="${dto.num}" style="cursor: pointer;">
            <td>${(map.page.totalCount - (dto.rn - 1))}</td>  
            <td>${dto.nickname}</td>
            <td>${dto.subject}</td>
            <td>${dto.reg_date}</td>
            <td>${dto.hit}</td>
         </tr>
         <tr>
         <td></td>
         </tr>
         </c:otherwise>
         </c:choose>
      </c:forEach>
   </table>
</article>
   <div class="page_wrap">
         <div class="page_nation">
            <c:if test="${map.page.curPage > 1}">
               <a class="arrow pprev" href="#" onclick="list('1')"></a>
            </c:if>
            <c:if test="${map.page.curBlock > 1}">
               <a class="arrow prev" href="#" onclick="list('${map.page.prevPage}')"></a>
            </c:if>
            <c:forEach var="num" begin="${map.page.blockStart}"
               end="${map.page.blockEnd}">
               <c:choose>
                  <c:when test="${num == map.page.curPage}">
                     <a style="color: green" class="active">${num}</a>
                  </c:when>
                  <c:otherwise>
                     <a href="#" onclick="list('${num}')">${num}</a>
                  </c:otherwise>
               </c:choose>
            </c:forEach>
            <c:if test="${map.page.curBlock < map.page.totBlock}">
               <a class="arrow next" href="#" onclick="list('${map.page.nextPage}')"></a>
            </c:if>
            <c:if test="${map.page.curPage < map.page.totPage}">
               <a class="arrow nnext" href="#" onclick="list('${map.page.totPage}')"></a>
            </c:if>
         </div>
      </div>

</div>
<br><br><br><br><br><br><br><br>
<div class="sidebar" style="float: right;">
 </div>
      
<div id="footer">
<%@ include file="../main/footer.jsp"%>
</div>
</body>
</html>