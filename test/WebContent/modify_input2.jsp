<%@ page language="java" contentType="text/html; charset=euc-kr" %>
<%@ page import = "java.sql.*, java.util.*" %>
<% request.setCharacterEncoding("euc-kr"); %>

<%
String num = request.getParameter("num");
String pass = request.getParameter("pass");

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
	response.sendRedirect("./modify.jsp?num=" + num);
}else{
	response.sendRedirect("./modify_pass.jsp?num=" + num);
}

rs.close();
pstmt.close();
conn.close();
%>
