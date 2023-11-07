package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import vo.CartCustGoodsJoin;

public class CartDao {

	public ArrayList<CartCustGoodsJoin> selectCartList(int beginRow, int rowPerPage, String memberId) throws Exception{
		ArrayList<CartCustGoodsJoin> list = new ArrayList<CartCustGoodsJoin>();
		Class.forName("org.mariadb.jdbc.Driver");
		System.out.println("드라이브 로딩성공");
		String url = "jdbc:mariadb://localhost:3306/mall";  
		String dbuser = "root";                           
		String dbpw = "java1234";          
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "SELECT c2.cart_no cartNo, c2.quantity quantity, g.goods_price goodsPrice, g.goods_title goodsTitle FROM customer c1 INNER JOIN cart c2 ON c1.customer_no = c2.customer_no INNER JOIN goods g ON c2.goods_no = g.goods_no WHERE c1.customer_id = ? LIMIT ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);	
		stmt.setInt(2, beginRow);
		stmt.setInt(3, rowPerPage);
		ResultSet rs = stmt.executeQuery(); 
		list = new ArrayList<>();
		while(rs.next()) {
			CartCustGoodsJoin c = new CartCustGoodsJoin();
			c.setGoodsTitle(rs.getString("goodsTitle"));
			c.setGoodsPrice(rs.getInt("goodsPrice"));
			c.setCartNo(rs.getInt("cartNo"));
			c.setQuantity(rs.getInt("quantity"));
			list.add(c);
		}
		
		return list;
	}
	
	public int lastPage(int total) throws Exception{
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";  
		String dbuser = "root";                           
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "SELECT COUNT(*) FROM cart";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			row = rs.getInt("COUNT(*)");
		}
		return row;
	}
}
