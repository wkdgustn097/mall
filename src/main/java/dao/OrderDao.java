package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import vo.OrderFormJoin;
import vo.Orders;

public class OrderDao {
	
	public OrderFormJoin selectAddrList(String memberId) throws Exception{
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
		return orderFormJoin;
	}
	
	public Orders insertOrders(int goodsNo, int goodsTotal, int quantity, int customerNo, int customerAddrNo) throws Exception{
		Orders orders = new Orders();
		Class.forName("org.mariadb.jdbc.Driver");
		System.out.println("드라이브 로딩성공");
		String url = "jdbc:mariadb://localhost:3306/mall";  
		String dbuser = "root";                           
		String dbpw = "java1234";          
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "INSERT INTO orders(goods_no, customer_no, customer_addr_no,quantity, total_price, orders_state, createdate, updatedate) VALUES(?,?,?,?,?,'주문완료',NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, goodsNo);
		stmt.setInt(2, customerNo);
		stmt.setInt(3, customerAddrNo);
		stmt.setInt(4, quantity);
		stmt.setInt(5, goodsTotal);
		System.out.println(stmt  + "<--stmt");
		
		int row = stmt.executeUpdate();	//업데이트
		if (row==1) {					//업데이트 확인
			System.out.println("입력성공");
		}  else {
			System.out.println("입력실패");
		}
		return orders;
		
	}
}
