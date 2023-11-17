<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));	
	
	NoticeDao noticeDao = new NoticeDao();	//--> dao 패키지 안에 있는 NoticeDao를 사용할 것이다.(이름: noticeDao로 명명)
	Notice n = noticeDao.noticeOne(noticeNo);	// --> vo 패키지 안에 있는 Notice를 사용할 것이다.(이름: n으로 명명)
	
	

%>
<!doctype html>
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
								<h1>Notice</h1>
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
             <h1 class="mb-4 section-title">Notice</h1>
             <br>
				<table class ="table">
 
    
        <tr>
            <th>notice_title</th>
            <td><%=n.getNoticeTitle()%></td>
        </tr>
        <tr>
    		<th>notice_content</th>
    		<td><textarea rows="6" cols="130" style="border: none;"><%=n.getNoticeContent()%></textarea></td>
		</tr>
        
        
        <tr>
        	<th>createdate</th>
        	<td><%=n.getCreatedate()%></td>
        </tr>
        <tr>
        	<th>updatedate</th>
        	<td><%=n.getUpdatedate()%></td>
        </tr>
    </table>
   	<div>
   	<%
    	if(session.getAttribute("managerId") != null){
    %>
   		<a href="<%=request.getContextPath() %>/updateNoticeForm.jsp?noticeNo=<%=noticeNo%>" class="btn btn-success">수정</a>

    	<a href="<%=request.getContextPath() %>/deleteNoticeAction.jsp?noticeNo=<%=noticeNo%>" class="btn btn-success">삭제</a>
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
</body>
</html>
