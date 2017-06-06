<%@ page language="java" contentType="text/html; charset=euc-kr" %>
<%@ page import = "java.sql.*, java.util.*" %>
<% request.setCharacterEncoding("euc-kr"); %>

<HTML>
<HEAD>
<TITLE> 게시판 </TITLE>

<SCRIPT language="JavaScript">
function Check()
{
if (Modify.name.value.length < 1) {
	alert("작성자를 입력하세요.");
	Modify.name.focus(); 
        return false;
	}

if (Modify.pass.value.length < 1) {
	alert("비밀번호를 입력하세요.");
	Modify.pass.focus(); 
	return false;
	}

if (Modify.email.value.indexOf("@") + "" == "-1" ||
	Modify.email.value.indexOf(".") + "" == "-1" ||
	Modify.email.value == "" )
	{ 
		alert("E-mail을 입력하세요.");
		Modify.email.focus();
		return false;
	}

if (Modify.title.value.length < 1) {
	alert("글제목을 입력하세요.");
	Modify.title.focus(); 
	return false;
        }

if (Modify.contents.value.length < 1) {
	alert("글내용을 입력하세요.");
	Modify.contents.focus(); 
	return false;
        }

Modify.submit();
}

function list()
{
location.href = "listboard.asp";
}

</SCRIPT>
</HEAD>

<BODY>

<%
String num = request.getParameter("num"); 

Class.forName("oracle.jdbc.OracleDriver");

String url = "jdbc:oracle:thin:@dalma.dongguk.ac.kr:1521:stud2";
Connection conn = DriverManager.getConnection(url,"coba9913","coba9913");

PreparedStatement pstmt = null;
ResultSet rs = null;

try {

String strSQL = "SELECT * FROM board WHERE num = ?";
pstmt = conn.prepareStatement(strSQL);
pstmt.setInt(1, Integer.parseInt(num));

rs = pstmt.executeQuery();
rs.next();

String title = rs.getString("title");

%>
                   
<center><font size='3'><b> 답변하기 </b></font>                  

<TABLE border='0' width='600' cellpadding='0' cellspacing='0'>
	<TR>
		<TD><hr size='1' noshade>
		</TD>
 	</TR>
</TABLE>
                 
<FORM Name='Modify' Action='reply_input.jsp' Method='POST' OnSubmit='return Check()'>
<input type='hidden' name='num' value='<%=num %>'>
      
<TABLE border='0' width='600'>
	<TR>
		<TD width='100' bgcolor='cccccc'>
			<font size='2'><center><b>작성자</b></center></font> 
		</TD>
		<TD>
			<p><input type='text' size='12' name='name' value=""> * 필수 </p>
		</TD>
	</TR>

	<TR>
		<TD width='100' bgcolor='cccccc'>
			<font size='2'><center><b>비밀번호</b></center></font>
		</TD>
		<TD>
			<p><input type='password' size='12' name='pass'> * 필수 </p>
		</TD>
	</TR>

	<TR>
		<TD width='100' bgcolor='cccccc'>
			<font size='2'><center><b>E-mail</b></center></font>
		</TD>
		<TD>
			<font size='2'><input type='text' size='40' maxlength='50' name='email' value=""></font>
		</TD>
	</TR>
	
	<TR>
      		<TD colspan='2'>
         		<hr size='1' noshade>
      		</TD>
	</TR>

	<TR>
		<TD width='100' bgcolor='cccccc'>
			<font size='2'><center><b>글 제목</b></center></font>
		</TD>
		<TD>
			<font size='2'><input type='text' size='70' maxlength='50' name='title' value="[답변]<%=title %>"></font>
		</TD>
	</TR>

	<TR>
		<TD bgcolor='cccccc'>
			<font size='2'><center><b>글 내용</b></center></font>
		</TD>
		<TD>
         		<font size='2'>
         		<textarea cols='70' rows='15' wrap='virtual' name='contents'></textarea>
         		</font>
      		</TD>
	</TR>
	
	<TR>
		<TD colspan='2'><hr size='1' noshade></TD>
	</TR>

	<TR>
		<TD align='center' colspan='2' width='100%'>
		<TABLE>
			<TR>
				<TD width='200' align='center'>
					<input Type = 'Reset' Value = '다시 작성'>
				</TD>
				<TD width='200' align='center'>
					<input Type = 'Submit' Value = '완료'>
				</TD>
				<TD width='200' align='center'>
					<input Type = 'Button' Value = '목록' Name='Page' onClick='list();'>
				</TD>
			</TR>
		</TABLE>
		</TD>
	</TR>
   
</TABLE>

<%
}catch(SQLException e){
   	out.print("SQL에러 " + e.toString());
}catch(Exception ex){
   	out.print("JSP에러 " + ex.toString());
}finally{  
	rs.close();
	pstmt.close();
	conn.close();
}
%>

</BODY>
</HTML>


