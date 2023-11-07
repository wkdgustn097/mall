<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
		
	}
	int rowPerPage = 8;
	int beginRow = (currentPage-1)*rowPerPage;
	int total = 0;
	
	NoticeDao noticeDao = new NoticeDao();
	
	ArrayList <Notice> list = noticeDao.noticeList(beginRow, rowPerPage);
	int totalRow = noticeDao.lastPage(total);
	int lastPage = totalRow/rowPerPage;
	if(totalRow % rowPerPage !=0){
		lastPage = lastPage + 1;
	}
%>
<!doctype html>
<html lang="en">
<head>
  <link rel="stylesheet" href="css/default.css">
  <link rel="stylesheet" href="css/style.css">
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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<body>

		<!-- Start Header/Navigation -->
		<nav class="custom-navbar navbar navbar navbar-expand-md navbar-dark bg-dark" arial-label="Furni navigation bar">

			<div class="container">
				<a class="navbar-brand" href="index.html">Furni<span>.</span></a>

				<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarsFurni" aria-controls="navbarsFurni" aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>

				<div class="collapse navbar-collapse" id="navbarsFurni">
					<ul class="custom-navbar-nav navbar-nav ms-auto mb-2 mb-md-0">
						<li class="nav-item">
							<a class="nav-link" href="index.html">Home</a>
						</li>
						<li><a class="nav-link" href="shop.html">Shop</a></li>
						<li><a class="nav-link" href="about.html">About us</a></li>
						<li><a class="nav-link" href="services.html">Services</a></li>
						<li class="active"><a class="nav-link" href="notice.jsp">Notice</a></li>
						<li><a class="nav-link" href="contact.html">Contact us</a></li>
					</ul>

					<ul class="custom-navbar-cta navbar-nav mb-2 mb-md-0 ms-5">
						<li><a class="nav-link" href="#"><img src="images/user.svg"></a></li>
						<li><a class="nav-link" href="cart.html"><img src="images/cart.svg"></a></li>
					</ul>
				</div>
			</div>
				
		</nav>
		<!-- End Header/Navigation -->

		<!-- Start Hero Section -->
			<div class="hero">
				<div class="container">
					<div class="row justify-content-between">
						<div class="col-lg-5">
							<div class="intro-excerpt">
								<h1>Notice</h1>
								<p class="mb-4">공지사항을 잘 확인해주세요.</p>
								<p class="mb-4">기타 문의사항은 Q&A 게시판을 통해 문의해 주세요.</p>
							</div>
						</div>
						<div class="col-lg-7">
							<div class="hero-img-wrap">
								<img src="images/couch.png" class="img-fluid">
							</div>
						</div>
					</div>
				</div>
			</div>
		<!-- End Hero Section -->

		<!-- Start Blog Section -->
	<div class="blog-section" style="text-align: center;">
    <table border="2" style="margin: 0 auto; border-collapse: collapse; width: 90%;">
       	<tr>
            <th>notice_no</th>
            <th>notice_title</th>
            <th>createdate</th>
            <th>updatedate</th>
        </tr>
        <%
            for(Notice n : list){
        %>
        <tr>
            <td><%=n.getNoticeNo() %></td>
            <td><a href="noticeOne.jsp?noticeNo=<%=n.getNoticeNo()%>"><%=n.getNoticeTitle() %></a></td>
            <td><%=n.getCreatedate() %></td>
            <td><%=n.getUpdatedate() %></td>
        </tr>
        <%
            }
        %>
    </table>

    
    <a href="insertNoticeForm.jsp">추가</a>
</div>
		
		</div>
<!-- End Blog Section -->	

		

		

							

			
		<!-- End Testimonial Slider -->

		

		

		<script src="js/bootstrap.bundle.min.js"></script>
		<script src="js/tiny-slider.js"></script>
		<script src="js/custom.js"></script>
		<!-- 페이징 부트 스트랩 사용  -->
	<div class="container">
	 <ul class="pagination" style="padding-left:500px">
	      <li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/notice.jsp?currentPage=1">처음으로</a></li>
	  <%
		  if(currentPage > 1) {
  	  %>
			 <li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/notice.jsp?currentPage=<%=currentPage-1%>">이전</a></li>
	  <%
       		 if(currentPage>2){
      %>
       
        		<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/notice.jsp?currentPage=<%=currentPage-2%>"><%=currentPage-2%></a></li>
      <%
			 }
	  %>
	    	 <li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/notice.jsp?currentPage=<%=currentPage-1%>"><%=currentPage-1%></a></li>
      <%
        	 }
      %>
          <li class="page-item active"><a class="page-link" href="<%=request.getContextPath()%>/notice.jsp?currentPage=<%=currentPage%>"><%=currentPage%></a></li>
    
      <%
		  if(currentPage < lastPage) {
	  %>
	   		 <li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/notice.jsp?currentPage=<%=currentPage+1%>"><%=currentPage+1%></a></li>
	    	 <li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/notice.jsp?currentPage=<%=currentPage+2%>"><%=currentPage+2%></a></li>
      <%
              if(currentPage==1){
      %>
      	     	 <li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/notice.jsp?currentPage=<%=currentPage+3%>"><%=currentPage+3%></a></li>
      			 <li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/notice.jsp?currentPage=<%=currentPage+4%>"><%=currentPage+4%></a></li>
      <%  	 
              }
        	  if(currentPage==2){
      %>
      		  	 <li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/notice.jsp?currentPage=<%=currentPage+3%>"><%=currentPage+3%></a></li>
      <%  	 
         	  }
      %>
	           <li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/notice.jsp?currentPage=<%=currentPage+1%>">다음</a></li>
	  <%
	
		  }
      %>
	    <li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/notice.jsp?currentPage=<%=lastPage%>">마지막으로</a></li>
	   </ul>
	  </div>
	</body>

</html>
