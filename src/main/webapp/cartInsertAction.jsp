<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.sql.*" %>
<%
	if(session.getAttribute("loginId") == null) { // 로그인 되어 있으면
		response.sendRedirect(request.getContextPath()+"/main.jsp");
		return;
	}
	
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo")); // 넘겨온 값 받기
	int quantity = Integer.parseInt(request.getParameter("quantity")); // 넘겨온 값 받기
	
	String memberId = (String)(session.getAttribute("loginId")); //session 값 가져오기 
	
	CartDao cartDao = new CartDao(); 
	Cart cart = cartDao.insertCart(goodsNo, quantity, memberId);
	
	response.sendRedirect(request.getContextPath() + "/cartForm.jsp?");

%>
