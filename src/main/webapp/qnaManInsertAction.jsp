<%@ page language="java" contentType="text/html; charset=UTF8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%@ page import= "dao.*" %>
<%	

	if (session.getAttribute("managerId") == null){
	   response.sendRedirect(request.getContextPath()+"/qnaForm.jsp");
	   return;
	}
//	String questionTitle = request.getParameter("questionTitle");
//	System.out.println(questionTitle + "<--questionTitle");
	String managerId = (String) session.getAttribute("managerId");
	System.out.println(managerId + "<--managerId");
	int questionNo = Integer.parseInt(request.getParameter("questionNo"));
	System.out.println(questionNo + "<--questionNo");
	String comment = request.getParameter("comment");
	
	
	QnaDao qnaDao = new QnaDao();
	int row = qnaDao.qnaManInsert(questionNo, managerId, comment);

	response.sendRedirect(request.getContextPath() +"/qnaForm.jsp");
%>