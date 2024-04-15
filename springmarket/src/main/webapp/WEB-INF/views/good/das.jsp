<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script>
$(function(){
    $("#cart").click(function() {
        if (${sessionScope.userid == null}) {
            var result = confirm("로그인이 필요합니다. 로그인하시겠습니까?");
            if (result) {
                // 확인 버튼을 누른 경우
                window.location.href = "../member/login.jsp"; // 로그인 페이지 URL로 이동합니다. 필요에 따라 수정해야 합니다.
            } else {
                // 취소 버튼을 누른 경우
                return false; // 이벤트를 취소합니다.
            }
        } else {
           var productCode = '${dto.product_code}'; // 상품 코드 가져오기
           var amount = document.getElementById('count').textContent; // count 값 가져오기
           window.location.href = "../cart_servlet/insert.do?product_code=" + productCode + "&amount=" + amount;
            // 로그인되어 있으면 해당 상품을 장바구니에 추가하는 코드를 작성합니다.
        }
    });
    
    $("#buy").click(function() {
        if (${sessionScope.userid == null}) {
            var result = confirm("로그인이 필요합니다. 로그인하시겠습니까?");
            if (result) {
                // 확인 버튼을 누른 경우
                window.location.href = "../member/login.jsp"; // 로그인 페이지 URL로 이동합니다. 필요에 따라 수정해야 합니다.
            } else {
                // 취소 버튼을 누른 경우
                return false; // 이벤트를 취소합니다.
            }
        } else{
            requestPay();
        }             
    });
});
</script>
<style>
body {
   margin: 0; /* body의 기본 여백을 제거합니다. */
}

.container a:hover {
   color: red;
}

.container {
   max-width: 800px; /* 컨테이너의 최대 너비를 지정합니다. */
   margin: 0 auto; /* 가운데 정렬을 수행합니다. */
   padding: 0 20px; /* 양쪽에 20px의 여백을 추가합니다. */
}

.movie-item {
   display: inline-block;
}

.movie-item img {
   width: 200px; /* 이미지 너비를 200px로 설정합니다. */
   height: 150px; /* 이미지 높이를 150px로 설정합니다. */
}

a {
   display: inline-block; /* 링크를 인라인 블록 요소로 만듭니다. */
   margin-right: 20px; /* 링크 사이의 간격을 설정합니다. */
   font-size: 20px; /* 링크의 글꼴 크기를 설정합니다. */
   color: gray; /* 링크의 글꼴 색상을 회색으로 설정합니다. */
   text-decoration: none; /* 밑줄 제거 */
}

table {
   table-layout: fixed; /* 테이블의 크기를 고정합니다. */
   width: 100%; /* 테이블의 너비를 100%로 설정합니다. */
}

td {
   border: none; /* 테이블 셀의 테두리를 제거합니다. */
   padding: 10px; /* 셀 내부 여백을 설정합니다. */
}

.counter {
   text-align: left;
   font-size: 20px;
   margin-top: 20px;
}

button {
   font-size: 20px;
   margin: 10px;
   padding: 5px 10px;
   cursor: pointer;
}

.total-price {
   margin-left: auto; /* 맨 오른쪽으로 이동 */
}

#cart {
   border: none; /* 테두리 없음 */
   background: none; /* 배경 없음 */
   cursor: pointer; /* 마우스 커서 모양 */
   padding: 0; /* 내부 여백 없음 */
   width: 150px; /* 버튼 너비 */
   height: 50px; /* 버튼 높이 */
}

