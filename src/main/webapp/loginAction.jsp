<!-- loginAction -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>
<%@ page import="java.net.URLEncoder"%>
<%
	String customerNo = null;
	String customerId = request.getParameter("id");
	String customerPw = request.getParameter("pw");
	String managerId = request.getParameter("id");
	String managerPw = request.getParameter("pw");
	
	MallDao mallDao = new MallDao();

	ArrayList<Login> logOn = mallDao.login(customerId,customerPw,managerId,managerPw);
	int customerNo1 = logOn.get(0).getCustomerNo();
	int managerNo1 = logOn.get(0).getManagerNo();
	String customerId1 = logOn.get(0).getCustomerId();
	String managerId1 = logOn.get(0).getManagerId();
	System.out.println(customerNo1);
	System.out.println(managerNo1);
	System.out.println(customerId1);
	System.out.println(managerId1);
	
	
	


	
	
	if(customerNo1 != 0) {	//고객 로그인 성공
		session.setAttribute("loginId", customerId1);
		response.sendRedirect(request.getContextPath()+"/main.jsp");
	} else if(managerNo1 != 0){ // 매니저 로그인 성공
		session.setAttribute("loginId", managerId1);
		response.sendRedirect(request.getContextPath()+"/main.jsp");
	}else{
		String msg = URLEncoder.encode("아이디,비밀번호를 확인하세요"); // 한글이 깨찜 방지
		response.sendRedirect(request.getContextPath()+"/login.jsp?msg="+msg);	
	} 
%>