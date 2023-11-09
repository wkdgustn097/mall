<!-- myPageActionGo -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>
<%@ page import="java.net.URLEncoder"%>
<%
String idIn = (String)(session.getAttribute("loginId"));
	UserDao userDao = new UserDao();
	
	String updatePw = request.getParameter("updatePw");
	String updateName = request.getParameter("updateName");
	String updatePhone = request.getParameter("updatePhone");
	String updateAddress = request.getParameter("updateAddress");
	
	
	// 마이페이지 패스워드 체크 성공 이후 업데이트
	String reslut = userDao.updateUser(idIn, updatePw, updateName, updatePhone, updateAddress);
	System.out.println(reslut); 
	if (reslut.equals("false")){	// 업데이트 실패시
		String msg = URLEncoder.encode("이전 비밀번호랑 다른 비밀번호를 입력해주세요.");
		String myPageOpen = "false"; 
		response.sendRedirect(request.getContextPath()+"/myPage.jsp?myPageOpen="+myPageOpen+"&msg="+msg);
	}else if(reslut.equals("true")){	// 업데이트 성공
		response.sendRedirect(request.getContextPath()+"/main.jsp");
	}
%>