/* 이미지 스타일 */
#cart img {
   width: 24px; /* 이미지 너비 */
   height: 24px; /* 이미지 높이 */
   vertical-align: middle; /* 이미지를 텍스트 중앙에 정렬 */
   margin-right: 10px; /* 이미지와 텍스트 사이 간격 */
}
</style>
</head>
<body>
   <%@include file="../menu/menu.jsp"%>
   <div class="container">
      <!-- 본문을 감싸는 컨테이너를 생성합니다. -->
      <a href="/cinema/store_servlet/list.do" style="text-decoration: none;"><h1
            style="color: black;">스토어</h1></a>
      <hr style="border-top: 5px solid black;">
      <a href="/cinema/product_servlet/category.do?product_type=4"
         style="text-decoration: none; color: black;"> 콤보</a> <a
         href="/cinema/product_servlet/category.do?product_type=1"
         style="text-decoration: none; color: black;">팝콘</a> <a
         href="/cinema/product_servlet/category.do?product_type=2"
         style="text-decoration: none; color: black;">음료</a> <a
         href="/cinema/product_servlet/category.do?product_type=3"
         style="text-decoration: none; color: black;">스낵</a> <a
         href="/cinema/product_servlet/category.do?product_type=5"
         style="text-decoration: none; color: black;">굿즈</a><c:if test="${sessionScope.userid !=null }">
         <a href="/cinema/cart_servlet/list.do" style="float: right; text-decoration: none;color: black;">장바구니</a>
         </c:if>
         <c:if test="${sessionScope.userid==null }">
         <a href="../member/login.jsp" style="float: right; text-decoration: none;color: black;">장바구니</a>
         </c:if>
      <hr style="border-top: 2px solid black;">
      <br> <br>
      <h2>${dto.product_name}</h2>
      <hr style="border-top: 2px solid black;">
      <table>
         <tr align="center">
            <td style="padding-right: 20px;"><img
               src="/cinema/images/${dto.filename}" width="400px" height="400px"></td>
            <td align="left"><span style="font-size: 24px; color: black;">
                  <fmt:formatNumber value="${dto.price}" pattern="#,###" />원
            </span>
               <hr style="color: black;"> <span style="color: black;">상품구성:${dto.description}<br>유효기간:구매일로부터
                  6개월 이내
            </span>
               <hr style="color: black;">
               <div class="counter">
                  <button id="decrement">-</button>
                  <span id="count" name="count"
                     style="font-size: 24px; color: black;">1</span>
                  <button id="increment">+</button>
                  &nbsp&nbsp 총 구매금액:&nbsp <span id="num" class="total-price"><fmt:formatNumber
                        value="${dto.price}" pattern="#,###" />원</span>
               </div>
               <hr style="color: black;">

               <button id="cart">
                  <img src="../images/market.png"
                     style="width: 70px; height: 70px; vertical-align: middle; margin-right: 10px;">
               </button>
               <button id="buy" 
                  style="padding: 15px 30px; background-color: gray; color: white; border: none; border-radius: 10px; font-size: 16px; cursor: pointer;">
                  구매하기</button></td>
         </tr>
      </table>
      <hr style="border-top: 2px solid black;">
   </div>

   <script>
     // JavaScript 코드
     const countElement = document.getElementById('count');
     const incrementButton = document.getElementById('increment');
     const decrementButton = document.getElementById('decrement');
     const totalPriceElement = document.querySelector('.total-price'); // .total-price 클래스를 갖는 요소를 선택합니다.
     let count = 1; // 초기값 설정

     incrementButton.addEventListener('click', () => {
          count++;
          countElement.textContent = count;
          let totalPrice = count * Number('${dto.price}');
          totalPriceElement.textContent = formatPrice(totalPrice);
      });

        decrementButton.addEventListener('click', () => {
          if (count > 1) {
            count--;
            countElement.textContent = count;
            let totalPrice = count * Number('${dto.price}');
           totalPriceElement.textContent = formatPrice(totalPrice); // 버튼 클릭시 totalPriceElement의 값을 count만큼 곱하여 업데이트합니다.
          }
        });
        
        function formatPrice(price) {
             return new Intl.NumberFormat('ko-KR').format(price) + '원';
         }      
        
        function requestPay() {
           var totalAmountText = document.getElementById('num').textContent;
           var amount = parseInt(totalAmountText.replace(/[^\d]/g, ''), 10);
           IMP.init('imp68066408'); //iamport 대신 자신의 "가맹점 식별코드"를 사용
           IMP.request_pay({
              pg : "kakaopay",
              pay_method : "card",
              merchant_uid : 'merchant_' + new Date().getTime(),
              name : "쌍용시네마",
              amount : amount,
              buyer_name : '${sessionScope.name}'
           }, function(rsp) { // callback
              if (rsp.success) {
                 var msg = '결제가 완료되었습니다.';
                 alert(msg);

                 savePayment(amount); // savePayment 함수 호출 --%>
                 cartdelete();

              } else {
                 var msg = '결제에 실패하였습니다.';
                 msg += '에러내용 : ' + rsp.error_msg;
                 alert(msg);
              }
           });
        }
          function savePayment(amount) {
             location.href = "../member_servlet/buy.do?amount=" + amount;
         }
        </script>
</body>
</html>
