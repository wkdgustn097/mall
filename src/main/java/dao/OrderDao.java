package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import vo.OrderFormJoin;

public class OrderDao {
	
	public OrderFormJoin selectAddrList(String memberId) throws Exception{
		OrderFormJoin orderFormJoin = new OrderFormJoin();
		Class.forName("org.mariadb.jdbc.Driver");
		System.out.println("드라이브 로딩성공");
		String url = "jdbc:mariadb://localhost:3306/mall";  
		String dbuser = "root";                           
		String dbpw = "java1234";          
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "SELECT ca.address address FROM customer c INNER JOIN customer_addr ca ON c.customer_no = ca.customer_no WHERE c.customer_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,memberId);
		System.out.println(stmt  + "<--stmt");
		ResultSet rs = stmt.executeQuery(); 
		if(rs.next()) {
			orderFormJoin.setAddress(rs.getString("address"));
		}
		return orderFormJoin;
	}
	
	public OrderFormJoin insertOrder(String memberId, int goodsNo, int goodsTotal, int quantity) throws Exception{
		OrderFormJoin orderFormJoin = new OrderFormJoin();
		Class.forName("org.mariadb.jdbc.Driver");
		System.out.println("드라이브 로딩성공");
		String url = "jdbc:mariadb://localhost:3306/mall";  
		String dbuser = "root";                           
		String dbpw = "java1234";          
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "SELECT ca.address address FROM customer c INNER JOIN customer_addr ca ON c.customer_no = ca.customer_no WHERE c.customer_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,memberId);
		System.out.println(stmt  + "<--stmt");
		ResultSet rs = stmt.executeQuery(); 
		if(rs.next()) {
			orderFormJoin.setAddress(rs.getString("address"));
		}
		return orderFormJoin;
	}
}
