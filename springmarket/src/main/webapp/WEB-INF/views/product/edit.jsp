<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap">
<script src="/resources/ckeditor/ckeditor.js"></script>
<meta charset="UTF-8">
<title>판매게시물 수정</title>

<script>
	function update_product() {
		let subject = document.form1.subject.value;
		let price = document.form1.price.value;
		let contents = document.form1.contents.value;
		if (subject == "") {
			alert("상품명을 입력하세요");
			document.form1.subject.focus();
			return;
		}
		if (price == "") {
			alert("가격을 입력하세요");
			document.form1.price.focus();
			return;
		}
		
		document.form1.action = "/product/update";
		document.form1.submit();
	}
	
	$(function(){
        //처음 이미지 가져오기
        let photo_path = $('.profile-photo').attr('src');
        let my_photo; //회원이 업로드할 이미지 담을 변수
        $('#file').change(function(){
            my_photo = this.files[0];
            console.log(this.files[0].size);
            if(!my_photo){
                $('.profile-photo').attr('src', photo_path);
                return
            }
          
            //이미지 미리보기 처리
            let reader = new FileReader();
            reader.readAsDataURL(my_photo);

            reader.onload = function(){
                $('.profile-photo').attr('src', reader.result);
            };
        });
        });

    
	function upload() {
	    let fileInput = document.getElementById("file");
	    if (fileInput.files.length === 0) {
	        // 파일이 선택되지 않았을 때의 처리
	        $('.profile-photo').css('visibility', 'visible');
	        $('.profile-photo2').css('visibility', 'hidden');
	        return;
	    }

	    // 파일이 선택되었을 때의 처리
	    let file = fileInput.files[0];
	    if (!file.type.match('image.*')) {
	        alert('이미지 파일을 선택해주세요.');
	        return;
	    }

	    // 이미지 미리보기 처리
	    let reader = new FileReader();
	    reader.onload = function(e) {
	        $('.profile-photo2').attr('src', e.target.result);
	        $('.profile-photo2').css('visibility', 'visible');
	    };
	    reader.readAsDataURL(file);
	}

</script>
</head>
<body>
<%@ include file="../main/menu.jsp"%>
<div align="center">
	<form name="form1" method="post" enctype="multipart/form-data">
		<table>
			<tr>
				<th>제목(상품명)</th>
			</tr>
			<tr>
				<td><input name="subject" value="${dto.subject}"></td>
			</tr>
			<tr>
				<th>가격</th>
			</tr>
			<tr>
				<td><input name="price" value="${dto.price}"></td>
			</tr>
			<tr>
				<th>상품설명</th>
			</tr>
			<tr>
				<td><textarea rows="7" cols="60" id="contents" name="contents" style="resize: none;">${dto.contents}</textarea>
						<script>
							CKEDITOR
									.replace(
											"contents",
											{
												filebrowserUploadUrl : "/product/imageUpload.do"
											});
						</script></td>
			</tr>

			<tr>
				<th>상품 이미지</th>
			</tr>
			<tr>
				<td>
				<input type = "file" name="file" id="file" accept="image/gif, image/png, image/jpeg, image/jpg " multiple="multiple" onchange="upload()">
				<img src="/resources/images/${dto.filename}" class="profile-photo" width="150px" height="150px" style= "visibility: visible;">
				 ➔
				<img src="/resources/images" class="profile-photo2" width="150px" height="150px" style= "visibility: hidden;"> <br> 
					
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="hidden"name="write_code" value="${dto.write_code}"> 
				<input type="button" value="수정" onclick="update_product()"> 
				<input type="button" value="목록" onclick="location.href='/product/mylist'"></td>
			</tr>

		</table>
	</form>
</div>
<%@ include file="../main/footer.jsp"%>
</body>
</html>