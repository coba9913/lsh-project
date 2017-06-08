package boradDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import DbUtil.Dbutil;
import DbUtil.JdbcUtil;
import boradBean.User;

public class DAO { // 님아 제발 close좀 하자 님 때문에 DB 막힌거였네....하...1

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

	public void write(String num) {
		conn = db.getOracleConnection();
		try {
			sql = "select * from board where num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num);
			rs = pstmt.executeQuery();

			if (rs.next()) {
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
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			jdbc.close(rs);
			jdbc.close(pstmt);
			jdbc.close(conn);
		}
	}

	public void insertBoard(ArrayList<User> list) {
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

	public String goodpass(String num) {
		conn = db.getOracleConnection();
		String pass = null;
		try {
			sql = "SELECT pass FROM board WHERE num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(num));

			rs = pstmt.executeQuery();
			rs.next();

			pass = rs.getString("pass").trim();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			jdbc.close(rs);
			jdbc.close(pstmt);
			jdbc.close(conn);
		}
		return pass;
	}

	public void delete(String num) {
		try {
			sql = "DELETE From board WHERE num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(num));
			pstmt.executeUpdate();

			sql = "UPDATE board SET num = num - 1 WHERE num > ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(num));
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			jdbc.close(rs);
			jdbc.close(pstmt);
			jdbc.close(conn);
		}
	}


}
