<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>중고상품 목록</title>
<style>
body {
   text-align: center;
}

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
   background: #f8f8f8 url('../images/page_pprev.png') no-repeat center
      center;
   margin-left: 0;
}

.page_nation .prev {
   background: #f8f8f8 url('../images/page_prev.png') no-repeat center
      center;
   margin-right: 7px;
}

.page_nation .next {
   background: #f8f8f8 url('../images/page_next.png') no-repeat center
      center;
   margin-left: 7px;
}

.page_nation .nnext {
   background: #f8f8f8 url('../images/page_nnext.png') no-repeat center
      center;
   margin-right: 0;
}

.page_nation a.active {
   background-color: #42454c;
   color: #fff;
   border: 1px solid #42454c;
}

.box img { /* hover 뒤 애니메이션 */
   transform: scale(1.0); /* 이미지 확대 */
   transition: transform .3s; /* 시간 설정 */
}

.box img:hover { /* hover 시 애니메이션 */
   transform: scale(1.1); /* 이미지 확대 */
   transition: transform .3s; /* 시간 설정 */
}



@media only screen and (max-width: 767px) {
   .card-link {
      width: 100%;
      margin-bottom: 20px;
   }
}
.box {
  max-width: 100%;
  height: 400px; /* 원하는 높이로 설정합니다. */
  overflow: hidden; /* 이미지가 넘치는 경우를 대비해 오버플로우를 숨깁니다. */
}

.box img {
  width: 100%;
  height: 100%;
  object-fit: cover; /* 이미지를 박스에 맞추고 자르거나 늘리도록 설정합니다. */
}
.card-title {
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis; /* 일정 길이 이상의 텍스트를 생략하고 ...으로 표시 */
    font-size: 30px;
}
</style>

<!-- <script>
   function list(page) {
      location.href = "/market/mk_servlet/search.do?cur_page=" + page
            + "&keyword=${keyword}";
   }
</script> -->
</head>
<body>
<%--   <c:if test="${sessionScope.userid == 'admin'}">
      <%@ include file="../admin/admin_menu.jsp"%>
   </c:if>
   <c:if test="${sessionScope.userid != 'admin'}">
      <%@ include file="../main/menu.jsp"%>
   </c:if>
   <c:if test="${keyword == null}">
      <h1 align="center">중고상품</h1>
   </c:if>
   <c:if test="${keyword != null}">
      <h1 align="center">${keyword}의 검색결과</h1>
   </c:if> --%>
<c:choose>
      <c:when test="${sessionScope.userid == 'admin'}">
         <%@ include file="../admin/admin_menu.jsp"%>
      </c:when>
      <c:otherwise>
         <%@ include file="../main/menu.jsp"%>
      </c:otherwise>
   </c:choose>

   <div class="container">
      <div class="row">
         <c:forEach var="row" items="${list}" varStatus="status">
            <div class="col-lg-4 col-md-6 col-sm-12">
               <article class="card-link" >
                  <a class="card" style="margin: 10px; text-decoration: none;"
                     href="/product/detail/${row.write_code}">
                     <div class="box">
                        <img class="card-img" alt="${row.filename}"
                           src="/resources/images/${row.filename}" />
                     </div>
                     <div>
                        <h2 class="card-title" style="text-align: center; font-size: 20px; font-weight: bold;">${row.subject}</h2>
                        <div class="card-content" style="font-weight: bold;">
                           가격:
                           <fmt:formatNumber value="${row.price}" pattern="#,###"/>
                           원
                        </div>
                        <div class="card-content"><span style="font-size: small">${mdao.address(row.userid)}</span></div>
                        <div class="card-mini">
                           <span style="font-size: small">관심 : ${dao.love_count(row.write_code)}</span> ∙ 
                           <span style="font-size: small">조회수 : ${row.see} </span>
                        </div>
                     </div>
                  </a>
               </article>
            </div>
         </c:forEach>
      </div>
      <br><br><br><br><br>
      <div class="page_wrap">
         <div class="page_nation">
            <c:if test="${page.curPage > 1}">
               <a class="arrow pprev" href="#" onclick="list('1')"></a>
            </c:if>
            <c:if test="${page.curBlock > 1}">
               <a class="arrow prev" href="#" onclick="list('${page.prevPage}')"></a>
            </c:if>
            <c:forEach var="num" begin="${page.blockStart}"
               end="${page.blockEnd}">
               <c:choose>
                  <c:when test="${num == page.curPage}">
                     <a style="color: green" class="active">${num}</a>
                  </c:when>
                  <c:otherwise>
                     <a href="#" onclick="list('${num}')">${num}</a>
                  </c:otherwise>
               </c:choose>
            </c:forEach>
            <c:if test="${page.curBlock < page.totBlock}">
               <a class="arrow next" href="#" onclick="list('${page.nextPage}')"></a>
            </c:if>
            <c:if test="${page.curPage < page.totPage}">
               <a class="arrow nnext" href="#" onclick="list('${page.totPage}')"></a>
            </c:if>
         </div>
      </div>
   </div>
   <%@ include file="../main/footer.jsp"%>
</body>
</html>
