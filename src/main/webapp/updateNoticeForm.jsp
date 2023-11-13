<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	if(session.getAttribute("managerId") == null){
	response.sendRedirect(request.getContextPath()+"/notice.jsp");
	return;
	}

	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
%>
<!doctype html>
<html lang="en">
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
	<form action="<%=request.getContextPath()%>/updateNoticeAction.jsp" method="post"  accept-charset="UTF-8">
		<input type="hidden" name="notice_no" value="<%=noticeNo%>">
		<table border="1">
			<tr>
				<td>제목</td>
				<td>
					<input type="text" name="notice_title">
				</td>
			</tr>
			<tr>
    			<td>공지내용</td>
    			<td>
       				 <textarea name="notice_content" rows="5" cols="50"></textarea>
    			</td>
			</tr>
		</table>
		<button>공지사항수정</button>
	</form>
		
		<script src="js/bootstrap.bundle.min.js"></script>
		<script src="js/tiny-slider.js"></script>
		<script src="js/custom.js"></script>
	</body>

</html>
