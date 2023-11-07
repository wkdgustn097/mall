package dao;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import vo.*;

public class MallDaoLee {
	

	public Map<String, Object> insertManager(String managerId, String managerPw, String managerName) throws Exception {
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
		stmtCId.setString(1, managerId);
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
		stmtMId.setString(1, managerId);
		ResultSet rsMId = stmtMId.executeQuery();
		if(rsMId.next()){
			System.out.println("사용불가능 아이디 (manager_id 중복)");
			rsCId.close();
			stmtCId.close();
			rsMId.close();
			stmtMId.close();
			conn.close();
			result.put("status", "중복 아이디입니다");	//	리턴
			return result;
		}
		
		
		// 메니저 계정생성 	
		String sql1 = "INSERT INTO manager(manager_id,manager_pw,manager_name,createdate,updatedate,ACTIVE)VALUES(?,?,?,NOW(),NOW(),'Y')";
		PreparedStatement stmt1 = conn.prepareStatement(sql1);
		stmt1.setString(1, managerId);
		stmt1.setString(2, managerPw);
		stmt1.setString(3, managerName);
		int row1 = stmt1.executeUpdate();	//업데이트
		if (row1==1) {					//업데이트 확인
			System.out.println("매니저 입력성공");
		}  else {
			System.out.println("매니저 입력실패");
			result.put("status", "중복 아이디입니다");
			rsCId.close();
			stmtCId.close();
			conn.close();
			rsMId.close();
			stmtMId.close();
			stmt1.close();
			return result;
		}
		
		rsCId.close();
		stmtCId.close();
		conn.close();
		rsMId.close();
		stmtMId.close();
		stmt1.close();
		result.put("status", "사용가능한 아이디입니다");
		return result;
		
	}
	
	public String pwCk(String idIn, String pwIn) throws Exception {
		Class.forName("org.mariadb.jdbc.Driver");
		System.out.println("드라이브 성공");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		System.out.println(idIn);
		System.out.println(pwIn);
		
		// 패스워드 체크 로직
		String sqlCId = "SELECT customer_no customerCNo FROM customer where customer_id = ? AND customer_pw = ?";
		PreparedStatement stmtCId = conn.prepareStatement(sqlCId);
		stmtCId.setString(1, idIn);
		stmtCId.setString(2, pwIn);
		ResultSet rsCId = stmtCId.executeQuery();
		if(rsCId.next()){	// 고객 아이디 패스워드 확인
			System.out.println("고객 아이디 패스워드 확인");
			conn.close();
			rsCId.close();
			stmtCId.close();
			String result = "true"; 	
			return result;
		}else {
		String sqlMId = "SELECT manager_no managerMNo FROM manager where manager_id = ? AND manager_pw = ?";
		PreparedStatement stmtMId = conn.prepareStatement(sqlMId);
		stmtMId.setString(1, idIn);
		stmtMId.setString(2, pwIn);
		ResultSet rsMId = stmtMId.executeQuery();
		if(rsMId.next()){	//매니저 아이디 패스워드 확인
			System.out.println("매니저 아이디 패스워드 확인");
			conn.close();
			stmtMId.close();
			rsMId.close();
			String result = "true";
			return result;
		}
		}
		
		System.out.println("아이디 패스워드 확인 실패");
		rsCId.close();
		stmtCId.close();
		conn.close();
		String result = "false";
		return result;
	}
}
