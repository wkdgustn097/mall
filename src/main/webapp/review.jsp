<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<%@ page import="java.net.URLEncoder"%>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
	currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}

	int rowPerPage = 5;
	int beginRow = (currentPage-1)*rowPerPage;
	int total = 0;
	
	ReviewDao reviewDao = new ReviewDao();
	
	ArrayList<Review> list = reviewDao.reviewList(beginRow, rowPerPage);
	int totalRow = reviewDao.lastPage(total);
	int lastPage = totalRow/rowPerPage;
	if(totalRow % rowPerPage !=0){
		lastPage = lastPage + 1;
	}
%>
<jsp:include page="/inc/menu.jsp"></jsp:include>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="container">

<div class="blog-section" style="text-align: center;">
    <table border="2" style="margin: 0 auto; border-collapse: collapse; width: 90%;">
       	<tr>
            <th>review_no</th>
            <th>review_content</th>
            <th>createdate</th>
            <th>updatedate</th>
        </tr>
        <%
            for(Review n : list){
        %>
        <tr>
            <td><%=n.getReviewNo() %></td>
            <td><%=n.getReviewContent() %></td>
            <td><%=n.getCreatedate() %></td>
            <td><%=n.getUpdatedate() %></td>
        </tr>
        <%
            }
        %>
    </table>

</div>

	<br>
	<br>
	<a href="<%=request.getContextPath()%>/main.jsp" class="btn btn-success">홈으로</a>
	<br>
	<br>
	<a href="<%=request.getContextPath()%>/reviewInsert.jsp" class="btn btn-success">리뷰입력</a>
	<br>
	<br>
	<a href="<%=request.getContextPath()%>/reviewDelete.jsp" class="btn btn-success">리뷰삭제</a>
	
</div>
</body>
</html>