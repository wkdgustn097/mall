<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%

	// 페이징 변수 
	// rowPerPage 8로 잡
	int currentPage = 1;	
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 8;
	int beginRow = (currentPage-1) * rowPerPage;
	int total = 0;
	
	// totalRow는 goods가 기
	ShopListDao mallDao = new ShopListDao();
	ArrayList<Gijoin> list = mallDao.selectShopList(beginRow, rowPerPage);
	int totalRow = mallDao.lastPage(total);
	int lastPage = totalRow/rowPerPage;
    if(totalRow % rowPerPage != 0){
        lastPage = lastPage + 1;
     }
%>
<!doctype html>
<html lang="UTF-8">
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
								<h1>Shop</h1>
								<p class="mb-4">여러가지 화장품을 구경해보세요</p>
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
		    	<% 
				   if(session.getAttribute("managerId") != null){
				%>
					<a href="<%=request.getContextPath()%>/insertShopForm.jsp" class="btn btn-black btn-lg py-3 btn-block">상품 추가하기</a><br>
					<br>
				<% 
				   }
				%>
				
		      	<div class="row">
							<%
								int i = 1;
								for(Gijoin g : list) {
							%>
		      		<!-- Start Column 1 -->
					<div class="col-12 col-md-4 col-lg-3 mb-5">
						<a class="product-item" href="<%=request.getContextPath()%>/shopOne.jsp?goodsNo=<%=g.getGoodsNo()%>">
							<img src="<%=request.getContextPath()%>/upload/<%=g.getOriginName()%>" class="img-fluid product-thumbnail">
							<h3 class="product-title"><%=g.getGoodsTitle()%></h3>
							<strong class="product-price"><%=g.getGoodsPrice() %></strong>
							<span class="icon-cross">
								<img src="images/cross.svg" class="img-fluid">
							</span>
						</a>
					</div> 
							<%
										}
							%>
		      	</div>
		    </div>
		</div>
		<script src="js/bootstrap.bundle.min.js"></script>
		<script src="js/tiny-slider.js"></script>
		<script src="js/custom.js"></script>
		
	<!-- 페이징 부트 스트랩 사용  -->
	<div class="container">
	 <ul class="pagination" style="padding-left:500px">
	      <li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/shopListForm.jsp?currentPage=1">처음으로</a></li>
	  <%
		  if(currentPage > 1) {
  	  %>
			 <li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/shopListForm.jsp?currentPage=<%=currentPage-1%>">이전</a></li>
	  <%
       		 if(currentPage>2){
      %>
       
        		<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/shopListForm.jsp?currentPage=<%=currentPage-2%>"><%=currentPage-2%></a></li>
      <%
			 }
	  %>
	    	 <li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/shopListForm.jsp?currentPage=<%=currentPage-1%>"><%=currentPage-1%></a></li>
      <%
        	 }
      %>
          <li class="page-item active"><a class="page-link" href="<%=request.getContextPath()%>/shopListForm.jsp?currentPage=<%=currentPage%>"><%=currentPage%></a></li>
    
      <%
		  if(currentPage < lastPage) {
	  %>
	   		 <li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/shopListForm.jsp?currentPage=<%=currentPage+1%>"><%=currentPage+1%></a></li>
	    	 <li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/shopListForm.jsp?currentPage=<%=currentPage+2%>"><%=currentPage+2%></a></li>
      <%
              if(currentPage==1){
      %>
      	     	 <li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/shopListForm.jsp?currentPage=<%=currentPage+3%>"><%=currentPage+3%></a></li>
      			 <li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/shopListForm.jsp?currentPage=<%=currentPage+4%>"><%=currentPage+4%></a></li>
      <%  	 
              }
        	  if(currentPage==2){
      %>
      		  	 <li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/shopListForm.jsp?currentPage=<%=currentPage+3%>"><%=currentPage+3%></a></li>
      <%  	 
         	  }
      %>
	           <li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/shopListForm.jsp?currentPage=<%=currentPage+1%>">다음</a></li>
	  <%
	
		  }
      %>
	    <li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/shopListForm.jsp?currentPage=<%=lastPage%>">마지막으로</a></li>
	   </ul>
	  </div>
	</body>
</html>
