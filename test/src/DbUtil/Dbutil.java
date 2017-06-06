package DbUtil;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Dbutil {

	public static Connection getOracleConnection(){
		String url = "jdbc:oracle:thin:@dalma.dongguk.ac.kr:1521:stud2";
		String user = "coba9913";
		String password = "coba9913";
		Connection conn = null;
		try{
			Class.forName("oracle.jdbc.OracleDriver");
			conn = DriverManager.getConnection(url, user, password);
		}catch(ClassNotFoundException e){
			
		}catch(SQLException e){
			
		}
		return conn;
	}
	
}
