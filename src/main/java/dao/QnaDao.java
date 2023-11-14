package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import vo.Question;
import vo.QuestionGoCustJoin;
import vo.Question_comment;

public class QnaDao {

	public ArrayList<Question> qnaList(int beginRow, int rowPerPage) throws Exception{
		ArrayList<Question> list = new ArrayList<>();
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
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
		String url = "jdbc:mariadb://localhost:3306/mall";
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
		return questionGoCustJoin;
	}
	
	public Question_comment qnaOneComment(int inputQuestionNo) throws Exception{
		Question_comment question_comment = new Question_comment();
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
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
}
