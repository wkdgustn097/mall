<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	NoticeDao nd = new NoticeDao();
	Notice n = new Notice();
	n.setNoticeTitle(request.getParameter("getNoticeTitle"));
	n.setNoticeContent(request.getParameter("getNoticeContent"));
	
	int row = nd.updateNoticeAction(n);
	
	if(row == 1){
		System.out.println("수정완료");
		response.sendRedirect(request.getContextPath()+"/NoticeOne.jsp");
	}
		response.sendRedirect(request.getContextPath()+"/NoticeForm.jsp?NoticeNo");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>