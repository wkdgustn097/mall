<!-- myPageActionGo -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>
<%@ page import="java.net.URLEncoder"%>
<%
	String idIn = (String)(session.getAttribute("loginId"));
	MallDaoLee mallDaoLee = new MallDaoLee();
	
	String updatePw = request.getParameter("updatePw");
	String updateName = request.getParameter("updateName");
	String updatePhone = request.getParameter("updatePhone");
	String updateAddress = request.getParameter("updateAddress");
	
	
	// 마이페이지 패스워드 체크 성공 이후 업데이트
	String reslut = mallDaoLee.updateUser(idIn, updatePw, updateName, updatePhone, updateAddress);
	System.out.println(reslut); 
	if (reslut.equals("false")){	// 업데이트 실패시
		String msg = URLEncoder.encode("ERROR : 0000 (관리자에게 문의하세요)");
		String myPageOpen = "false"; 
		response.sendRedirect(request.getContextPath()+"/myPage.jsp?myPageOpen="+myPageOpen+"&msg="+msg);
	}else if(reslut.equals("true")){	// 업데이트 성공
		response.sendRedirect(request.getContextPath()+"/main.jsp");
	}



%>