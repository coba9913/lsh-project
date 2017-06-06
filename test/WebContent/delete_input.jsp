<%@page import="boradDAO.DAO"%>
<%@page import="DbUtil.Dbutil"%>
<%@ page language="java" contentType="text/html; charset=euc-kr" %>
<%@ page import = "java.sql.*, java.util.*" %>
<% request.setCharacterEncoding("euc-kr"); %>

<%
String num = request.getParameter("num"); 
String pass = request.getParameter("pass"); 

/* Dbutil db = new Dbutil();
DAO dao = new DAO();
dao.delete(); */
Class.forName("oracle.jdbc.OracleDriver");

String url = "jdbc:oracle:thin:@dalma.dongguk.ac.kr:1521:stud2";
Connection conn = DriverManager.getConnection(url,"coba9913","coba9913");

PreparedStatement pstmt = null;
ResultSet rs = null;

String strSQL = "SELECT pass FROM board WHERE num = ?";
pstmt = conn.prepareStatement(strSQL);
pstmt.setInt(1, Integer.parseInt(num));

rs = pstmt.executeQuery();
rs.next(); 

String goodpass = rs.getString("pass").trim();
if (pass.equals(goodpass)){
	//dao.deleteAll();
	 strSQL = "DELETE From board WHERE num=?";
	pstmt = conn.prepareStatement(strSQL);
	pstmt.setInt(1, Integer.parseInt(num));
	pstmt.executeUpdate();
	
	 strSQL = "UPDATE board SET num = num - 1 WHERE num > ?";
	pstmt = conn.prepareStatement(strSQL);
	pstmt.setInt(1, Integer.parseInt(num));
	pstmt.executeUpdate();
	//dao.Update();

	response.sendRedirect("./listboard.jsp");
}else{
	response.sendRedirect("delete_pass.jsp?num=" + num);
}

 rs.close();
pstmt.close();
conn.close(); 
%>
