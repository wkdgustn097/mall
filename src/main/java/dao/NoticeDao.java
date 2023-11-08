package dao;
import java.util.ArrayList;
import vo.Notice;
import java.sql.*;

public class NoticeDao {
	
	public int lastPage(int total)throws Exception{
		
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "SELECT count(*) FROM notice";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			row = rs.getInt("count(*)");
		}
		
		
		return row;
	}

	
	
	// 호출: updateNoticeAction.jsp
	public int updateNoticeAction (Notice notice) throws Exception{
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		String sql = "UPDATE notice SET notice_title = ?, notice_content = ?, updatedate = NOW() WHERE notice_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,notice.getNoticeTitle());
		stmt.setString(2,notice.getNoticeContent());
		stmt.setInt(3, notice.getNoticeNo());
		System.out.println(stmt + "<-- stmt updateNoticeAction()");
		row = stmt.executeUpdate();
		return row;
	}
	
	// 호출 : updateNoticeForm.jsp

	
	
	// 호출 : deleteNoticeAction.jsp
	public int deleteNoticeAction (Notice notice) throws Exception{
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		String sql = "DELETE from notice where notice_no = ? and manager_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1,notice.getNoticeNo());
		stmt.setInt(2, notice.getManagerNo());
		System.out.println(stmt + "<-- stmt deleteNoticeAction()");
		row = stmt.executeUpdate();
		return row;
	}
	

	// 호출: insertNoticeAction.jsp
	public int insertNoticeAction(Notice notice) throws Exception{
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		String sql = "INSERT INTO notice(manager_no, notice_title, notice_content, createdate, updatedate) VALUES (?, ?, ?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, notice.getManagerNo());
		stmt.setString(2, notice.getNoticeTitle());
		stmt.setString(3, notice.getNoticeContent());
		System.out.println(stmt + "<-- stmt insertNoticeAction()");
		row = stmt.executeUpdate();
		return row;
	}
	
	// 호출: noticeList.jsp
	public ArrayList<Notice> noticeList(int beginRow, int rowPerPage) throws Exception{
		ArrayList<Notice> list = new ArrayList<>();
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "SELECT notice_no noticeNo, manager_no managerNo, notice_title noticeTitle, notice_content noticeContent, createdate, updatedate from notice LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		list = new ArrayList<>();
		while (rs.next()) {
		    Notice n = new Notice();
		    n.setNoticeNo(rs.getInt("noticeNo"));
		    n.setManagerNo(rs.getInt("managerNo"));
		    n.setNoticeTitle(rs.getString("noticeTitle"));
		    n.setNoticeContent(rs.getString("noticeContent"));
		    n.setCreatedate(rs.getString("createdate"));
		    n.setUpdatedate(rs.getString("updatedate"));
		    list.add(n); // Notice 개체를 목록에 추가합니다.
		}

		
		
		return list;
	}
	
}
