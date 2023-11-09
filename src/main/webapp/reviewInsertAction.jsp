<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>

<%
int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
String reviewContent = request.getParameter("reviewContent");

System.out.println(ordersNo + reviewContent);

ReviewDao reviewDao = new ReviewDao();

String result = reviewDao.reviewIn(ordersNo, reviewContent);
if(result.equals("true")){
	System.out.println("액션 리뷰작성성공");
	response.sendRedirect(request.getContextPath()+"/review.jsp");
}
	
%>