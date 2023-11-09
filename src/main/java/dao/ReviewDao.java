package dao;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import vo.*;

public class ReviewDao {

	public String reviewIn(int ordersNo, String reviewContent) throws Exception{
		Class.forName("org.mariadb.jdbc.Driver");
		System.out.println("드라이브 로딩성공");
		String url = "jdbc:mariadb://localhost:3306/mall";  
		String dbuser = "root";                           
		String dbpw = "java1234";          
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sqlCk = "SELECT orders_state ordersState FROM orders WHERE orders_no = ?";
		PreparedStatement stmtCk = conn.prepareStatement(sqlCk);
		stmtCk.setInt(1, ordersNo);
		
		ResultSet rsCk = stmtCk.executeQuery();
		if(rsCk.next()) { // orders 체크 완료
			System.out.println("주문번호 입력 성공");
			String state = rsCk.getString("ordersState");
			if(state.equals("배송완료")) {	// 배송완료 체크시 리뷰작성
				System.out.println("배송완료 체크");
				String sqlReviewIn = "INSERT INTO review(orders_no,review_content,createdate,updatedate) VALUES(?,?,NOW(),NOW())"; 
				PreparedStatement stmtReviewIn = conn.prepareStatement(sqlReviewIn);
				stmtReviewIn.setInt(1, ordersNo);
				stmtReviewIn.setString(2, reviewContent);
				int rowReviewIn = stmtReviewIn.executeUpdate();	//업데이트
				if (rowReviewIn==1) {					//업데이트 확인
					System.out.println("리뷰입력성공");
					String result = "true";
					return result;
				}else {
					System.out.println("리뷰입력실패");
				}
			}
		}
		String result = "false";
		return result;
	}
	public String reviewDel(int reviewNo) throws Exception{
		Class.forName("org.mariadb.jdbc.Driver");
		System.out.println("드라이브 로딩성공");
		String url = "jdbc:mariadb://localhost:3306/mall";  
		String dbuser = "root";                           
		String dbpw = "java1234";          
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sqlDel = "DELETE FROM review WHERE review_no = ?";
		PreparedStatement stmtDel = conn.prepareStatement(sqlDel);
		stmtDel.setInt(1, reviewNo);
		int rowDel = stmtDel.executeUpdate(); // 삭제(업데이트) 확인
		
		if (rowDel  > 0) { 
			System.out.println(reviewNo +"리뷰삭제성공");
			String result = "true";
			return result ;
		}
		String result = "false";
		return result ;
	}
	
	
	public ArrayList<Review> reviewList(int beginRow, int rowPerPage) throws Exception{
		ArrayList<Review> list = new ArrayList<>();
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "SELECT review_no reviewNo, review_content reviewContent, orders_no ordersNo , createdate, updatedate FROM review LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		list = new ArrayList<>();
		while (rs.next()) {
		    Review n = new Review();
		    n.setReviewNo(rs.getInt("reviewNo"));
		    n.setOrdersNo(rs.getInt("ordersNo"));
		    n.setReviewContent(rs.getString("reviewContent"));
		    n.setCreatedate(rs.getString("createdate"));
		    n.setUpdatedate(rs.getString("updatedate"));
		   
		    list.add(n); // Notice 개체를 목록에 추가합니다.
		}
		
		
		
		return list;
	}
	public int lastPage(int total)throws Exception{
		
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
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

}
