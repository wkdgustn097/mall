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

public class UserDao {
	
	
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
			
			
			// customer_pw_history INSERT
			String SqlHis = "INSERT INTO customer_pw_history(customer_no,customer_pw,createdate)VALUES(?,?,NOW())";
			PreparedStatement stmtHis = conn.prepareStatement(SqlHis);
			stmtHis.setString(1, customerNo);	
			stmtHis.setString(2, customerPw);
			int rowHis = stmtHis.executeUpdate();	//업데이트
			if (rowHis==1) {					//업데이트 확인
				System.out.println("고객 pw_history 입력 성공");
				stmtHis.close();
			}else {
				System.out.println("고객 pw_history 입력 실패");
			}
			
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
			
			// managerNo 추출
			String sqlNo = "SELECT manager_no managerNo FROM manager WHERE manager_id = ?";
			PreparedStatement stmtNo = conn.prepareStatement(sqlNo);
			stmtNo.setString(1, managerId);
			ResultSet rsNo = stmtNo.executeQuery();
			if(rsNo.next()) {
				String managerNo = rsNo.getString("managerNo");
				System.out.println(managerNo + "  <--- managerNo추출성공");
				
				// manager_pw_history INSERT
				String SqlHis = "INSERT INTO manager_pw_history(manager_no,manager_pw,createdate)VALUES(?,?,NOW())";
				PreparedStatement stmtHis = conn.prepareStatement(SqlHis);
				stmtHis.setString(1, managerNo);	
				stmtHis.setString(2, managerPw);
				int rowHis = stmtHis.executeUpdate();	//업데이트
				if (rowHis==1) {					//업데이트 확인
					System.out.println("매니저 pw_history 입력 성공");
					
				}else {
					System.out.println("매니저 pw_history 입력 실패");
		
				}
				stmtHis.close();
				stmtNo.close();
				rsNo.close();
			}
			
			
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
	
