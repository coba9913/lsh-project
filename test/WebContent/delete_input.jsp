<%@page import="boradDAO.DAO"%>
<%@page import="DbUtil.Dbutil"%>
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*"%>
<%
	request.setCharacterEncoding("euc-kr");
%>

<%
	String num = request.getParameter("num");
	String pass = request.getParameter("pass");

	DAO dao = new DAO();

	String goodpass = dao.goodpass(num);
	if (pass.equals(goodpass)) {
		dao.delete(num);
		response.sendRedirect("./listboard.jsp");
	} else {
		response.sendRedirect("delete_pass.jsp?num=" + num);
	}
%>
