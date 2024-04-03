<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>채팅 목록</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f2f2f2;
        }

        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        th, td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }

        tr:hover {
            background-color: #f5f5f5;
        }

        .button {
            display: inline-block;
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            text-align: center;
            transition: background-color 0.3s ease;
        }

        .button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<c:if test="${sessionScope.userid == 'admin'}">
    <%@ include file="../admin/admin_menu.jsp"%>
</c:if>
<c:if test="${sessionScope.userid != 'admin'}">
    <%@ include file="../main/menu.jsp"%>
</c:if>
<table>
    <tr>
        <th>상대방</th>
        <th>시간</th>
        <th>내용</th>
        <th>채팅 시작</th>
    </tr>
    <c:forEach var="row" items="${list}">
        <c:if test="${sessionScope.userid == row.toid}">
        
            <tr class="a" data-toid="${row.fromid }">
                <td>${row.fromid}</td>
                <td>${row.time}</td>
                <td>${row.chatcomment}</td>
                <td><a href="/market/chat_servlet/chat.do?toid=${row.fromid}&userid=${sessionScope.userid}" class="button">채팅 시작</a></td>
            </tr>
        </c:if>
        <c:if test="${sessionScope.userid == row.fromid}">
            <tr class="a" data-toid="${row.toid }">
                <td>${row.toid}</td>
                <td>${row.time}</td>
                <td>${row.chatcomment}</td>
                <td><a href="/market/chat_servlet/chat.do?toid=${row.toid}&userid=${sessionScope.userid}" class="button">채팅 시작</a></td>
            </tr>
        </c:if>
    </c:forEach>
</table>
</body>
</html>