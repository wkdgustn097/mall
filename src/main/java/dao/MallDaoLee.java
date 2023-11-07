package dao;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
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
	public String updateUser(String idIn, String updatePw, String updateName, String updatePhone, String updateAddress) throws Exception  {
		Class.forName("org.mariadb.jdbc.Driver");
		System.out.println("드라이브 성공");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		// 데이터 확인
		System.out.println(idIn + "<-아이디 , "+updatePw + "<-비밀번호 , "+updateName + "<-이름 , "+updatePhone + "<-전화번호 , "+updateAddress + "<-주소 , ");
		
		/*
		UPDATE customer C
		INNER JOIN customer_addr A ON C.customer_no = A.customer_no
		INNER JOIN customer_detail D ON A.customer_no = D.customer_no
		SET C.customer_pw = '1234',
		    D.customer_name = ?,
		    D.customer_phone = ?,
		    A.address = ?,
		    C.updatedate = NOW(),
		    A.updatedate = NOW(),
		    D.updatedate = NOW()
		WHERE C.customer_id = ?;
		*/
		
		
		String sql1 = "UPDATE customer C INNER JOIN customer_addr A ON C.customer_no = A.customer_no INNER JOIN customer_detail D ON A.customer_no = D.customer_no SET C.customer_pw = ?, D.customer_name = ?, D.customer_phone = ?, A.address = ?, C.updatedate = NOW(), A.updatedate = NOW(), D.updatedate = NOW() WHERE C.customer_id = ?";
		PreparedStatement stmt1 = conn.prepareStatement(sql1);
		
		stmt1.setString(1, updatePw);	
		stmt1.setString(2, updateName);	
		stmt1.setString(3, updatePhone);
		stmt1.setString(4, updateAddress);
		stmt1.setString(5, idIn);
		int rowsUpdated1 = stmt1.executeUpdate();
		
		if (rowsUpdated1 > 0) { // 업데이트가 성공한 경우
			System.out.println("고객 정보 업데이트 성공");
			conn.close();
			stmt1.close();
			String result = "true";
			return result;
		}
		else{	//실패시 오류메세지 출력
			
			String sql2 = "UPDATE manager SET manager_pw = ?, manager_name = ?, updatedate = NOW() WHERE manager_id = ?";
			PreparedStatement stmt2 = conn.prepareStatement(sql2);
			
			stmt2.setString(1, updatePw);	
			stmt2.setString(2, updateName);	
			stmt2.setString(3, idIn);
			int rowsUpdated2 = stmt2.executeUpdate();
			if (rowsUpdated2 > 0) { // 업데이트가 성공한 경우
				System.out.println("매니저 정보 업데이트 성공");
				conn.close();
				stmt1.close();
				stmt2.close();
				String result = "true";
				return result;
			}
		}
		System.out.println("업데이트 실패");
		conn.close();
		stmt1.close();
		String result = "false";
		return result;
	}
	public List<String> myPageInfo(String inId) throws Exception {
		List<String> myPageInfoList = new ArrayList<>();
		
		Class.forName("org.mariadb.jdbc.Driver");
		System.out.println("드라이브 성공");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql1 = "SELECT C.customer_id loadId, C.createdate createdate, C.updatedate updatedate, D.customer_name loadName, D.customer_phone loadPhone, A.address loadAddr FROM customer C INNER JOIN customer_addr A ON C.customer_no = A.customer_no INNER JOIN customer_detail D ON A.customer_no = D.customer_no WHERE customer_id = ?";
		PreparedStatement stmt1 = conn.prepareStatement(sql1);
		stmt1.setString(1, inId);
		ResultSet rs1 = stmt1.executeQuery();
		if (rs1.next()) {
			String loadId = rs1.getString("loadId");	
			System.out.println(loadId + " : 고객정보 로드 성공");
		    String loadName = rs1.getString("loadName");			
		    String loadPhone = rs1.getString("loadPhone");
		    String loadAddr = rs1.getString("loadAddr");
		    String createdate = rs1.getString("createdate");
		    String updatedate = rs1.getString("updatedate");
		    
		    myPageInfoList.add(loadId);
		    myPageInfoList.add(loadName);
		    myPageInfoList.add(loadPhone);
		    myPageInfoList.add(loadAddr);
		    myPageInfoList.add(createdate);
		    myPageInfoList.add(updatedate); 
		    conn.close();
		    stmt1.close();
		    rs1.close();
		    return myPageInfoList;
		    
		}else {
			
			String sql2 = "SELECT manager_id loadId, manager_name loadName, createdate, updatedate FROM manager WHERE manager_id = ?";
			PreparedStatement stmt2 = conn.prepareStatement(sql2);
			stmt2.setString(1, inId);
			ResultSet rs2 = stmt2.executeQuery();
			if (rs2.next()) {
				String loadId = rs2.getString("loadId");	
				System.out.println(loadId + " : 매니저정보 로드 성공");
			    String loadName = rs2.getString("loadName");
			    String loadPhone = "non";
			    String loadAddr = "non";
			    String createdate = rs2.getString("createdate");
			    String updatedate = rs2.getString("updatedate");
			    myPageInfoList.add(loadId);
			    myPageInfoList.add(loadName);
			    myPageInfoList.add(loadPhone);
			    myPageInfoList.add(loadAddr);
			    myPageInfoList.add(createdate);
			    myPageInfoList.add(updatedate); 
			    conn.close();
			    stmt1.close();
			    rs1.close();
			    stmt2.close();
			    rs2.close();
			    return myPageInfoList;
			    
			}
		}
		String loadId = "loadFail";	
		System.out.println(loadId + " 로드 실패");
	    String loadName = "loadFail";
	    String loadPhone = "loadFail";
	    String loadAddr = "loadFail";
	    String createdate = "loadFail";
	    String updatedate = "loadFail";
	    myPageInfoList.add(loadId);
	    myPageInfoList.add(loadName);
	    myPageInfoList.add(loadPhone);
	    myPageInfoList.add(loadAddr);
	    myPageInfoList.add(createdate);
	    myPageInfoList.add(updatedate); 
		conn.close();
	    stmt1.close();
	    rs1.close();
		return myPageInfoList;
	}
	public String deleteUser(String idIn) throws Exception  {
		
		Class.forName("org.mariadb.jdbc.Driver");
		System.out.println("드라이브 성공");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		// id값을 받아서 고객이 맞는지 먼저 체크 
		String sqlCk = "SELECT customer_no cusromerNo FROM customer WHERE customer_id = ?";
		PreparedStatement stmtCk = conn.prepareStatement(sqlCk);
		stmtCk.setString(1, idIn);
		ResultSet rsCk = stmtCk.executeQuery();
		
		if (rsCk.next()) { // 고객 아이디 확인완료 -> 삭제
			System.out.println("고객 아이디 확인완료");
			String cusromerNo = rsCk.getString("cusromerNo");	//고객번호 추출
			
			String sqlDel1 = "DELETE A, D FROM customer_addr A INNER JOIN customer_detail D ON A.customer_no = D.customer_no  WHERE D.customer_no= ?";
			PreparedStatement stmtDel1 = conn.prepareStatement(sqlDel1);
			stmtDel1.setString(1, cusromerNo);		// 고객번호로 1차 정보 삭제
			int rowDel1 = stmtDel1.executeUpdate(); // 삭제(업데이트) 확인
			
			if (rowDel1  > 0) { 	// 1차정보 삭제완료
				System.out.println("고객 아이디 1차 삭제 성공");
				
				String sqlDel11 = "DELETE FROM customer WHERE customer_id= ?";
				PreparedStatement stmtDel11 = conn.prepareStatement(sqlDel11);
				stmtDel11.setString(1, idIn);
				int rowDel11 = stmtDel11.executeUpdate(); // 삭제(업데이트) 확인
				
				if (rowDel11  > 0) { 	// 2차정보 삭제완료
					System.out.println("고객 아이디 2차 삭제 성공");
					conn.close();
					stmtCk.close();
					rsCk.close();
					stmtDel1.close();
					stmtDel11.close();
					String deleteUser="true";
					return deleteUser;
				}
				
			}
		}else {
			String sqlDel2 = "DELETE FROM manager WHERE manager_id = ?";
			PreparedStatement stmtDel2 = conn.prepareStatement(sqlDel2);
			stmtDel2.setString(1, idIn);
			int rowDel2 = stmtDel2.executeUpdate(); // 삭제(업데이트) 확인
			if (rowDel2  > 0) { 	// 삭제완료
				System.out.println("매니저 아이디 삭제 성공");
				conn.close();
				stmtCk.close();
				rsCk.close();
				stmtDel2.close();
				String deleteUser="true";
				return deleteUser;
			}
		}
		System.out.println("아이디 삭제 실패");
		conn.close();
		stmtCk.close();
		rsCk.close();
		String deleteUser="false";
		return deleteUser;
	}
}