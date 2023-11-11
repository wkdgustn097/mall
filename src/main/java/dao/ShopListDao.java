package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import vo.Gijoin;
import vo.GoodsReviewCountJoin;
import vo.GoodsSuccess;
import vo.Goods_img;

public class ShopListDao {
	
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
	
	
	public Gijoin insertShopGoods(String goodsTitle, String goodsPrice, String goodsMemo, String fileName, String originName, String contentType) throws Exception{
		Gijoin gijoin = new Gijoin();
		//Driver 설정
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall" ;
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);

		String sql = "INSERT INTO goods (goods_title, goods_price, soldout, goods_memo, createdate, updatedate) values (?, ?, 'N', ?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS); 
		stmt.setString(1, goodsTitle);
		stmt.setString(2, goodsPrice);
		stmt.setString(3, goodsMemo);
		
		int row1 = stmt.executeUpdate();
		ResultSet rs = stmt.getGeneratedKeys();
		
		int goodsNo = 0;
		if(rs.next()){
			goodsNo = rs.getInt(1);
			System.out.println(goodsNo);
		   }
		
		String sql1 = "INSERT INTO goods_img (goods_no, filename, origin_name, content_type, createdate, updatedate) values (?, ? ,?, ?, NOW(), NOW())";
		PreparedStatement stmt1 = conn.prepareStatement(sql1); 
		stmt1.setInt(1, goodsNo);
		stmt1.setString(2, fileName);
		stmt1.setString(3, originName);
		stmt1.setString(4, contentType);
		int row2 = stmt1.executeUpdate();
		
		//db자원을 반납
		stmt1.close();
		rs.close();
		stmt.close();
		conn.close();
		
		
		
