package dao;
import java.util.ArrayList;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import vo.Goods;
import vo.QuesGoManJoin;
import vo.Question;
import vo.QuestionGoCustJoin;
import vo.Question_comment;

public class QnaDao {
	public ArrayList<Question> qnaList(int beginRow, int rowPerPage) throws Exception{
		ArrayList<Question> list = new ArrayList<>();
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://3.36.253.196/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "SELECT Question_no questionNo, question_title questionTitle FROM question LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			Question q = new Question();
		    q.setQuestionNo(rs.getInt("questionNo"));
		    q.setQuestionTitle(rs.getString("questionTitle"));
		    list.add(q); 
		}
		return list;
	}

	public QuestionGoCustJoin qnaOne(QuestionGoCustJoin qnaElement) throws Exception{
		QuestionGoCustJoin questionGoCustJoin = new QuestionGoCustJoin();
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://3.36.253.196/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		String sql = "SELECT q.question_title questionTitle, q.question_content questionContent, g.goods_title goodsTitle, c.customer_id customerId, q.question_no questionNo FROM question q INNER JOIN goods g ON q.goods_no = g.goods_no INNER JOIN customer c ON q.customer_no = c.customer_no WHERE question_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnaElement.getQuestionNo());
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			questionGoCustJoin = new QuestionGoCustJoin();
			questionGoCustJoin.setQuestionTitle(rs.getString("questionTitle"));
			questionGoCustJoin.setGoodsTitle(rs.getString("goodsTitle"));
			questionGoCustJoin.setQuestionContent(rs.getString("questionContent"));
			questionGoCustJoin.setCustomerId(rs.getString("customerId"));
			questionGoCustJoin.setQuestionNo(rs.getInt("questionNo"));
			
		}
		conn.close();
		return questionGoCustJoin;
	}
	
	public Question_comment qnaOneComment(int inputQuestionNo) throws Exception{
		Question_comment question_comment = new Question_comment();
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://3.36.253.196/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "SELECT manager_no managerNo, comment FROM question_comment WHERE question_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, inputQuestionNo);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			question_comment = new Question_comment();
			question_comment.setManagerNo(rs.getInt("managerNo"));
			question_comment.setComment(rs.getString("comment"));
		}
		return question_comment;
	}
	
	public QuesGoManJoin qnaManSelect(int questionNo) throws Exception{
		QuesGoManJoin quesGoManJoin = new QuesGoManJoin();
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://3.36.253.196/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "SELECT g.goods_title goodsTitle, c.customer_id customerId, q.question_title questionTitle FROM question q INNER JOIN goods g ON q.goods_no = g.goods_no INNER JOIN customer c ON q.customer_no = c.customer_no  WHERE q.question_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, questionNo);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			quesGoManJoin = new QuesGoManJoin();
			quesGoManJoin.setGoodsTitle(rs.getString("goodsTitle"));
			quesGoManJoin.setCustomerId(rs.getString("customerId"));
			quesGoManJoin.setQuestionTitle(rs.getString("questionTitle"));
		}
		return quesGoManJoin;
	}
	
	
	public int qnaCusUpdate(String questionTitle, String questionContent, int questionNo) throws Exception{
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://3.36.253.196/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		String sql = "UPDATE question SET question_title = ?, question_content = ? , updatedate = NOW() WHERE question_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, questionTitle);
		stmt.setString(2, questionContent);
		stmt.setInt(3,  questionNo);
		System.out.println(stmt + "<-- stmt qnaCusUpdateAction");
		row = stmt.executeUpdate();
		return row;
	}
	
	public int qnaManUpdate(String comment, int questionCommentNo) throws Exception{
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://3.36.253.196/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		System.out.println("<--=-------------------------");
		System.out.println(comment+ "<--comment");
		System.out.println(questionCommentNo+ "<--questionCommentNo");


		
		String sql = "UPDATE question_comment SET comment = ? , updatedate = NOW() WHERE question_comment_no = ? ";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, comment);
		stmt.setInt(2, questionCommentNo);
		System.out.println(stmt + "<-- stmt qnaManUpdateAction");
		row = stmt.executeUpdate();
		
		return row;
	}
	public int qnaCusDelete(int questionNo) throws Exception{
		int row = 0;
		System.out.println("-----------------------"); // 이 줄을 추가
		System.out.println(questionNo + "< --- questionNo");
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://3.36.253.196/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql2 = "DELETE FROM question_comment WHERE question_no = ?";
		PreparedStatement stmt2 = conn.prepareStatement(sql2);
		stmt2.setInt(1, questionNo);
		int row2 = stmt2.executeUpdate();
		System.out.println("stmt2 전"); // 이 줄을 추가
		System.out.println(stmt2 + "< --- stmt2----------------------------------------");
		
		String sql = "DELETE FROM question WHERE question_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, questionNo);
		System.out.println(stmt + "<-- stmt qnaCusDelete");
	    int row1 = stmt.executeUpdate();

		return row;
		
	}
	
	public int qnaManDelete(int questionCommentNo) throws Exception{
		int row = 0;
		System.out.println(questionCommentNo + "< --- questionCommentNo");
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://3.36.253.196/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		String sql = "DELETE FROM question_comment WHERE question_comment_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, questionCommentNo);
		System.out.println(stmt + "<-- stmt qnaManDelete");
		row = stmt.executeUpdate();
		return row;
	}
	public Question_comment question_comment(int questionNo) throws Exception{
		
		Question_comment question_commentNo = new Question_comment();
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://3.36.253.196/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "SELECT question_comment_no, comment FROM question_comment WHERE question_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, questionNo);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			question_commentNo = new Question_comment();
			question_commentNo.setQuestionCommentNo(rs.getInt("question_comment_no"));
			question_commentNo.setQuestionCommentNo(rs.getInt("comment"));
		}
		
		return question_commentNo;
	}
	public int qnaManInsert(int questionNo, String managerId, String comment) throws Exception{
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://3.36.253.196/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		
		String sql = "SELECT manager_no FROM manager WHERE manager_id = ? ";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, managerId);
		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
		    int managerNo = rs.getInt("manager_no");
		
			String sql2 = "INSERT INTO question_comment (question_no, manager_no, comment, cratedate, updatedate) VALUES (?, ?, ?,  NOW(), NOW())";
			PreparedStatement stmt2 = conn.prepareStatement(sql2);
			stmt2.setInt(1, questionNo);
			stmt2.setInt(2, managerNo);
			stmt2.setString(3, comment);
			row = stmt2.executeUpdate();
			
			stmt2.close();
		}
		conn.close();
		stmt.close();
		rs.close();
		return row;

	}
	
	public int qnaCusInsert(String goodsTitle, String customerId, String questionTitle, String questionContent) throws Exception{
		
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://3.36.253.196/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "SELECT goods_no FROM goods WHERE goods_title = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,  goodsTitle);
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
		int goodsNo = rs.getInt("goods_no");
		
		
			String sql2 = "SELECT customer_no FROM customer WHERE customer_id = ?";
			PreparedStatement stmt2 = conn.prepareStatement(sql2);
			stmt2.setString(1, customerId);
			ResultSet rs2 = stmt2.executeQuery();
			stmt2.close();
			rs2.close();
			
			if(rs2.next()) {
				int customerNo = rs2.getInt("customer_no");
			
		
				String sql3 = "INSERT INTO question(goods_no, customer_no, question_title, question_content, createdate, updatedate) VALUES(?, ?, ?, ?, NOW(), NOW())";
				PreparedStatement stmt3 = conn.prepareStatement(sql3);
				stmt3.setInt(1, goodsNo);
				stmt3.setInt(2, customerNo);
				stmt3.setString(3, questionTitle);
				stmt3.setString(4, questionContent);
				row = stmt3.executeUpdate();
				stmt3.close();
			}
		}
				
	
		
		stmt.close();
		conn.close();
		
		rs.close();
		return row;
	}
	
	public ArrayList<Goods> goodsList(String goodsTitle) throws Exception{
	ArrayList<Goods> list = new ArrayList<>();
	Class.forName("org.mariadb.jdbc.Driver");
	String url = "jdbc:mariadb://3.36.253.196/mall";
	String dbuser = "root";
	String dbpw = "java1234";
	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
	String sql = "SELECT goods_title FROM goods";
	PreparedStatement stmt = conn.prepareStatement(sql);
	ResultSet rs = stmt.executeQuery();
	while (rs.next()) {
	    Goods goods = new Goods();
	    goods.setGoodsTitle(rs.getString("goods_title"));
	    list.add(goods);
	}

	return list;
	}


}
