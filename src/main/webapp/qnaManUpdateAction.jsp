<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	String comment = request.getParameter("comment");
	System.out.println(comment+ "<--comment");
	int questionCommentNo = Integer.parseInt(request.getParameter("questionCommentNo"));
	System.out.println(questionCommentNo+ "<--questionCommentNo");
	
	QnaDao qnaDao = new QnaDao();
	
	int row = qnaDao.qnaManUpdate(comment, questionCommentNo);
	if(row == 1){
     	System.out.println("삭제 완료");
 
 	}else {
 		System.out.println("삭제 실패");
		}
	response.sendRedirect(request.getContextPath()+"/qnaForm.jsp");
%>