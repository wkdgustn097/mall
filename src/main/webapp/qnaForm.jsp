<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>
<%
	int currentPage = 1;	
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 8;
	int beginRow = (currentPage-1) * rowPerPage;
	int total = 0;
	
	QnaDao qnaDao = new QnaDao();
	ArrayList<Question> list = qnaDao.qnaList(beginRow, rowPerPage);
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

		<!-- Start Header/Navigation -->
		<jsp:include page="/inc/menu.jsp"></jsp:include>
		<!-- Start Hero Section -->
			<div class="hero">
				<div class="container">
					<div class="row justify-content-between">
						<div class="col-lg-5">
							<div class="intro-excerpt">
								<h1>Qna</h1>
								<p class="mb-4">문의사항은 이곳을 통해 문의해주세요</p>
							</div>
						</div>
						<div class="col-lg-7">
							
						</div>
					</div>
				</div>
			</div>
		<!-- End Hero Section -->
		<form action="<%=request.getContextPath()%>/orderAction.jsp">
		<div class="untree_co-section">
		    <div class="container">
		              <h2 class="h3 mb-3 text-black">QnA</h2>
		              <div class="p-3 p-lg-5 border bg-white">
		                <table class="table site-block-order-table mb-5">
		                  <thead>
		                    <th>번호</th>
		                    <th>제목</th>
		                  </thead>
		                  <tbody>
		                    <%
		                   		 for(Question q : list){
		                    %>
		                    <tr>
		                      <td><%=q.getQuestionNo()%></td>
		                      <td><a href="<%=request.getContextPath()%>/qnaOne.jsp?questionNo=<%=q.getQuestionNo()%>"><%=q.getQuestionTitle()%></a></td>
		                     </tr>
		                    <%
		                   		 }
		                    %>
		                  </tbody>
		                </table>

		                <div class="form-group">
		                  <button class="btn btn-black btn-lg py-3 btn-block">주문하기</button>
		                </div>

		              </div>
		            </div>
		          </div>
		      <!-- </form> -->
		  </form>

		<script src="js/bootstrap.bundle.min.js"></script>
		<script src="js/tiny-slider.js"></script>
		<script src="js/custom.js"></script>
	</body>

</html>
