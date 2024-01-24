package dao;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import vo.*;

public class ReviewDao {

	public String reviewIn(int ordersNo, String reviewContent, String loginId) throws Exception{
		Class.forName("org.mariadb.jdbc.Driver");
		System.out.println("드라이브 로딩성공");
		String url = "jdbc:mariadb://3.36.253.196/mall";  
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
				
				
				String sqlReviewCk = "SELECT review_content reviewContent FROM review R JOIN orders O ON R.orders_no = O.orders_no JOIN customer C ON O.customer_no = C.customer_no  WHERE R.orders_no = ? and C.customer_id = ?";
				PreparedStatement stmtReviewCk = conn.prepareStatement(sqlReviewCk);
				stmtReviewCk.setInt(1, ordersNo);
				stmtReviewCk.setString(2, loginId);
				ResultSet rsReviewCk = stmtReviewCk.executeQuery();
				if(rsReviewCk.next()) {
					System.out.println("리뷰 중복 등록 불가능");
					String result = "duplication";
					return result;
				}
				
				
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
		String url = "jdbc:mariadb://3.36.253.196/mall";  
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
	
	
	public ArrayList<ReviewOrderGoodsJoin> reviewList(int beginRow, int rowPerPage) throws Exception{
		ArrayList<ReviewOrderGoodsJoin> list = new ArrayList<>();
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://3.36.253.196/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "SELECT G.goods_title goodsTitle, R.review_no reviewNo, R.review_content reviewContent, R.orders_no ordersNo , R.createdate createdate, R.updatedate updatedate FROM review R JOIN orders O ON R.orders_no = O.orders_no JOIN goods G ON G.goods_no = O.goods_no ORDER BY R.review_no DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		list = new ArrayList<>();
		while (rs.next()) {
			
			
			ReviewOrderGoodsJoin n = new ReviewOrderGoodsJoin();
			n.setGoodsTitle(rs.getString("goodsTitle"));
		    n.setReviewNo(rs.getInt("reviewNo"));
		    n.setOrdersNo(rs.getInt("ordersNo"));
		    n.setReviewContent(rs.getString("reviewContent"));
		    n.setCreatedate(rs.getString("createdate"));
		    n.setUpdatedate(rs.getString("updatedate"));
		   
		    list.add(n); // Notice 개체를 목록에 추가합니다.
		}
		
		
		
		return list;
	}
	
	public ArrayList<ReviewOrderGoodsJoin> reviewOrdersNo(String loginId)throws Exception{
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://3.36.253.196/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		ArrayList<ReviewOrderGoodsJoin> ordersNoList = new ArrayList<>();
		 
		String sql = "SELECT O.orders_no ordersNo, G.goods_title goodsTitle FROM customer C JOIN orders O ON C.customer_no = O.customer_no JOIN goods G ON O.goods_no = G.goods_no WHERE customer_id = ? AND O.orders_state = '배송완료' ";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, loginId);
		ResultSet rs = stmt.executeQuery();
		System.out.println("주문번호 확인 완료");
			while (rs.next()) {
				ReviewOrderGoodsJoin n = new ReviewOrderGoodsJoin();
				n.setOrdersNo(rs.getInt("ordersNo"));
				n.setGoodsTitle(rs.getString("goodsTitle"));
	            
				ordersNoList.add(n);
			}
		
		System.out.println(ordersNoList);
		return ordersNoList;
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

}
