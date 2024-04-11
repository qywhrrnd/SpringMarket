<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Report List</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f8f9fa;
}

.container {
	margin-top: 50px;
}

th, td {
	text-align: center;
}
</style>
</head>
<body>
	<%@ include file="../admin/admin_menu.jsp"%>

	<div class="container">
		<h2>Report List</h2>
		<form method="post" name="form1">
			<table class="table table-striped">
				<thead class="thead-dark">
					<tr align="center">
						<th scope="col"><input type="checkbox" id="chkAll"></th>
						<th scope="col" style="white-space: nowrap;">제목</th>
						<th scope="col" style="white-space: nowrap;">신고인</th>
						<th scope="col" style="white-space: nowrap;">피신고인</th>
						<th scope="col" style="white-space: nowrap;">신고내용</th>
						<th scope="col"><input type="button" value="선택삭제"
							id="btnAllDel" class="btn btn-danger"></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="row" items="${list}">
						<tr>
							<td><input type="checkbox" name="num" value="${row.idx}"></td>
							<td><a
								href="${pageContext.request.contextPath}${row.link}">${row.report_subject}</a></td>
							<td>${row.reporter}</td>
							<td>${row.report_userid}</td>
							<td>${row.report_contents}</td>
							<td><input type="button" value="삭제"
								onclick="reportlist_del('${row.idx}')"
								class="btn btn-outline-danger"></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</form>
	</div>

	<script>
		$(function() {
			$("#chkAll").click(function() {
				if ($("#chkAll").prop("checked")) {
					$("input[name=num]").prop("checked", true);
				} else {
					$("input[name=num]").prop("checked", false);
				}
			});

			$("#btnAllDel").click(function() {
				let arr = $("input[name=num]"); //체크박스 배열
				let cnt = 0; //체크된 태그 카운트
				for (i = 0; i < arr.length; i++) {
					if (arr[i].checked == true)
						cnt++;
				}
				if (cnt == 0) {
					alert("삭제할 신고내역을 선택해주세요");
					return;
				}
				if (confirm("선택된 내역을 삭제하시겠습니까?")) {
				document.form1.action = "/report/report_deleteAll"; // 액션 수정
				document.form1.submit();
				}
			});
		});
		function reportlist_del(idx) {
			if (confirm("삭제하시겠습니까?")) {
				location.href = "/report/report_delete?idx=" + idx;
			}
		}
	</script>
</body>
</html>