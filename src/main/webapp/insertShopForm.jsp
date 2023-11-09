<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="author" content="Untree.co">
  <link rel="shortcut icon" href="favicon.png">

  <meta name="description" content="" />
  <meta name="keywords" content="bootstrap, bootstrap4" />

		<!-- Bootstrap CSS -->
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
		<link href="css/tiny-slider.css" rel="stylesheet">
		<link href="css/style.css" rel="stylesheet">
		<title>Furni Free Bootstrap 5 Template for Furniture and Interior Design Websites by Untree.co </title>
	</head>

	<body>

		<jsp:include page="/inc/menu.jsp"></jsp:include>

		<!-- Start Hero Section -->
			<div class="hero">
				<div class="container">
					<div class="row justify-content-between">
						<div class="col-lg-5">
							<div class="intro-excerpt">
								<h1>상품 추가하기</h1>
							</div>
						</div>
						<div class="col-lg-7">
							
						</div>
					</div>
				</div>
			</div>
		<!-- End Hero Section -->

		
		<div class="untree_co-section before-footer-section">
            <div class="container">
             <div class="p-3 p-lg-5 border bg-white">
             <h1 class="mb-4 section-title">상품 추가하기</h1>
             <br>
             <form method="post" enctype="multipart/form-data" action="<%=request.getContextPath()%>/insertShopAction.jsp">
				<table class ="table">
					<tr>
						<td><p>상품이름</p></td>
						<td><input type="text" name="goodsTitle"></td>
					</tr>
					<tr>
						<td><p class="product-title">상품가격</p></td>
						<td><input type="number" name="goodsPrice"></td>
					</tr>
					<tr>
						<td><p class="product-title">상품설명</p></td>
						<td><textarea rows="4" cols="50" name="goodsMemo"></textarea></td>
					</tr>
					<tr>
						<td><p class="product-title">상품이미지</p></td>
						<td><input type="file" name="goodsImage"></td>
					</tr>
				</table>
				<button type="submit" type="button" class="btn btn-black btn-lg py-3 btn-block">상품입력</button>
			 </form>
			</div>
            </div>
          </div>
		




		<script src="js/bootstrap.bundle.min.js"></script>
		<script src="js/tiny-slider.js"></script>
		<script src="js/custom.js"></script>
	</body>

</html>
