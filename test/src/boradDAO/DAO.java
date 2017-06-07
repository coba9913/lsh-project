package boradDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import DbUtil.Dbutil;
import DbUtil.JdbcUtil;
import boradBean.User;

public class DAO { // �떂�븘 �젣諛� close醫� �븯�옄 �떂 �븣臾몄뿉 DB 留됲엺嫄곗��꽕....�븯...1

	Dbutil db = null;
	JdbcUtil jdbc = null;
	User user = null;
	String sql = "";
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	public DAO() {
		db = new Dbutil();
		jdbc = new JdbcUtil();
	}

	public int count() {
		int cnt = 0;
		conn = db.getOracleConnection();
		try {
			sql = "select count (*) from board";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				cnt = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			jdbc.close(rs);
			jdbc.close(pstmt);
			jdbc.close(conn);
		}
		return cnt;
	}

	public List getDBAll(int startRow, int endRow, String key, String keyword) {
		List list = new ArrayList();
		conn = db.getOracleConnection();
		try {
			if (key == null || keyword == null) {
				sql = "SELECT * FROM board  WHERE num BETWEEN ? and ?" + "ORDER BY num DESC";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, endRow);
			} else {
				sql = "SELECT * FROM board WHERE " + key + " like ? ORDER BY num DESC";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, "%" + keyword + "%");
			}
			rs = pstmt.executeQuery();
			while (rs.next()) {
				User user = new User();
				user.setNum(rs.getInt("num"));
				user.setName(rs.getString("name"));
				user.setPass(rs.getString("pass"));
				user.setEmail(rs.getString("email"));
				user.setTitle(rs.getString("title"));
				user.setContents(rs.getString("contents"));
				user.setWritedate(rs.getString("writedate"));
				user.setReadCount(rs.getInt("readcount"));
				list.add(user);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			jdbc.close(rs);
			jdbc.close(pstmt);
			jdbc.close(conn);
		}
		return list;
	}

	public void getDeleteAll(int num, String pass, String goodpass) {
		conn = db.getOracleConnection();
		try {
			if (pass.equals(goodpass)) {
				sql = "DELETE From board WHERE num=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.executeUpdate();

				sql = "UPDATE board SET num = num - 1 WHERE num > ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.executeUpdate();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			jdbc.close(rs);
			jdbc.close(pstmt);
			jdbc.close(conn);
		}
	}

	public String getPass(String num) {
		String pass = "";
		conn = db.getOracleConnection();
		try {
			sql = "select pass from board where num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				pass = rs.getString(2);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			jdbc.close(rs);
			jdbc.close(pstmt);
			jdbc.close(conn);
		}
		return pass;
	}
	
	public void UpdateAll(String name, String pass, String email, String title, String contents, int num) {
		conn = db.getOracleConnection();
		Calendar dateIn = Calendar.getInstance();
		String indate = Integer.toString(dateIn.get(Calendar.YEAR)) + "-";
		indate = indate + Integer.toString(dateIn.get(Calendar.MONTH) + 1) + "-";
		indate = indate + Integer.toString(dateIn.get(Calendar.DATE)) + " ";
		indate = indate + Integer.toString(dateIn.get(Calendar.HOUR_OF_DAY)) + ":";
		indate = indate + Integer.toString(dateIn.get(Calendar.MINUTE)) + ":";
		indate = indate + Integer.toString(dateIn.get(Calendar.SECOND));
		try {
			sql = "UPDATE board SET name=?, pass=?, email=?, title=?, contents=?, writedate=? WHERE num=?";
			pstmt.setString(1, name);
			pstmt.setString(2, pass);
			pstmt.setString(3, email);
			pstmt.setString(4, title);
			pstmt.setString(5, contents);
			pstmt.setString(6, indate);
			pstmt.setInt(7, num);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			jdbc.close(rs);
			jdbc.close(pstmt);
			jdbc.close(conn);
		}
		
	}

	public List lineMemo(String num) {
		conn = db.getOracleConnection();
		List list = new ArrayList();
		try {
			sql = "select * from board where num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				user = new User();
				user.setNum(rs.getInt("num"));
				user.setName(rs.getString("name"));
				user.setPass(rs.getString("pass"));
				user.setEmail(rs.getString("email"));
				user.setTitle(rs.getString("title"));
				user.setContents(rs.getString("contents"));
				user.setWritedate(rs.getString("writedate"));
				user.setReadCount(rs.getInt("readCount"));
				list.add(user);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			jdbc.close(rs);
			jdbc.close(pstmt);
			jdbc.close(conn);
		}
		return list;
	}

	public void 
	/*public void insertBoard(ArrayList<User> list) {
		user = new User();
		conn = db.getOracleConnection();
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
			e.printStackTrace();
		} finally {
			jdbc.close(pstmt);
			jdbc.close(conn);
		}
	}
*/
}
