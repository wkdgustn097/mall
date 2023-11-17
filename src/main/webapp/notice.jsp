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
<jsp:include page="/inc/menu.jsp"></jsp:include>
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
						
					</div>
				</div>
			</div>
		<!-- End Hero Section -->
		<form action="<%=request.getContextPath()%>/insertNoticeForm.jsp">
		<div class="untree_co-section">
		    <div class="container">
		              <h2 class="h3 mb-3 text-black">Notice</h2>
		              <div class="p-3 p-lg-5 border bg-white">
		                <table class="table site-block-order-table mb-5">
		
       	<thead>
            <th>notice_no</th>
			<th>notice_title</th>
            <th>createdate</th>
            <th>updatedate</th>
        </thead>
        <tbody>
        <%
            for(Notice n : list){
        %>
        <tr>
            <td style="align-text:center;"><%=n.getNoticeNo() %></td>
            <td><a href="<%=request.getContextPath()%>/noticeOne.jsp?noticeNo=<%=n.getNoticeNo()%>"><%=n.getNoticeTitle() %></a></td>
            <td><%=n.getCreatedate() %></td>
            <td><%=n.getUpdatedate() %></td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>

    <%
    	if(session.getAttribute("managerId") != null){
    %>
  	  <button class="btn btn-black btn-lg py-3 btn-block">추가</a></button>
    <%
    	}
    %>
</div>
		
		</div>
		</form>	


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