	// 마이페이지 수정
	public String updateUser(String idIn, String updatePw, String updateName, String updatePhone, String updateAddress) throws Exception  {
		Class.forName("org.mariadb.jdbc.Driver");
		System.out.println("드라이브 성공");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		// 데이터 확인
		System.out.println(idIn + "<-아이디 , "+updatePw + "<-비밀번호 , "+updateName + "<-이름 , "+updatePhone + "<-전화번호 , "+updateAddress + "<-주소 , ");
		
		
		String customerNo = null;
		String managerNo = null;
		// id값을 받아서 고객 또는 매니저 번호 추출
		String sqlNo1 = "SELECT customer_no cusromerNo FROM customer WHERE customer_id = ?";
		PreparedStatement stmtNo1 = conn.prepareStatement(sqlNo1);
		stmtNo1.setString(1, idIn);
		ResultSet rsNo1 = stmtNo1.executeQuery();
		if (rsNo1.next()) { // 고객 아이디 확인완료
			System.out.println("고객 아이디 확인완료");
			customerNo = rsNo1.getString("cusromerNo");	//고객번호 추출
		}else {		// 없으면 매니저번호 확인
			String sqlNo2 = "SELECT manager_no managerNo FROM manager WHERE manager_id = ?";
			PreparedStatement stmtNo2 = conn.prepareStatement(sqlNo2);
			stmtNo2.setString(1, idIn);
			ResultSet rsNo2 = stmtNo2.executeQuery();
			if(rsNo2.next()) {	// 매니저 아이디 확인 완료
				managerNo = rsNo2.getString("managerNo");
				System.out.println(managerNo + "  <--- managerNo추출성공");
				stmtNo2.close();
				rsNo2.close();
			}
		}
		
		stmtNo1.close();
		rsNo1.close();
		
		System.out.println(customerNo);
		System.out.println(managerNo);
		
		if(customerNo != null) {
			String sqlHis1 = "SELECT customer_pw customerHisPw FROM customer_pw_history WHERE customer_no = ?";
			PreparedStatement stmtHis1 = conn.prepareStatement(sqlHis1);
			stmtHis1.setString(1, customerNo);
			ResultSet rsHis1 = stmtHis1.executeQuery();
			if(rsHis1.next()) {	// 매니저 아이디 확인 완료
				String customerHisPw = rsHis1.getString("customerHisPw");
				System.out.println(customerHisPw + "  <--- customer_pw_history 추출성공");
				stmtHis1.close();
				rsHis1.close();
				if(customerHisPw.equals(updatePw)) {
					System.out.println("고객 비밀번호 중복");
					conn.close();
					String result = "false";
					return result;
				}
			}
		}
		if(managerNo != null){
			String sqlHis2 = "SELECT manager_pw managerHisPw FROM manager_pw_history WHERE manager_no = ?";
			PreparedStatement stmtHis2 = conn.prepareStatement(sqlHis2);
			stmtHis2.setString(1, managerNo);
			ResultSet rsHis2 = stmtHis2.executeQuery();
			if(rsHis2.next()) {	// 매니저 아이디 확인 완료
				String managerHisPw = rsHis2.getString("managerHisPw");
				System.out.println(managerHisPw + "  <--- manager_pw_history 추출성공");
				stmtHis2.close();
				rsHis2.close();
				if(managerHisPw.equals(updatePw)) {
					conn.close();
					String result = "false";
					return result;
				}
			}
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
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
			
			// customerNo 추출
			String sqlNo = "SELECT customer_no customerNo FROM customer WHERE customer_id = ?";
			PreparedStatement stmtNo = conn.prepareStatement(sqlNo);
			stmtNo.setString(1, idIn);
			ResultSet rsNo = stmtNo.executeQuery();
			if(rsNo.next()) {
				customerNo = rsNo.getString("customerNo");
				System.out.println(customerNo + "  <--- customerNo추출성공");
				
				
				
				//!!!!!!!!!!! 수정중
				// customer_pw_history DELETE
				String sqlCHisDel = "DELETE FROM customer_pw_history WHERE customer_no= ?";
				PreparedStatement stmtCHisDel = conn.prepareStatement(sqlCHisDel);
				stmtCHisDel.setString(1, customerNo);
				int rowCHisDel = stmtCHisDel.executeUpdate(); // 삭제(업데이트) 확인
				
				if (rowCHisDel  > 0) { 	
					System.out.println("고객 pw_history 이전정보 삭제 성공");
				}else {
					System.out.println("고객 pw_history 이전정보 삭제 실패");
					
				}
				
				// customer_pw_history INSERT
				String SqlHis = "INSERT INTO customer_pw_history(customer_no,customer_pw,createdate)VALUES(?,?,NOW())";
				PreparedStatement stmtHis = conn.prepareStatement(SqlHis);
				stmtHis.setString(1, customerNo);	
				stmtHis.setString(2, updatePw);
				int rowHis = stmtHis.executeUpdate();	//업데이트
				if (rowHis==1) {					//업데이트 확인
					System.out.println("고객 pw_history 입력 성공");
				}else {
					System.out.println("고객 pw_history 입력 실패");
				}
				stmtCHisDel.close();
				stmtHis.close();
				stmtNo.close();
				rsNo.close();
					
			}		
					
					
			conn.close();
			stmt1.close();
			String result = "true";
			return result;
		}
		else{	// 실패시 매니저 업데이트
			
			String sql2 = "UPDATE manager SET manager_pw = ?, manager_name = ?, updatedate = NOW() WHERE manager_id = ?";
			PreparedStatement stmt2 = conn.prepareStatement(sql2);
			
			stmt2.setString(1, updatePw);	
			stmt2.setString(2, updateName);	
			stmt2.setString(3, idIn);
			int rowsUpdated2 = stmt2.executeUpdate();
			if (rowsUpdated2 > 0) { // 업데이트가 성공한 경우
				System.out.println("매니저 정보 업데이트 성공");
				
				// managerNo 추출
				String sqlNo = "SELECT manager_no managerNo FROM manager WHERE manager_id = ?";
				PreparedStatement stmtNo = conn.prepareStatement(sqlNo);
				stmtNo.setString(1, idIn);
				ResultSet rsNo = stmtNo.executeQuery();
				if(rsNo.next()) {
					managerNo = rsNo.getString("managerNo");
					System.out.println(managerNo + "  <--- managerNo추출성공");
					
					
					
					//!!!!!!!!!!! 수정중
					// manager_pw_history DELETE
					String sqlMHisDel = "DELETE FROM manager_pw_history WHERE manager_no= ?";
					PreparedStatement stmtMHisDel = conn.prepareStatement(sqlMHisDel);
					stmtMHisDel.setString(1, managerNo);
					int rowMHisDel = stmtMHisDel.executeUpdate(); // 삭제(업데이트) 확인
					
					if (rowMHisDel  > 0) { 	
						System.out.println("매니저 pw_history 이전정보 삭제 성공");
					}else {
						System.out.println("매니저 pw_history 이전정보 삭제 실패");
						
					}
					
					// manager_pw_history INSERT
					String SqlHis = "INSERT INTO manager_pw_history(manager_no,manager_pw,createdate)VALUES(?,?,NOW())";
					PreparedStatement stmtHis = conn.prepareStatement(SqlHis);
					stmtHis.setString(1, managerNo);	
					stmtHis.setString(2, updatePw);
					int rowHis = stmtHis.executeUpdate();	//업데이트
					if (rowHis==1) {					//업데이트 확인
						System.out.println("매니저 pw_history 입력 성공");
					}else {
						System.out.println("매니저 pw_history 입력 실패");
					}
					stmtMHisDel.close();
					stmtHis.close();
					stmtNo.close();
					rsNo.close();
					
				}
				
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
	
	
	public List<String> myPageInfo(String inId) throws Exception { // 마이페이지 상세정보
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
	
	
	
	public String deleteUser(String idIn) throws Exception  { // 계정 삭제
		
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
			String customerNo = rsCk.getString("cusromerNo");	//고객번호 추출
			
			
			// customer_pw_history DELETE
			String sqlCHisDel = "DELETE FROM customer_pw_history WHERE customer_no= ?";
			PreparedStatement stmtCHisDel = conn.prepareStatement(sqlCHisDel);
			stmtCHisDel.setString(1, customerNo);
			int rowCHisDel = stmtCHisDel.executeUpdate(); // 삭제(업데이트) 확인
			
			if (rowCHisDel  > 0) { 	
				System.out.println("고객 pw_history 삭제 성공");
			}else {
				System.out.println("고객 pw_history 삭제 실패");
				
			}
			
			
			String sqlDel1 = "DELETE A, D FROM customer_addr A INNER JOIN customer_detail D ON A.customer_no = D.customer_no  WHERE D.customer_no= ?";
			PreparedStatement stmtDel1 = conn.prepareStatement(sqlDel1);
			stmtDel1.setString(1, customerNo);		// 고객번호로 1차 정보 삭제
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
			String sqlNo = "SELECT manager_no managerNo FROM manager WHERE manager_id = ?";
			PreparedStatement stmtNo = conn.prepareStatement(sqlNo);
			stmtNo.setString(1, idIn);
			ResultSet rsNo = stmtNo.executeQuery();
			if(rsNo.next()) {
				String managerNo = rsNo.getString("managerNo");
				System.out.println(managerNo + "  <--- managerNo추출성공");
				
				
				
				//!!!!!!!!!!! 수정중
				// manager_pw_history DELETE
				String sqlMHisDel = "DELETE FROM manager_pw_history WHERE manager_no= ?";
				PreparedStatement stmtMHisDel = conn.prepareStatement(sqlMHisDel);
				stmtMHisDel.setString(1, managerNo);
				int rowMHisDel = stmtMHisDel.executeUpdate(); // 삭제(업데이트) 확인
				
				if (rowMHisDel  > 0) { 	
					System.out.println("매니저 pw_history삭제 성공");
				}else {
					System.out.println("매니저 pw_history삭제 실패");
					
				}
				
			
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
		}
		System.out.println("아이디 삭제 실패");
		conn.close();
		stmtCk.close();
		rsCk.close();
		String deleteUser="false";
		return deleteUser;
	}
}