		return gijoin;
	}
	
	
	public Gijoin selectShopUpdateList(Gijoin inputGijoin) throws Exception{
		Gijoin gijoin = null;
		System.out.println(inputGijoin.getGoodsNo()+"<--inputGijoin");
		Class.forName("org.mariadb.jdbc.Driver");
		System.out.println("드라이브 로딩성공");
		String url = "jdbc:mariadb://localhost:3306/mall";  
		String dbuser = "root";                           
		String dbpw = "java1234";          
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "SELECT g.goods_no goodsNo, goods_title goodsTitle, goods_price goodsPrice, soldout, goods_memo goodsMemo, g.createdate createdate, g.updatedate updatedate, origin_name originName, filename FROM goods g INNER JOIN goods_img gi on g.goods_no = gi.goods_no WHERE g.goods_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1,inputGijoin.getGoodsNo());
		System.out.println(stmt  + "<--stmt");
		ResultSet rs = stmt.executeQuery(); 
		if(rs.next()) {
			gijoin = new Gijoin();
			gijoin.setGoodsNo(rs.getInt("goodsNo"));
			gijoin.setGoodsTitle(rs.getString("goodsTitle"));
			gijoin.setGoodsPrice(rs.getInt("goodsPrice"));
			gijoin.setSoldout(rs.getString("soldout"));
			gijoin.setGoodsMemo(rs.getString("goodsMemo"));
			gijoin.setCreatedate(rs.getString("createdate"));
			gijoin.setUpdatedate(rs.getString("updatedate"));
			gijoin.setOriginName(rs.getString("originName"));
			gijoin.setFilename(rs.getString("filename"));
		}
		System.out.println(gijoin.getGoodsTitle() + "<----gijoin");
		rs.close();
		stmt.close();
		conn.close();
		return gijoin;
	}
	
	
	public GoodsSuccess updateShopGoods(String goodsTitle, String goodsPrice, String goodsMemo, int goodsNo) throws Exception{
		GoodsSuccess goodsSuccess = new GoodsSuccess();
		Class.forName("org.mariadb.jdbc.Driver");
		System.out.println("드라이브 로딩성공");
		String url = "jdbc:mariadb://localhost:3306/mall";  
		String dbuser = "root";                           
		String dbpw = "java1234";          
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		conn.setAutoCommit(false);
		
		String sql = "UPDATE goods SET goods_title = ?, goods_price = ?, goods_memo = ?, updatedate = NOW() WHERE goods_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, goodsTitle);
		stmt.setString(2, goodsPrice);
		stmt.setString(3, goodsMemo);
		stmt.setInt(4, goodsNo);
		System.out.println(stmt + "<--stmt");
		int row = stmt.executeUpdate();		
		System.out.println(row + "<--row");
		if(row != 1) {
			conn.rollback();
			stmt.close();
			conn.close();
			goodsSuccess.setSuccess("실패");
			System.out.println("----------------실패-------------");
			return goodsSuccess;
		}
		conn.commit();
		stmt.close();
		conn.close();
		return goodsSuccess;
	}
	
	public Goods_img updateShopGoodsImage(String originName, String filename, String contentType, int goodsNo) throws Exception{
		Goods_img goods_img = new Goods_img();
		Class.forName("org.mariadb.jdbc.Driver");
		System.out.println("드라이브 로딩성공");
		String url = "jdbc:mariadb://localhost:3306/mall";  
		String dbuser = "root";                           
		String dbpw = "java1234";          
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		conn.setAutoCommit(false);
		
		String sql = "UPDATE goods_img SET filename = ?, origin_name = ?, content_type = ?, updatedate = NOW() WHERE goods_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, filename);
		stmt.setString(2, originName);
		stmt.setString(3, contentType);
		stmt.setInt(4, goodsNo);
		System.out.println(stmt + "<--stmt");
		
		
		int row = stmt.executeUpdate();
		System.out.println(row + "<--row");
		if(row != 1) {
			conn.rollback();
			stmt.close();
			conn.close();
			System.out.println("----------------실패-------------");
			return goods_img;
		}
		conn.commit();
		stmt.close();
		conn.close();
		return goods_img;
	}
	
	
	public String deleteShopGoods(int goodsNo) throws Exception{
		String name = null;
		Class.forName("org.mariadb.jdbc.Driver");
		System.out.println("드라이브 로딩성공");
		String url = "jdbc:mariadb://localhost:3306/mall";  
		String dbuser = "root";                           
		String dbpw = "java1234";          
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		conn.setAutoCommit(false);
		
		// 삭제할 image의 filename 호출 
		String sql = "SELECT filename FROM goods_img WHERE goods_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, goodsNo);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			name = rs.getString("filename");
		}
		
		// goods_img 의 goods_no 삭제 
		String sql1 = "DELETE FROM goods_img WHERE goods_no = ?";
		PreparedStatement stmt1 = conn.prepareStatement(sql1);
		stmt1.setInt(1, goodsNo);
		int row1 = stmt1.executeUpdate();
		
		// 여기서 부터 goods_no를 FK를 사용하고 있는 컬럼들 삭제 
		
		// cart 삭
		String sql2 = "DELETE FROM cart WHERE goods_no = ?";
		PreparedStatement stmt2 = conn.prepareStatement(sql2);
		stmt2.setInt(1, goodsNo);
		int row2 = stmt2.executeUpdate();
		
		int ordersNo = 0;
		
		
		// order_no 호출 / order를 삭제하기 위해서 order_no를 FK로 쓰고 있는 review부터 삭제 
		String sql3 = "SELECT orders_no FROM orders WHERE goods_no = ?";
		PreparedStatement stmt3 = conn.prepareStatement(sql3);
		stmt3.setInt(1, goodsNo);
		ResultSet rs1 = stmt3.executeQuery();
		if(rs.next()) {
			ordersNo = rs1.getInt("orders_no");
		}
		
		String sql4 = "DELETE FROM review WHERE orders_no = ?";
		PreparedStatement stmt4 = conn.prepareStatement(sql4);
		stmt4.setInt(1, ordersNo);
		int row4 = stmt4.executeUpdate();

		String sql5 = "DELETE FROM orders WHERE goods_no = ?";
		PreparedStatement stmt5 = conn.prepareStatement(sql5);
		stmt5.setInt(1, goodsNo);
		int row5 = stmt5.executeUpdate();

		// question_no 호출 / question를 삭제하기 위해서 question_no를 FK로 쓰고 있는 question_comment부터 삭제 

		int questionNo = 0;
		
		String sql6 = "SELECT question_no FROM question WHERE goods_no = ?";
		PreparedStatement stmt6 = conn.prepareStatement(sql6);
		stmt6.setInt(1, goodsNo);
		ResultSet rs6 = stmt6.executeQuery();
		if(rs.next()) {
			questionNo = rs6.getInt("question_no");
		}
		
		String sql7 = "DELETE FROM question_comment WHERE question_no = ?";
		PreparedStatement stmt7 = conn.prepareStatement(sql7);
		stmt7.setInt(1, questionNo);
		int row7 = stmt7.executeUpdate();
		
		String sql8 = "DELETE FROM question WHERE goods_no = ?";
		PreparedStatement stmt8 = conn.prepareStatement(sql8);
		stmt8.setInt(1, goodsNo);
		int row8 = stmt8.executeUpdate();

		
		// 연결된 FK삭제 후 goods 삭제 
		String sql9 = "DELETE FROM goods WHERE goods_no = ?";
		PreparedStatement stmt9 = conn.prepareStatement(sql9);
		stmt9.setInt(1, goodsNo);
		int row9 = stmt9.executeUpdate();
		if(row9==1) {
			conn.commit();
		} else {
			conn.rollback();
		}
		
		conn.close();
		stmt.close();
		rs.close();
		conn.close();
		stmt1.close();
		rs1.close();
		stmt2.close();
		stmt3.close();
		rs6.close();
		stmt4.close();
		stmt5.close();
		stmt6.close();
		stmt7.close();
		stmt8.close();
		stmt9.close();

		return name;
	}
	
	public ArrayList<GoodsReviewCountJoin> goodsReviewSelect() throws Exception{
		ArrayList<GoodsReviewCountJoin> list = new ArrayList<GoodsReviewCountJoin>();
		Class.forName("org.mariadb.jdbc.Driver");
		System.out.println("드라이브 로딩성공");
		String url = "jdbc:mariadb://localhost:3306/mall";  
		String dbuser = "root";                           
		String dbpw = "java1234";          
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "SELECT\n"
				+ "    r.orders_no ordersNo,\n"
				+ "    g.goods_no goodsNo,\n"
				+ "    g.goods_title goodsTitle,\n"
				+ "    g.goods_price goodsPrice,\n"
				+ "    gi.filename filename,\n"
				+ "    COUNT(r.orders_no) AS orders_count\n"
				+ "FROM\n"
				+ "    review r\n"
				+ "JOIN\n"
				+ "    orders o ON r.orders_no = o.orders_no\n"
				+ "JOIN\n"
				+ "    goods g ON o.goods_no = g.goods_no\n"
				+ "JOIN\n"
				+ "    goods_img gi ON g.goods_no = gi.goods_no\n"
				+ "GROUP BY\n"
				+ "    r.orders_no, g.goods_title, g.goods_price, gi.filename\n"
				+ "ORDER BY\n"
				+ "    orders_count DESC\n"
				+ "\n"
				+ " LIMIT 0,7";
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println(stmt + "<-- stmt-------------");
		ResultSet rs = stmt.executeQuery(); 
		list = new ArrayList<>();
		while(rs.next()) {
			GoodsReviewCountJoin g = new GoodsReviewCountJoin();
			g.setGoodsNo(rs.getInt("goodsNo"));
			g.setGoodsTitle(rs.getString("goodsTitle"));
			g.setGoodsPrice(rs.getInt("goodsPrice"));
			g.setFilename(rs.getString("Filename"));
			list.add(g);
		}
		rs.close();
		stmt.close();
		conn.close();
		return list;
	}
	
}