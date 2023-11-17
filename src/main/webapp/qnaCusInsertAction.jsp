<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%@ page import= "dao.*" %>
<%	
	String goodsTitle = request.getParameter("goodsTitle");
	System.out.println(goodsTitle+ "<--goodsTitle");
	String customerId = request.getParameter("customerId");
	System.out.println(customerId+ "<--customerId");
	String questionTitle = request.getParameter("questionTitle");
	System.out.println(questionTitle+ "<-questionTitle");
	String questionContent = request.getParameter("questionContent");
	System.out.println( questionContent+"<-questionContent");
	QnaDao qnaDao = new QnaDao();
	int row = qnaDao.qnaCusInsert(goodsTitle, customerId, questionTitle, questionContent);
	
	response.sendRedirect(request.getContextPath() +"/qnaForm.jsp");
%>