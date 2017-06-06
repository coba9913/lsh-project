package boradDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import DbUtil.Dbutil;
import boradBean.User;

public class DAO {

	Dbutil db = null;
	String sql = "";
	
	public DAO() {
		db = new Dbutil();
	}
	//전체 글의 갯수
	public int count(){
		int cnt = 0;
		Connection conn = db.getOracleConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try{
			sql = "select count (*) from board";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
		}catch(Exception e){
			
		}
		return cnt;
	}
	//num에 따른 글 번호의 정보
	public void write(String num){
		Connection conn = db.getOracleConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		User user = null;
		try{
			sql = "select * from board where num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				user = new User();
				user.setNum(rs.getInt(1));
				user.setName(rs.getString(2));
				user.setPass(rs.getString(3));
				user.setEmail(rs.getString(4));
				user.setTitle(rs.getString(5));
				user.setContents(rs.getString(6));
				user.setWritedate(rs.getString(7));
				user.setReadCount(rs.getInt(8));
			}
		}catch(SQLException e){
			
		}
	}
	//글 삽입
	public void insertBoard(ArrayList<User> list) {
		User user = new User();
		Connection conn = db.getOracleConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			sql = "INSERT INTO board(num, name, pass, email, title, contents, writedate, readcount)";
			pstmt.setInt(1, user.getNum());
			pstmt.setString(2, user.getName());
			pstmt.setString(3, user.getPass());
			pstmt.setString(4, user.getEmail());
			pstmt.setString(5, user.getTitle());
			pstmt.setString(6, user.getContents());
			pstmt.setString(7, user.getWritedate());
			pstmt.setInt(8, user.getReadCount());
			pstmt.executeQuery();
		} catch (SQLException e) {

		}
	}
	//저장된 글의 비밀번호 찾기
	public void 

}
