<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>
<%
	String customerId = request.getParameter("insertId");
	String customerPw = request.getParameter("insertPw");
	String customerName = request.getParameter("insertName");
	String customerPhone = request.getParameter("insertPhone");
	String address = request.getParameter("insertAddress");
	
	MallDao mallDao = new MallDao();
	mallDao.insert(customerId, customerPw, customerName, customerPhone, address);
	
/* 	if(row==1){
		System.out.println("성공");
	} */
	response.sendRedirect(request.getContextPath()+"/login.jsp");
%>