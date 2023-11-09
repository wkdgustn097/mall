package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import vo.Gijoin;

public class ShopOneListDao {
	
	public Gijoin selectShopOneList(Gijoin inputGijoin) throws Exception{
		Gijoin gijoin = null;
		System.out.println(inputGijoin.getGoodsNo()+"<--inputGijoin");
		Class.forName("org.mariadb.jdbc.Driver");
		System.out.println("드라이브 로딩성공");
		String url = "jdbc:mariadb://localhost:3306/mall";  
		String dbuser = "root";                           
		String dbpw = "java1234";          
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "SELECT g.goods_no goodsNo, goods_title goodsTitle, goods_price goodsPrice, soldout, goods_memo goodsMemo, g.createdate createdate, g.updatedate updatedate, origin_name originName FROM goods g INNER JOIN goods_img gi on g.goods_no = gi.goods_no WHERE g.goods_no = ?";
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
		}
		rs.close();
		stmt.close();
		conn.close();
		return gijoin;
	}

}
