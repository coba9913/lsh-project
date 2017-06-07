<%@page import="boradBean.User"%>
<%@page import="boradDAO.DAO"%>
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.*, java.util.*"%>
<%
	request.setCharacterEncoding("euc-kr");
%>

<HTML>
<HEAD>
<TITLE>게시판</TITLE>

<SCRIPT language="JavaScript">
	function Check() {
		if (Form.keyword.value.length < 1) {
			alert("검색어를 입력하세요.");
			Form.keyword.focus();
			return false;
		}
	}
</SCRIPT>

<META http-equiv="Content-Type" content="text/html; charset=euc-kr">
<style type='text/css'>
<!--
a:link {
	font-family: "";
	color: black;
	text-decoration: none;
}

a:visited {
	font-family: "";
	color: black;
	text-decoration: none;
}

a:hover {
	font-family: "";
	color: black;
	text-decoration: underline;
}
-->
</style>

</HEAD>
<BODY>

	<%
		String key = request.getParameter("key");
		String keyword = request.getParameter("keyword");

		String pageNum = request.getParameter("pageNum");
		if (pageNum == null) {
			pageNum = "1";
		}

		int listSize = 5;
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage - 1) * listSize + 1;
		int endRow = currentPage * listSize;
		int lastRow = 0;
		int i = 0;
		String strSQL = "";

		//뭐한거야 세형아....새롭게 dao 메소드 만들지말고 여기 있는거 뽑아서 사용해라고....죽는다 진짜..
		DAO dao = new DAO();
		List list = null;

		/* Class.forName("oracle.jdbc.OracleDriver");
		String url = "jdbc:oracle:thin:@dalma.dongguk.ac.kr:1521:stud2";
		Connection conn = DriverManager.getConnection(url,"coba9913","coba9913");
		
		Statement stmt = conn.createStatement();
		ResultSet rs = null;
		
		if (key==null || keyword==null){
			strSQL = "SELECT count(*) FROM board";
		}else{
			strSQL = "SELECT count(*) FROM board WHERE " + key + " like '%" + keyword + "%'";
		}
		rs = stmt.executeQuery(strSQL);
		rs.next(); */
		lastRow = dao.count();
		//lastRow = rs.getInt(1);

		/* rs.close(); */
	%>

	<center>
		<font size='3'><b> 2012211581 이세형 게시판 </b></font>
		</TD>

		<TABLE border='0' width='600' cellpadding='0' cellspacing='0'>
			<TR>
				<TD><hr size='1' noshade></TD>
			</TR>
		</TABLE>

		<TABLE border='0' cellspacing=1 cellpadding=2 width='600'>

			<TR bgcolor='cccccc'>
				<TD><font size=2><center>
							<b>번호</b>
						</center></font></TD>
				<TD><font size=2><center>
							<b>글 제목</b>
						</center></font></TD>
				<TD><font size=2><center>
							<b>작성자</b>
						</center></font></TD>
				<TD><font size=2><center>
							<b>작성일</b>
						</center></font></TD>
				<TD><font size=2><center>
							<b>조회</b>
						</center></font></TD>
			</TR>

			<%
				if (lastRow > 0) {
					list = dao.getDBAll(startRow, endRow, key, keyword);
					Iterator it = list.iterator();
					User user;
					while (it.hasNext()) {
						user = (User) it.next();
						int listnum = user.getNum();
						String name = user.getName();
						String email = user.getEmail();
						String title = user.getTitle();
						String writedate = user.getWritedate();
						int readcount = user.getReadCount();
						/* 	if(key==null || keyword==null){
							strSQL = "SELECT * FROM board WHERE num BETWEEN " + startRow + " and " + endRow + "ORDER BY num DESC";
							rs = stmt.executeQuery(strSQL);
						} else {
							strSQL = "SELECT * FROM board WHERE " + key + " like '%" + keyword + "%' ORDER BY num DESC";
							rs = stmt.executeQuery(strSQL);
						} 
						
						for (i = 1; i < listSize; i++){			
							while(rs.next()){
						
							int listnum = rs.getInt("num");
							String name = rs.getString("name");
							String email = rs.getString("email");
							String title = rs.getString("title");
							String writedate = rs.getString("writedate");
							int readcount = rs.getInt("readcount"); */
			%>

			<TR bgcolor='ededed'>
				<TD align=center><font size=2 color='black'><%=listnum%></font></TD>
				<TD align=left><a href="write_output.jsp?num=<%=listnum%>">
						<font size=2 color="black"><%=title%></font>
				</a></TD>
				<TD align=center><a href="<%=email%>"> <font size=2
						color="black"><%=name%></font></a></TD>
				<TD align=center><font size=2><%=writedate%></font></TD>
				<TD align=center><font size=2><%=readcount%></font>
			</TR>

			<%
				/* 	 	}    
																	}	 */
					}
			%>

		</TABLE>

		<TABLE border='0' width='600' cellpadding='0' cellspacing='0'>
			<TR>
				<TD><hr size='1' noshade></TD>
			</TR>
		</TABLE>

		<%
			/* rs.close();
									stmt.close();
									conn.close(); */
			}

			if (lastRow > 0) {
				int setPage = 1;
				int lastPage = 0;
				if (lastRow % listSize == 0)
					lastPage = lastRow / listSize;
				else
					lastPage = lastRow / listSize + 1;

				if (currentPage > 1) {
		%>
		<a href="listboard.jsp?pageNum=<%=currentPage - 1%>">[이전]</a>
		<%
			}
				for (i = setPage; i <= lastPage; i++) {
					if (i == Integer.parseInt(pageNum)) {
		%>
		[<%=i%>]
		<%
			} else {
		%>
		<a href="listboard.jsp?pageNum=<%=i%>">[<%=i%>]
		</a>
		<%
			}

					if (lastPage > currentPage) {
		%>
		<a href="listboard.jsp?pageNum=<%=currentPage + 1%>">[다음]</a>
		<%
			}
				}
			}
		%>

		<TABLE border='0' width='600' cellpadding='0' cellspacing='0'>
			<TR>
				<TD><hr size='1' noshade></TD>
			</TR>
		</TABLE>

		<TABLE border=0 width=600>
			<TR>
				<TD align='center'>
					<TABLE border='0' cellpadding='0' cellspacing='0'>
						<FORM Name='Form' Method='POST' Action='listboard.jsp'
							OnSubmit='return Check()'>
							<input type='hidden' name='search' value='1'>
							<TR>
								<TD align='right'><select name='key'
									style="background-color: cccccc;">
										<option value='title' selected><font size='2'>
												글제목</font></option>
										<option value='contents'><font size='2'> 글내용</font></option>
										<option value='name'><font size='2'> 작성자</font></option>
								</select></TD>
								<TD align='left'><input type='text' name='keyword' value=''
									size='20' maxlength='30'> <input type='submit'
									value='검색'></td>
							</TR>
						</FORM>
					</TABLE>
				</TD>

				<TD align='right'><a href='write.jsp'>[등록]</a></TD>
			</TR>
		</TABLE>
</BODY>
</HTML>