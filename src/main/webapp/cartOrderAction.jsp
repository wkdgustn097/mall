<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>
<%
	if(session.getAttribute("loginId") == null) { // 로그인 되어 있으면
		response.sendRedirect(request.getContextPath()+"/main.jsp");
		return;
	}

	String memberId = (String)(session.getAttribute("loginId")); //session 값 가져오기 
	int customerNo = Integer.parseInt(request.getParameter("customerNo"));
	
	CartDao cartDao = new CartDao(); // MallDao 생성
    
    Orders order = cartDao.insertCartOrder(customerNo); 
    
    response.sendRedirect(request.getContextPath()+"/thankYou.jsp");
%>
