<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	String questionTitle = request.getParameter("questionTitle");
	System.out.println(questionTitle+ "<--questionTitle");
	String questionContent = request.getParameter("questionContent");
	System.out.println(questionContent+ "<--questionContent");
	int questionNo = Integer.parseInt(request.getParameter("questionNo"));
	System.out.println(questionNo+ "<--questionNo");

	QnaDao qnaDao = new QnaDao();
	
	int row = qnaDao.qnaCusUpdate(questionTitle, questionContent, questionNo);
	if(row == 1){
     	System.out.println("삭제 완료");
 
 	}else {
 		System.out.println("삭제 실패");
		}
	response.sendRedirect(request.getContextPath()+"/qnaForm.jsp");
%>