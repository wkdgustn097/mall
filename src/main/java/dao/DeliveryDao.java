package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import vo.ReviewOrderGoodsJoin;

public class DeliveryDao {
	public ArrayList<ReviewOrderGoodsJoin> reviewList(int beginRow, int rowPerPage) throws Exception{
		ArrayList<ReviewOrderGoodsJoin> list = new ArrayList<>();
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://3.36.253.196/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "SELECT O.orders_state ordersState, G.goods_title goodsTitle, O.orders_no ordersNo , O.createdate createdate, O.updatedate updatedate FROM orders O JOIN goods G ON G.goods_no = O.goods_no ORDER BY O.orders_state LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		list = new ArrayList<>();
		while (rs.next()) {
			
			
			ReviewOrderGoodsJoin n = new ReviewOrderGoodsJoin();
			n.setOrdersState(rs.getString("ordersState"));
			n.setGoodsTitle(rs.getString("goodsTitle"));
		    n.setOrdersNo(rs.getInt("ordersNo"));
		    n.setCreatedate(rs.getString("createdate"));
		    n.setUpdatedate(rs.getString("updatedate"));
		   System.out.println(rs.getString("ordersState"));
		    list.add(n); // Notice 개체를 목록에 추가합니다.
		}
		
		
		
		return list;
	}
	public int lastPage(int total)throws Exception{
		
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://3.36.253.196/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "SELECT count(*) FROM review";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			row = rs.getInt("count(*)");
		}
		
		
		return row;
	}
	public String deliveryCk(int ordersNo) throws Exception{
		
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://3.36.253.196/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "UPDATE orders SET orders_state = ? WHERE orders_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, "배송완료");
		stmt.setInt(2, ordersNo);
		int row = stmt.executeUpdate();	//업데이트
		if (row==1) {					//업데이트 확인
			System.out.println("입력성공");
			conn.close();
			stmt.close();
			String result = "true";
			return result;
		}  else {
			System.out.println("입력실패");
			conn.close();
			stmt.close();
			String result = "false";
			return result;
		}
		
	}
}
