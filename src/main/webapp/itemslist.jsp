<%@ page session="true" %>
<%@ page import="java.sql.*" %>

<HTML>
<HEAD>
<TITLE>E-Commerce Site</TITLE>
</HEAD>
<body bgcolor="#FFFFFF" text="#000000">
<table cellpadding="6" border="0" width="750">
  <tr> 
    <td colspan=2><jsp:include page="header.jsp" flush="true" />  </td>
  </tr>
  <tr> 
    <td valign="top"><jsp:include page="menu.jsp"  flush="true" /></td>
<td valign="top" halign="left" >
<table border="1" cellpadding="3">
<tr>
 <TD><FONT FACE="Arial" SIZE="4"><B>Code</B></FONT></TD>
      <TD><FONT FACE="Arial" SIZE="4"><B>Name</B></FONT></TD>
      <TD><FONT FACE="Arial" SIZE="4"><B>Description</B></FONT></TD>
      <TD><FONT FACE="Arial" SIZE="4"><B>Price</B></FONT></TD>
<TD><FONT FACE="Arial" SIZE="4"><B>Details</B></FONT></TD>
</TR>
<%
  String categoryId = request.getParameter("category");
String sql;
if (categoryId!=null)
{
  sql = "SELECT Pcode, Pname, Description, Price from Products where CategoryID='"+categoryId+"'";
}
else
{
  sql = "SELECT Pcode, Pname, Description, Price from Products"; 
}
  try {
	  Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ecommweb","root","puni123");

    Statement s = con.createStatement();
    ResultSet rs = s.executeQuery(sql);

    while (rs.next()) {
String cd=rs.getString(1);
      out.println("<TR>");
      out.println("<TD>" + cd + "</TD>");
      out.println("<TD>" + rs.getString(2) + "</TD>");
      out.println("<TD>" + rs.getString(3) + "</TD>");
      out.println("<TD>" + rs.getString(4) + "</TD>");
 out.println("<TD><A href=ProductDetails.jsp?productid="+cd+">Details</a></TD>");
      out.println("</TR>");
    }
    rs.close();
    s.close();
    con.close();
  }
  catch (SQLException e) {
	  
	  System.out.println(e);
  }


%>
</TABLE>
</table>
</BODY>
</HTML>
