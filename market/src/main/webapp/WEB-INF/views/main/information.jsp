<%@page import="org.hibernate.internal.build.AllowSysOut"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
<%@ include file="../main/menu.jsp"%>
<div align="center">
<h1>${sessionScope.userid}님</h1><br>
<c:if test="${sessionScope.userid != null }">
<h5 style="text-decoration: underline;">나의 거래</h5>
<button type="button" onclick="location.href='/market/love_servlet/love_List.do?userid=${sessionScope.userid} '">♡관심목록</button><br><br>
<button type="button" onclick="location.href='/market/mk_servlet/myList.do?userid=${sessionScope.userid}'">판매내역</button><br><br>
<button type="button" onclick="location.href='/market/buylist.jsp'">구매내역</button>
</c:if>

</div>
</body>
</html>