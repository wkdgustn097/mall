package dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import vo.*;
import java.sql.*;

public class MallDao {
		
	// shopListForm shop상품 List 출
//	public ArrayList<Gijoin> selectShopList() throws Exception{
//		ArrayList<Gijoin> list = new ArrayList<Gijoin>();
//		Class.forName("org.mariadb.jdbc.Driver");
//		System.out.println("드라이브 성공");
//		String url = "jdbc:mariadb://localhost:3306/mall";
//		String dbuser = "root";
//		String dbpw = "java1234";
//		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
//		
//		String sql = "SELECT g.goods_no goodsNo, goods_title goodsTitle, goods_price goodsPrice, soldout, goods_memo goodsMemo, g.createdate createdate, g.updatedate updatedate, origin_name originName FROM goods g INNER JOIN goods_img gi on g.goods_no = gi.goods_no";
//		PreparedStatement stmt = conn.prepareStatement(sql);
//		System.out.println(stmt + "<--stmt");
//		ResultSet rs = stmt.executeQuery();
//		
//		list = new ArrayList<>();
//		while(rs.next()) {
//			Gijoin g = new Gijoin();
//			g.setGoodsNo(rs.getInt("goodsNo"));
//			g.setGoodsTitle(rs.getString("goodsTitle"));
//			g.setGoodsPrice(rs.getInt("goodsPrice"));
//			g.setSoldout(rs.getString("soldout"));
//			g.setGoodsMemo(rs.getString("goodsMemo"));
//			g.setCreatedate(rs.getString("createdate"));
//			g.setUpdatedate(rs.getString("updatedate"));
//			g.setOriginName(rs.getString("originName"));
//			list.add(g);
//		}
//		return list;
//	}
	
	
	
	public int lastPage(int total) throws Exception{
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";  
		String dbuser = "root";                           
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "SELECT COUNT(*) FROM goods";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			row = rs.getInt("COUNT(*)");
		}
		rs.close();
		stmt.close();
		conn.close();
		return row;
	}
	
	public ArrayList<Gijoin> selectShopList(int beginRow, int rowPerPage) throws Exception{
		ArrayList<Gijoin> list = new ArrayList<Gijoin>();
		Class.forName("org.mariadb.jdbc.Driver");
		System.out.println("드라이브 로딩성공");
		String url = "jdbc:mariadb://localhost:3306/mall";  
		String dbuser = "root";                           
		String dbpw = "java1234";          
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "SELECT g.goods_no goodsNo, goods_title goodsTitle, goods_price goodsPrice, soldout, goods_memo goodsMemo, g.createdate createdate, g.updatedate updatedate, origin_name originName FROM goods g INNER JOIN goods_img gi on g.goods_no = gi.goods_no LIMIT ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery(); 
		list = new ArrayList<>();
		while(rs.next()) {
			Gijoin g = new Gijoin();
			g.setGoodsNo(rs.getInt("goodsNo"));
			g.setGoodsTitle(rs.getString("goodsTitle"));
			g.setGoodsPrice(rs.getInt("goodsPrice"));
			g.setSoldout(rs.getString("soldout"));
			g.setGoodsMemo(rs.getString("goodsMemo"));
			g.setCreatedate(rs.getString("createdate"));
			g.setUpdatedate(rs.getString("updatedate"));
			g.setOriginName(rs.getString("originName"));
			list.add(g);
		}
		rs.close();
		stmt.close();
		conn.close();
		return list;
	}
	
}