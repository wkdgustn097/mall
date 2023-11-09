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

	String[] newQuantity = request.getParameterValues("newQuantity");  // 배열 받기 
    for (int i = 0; i < newQuantity.length; i++) {         
    	System.out.println(newQuantity[i] + "<----newQuantity");        // 디버깅 
    	}
	String[] cartNo = request.getParameterValues("cartNo"); // 배열 받ㄱㅣ 
    for (int i = 0; i < cartNo.length; i++) {         
    	System.out.println(cartNo[i] + "<----cartNo");       
    	}
    
	CartDao cartDao = new CartDao(); 
    
    for(int j=0; j < newQuantity.length; j=j+1){
    	String[] cart = cartDao.updateQuantity(newQuantity[j], cartNo[j]);  // 배열로 값 넘겨주기 
    }
    
    response.sendRedirect(request.getContextPath()+"/cartForm.jsp");
%>