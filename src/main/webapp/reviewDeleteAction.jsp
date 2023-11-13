<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>

<%
	int reviewNo = Integer.parseInt(request.getParameter("reviewNo"));
	
	System.out.println(reviewNo);
	
	ReviewDao reviewDao = new ReviewDao();
	
	String result = reviewDao.reviewDel(reviewNo);

	
%>