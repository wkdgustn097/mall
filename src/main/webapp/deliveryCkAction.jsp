<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>
<%
	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
	System.out.println(ordersNo);
	DeliveryDao deliveryDao = new DeliveryDao();
	
	String result = deliveryDao.deliveryCk(ordersNo);
	
	if(result.equals("true")){
		System.out.println(ordersNo+"배송완료");
		response.sendRedirect(request.getContextPath()+"/delivery.jsp");
	}else{
		System.out.println(ordersNo+"배송실패");
		response.sendRedirect(request.getContextPath()+"/delivery.jsp");	
	}
	

%>
