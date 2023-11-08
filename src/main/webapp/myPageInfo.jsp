<!-- myPageInfo -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>
<%@ page import="java.net.URLEncoder"%>
<%


	if(session.getAttribute("loginId") == null) { // 로그인이 안되어있으면 login.jsp로 보냄
		response.sendRedirect(request.getContextPath()+"/login.jsp");
		return;
	}
	String idIn = (String)(session.getAttribute("loginId"));
	UserDao userDao = new UserDao();
	List<String> myPageInfo = userDao.myPageInfo(idIn);
	
	String loadId = null;
	String loadName = null;
	String loadPhone = null;
	String loadAddr = null;
	String createdate = null;
	String updatedate = null;
	if (myPageInfo.size() >= 2) {
		loadId = myPageInfo.get(0);
		loadName = myPageInfo.get(1);
		loadPhone = myPageInfo.get(2);
		loadAddr = myPageInfo.get(3);
		createdate = myPageInfo.get(4);
		updatedate = myPageInfo.get(5);
    }
%>


<!DOCTYPE html>
<html>
<jsp:include page="/inc/menu.jsp"></jsp:include> <!-- 네비게이션바 -->
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<br>

	<div class="container">
		<h1> 내 정보 </h1>
		<table class="table table-bordered table-hover">
		<tr>
			<td>아이디</td>
			<td><%=loadId%></td>
		</tr>
		<tr>
			<td>이름</td>
			<td><%=loadName%></td>
		</tr>
		<tr>
			<td>전화번호</td>
			<td><%=loadPhone%></td>
		</tr>
		<tr>
			<td>주소</td>
			<td><%=loadAddr%></td>
		</tr>
		<tr>
			<td>계정생성일</td>
			<td><%=createdate%></td>
		</tr>
		<tr>
			<td>업데이트날짜</td>
			<td><%=updatedate%></td>
		</tr>
		
		</table>
		<br>
		
		<a href="<%=request.getContextPath()%>/myPage.jsp" 
		class="btn btn-success">회원정보수정</a>
		<br>
		<br>
		<a href="<%=request.getContextPath()%>/myPageDelete.jsp"
		class="btn btn-danger">회원탈퇴</a>
		<br><br>
		
		
	</div>
</body>
</html>