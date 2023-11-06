<!-- insertAction -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>
<%@ page import="java.net.URLEncoder"%>
<%
	String customerId = request.getParameter("insertId");
	String customerPw = request.getParameter("insertPw");
	String customerName = request.getParameter("insertName");
	String customerPhone = request.getParameter("insertPhone");
	String address = request.getParameter("insertAddress");
	
	MallDao mallDao = new MallDao();
	Map<String, Object> result = mallDao.insert(customerId, customerPw, customerName, customerPhone, address);
	
	String status = (String) result.get("status");
	System.out.println(status);
	
	if (status.equals("중복 아이디입니다")) {
		String msg = URLEncoder.encode("중복된 아이디입니다"); // 한글이 깨찜 방지
		response.sendRedirect(request.getContextPath()+"/insert.jsp?msg="+msg);
	}else{
		response.sendRedirect(request.getContextPath()+"/login.jsp");
	}
	
%>