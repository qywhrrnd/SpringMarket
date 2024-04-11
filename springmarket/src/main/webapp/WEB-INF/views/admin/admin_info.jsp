<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보</title>
<script src="http://code.jquery.com/jquery-3.7.1.js"></script>
<script>
  /*  function delete_product(userid) {
      if (confirm("삭제하시겠습니까?")) {
         location.href = "/market/login_servlet/delete.do?userid=" + userid;
      }
   } */
   function updateReport(userid, report_code) {
      if (confirm("회원 상태를 변경하시겠습니까?")) {
         location.href = "/member/updateReport.do?userid=" + userid + "&report_code=" + report_code;
      }
   }
</script>
<style>
   table {
      width: 100%;
      border-collapse: collapse;
      
   }
   th, td {
      border: 1px solid black;
      text-align: center; /* 셀들을 가운데 정렬합니다. */
      padding: 8px;
   }
   select {
      width: 100%;
   }
</style>
</head>
<body>
   <%@ include file="../admin/admin_menu.jsp"%>
   <div align="center">
      <form method="post" name="form1">
         <h2 align="center">회원 정보</h2>

         <table>
            <tr align="center">
               <th>회원 아이디</th>
               <th>회원 이름</th>
               <th>생년월일</th>
               <th>주소</th>
               <th>핸드폰번호</th>
               <th>이메일</th>
               <th>&nbsp;</th>
               <th>회원상태</th>
            </tr>

            <c:forEach var="row" items="${dto}">
               <tr>
                  <td>${row.userid}</td>
                  <td>${row.name}</td>
                  <td>${row.birth}</td>
                  <td>${row.address}</td>
                  <td>${row.phone}</td>
                  <td>${row.email}</td>
                  <td>
                     <select onchange="updateReport('${row.userid}', this.value)">
                        <option value="0" ${row.report_type == '기본상태' ? 'selected' : '' }>기본상태</option>
                        <option value="1" ${row.report_type == '로그인제재' ? 'selected' : '' }>로그인제재</option>
                     </select>
                  </td>
                  <td>${row.report_type}</td>
               </tr>
            </c:forEach>
            <tr>
            <td colspan="8">
            <br><br><br><br><br><br>
            </td>
            </tr>
            <tr>
            <td colspan="8">
            <%@ include file="../main/footer.jsp"%>
            </td>
            </tr>
         </table>
      </form>
   </div>
   
</body>
</html>