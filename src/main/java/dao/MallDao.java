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
	
	public Map<String, Object> insert(String customerId, String customerPw, String customerName, String customerPhone, String address) throws Exception {
		Map<String, Object> result = new HashMap<>();
		Class.forName("org.mariadb.jdbc.Driver");
		System.out.println("드라이브 성공");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		// 아이디 중복체크로직 customer , manager
		String sqlCId = "SELECT customer_no customerCNo, customer_id customerIdCk FROM customer where customer_id = ?";
		PreparedStatement stmtCId = conn.prepareStatement(sqlCId);
		stmtCId.setString(1, customerId);
		ResultSet rsCId = stmtCId.executeQuery();
		if(rsCId.next()){
			System.out.println("사용불가능 아이디 (customer_id 중복)");
			rsCId.close();
			stmtCId.close();
			conn.close();
			result.put("status", "중복 아이디입니다");	//	리턴
			return result;
		}
		String sqlMId = "SELECT manager_no managerMNo, manager_id managerIdCk FROM manager where manager_id = ?";
		PreparedStatement stmtMId = conn.prepareStatement(sqlMId);
		stmtMId.setString(1, customerId);
		ResultSet rsMId = stmtMId.executeQuery();
		if(rsMId.next()){
			System.out.println("사용불가능 아이디 (manager_id 중복)");
			rsMId.close();
			stmtMId.close();
			conn.close();
			result.put("status", "중복 아이디입니다");	//	리턴
			return result;
		}
		
		
		//1단계 custoemr id pw 저장 (1)		
		String sql1 = "INSERT INTO customer(customer_id,customer_pw,createdate,updatedate,ACTIVE)VALUES(?,?,NOW(),NOW(),'Y')";
		PreparedStatement stmt1 = conn.prepareStatement(sql1);
		stmt1.setString(1, customerId);
		stmt1.setString(2, customerPw);
		
		int row1 = stmt1.executeUpdate();	//업데이트
		if (row1==1) {					//업데이트 확인
			System.out.println("입력성공");
		}  else {
			System.out.println("입력실패");
			result.put("status", "회원가입 실패");	//	리턴
			return result;
		}
		
		//1단계 완료 후 customer_no 추출 (11)
		String sql11 ="SELECT customer_no customerNo FROM customer WHERE customer_id = ?";
		PreparedStatement stmt11 = conn.prepareStatement(sql11);
		stmt11.setString(1, customerId);
		ResultSet rs11 = stmt11.executeQuery();
		if (rs11.next()) {
		    String customerNo = rs11.getString("customerNo");			
		    System.out.println(customerNo + " <----------- customerNo출력확인  ");
		}
		String customerNo = rs11.getString("customerNo");
		
		//2단계 customer_ditail 이름 전화번호 저장 (2)
		String sql2 = "INSERT INTO customer_detail(customer_no,customer_name,customer_phone,createdate,updatedate)VALUES(?,?,?,NOW(),NOW())";
		PreparedStatement stmt2 = conn.prepareStatement(sql2);
		stmt2.setString(1, customerNo);	
		stmt2.setString(2, customerName);
		stmt2.setString(3, customerPhone);	
		
		int row2 = stmt2.executeUpdate();	//업데이트
		if (row2==1) {					//업데이트 확인
			System.out.println("입력성공");
		}  else {
			System.out.println("입력실패");
			result.put("status", "회원가입 실패");	//	리턴
			return result;
		}
		
		
		//3단계 customer_addr 주소 저장 (3)
		String sql3 = "INSERT INTO customer_addr(customer_no,address,createdate,updatedate)VALUES(?,?,NOW(),NOW())";
		PreparedStatement stmt3 = conn.prepareStatement(sql3);
		stmt3.setString(1, customerNo);	
		stmt3.setString(2, address);
		
		int row3 = stmt3.executeUpdate();	//업데이트
		if (row3==1) {					//업데이트 확인
			System.out.println("입력성공");
		}  else {
			System.out.println("입력실패");
			result.put("status", "회원가입 실패");	//	리턴
			rsCId.close();
			stmtCId.close();
			rsMId.close();
			stmtMId.close();
			stmt1.close();
			stmt11.close();
			rs11.close();
			stmt2.close();
			stmt3.close();
			return result;
		}
		result.put("status", "회원가입 성공");	//	리턴
		rsCId.close();
		stmtCId.close();
		rsMId.close();
		stmtMId.close();
		stmt1.close();
		stmt11.close();
		rs11.close();
		stmt2.close();
		stmt3.close();
		return result; 
	}
	
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
	public ArrayList<Login> login(String customerId, String customerPw, String managerId, String managerPw)throws Exception {
		ArrayList<Login> login = new ArrayList<>();
		
		Class.forName("org.mariadb.jdbc.Driver");
		System.out.println("드라이브 성공");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		// 고객 로그인 시도
		String sql1 = "SELECT customer_id customerId1, customer_no customerNo1 FROM customer WHERE customer_id = ? AND customer_pw = ? ";
		PreparedStatement stmt1 = conn.prepareStatement(sql1);
		stmt1.setString(1, customerId);
		stmt1.setString(2, customerPw);
		ResultSet rs1 = stmt1.executeQuery();
		
		
		if(rs1.next()) { // 로그인 성공
			
			Login log1 = new Login(); 
			log1.setCustomerNo(rs1.getInt("customerNo1"));
			log1.setCustomerId(rs1.getString("customerId1"));
			login.add(log1);	// 고객번호 고객아이디 login에 저장
			System.out.println("고객 로그인 성공");
			System.out.println(login + "<-- 배열값 확인");
			return login;
		} else { // 로그인 실패 -> 매니저로그인 시도
			
			String sql2 = "SELECT manager_id managerId, manager_no managerNo FROM manager WHERE manager_id = ? AND manager_pw = ?";
			PreparedStatement stmt2 = conn.prepareStatement(sql2);
			stmt2.setString(1, managerId);
			stmt2.setString(2, managerPw);
			ResultSet rs2 = stmt2.executeQuery();
			
			if(rs2.next()) { // 매니저 로그인 성공
				Login log2 = new Login();
				log2.setManagerNo(rs2.getInt("managerNo"));
				log2.setManagerId(rs2.getString("managerId"));
				login.add(log2);	// 매니저번호 매니저아이디 login에 저장
				System.out.println("매니저 로그인 성공");
				System.out.println(log2.getManagerId()+"<--매니저아이디 확인");
				stmt1.close();
				rs1.close();
				stmt2.close();
				rs2.close();
				conn.close();
				
				return login;
			}else {	// 매니저 로그인 실패
				System.out.println("로그인 실패");
				stmt1.close();
				rs1.close();
				stmt2.close();
				rs2.close();
				conn.close();
				return login;
			}
		}
	}
}