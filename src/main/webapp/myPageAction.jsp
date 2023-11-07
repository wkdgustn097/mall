<!-- myPageAction -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>
<%@ page import="java.net.URLEncoder"%>
<%	

	String idIn = (String)(session.getAttribute("loginId"));
	String pwIn = request.getParameter("beforePw");
	MallDaoLee mallDaoLee = new MallDaoLee();
	
	// 마이페이지 패스워드 체크 
	String pwCk = mallDaoLee.pwCk(idIn, pwIn);
	System.out.println(pwIn);
	System.out.println(pwCk);
	if (pwCk.equals("false")) {	// 이전패스워드 확인 실패
		String msg = URLEncoder.encode("패스워드를 확인해주세요");
		String myPageOpen = "false"; 
		response.sendRedirect(request.getContextPath()+"/myPage.jsp?myPageOpen="+myPageOpen+"&msg="+msg);
	}else if(pwCk.equals("true")){	// 이전패스워드 확인 성공
		String myPageOpen = "true"; 
		response.sendRedirect(request.getContextPath()+"/myPage.jsp?myPageOpen="+myPageOpen+"&msg="+"");

	}
%>