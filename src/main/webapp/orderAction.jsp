<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	int goodsTotal = Integer.parseInt(request.getParameter("goodsTotal"));
	int quantity = Integer.parseInt(request.getParameter("quantity"));
	
	
%>
