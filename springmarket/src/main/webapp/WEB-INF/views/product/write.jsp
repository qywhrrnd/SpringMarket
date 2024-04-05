<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>내물건 팔기</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap">
  <style>
    body {
      font-family: 'Roboto', sans-serif;
      background-color: #f7f7f7;
      margin: 0;
      padding: 0;
    }

    #container {
      width: 60%;
      margin: 30px auto;
      background-color: #fff;
      padding: 20px;
      border-radius: 5px;
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    }

    h2 {
      text-align: center;
      margin-bottom: 20px;
    }

    form {
      margin-top: 20px;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 15px;
    }

    th, td {
      padding: 12px;
      border-bottom: 1px solid #ddd;
    }

    th {
      text-align: left;
    }

    input[type="text"], input[type="number"], textarea {
      width: 100%;
      padding: 10px;
      box-sizing: border-box;
      border: 1px solid #ccc;
      border-radius: 4px;
      resize: none;
      margin-top: 6px;
    }

    input[type="file"] {
      width: 100%;
      padding: 10px;
      margin-top: 6px;
    }

    input[type="button"] {
      background-color: #4CAF50;
      color: white;
      padding: 12px 24px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      margin-right: 10px;
    }

    input[type="button"]:hover {
      background-color: #45a049;
    }

    .center {
      text-align: center;
    }

    /* 가운데 정렬 */
    .product-description {
      text-align: center;
    }
  </style>
  <script src="http://code.jquery.com/jquery-3.6.1.js"></script>
  <script>
    function product_write() {
      let form1 = $("#form1");
      let subject = $("#subject").val();
      let contents = $("#contents").val();
      let price = $("#price").val();

      if (subject == "") {
        alert("제목을 입력하세요");
        $("#subject").focus();
        return;
      }
      if (price == "") {
        alert("금액을 입력하세요");
        $("#price").focus();
        return;
      }
      if (contents == "") {
        alert("설명을 입력하세요");
        $("#contents").focus();
        return;
      }
      form1.attr("action", "/product/insert");
      form1.submit();
    }
  </script>
</head>
<body>
  <%@ include file="../main/menu.jsp"%>
  <div class="container">
    <h2 align="center">내물건 팔기</h2>
    <hr style="text-align: left; margin-left: 0">
    <form id="form1" name="form1" method="post" enctype="multipart/form-data">
     <table>
     	
         <tr>
            <th>제목</th>
         </tr>
         <tr>
            <td><input type="text" name="subject" placeholder="상품명(제목)"></td>
         </tr>
         <tr>
            <th>상품가격</th>
         </tr>
         <tr>
            <td><input type="number" name="price" placeholder="상품가격"></td>
         </tr>
         <tr>
            <th>상품이미지</th>
         </tr>
         <tr>
            <td><input type="file" name="file"></td>
         </tr>
         <tr>
            <th>상품설명</th>
         </tr>
         <tr>
            <td><textarea rows="5" cols="80" id="contents" name="contents" style="resize: none; height: 300px"
            placeholder="-상품명(브랜드)&#13;&#10;&#13;&#10;-구매시기&#13;&#10;&#13;&#10;-사용기간&#13;&#10;&#13;&#10;-하자여부&#13;&#10;&#13;&#10;*실제 촬영한 사진과 함께 상세 정보를 입력해주세요."></textarea></td>
         </tr>
         <tr>
            <td colspan="2" align="center">
               <input type="button" value="등록" onclick="product_write()">
               <input type="button" value="취소" onclick="location.href='/product/list'">
            </td>
         </tr>
      </table>
  </form>
</div>
</body>
</html>