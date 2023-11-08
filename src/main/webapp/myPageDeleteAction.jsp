<!-- myPageDeleteCk -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>
<%@ page import="java.net.URLEncoder"%>
<%
String idIn = (String)(session.getAttribute("loginId"));
	String pwIn = request.getParameter("beforePw");
	UserDao userDao = new UserDao();
	String deleteUser = userDao.deleteUser(idIn);
	
	if(deleteUser.equals("false")){
		System.out.println("삭제실패");
		response.sendRedirect(request.getContextPath()+"/logout.jsp");
	}else if(deleteUser.equals("true")){
		System.out.println("삭제성공");
		response.sendRedirect(request.getContextPath()+"/logout.jsp");
	}
%>