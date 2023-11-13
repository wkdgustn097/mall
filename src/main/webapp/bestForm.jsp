<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%

	
	// totalRow는 goods가 기
	ShopListDao mallDao = new ShopListDao();
	ArrayList<GoodsReviewCountJoin> list = mallDao.goodsReviewSelect();


%>
<!doctype html>
<html lang="UTF-8">
<head>
	<style>
		.button {
		  display: inline-block;
		  border-radius: 4px;
		  background-color: #555555;
		  border: none;
		  color: #FFFFFF;
		  text-align: center;
		  font-size: 28px;
		  padding: 20px;
		  width: 50%;
		  transition: all 0.5s;
		  cursor: pointer;
		  margin: 5px;
		}
		
		.button span {
		  cursor: pointer;
		  display: inline-block;
		  position: relative;
		  transition: 0.5s;
		}
		
		.button span:after {
		  content: '\00bb';
		  position: absolute;
		  opacity: 0;
		  top: 0;
		  right: -20px;
		  transition: 0.5s;
		}
		
		.button:hover span {
		  padding-right: 25px;
		}
		
		.button:hover span:after {
		  opacity: 1;
		  right: 0;
		}
</style>
<script>
    function redirectToBestFormSale() {
        // bestFormSale 페이지로 이동하는 코드
        window.location.href = 'bestFormSale.jsp';
    }
    function redirectToBestForm() {
        // bestForm 페이지로 이동하는 코드
        window.location.href = 'bestForm.jsp';
    }
</script>
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
								<h1>Shop</h1>
							</div>
						</div>
						<div class="col-lg-7">
							
						</div>
					</div>
				</div>
			</div>
		<!-- End Hero Section -->

		

		<div class="untree_co-section product-section before-footer-section">
		    <div class="container">		
		      	<div class="row">
		      	<h1>후기 순</h1>
		      	<div style="padding-left:160px; padding-bottom:20px;">
					<button class="button" style="vertical-align:middle; width:40%;" onclick="redirectToBestForm()"><span>Review Best</span></button>
					<button class="button" style="vertical-align:middle; width:40%;" onclick="redirectToBestFormSale()"><span>Sales Rate Best</span></button>
				</div>
				
							<%
								int i = 1;
								for(GoodsReviewCountJoin g : list) {
							// ORDER BY로 제일 리뷰가 많은 상품이 1번째로 오니
							// i가 1이면 금메달
							%>
		      		<!-- Start Column 1 -->
					<div class="col-12 col-md-4 col-lg-3 mb-5">
							<span style='font-size:30px;'>
							<%
								if(i == 1){
							%>
								&#129351;
							<%  
								} else if(i == 2) {
							%>
								&#129352;
							<%
								} else if(i == 3) {
							%>
								&#129353;	
							<%
								} else {
							%>
								&nbsp;
							<%
								}
							%>
							<p style="color:black; font-size:20px; font-weight:800px;">
							<%=i%>위
							</p>
							</span>
						    <a class="product-item" href="<%=request.getContextPath()%>/bestFormOne.jsp?goodsNo=<%=g.getGoodsNo()%>">
							<img src="<%=request.getContextPath()%>/upload/<%=g.getFilename()%>" class="img-fluid product-thumbnail">
							<h3 class="product-title"><%=g.getGoodsTitle()%></h3>
							<strong class="product-price"><%=g.getGoodsPrice() %></strong>
							<span class="icon-cross">
								<img src="images/cross.svg" class="img-fluid">
							</span>
						</a>
					</div> 
							<%
									 i = i+1;
										}
							%>
		      	</div>
		    </div>
		</div>
		<script src="js/bootstrap.bundle.min.js"></script>
		<script src="js/tiny-slider.js"></script>
		<script src="js/custom.js"></script>
	</body>
</html>
