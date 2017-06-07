<%@page import="boradDAO.DAO"%>
<%@ page language="java" contentType="text/html; charset=euc-kr" %>
<%@ page import = "java.sql.*, java.util.*" %>
<% request.setCharacterEncoding("euc-kr"); %>

<%
 int num  = Integer.parseInt(request.getParameter("num"));
String name = request.getParameter("name");
String pass = request.getParameter("pass");
String email = request.getParameter("email");
String title = request.getParameter("title");
String contents = request.getParameter("contents");
/*
Class.forName("oracle.jdbc.OracleDriver");

String url = "jdbc:oracle:thin:@dalma.dongguk.ac.kr:1521:stud2";
Connection conn = DriverManager.getConnection(url,"coba9913","coba9913");

PreparedStatement pstmt = null;

Calendar dateIn = Calendar.getInstance();
String indate = Integer.toString(dateIn.get(Calendar.YEAR)) + "-";
indate = indate + Integer.toString(dateIn.get(Calendar.MONTH)+1) + "-";
indate = indate + Integer.toString(dateIn.get(Calendar.DATE)) + " ";
indate = indate + Integer.toString(dateIn.get(Calendar.HOUR_OF_DAY)) + ":";
indate = indate + Integer.toString(dateIn.get(Calendar.MINUTE)) + ":";
indate = indate + Integer.toString(dateIn.get(Calendar.SECOND));

pstmt = conn.prepareStatement("UPDATE board SET name=?, pass=?, email=?, title=?, contents=?, writedate=? WHERE num=?");
pstmt.setString(1, name);
pstmt.setString(2, pass);
pstmt.setString(3, email);
pstmt.setString(4, title);
pstmt.setString(5, contents);
pstmt.setString(6, indate);
pstmt.setInt(7, num);
pstmt.executeUpdate();

pstmt.close();
conn.close(); */
DAO dao = new DAO();
dao.UpdateAll(name, pass, email, title, contents, num);
response.sendRedirect("./listboard.jsp");
%>