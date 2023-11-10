<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.*"%>
<%
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));

	ShopListDao shopListDao = new ShopListDao();
	
	String name = shopListDao.deleteShopGoods(goodsNo);
	
	String uploadPath = request.getServletContext().getRealPath("/upload");
	File file = new File(uploadPath + "/" + name);
	if(file.exists()){
		file.delete();
	}
	
    response.sendRedirect(request.getContextPath() + "/shopListForm.jsp");
%>