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
		String url = "jdbc:mariadb://3.36.253.196/mall";  
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
		String url = "jdbc:mariadb://3.36.253.196/mall";  
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
		String url = "jdbc:mariadb://3.36.253.196/mall";  
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
		String url = "jdbc:mariadb://3.36.253.196/mall";  
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
		String url = "jdbc:mariadb://3.36.253.196/mall";  
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
	
	// cartOrderAction에 사용되는 dao
	public Orders insertCartOrder(int customerNo) throws Exception{
		Orders orders = new Orders();
		Class.forName("org.mariadb.jdbc.Driver");
		System.out.println("---성공---");
		String url = "jdbc:mariadb://3.36.253.196/mall";  
		String dbuser = "root";                           
		String dbpw = "java1234";          
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql1 = "SELECT c.goods_no goodsNo, c.quantity quantity, ca.customer_addr_no customerAddrNo, g.goods_price goodsPrice FROM cart c INNER JOIN customer_addr ca ON c.customer_no = ca.customer_no INNER JOIN goods g ON c.goods_no = g.goods_no WHERE c.customer_no = ?";
		PreparedStatement stmt1 = conn.prepareStatement(sql1);
		stmt1.setInt(1, customerNo);
		System.out.println(stmt1  + "<--stmt");	
		ResultSet rs = stmt1.executeQuery(); 
		
		// select문이 있으면, 하나씩 처리
		while(rs.next()) {
            int goodsNo = rs.getInt("goodsNo");
            int customerAddrNo = rs.getInt("customerAddrNo");
            int quantity = rs.getInt("quantity");
            int goodsPrice = rs.getInt("goodsPrice");
            int totalPrice = goodsPrice * quantity;
			
			String sql2 = "INSERT INTO orders(goods_no, customer_no,customer_addr_no, quantity, total_price, orders_state, createdate, updatedate) VALUES(?,?,?,?,?,'주문완료',NOW(), NOW())";
			PreparedStatement stmt2 = conn.prepareStatement(sql2);
			stmt2.setInt(1, goodsNo);
			stmt2.setInt(2, customerNo);
			stmt2.setInt(3, customerAddrNo);
			stmt2.setInt(4, quantity);
			stmt2.setInt(5, totalPrice);
			System.out.println(stmt2  + "<--stmt");	
			
			// stmt2를 실행하여 INSERT 쿼리를 수행
			int rowsInserted = stmt2.executeUpdate(); 
		    // INSERT 문을 실행한 결과가 1이면 성공
		    if (rowsInserted == 1) {
			       System.out.println("INSERT 성공");
			   } else {
			       System.out.println("INSERT 실패");
			   }
			
			String sql3 = "DELETE FROM cart WHERE customer_no = ? and goods_no = ?";
			PreparedStatement stmt3 = conn.prepareStatement(sql3);
			stmt3.setInt(1, customerNo);
			stmt3.setInt(2, goodsNo);
			System.out.println(stmt3  + "<--stmt");	
			
		    // stmt3를 실행하여 DELETE 쿼리를 수행
		    int rowsDeleted = stmt3.executeUpdate();

		    // DELETE 문을 실행한 결과가 1이면 성공
		    if (rowsDeleted == 1) {
		        System.out.println("DELETE 성공");
		    } else {
		        System.out.println("DELETE 실패");
		    }

		}
		stmt1.close();
		rs.close();
		conn.close();
		return orders;
		
	}
	
	
	//cartForm 상품 갯수 변경에 쓰이는 dao
	public String[] updateQuantity(String newQuantity, String cartNo) throws Exception{  // 배열로 값 받
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		System.out.println("드라이브 로딩성공");
		String url = "jdbc:mariadb://3.36.253.196/mall";  
		String dbuser = "root";                           
		String dbpw = "java1234";          
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		System.out.println(newQuantity  + "<--newQuantity");	
		System.out.println(cartNo  + "<--cartNo");	
		
	    String[] newQuantityArray = newQuantity.split(","); // newQuantity와 cartNo를 각각 쉼표로 분리하여 배열에 저장
	    String[] cartNoArray = cartNo.split(","); // newQuantity와 cartNo를 각각 쉼표로 분리하여 배열에 저장
	    
	    for (int i = 0; i < newQuantityArray.length; i++) {
	        System.out.println(newQuantityArray[i] + "<--newQuantity");  // 디버깅 
	        System.out.println(cartNoArray[i] + "<--cartNo"); // 디버깅 
		
			String sql = "UPDATE cart SET quantity = ? WHERE cart_no = ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, newQuantityArray[i]);
			stmt.setString(2, cartNoArray[i]);
			System.out.println(stmt  + "<--stmt------------>");	
			
			int row1 = stmt.executeUpdate();
		    if (row1 == 1) {
		        System.out.println("update성공");
		     } else {
		        System.out.println("update실패");
		     }
	    }
	    return new String[]{String.valueOf(row)};
	}
}
