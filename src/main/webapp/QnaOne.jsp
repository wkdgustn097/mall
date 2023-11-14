<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	QuestionGoCustJoin questionGoCustJoin = new QuestionGoCustJoin();
	questionGoCustJoin.setQuestionNo(Integer.parseInt(request.getParameter("questionNo")));
	
	QnaDao qnaDao = new QnaDao();
	QuestionGoCustJoin questionOne = qnaDao.qnaOne(questionGoCustJoin);
	
%>
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
								<h1>QnA</h1>
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
             <h1 class="mb-4 section-title">QnA</h1>
             <br>
				<table class ="table">
					<tr>
						<td><p>상품이름</p></td>
						<td><input type="text" name="goodsTitle" value="<%=questionOne.getGoodsTitle()%>"></td>
					</tr>
					<tr>
						<td><p class="product-title">회원이름</p></td>
						<td><input name="goodsPrice" value="<%=questionOne.getCustomerId()%>"></td>
					</tr>
					<tr>
						<td><p class="product-title">질문제목</p></td>
						<td><input style="width:475px;" name="goodsMemo" value="<%=questionOne.getQuestionTitle()%>"></td>
					</tr>
					<tr>
						<td><p class="product-title">질문내용</p></td>
						<td><textarea rows="5" cols="60"><%=questionOne.getQuestionContent()%></textarea></td>
					</tr>
				</table>
			</div>
			<br>
				<%
					if(session.getAttribute("managerId") != null) { 	// 매니저 로그인 되어 있으면	
				%>
		        <button class="btn btn-black btn-lg py-3 btn-block">질문 답변하기</button>
		        <%
					}
		        %>
		        &nbsp;<div class="p-3 p-lg-5 border bg-white">
		           <h1 class="mb-4 section-title">QnA</h1>
		           <br>
		           	<table class ="table">
		           		<tr>
							<td><p>상품이름</p></td>
							<td><input type="text" name="goodsTitle" value="<%=questionOne.getGoodsTitle()%>"></td>
						</tr>
		           	</table>
		        </div>
            </div>
          </div>
		




		<script src="js/bootstrap.bundle.min.js"></script>
		<script src="js/tiny-slider.js"></script>
		<script src="js/custom.js"></script>
	</body>

</html>
