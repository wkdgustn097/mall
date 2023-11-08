<!-- managerInsertAction -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>
<%@ page import="java.net.URLEncoder"%>
<%
String managerId = request.getParameter("insertId");
	String managerPw = request.getParameter("insertPw");
	String managerName = request.getParameter("insertName");
	
	UserDao userDao = new UserDao();
	System.out.println(managerId);
	Map<String, Object> result = userDao.insertManager(managerId, managerPw, managerName);
	
	String status = (String) result.get("status");
	System.out.println(status + "<---매니저아이디 체크 ");
	
	if (status.equals("중복 아이디입니다")) {
		System.out.println("매니저 아이디 중복");
		String msg = URLEncoder.encode("중복된 아이디입니다"); // 한글이 깨짐 방지
		response.sendRedirect(request.getContextPath()+"/managerInsert.jsp?msg="+msg);
	}else{
		response.sendRedirect(request.getContextPath()+"/login.jsp");
	}
%>