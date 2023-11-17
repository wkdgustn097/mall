<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>
<%
	if(session.getAttribute("loginId") == null){
	response.sendRedirect(request.getContextPath()+"/qnaForm.jsp");
	return;
	}
	int questionNo = Integer.parseInt(request.getParameter("questionNo"));
	System.out.println(questionNo+ "<--questionNo");
	
	QnaDao qnaDao = new QnaDao();
	
	int row = qnaDao.qnaCusDelete(questionNo);
	 	if(row == 1){
         	System.out.println("삭제 완료");
     
     	}else {
     		System.out.println("삭제 실패");
 		}
	 	
	response.sendRedirect(request.getContextPath() +"/qnaForm.jsp");

%>
