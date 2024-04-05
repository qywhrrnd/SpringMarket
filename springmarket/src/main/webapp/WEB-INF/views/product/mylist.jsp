<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.7.1.js"></script>
<script>
   function delete_product(write_code) {
      if (confirm("삭제하시겠습니까?")) {
    	  location.href = "/product/mylist_delete?write_code="
     			+ write_code;
      }
   }
   function updateStatus(write_code,status_code) {
      if (confirm("판매 상태를 변경하시겠습니까?")){
         location.href = "/product/updateStatus?write_code=" + write_code + "&status_code=" + status_code;
         
      }
   }
</script>
<style>
body {
   font-family: 'Nanum Gothic', sans-serif; /* 원하는 한글 글꼴로 변경 */
   background-color: #f8f8f8;
   margin: 0;
   padding: 0;
}

h2 {
   color: #333;
   margin-bottom: 20px; /* 제목과 테이블 사이 여백 조절 */
}

form {
   margin: 0;
}

.container {
   width: 80%;
   margin: 0 auto;
}

table {
   width: 100%;
   border-collapse: collapse;
   margin-top: 20px;
}

th, td {
   border: 1px solid #ddd;
   padding: 8px;
   text-align: center;
}

th {
   background-color: #f2f2f2;
}

img {
   max-width: 100%;
   height: auto;
}

.button-group {
   display: flex;
   justify-content: space-between;
   margin-bottom: 10px; /* 버튼 그룹과 테이블 사이 여백 조절 */
}

.button-group button {
   padding: 8px;
   cursor: pointer;
}

select {
   padding: 8px;
}

#footer {
   clear: both;
   text-align: center;
   padding: 5px;
   border-top: 1px solid #bcbcbc;
   position: relative; /* 푸터를 화면 하단에 고정시킴 */
   bottom: 0;
   width: 100%;
   background-color: white;
}
</style>
</head>
<body>
   <%@ include file="../main/menu.jsp"%>
   <c:choose>
      <c:when test="${list.size() == 0}">
   판매하는 상품이 없습니다.
   </c:when>
      <c:when test="${list.size() > 0}">

         <div align="center">
            <form method="post" name="form1">
               <h2 align="center">내 전체게시물</h2>
               <!-- <input type="button" value="전체" onclick="">&nbsp; <input
            type="button" value="판매중" onclick="">&nbsp; <input
            type="button" value="판매완료" onclick=""><br> -->


               <table border="1" style="width: 100%">

                  <tr align="center">
                     <th style="width: 200px">제목(상품명)</th>
                     <th style="width: 300px">사진</th>
                     <th style="width: 100px">가격</th>
                     <th style="width: 200px">&nbsp;</th>
                     <th style="width: 200px">판매상태</th>
                     <th style="width: 200px">&nbsp;</th>
                  </tr>

                  <c:forEach var="row" items="${list}">
                     <c:if test="${row.userid eq sessionScope.userid}">
                        <tr>
                           <td align="center">
                           <a href="/product/detail/${row.write_code}">
                                 ${row.subject}</a></td>
                           <td align="center"><img
                              src="/resources/images/${row.filename}" width="100px"
                              height="100px"></td>

                           <td align="center"><fmt:formatNumber value="${row.price}"
                                 pattern="#,###" /> <c:if
                                 test="${sessionScope.userid != null}">

                                 <td align="center"><a
                                    href="/product/edit/${row.write_code}">[편집]</a>
                                    &nbsp;<input type="button"
                                    onclick="delete_product('${row.write_code}')" value="삭제"></td>
                                 <td align="center">
                                    <%-- <c:if test="${sessionScope.userid != null}"> --%> 
                                    <select id="statusSelect"
                                    onchange="updateStatus('${row.write_code}', this.value)">
                                       <option value="선택">선택</option>
                                       <option value="0"
                                          ${row.status_type eq '판매중'? 'selected' : '' }>판매중</option>
                                       <option value="1"
                                          ${row.status_type eq '판매완료'? 'selected' : '' }>판매완료</option>
                                       <option value="2"
                                          ${row.status_type eq '판매보류'? 'selected' : '' }>판매보류</option>
                                 </select> <%-- </c:if> --%>
                              </c:if></td>
                           <td>${row.status_type}</td>
                        </tr>
                     </c:if>
                  </c:forEach>
               </table>
            </form>
         </div>
      </c:when>
   </c:choose>
   <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
   <div id="footer">
      <%@ include file="../main/footer.jsp"%>
   </div>
</body>

</html>