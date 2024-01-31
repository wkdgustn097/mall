<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	if(session.getAttribute("loginId") == null) { // 로그인 되어 있으면 
		response.sendRedirect(request.getContextPath()+"/main.jsp");
		return;
	}
	if(session.getAttribute("managerId") != null) { // 로그인 되어 있으면 
		response.sendRedirect(request.getContextPath()+"/main.jsp");
		return;
	}

	int goodsNo = Integer.parseInt(request.getParameter("goodsNo")); // 넘겨받은 goodsNo
	int goodsTotal = Integer.parseInt(request.getParameter("goodsTotal")); //hidden으로 받은 goodsTotal 
	int quantity = Integer.parseInt(request.getParameter("quantity"));  //넘겨받은 quantity
	int customerNo = Integer.parseInt(request.getParameter("customerNo")); //hidden으로 받은 customerNo 
	int customerAddrNo = Integer.parseInt(request.getParameter("customerAddrNo")); //hidden으로 받은 customerAddrNo 
	
	
	OrderDao orderDao = new OrderDao();
	Orders orders = orderDao.insertOrders(goodsNo, goodsTotal, quantity, customerNo, customerAddrNo); //orderDao.insertOrders에 값 넘겨주
	
	response.sendRedirect(request.getContextPath()+"/thankYou.jsp"); // update 되면 main으로 넘어가
%>
