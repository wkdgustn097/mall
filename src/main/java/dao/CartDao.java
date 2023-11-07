package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import vo.Cart;
import vo.CartCustGoodsJoin;
import vo.CartCustJoin;
import vo.OrderFormJoin;
import vo.Orders;

public class CartDao {
	
	// cartForm에 사용되는 dao
	public ArrayList<CartCustGoodsJoin> selectCartList(int beginRow, int rowPerPage, String memberId) throws Exception{
		ArrayList<CartCustGoodsJoin> list = new ArrayList<CartCustGoodsJoin>();
		Class.forName("org.mariadb.jdbc.Driver");
		System.out.println("드라이브 로딩성공");
		String url = "jdbc:mariadb://localhost:3306/mall";  
		String dbuser = "root";                           
		String dbpw = "java1234";          
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		
		String sql = "SELECT c2.cart_no cartNo, c2.quantity quantity, g.goods_price goodsPrice, g.goods_title goodsTitle FROM customer c1 INNER JOIN cart c2 ON c1.customer_no = c2.customer_no INNER JOIN goods g ON c2.goods_no = g.goods_no WHERE c1.customer_id = ? LIMIT ?,?";
		// 조인을 통하여 원하는 값 SELECT
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
		rs.close();
		stmt.close();
		conn.close();
		return list;
	}
	
	// cartForm에 사용되는 dao
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
		rs.close();
		stmt.close();
		conn.close();
		return row;
	}
	
	// cartInsertAction에 사용되는 dao
	public Cart insertCart(int goodsNo,int quantity,String memberId) throws Exception{
		Cart cart = new Cart();
		Class.forName("org.mariadb.jdbc.Driver");
		System.out.println("드라이브 로딩성공");
		String url = "jdbc:mariadb://localhost:3306/mall";  
		String dbuser = "root";                           
		String dbpw = "java1234";          
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		// customer_no 추출
		String sql1 = "SELECT customer_no customerNo FROM customer WHERE customer_id = ? ";
		PreparedStatement stmt1 = conn.prepareStatement(sql1);
		stmt1.setString(1, memberId);
		ResultSet rs1 = stmt1.executeQuery();
		if (rs1.next()) {
		    String customerNo = rs1.getString("customerNo");			
		    System.out.println(customerNo + " <-- customerNo");
		}
		String customerNo = rs1.getString("customerNo");
		
		
		String sql2 = "INSERT INTO cart(goods_no, customer_no,quantity,createdate, updatedate) VALUES(?,?,?,NOW(), NOW())";
		PreparedStatement stmt2 = conn.prepareStatement(sql2);
		stmt2.setInt(1, goodsNo);
		stmt2.setString(2, customerNo);
		stmt2.setInt(3, quantity);
		System.out.println(stmt2  + "<--stmt2");	
		int row = stmt2.executeUpdate();	//업데이트
		if (row==1) {					//업데이트 확인
			System.out.println("입력성공");
		}  else {
			System.out.println("입력실패");
		}
		rs1.close();
		stmt1.close();
		stmt2.close();
		conn.close();
		return cart;
		
	}
	
	//cartOrderForm에서 사용되는 dao
	public OrderFormJoin selectCartList(String memberId) throws Exception{
		OrderFormJoin orderFormJoin = new OrderFormJoin();
		Class.forName("org.mariadb.jdbc.Driver");
		System.out.println("드라이브 로딩성공");
		String url = "jdbc:mariadb://localhost:3306/mall";  
		String dbuser = "root";                           
		String dbpw = "java1234";          
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "SELECT ca.address address, c.customer_no customerNo, ca.customer_addr_no customerAddrNo FROM customer c INNER JOIN customer_addr ca ON c.customer_no = ca.customer_no WHERE c.customer_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,memberId);
		System.out.println(stmt  + "<--stmt");
		ResultSet rs = stmt.executeQuery(); 
		if(rs.next()) {
			orderFormJoin.setAddress(rs.getString("address"));
			orderFormJoin.setCustomerNo(rs.getInt("customerNo"));
			orderFormJoin.setCustomerAddrNo(rs.getInt("customerAddrNo"));
		}
		rs.close();
		stmt.close();
		conn.close();
		return orderFormJoin;
	}
	
	//cartOrderForm에서 사용되는 dao
	public ArrayList<CartCustGoodsJoin> selectCartOrderList(String memberId) throws Exception{
		ArrayList<CartCustGoodsJoin> list = new ArrayList<CartCustGoodsJoin>();
		Class.forName("org.mariadb.jdbc.Driver");
		System.out.println("드라이브 로딩성공");
		String url = "jdbc:mariadb://localhost:3306/mall";  
		String dbuser = "root";                           
		String dbpw = "java1234";          
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		
		String sql = "SELECT c2.cart_no cartNo, c2.quantity quantity, g.goods_price goodsPrice, g.goods_title goodsTitle FROM customer c1 INNER JOIN cart c2 ON c1.customer_no = c2.customer_no INNER JOIN goods g ON c2.goods_no = g.goods_no WHERE c1.customer_id = ?";
		// 조인을 통하여 원하는 값 SELECT
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);	
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
		rs.close();
		stmt.close();
		conn.close();
		return list;
	}
	
	
	
	
	// cartOrderAction에 사용되는 dao / goodsNo, totalPrice, quantity 추출용
	public CartCustJoin selectCartOrder(int customerNo) throws Exception{
		CartCustJoin cartCustJoin = new CartCustJoin();
		Class.forName("org.mariadb.jdbc.Driver");
		System.out.println("드라이브 로딩성공");
		String url = "jdbc:mariadb://localhost:3306/mall";  
		String dbuser = "root";                           
		String dbpw = "java1234";          
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "SELECT g.goods_no goodsNo, g.goods_price goodsPrice, quantity FROM cart c INNER JOIN goods g ON c.goods_no = g.goods_no WHERE c.customer_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, customerNo);
		System.out.println(stmt  + "<--stmt");
		ResultSet rs = stmt.executeQuery(); 
		if(rs.next()) {
			cartCustJoin.setGoodsNo(rs.getInt("goodsNo"));
			cartCustJoin.setGoodsPrice(rs.getInt("goodsPrice"));
			cartCustJoin.setQuantity(rs.getInt("quantity"));
		}
		rs.close();
		stmt.close();
		conn.close();
		return cartCustJoin;
	}
	
	
	
	// cartOrderAction에 사용되는 dao
	public Orders insertCartOrder(int goodsNo,int customerNo, int customerAddrNo,int quantity,int totalPrice) throws Exception{
		Orders orders = new Orders();
		Class.forName("org.mariadb.jdbc.Driver");
		System.out.println("드라이브 로딩성공");
		String url = "jdbc:mariadb://localhost:3306/mall";  
		String dbuser = "root";                           
		String dbpw = "java1234";          
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);

		String sql = "INSERT INTO orders(goods_no, customer_no,customer_addr_no, quantity, total_price, orders_state, createdate, updatedate) VALUES(?,?,?,?,?,'주문완료',NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, goodsNo);
		stmt.setInt(2, customerNo);
		stmt.setInt(3, customerAddrNo);
		stmt.setInt(4, quantity);
		stmt.setInt(5, totalPrice);
		System.out.println(stmt  + "<--stmt");	
		int row = stmt.executeUpdate();	//업데이트
		if (row==1) {					//업데이트 확인
			System.out.println("입력성공");
		}  else {
			System.out.println("입력실패");
		}
		stmt.close();
		stmt.close();
		conn.close();
		return orders;
		
	}
}
