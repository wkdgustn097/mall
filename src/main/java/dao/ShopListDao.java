package dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.io.InputStream;
import com.oreilly.servlet.*;




import vo.*;
import java.sql.*;

public class ShopListDao {
	
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
	
	
	public Gijoin insertShopGoods(String goodsTitle, String goodsPrice, String goodsMemo, String fileName, String originName, String contentType) throws Exception{
		Gijoin gijoin = new Gijoin();
		//Driver 설정
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall" ;
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);

		String sql = "INSERT INTO goods (goods_title, goods_price, soldout, goods_memo, createdate, updatedate) values (?, ?, 'N', ?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS); 
		stmt.setString(1, goodsTitle);
		stmt.setString(2, goodsPrice);
		stmt.setString(3, goodsMemo);
		
		int row1 = stmt.executeUpdate();
		ResultSet rs = stmt.getGeneratedKeys();
		
		int goodsNo = 0;
		if(rs.next()){
			goodsNo = rs.getInt(1);
			System.out.println(goodsNo);
		   }
		
		String sql1 = "INSERT INTO goods_img (goods_no, filename, origin_name, content_type, createdate, updatedate) values (?, ? ,?, ?, NOW(), NOW())";
		PreparedStatement stmt1 = conn.prepareStatement(sql1); 
		stmt1.setInt(1, goodsNo);
		stmt1.setString(2, fileName);
		stmt1.setString(3, originName);
		stmt1.setString(4, contentType);
		int row2 = stmt1.executeUpdate();
		
		//db자원을 반납
		stmt1.close();
		rs.close();
		stmt.close();
		conn.close();
		
		
		
		return gijoin;
	}
	
	
	public Gijoin selectShopUpdateList(Gijoin inputGijoin) throws Exception{
		Gijoin gijoin = null;
		System.out.println(inputGijoin.getGoodsNo()+"<--inputGijoin");
		Class.forName("org.mariadb.jdbc.Driver");
		System.out.println("드라이브 로딩성공");
		String url = "jdbc:mariadb://localhost:3306/mall";  
		String dbuser = "root";                           
		String dbpw = "java1234";          
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "SELECT g.goods_no goodsNo, goods_title goodsTitle, goods_price goodsPrice, soldout, goods_memo goodsMemo, g.createdate createdate, g.updatedate updatedate, origin_name originName, filename FROM goods g INNER JOIN goods_img gi on g.goods_no = gi.goods_no WHERE g.goods_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1,inputGijoin.getGoodsNo());
		System.out.println(stmt  + "<--stmt");
		ResultSet rs = stmt.executeQuery(); 
		if(rs.next()) {
			gijoin = new Gijoin();
			gijoin.setGoodsNo(rs.getInt("goodsNo"));
			gijoin.setGoodsTitle(rs.getString("goodsTitle"));
			gijoin.setGoodsPrice(rs.getInt("goodsPrice"));
			gijoin.setSoldout(rs.getString("soldout"));
			gijoin.setGoodsMemo(rs.getString("goodsMemo"));
			gijoin.setCreatedate(rs.getString("createdate"));
			gijoin.setUpdatedate(rs.getString("updatedate"));
			gijoin.setOriginName(rs.getString("originName"));
			gijoin.setFilename(rs.getString("filename"));
		}
		System.out.println(gijoin.getGoodsTitle() + "<----gijoin");
		rs.close();
		stmt.close();
		conn.close();
		return gijoin;
	}
	
	
	public GoodsSuccess updateShopGoods(String goodsTitle, String goodsPrice, String goodsMemo, int goodsNo) throws Exception{
		GoodsSuccess goodsSuccess = new GoodsSuccess();
		Class.forName("org.mariadb.jdbc.Driver");
		System.out.println("드라이브 로딩성공");
		String url = "jdbc:mariadb://localhost:3306/mall";  
		String dbuser = "root";                           
		String dbpw = "java1234";          
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		conn.setAutoCommit(false);
		
		String sql = "UPDATE goods SET goods_title = ?, goods_price = ?, goods_memo = ?, updatedate = NOW() WHERE goods_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, goodsTitle);
		stmt.setString(2, goodsPrice);
		stmt.setString(3, goodsMemo);
		stmt.setInt(4, goodsNo);
		System.out.println(stmt + "<--stmt");
		int row = stmt.executeUpdate();		
		System.out.println(row + "<--row");
		if(row != 1) {
			conn.rollback();
			stmt.close();
			conn.close();
			goodsSuccess.setSuccess("실패");
			System.out.println("----------------실패-------------");
			return goodsSuccess;
		}
		conn.commit();
		stmt.close();
		conn.close();
		return goodsSuccess;
	}
	
	public Goods_img updateShopGoodsImage(String originName, String filename, String contentType, int goodsNo) throws Exception{
		Goods_img goods_img = new Goods_img();
		Class.forName("org.mariadb.jdbc.Driver");
		System.out.println("드라이브 로딩성공");
		String url = "jdbc:mariadb://localhost:3306/mall";  
		String dbuser = "root";                           
		String dbpw = "java1234";          
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		conn.setAutoCommit(false);
		
		String sql = "UPDATE goods_img SET filename = ?, origin_name = ?, content_type = ?, updatedate = NOW() WHERE goods_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, filename);
		stmt.setString(2, originName);
		stmt.setString(3, contentType);
		stmt.setInt(4, goodsNo);
		System.out.println(stmt + "<--stmt");
		
		
		int row = stmt.executeUpdate();
		System.out.println(row + "<--row");
		if(row != 1) {
			conn.rollback();
			stmt.close();
			conn.close();
			System.out.println("----------------실패-------------");
			return goods_img;
		}
		conn.commit();
		stmt.close();
		conn.close();
		return goods_img;
	}
	
}