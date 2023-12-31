<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<%@ page import="java.net.URLDecoder"%>
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
	
	ReviewDao reviewDao = new ReviewDao();
	
	ArrayList<ReviewOrderGoodsJoin> list = reviewDao.reviewList(beginRow, rowPerPage);
	int totalRow = reviewDao.lastPage(total);
	int lastPage = totalRow/rowPerPage;
	if(totalRow % rowPerPage !=0){
		lastPage = lastPage + 1;
	}
	
%>
<%
	String msg = request.getParameter("msg");
    if (msg != null) {
%>
        <script>
            alert("<%= URLDecoder.decode(msg, "UTF-8") %>");
        </script>
<%
    }
%>
<%
	String msg1 = request.getParameter("msg1");
    if (msg1 != null) {
%>
        <script>
            alert("<%= URLDecoder.decode(msg1, "UTF-8") %>");
        </script>
<%
    }
%>
<!doctype html>
<html>
<jsp:include page="/inc/menu.jsp"></jsp:include>
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
	
		<!-- Start Hero Section -->
			<div class="hero">
				<div class="container">
					<div class="row justify-content-between">
						<div class="col-lg-5">
							<div class="intro-excerpt">
								<h1>Review</h1>
								<p class="mb-4">각종 상품들의 리뷰를 확인하세요.</p>
								<p class="mb-4"></p>
							</div>
						</div>
						<div class="col-lg-7">
							
						</div>
					</div>
				</div>
			</div>
			
			
		<div class="untree_co-section">
		    <div class="container">
		              <h2 class="h3 mb-3 text-black">상품리뷰</h2>
		              <div class="p-3 p-lg-5 border bg-white">
		                <table class="table site-block-order-table mb-5">
		                  <thead>
			                    <tr>
						            <th width="12%" >리뷰번호</th>
						            <th width="25%" align="center">상품이름</th>
						            <th width="65%" align="center">리뷰내용</th>
	        					</tr>
		                  </thead>
		                  <tbody>
		                     <%
						            for(ReviewOrderGoodsJoin n : list){
						     %>
						     <tr>
						            <td >&nbsp; &nbsp; &nbsp; <%=n.getReviewNo() %></td>
						            <td ><%=n.getGoodsTitle() %></td>
						            <td style="height:48px;"><%=n.getReviewContent() %></td>
						     </tr>
						     <%
						            }
						     %>
		                  </tbody>
		                </table>

		                <div class="form-group">
		                  <a href="<%=request.getContextPath()%>/reviewInsert.jsp" class="btn btn-black btn-lg py-3 btn-block">리뷰입력</a>
		                	<%
								if(session.getAttribute("managerId") != null){
							%>
									<a href="<%=request.getContextPath()%>/reviewDelete.jsp" class="btn btn-black btn-lg py-3 btn-block">리뷰삭제</a>
							<%
								}
							%>
		                </div>

		              </div>
		            </div>
		          </div>
		    

	


		<script src="js/bootstrap.bundle.min.js"></script>
		<script src="js/tiny-slider.js"></script>
		<script src="js/custom.js"></script>
		<!-- 페이징 부트 스트랩 사용  -->
	<div class="container">
	 <ul class="pagination" style="padding-left:500px">
	      <li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/review.jsp?currentPage=1">처음으로</a></li>
	  <%
		  if(currentPage > 1) {
  	  %>
			 <li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/review.jsp?currentPage=<%=currentPage-1%>">이전</a></li>
	  <%
       		 if(currentPage>2){
      %>
       
        		<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/review.jsp?currentPage=<%=currentPage-2%>"><%=currentPage-2%></a></li>
      <%
			 }
	  %>
	    	 <li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/review.jsp?currentPage=<%=currentPage-1%>"><%=currentPage-1%></a></li>
      <%
        	 }
      %>
          <li class="page-item active"><a class="page-link" href="<%=request.getContextPath()%>/review.jsp?currentPage=<%=currentPage%>"><%=currentPage%></a></li>
    
      <%
		  if(currentPage < lastPage) {
	  %>
	   		 <li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/review.jsp?currentPage=<%=currentPage+1%>"><%=currentPage+1%></a></li>
	    	
      <%
      %>
	           <li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/review.jsp?currentPage=<%=currentPage+1%>">다음</a></li>
	  <%
	
		  }
      %>
	    <li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/review.jsp?currentPage=<%=lastPage%>">마지막으로</a></li>
	   </ul>
	  </div>
	</body>
</body>
</html>