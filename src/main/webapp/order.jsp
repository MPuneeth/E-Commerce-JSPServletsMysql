<%@ page import="java.util.Hashtable" %>
<%@ page import="beans.ShoppingItem" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="java.sql.*" %>
<% 
  //try {
   // Class.forName("com.mysql.jdbc.Driver");
    //Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/ecommweb","root","puni123");
  //  }
  //catch (ClassNotFoundException e) {
  //  System.out.println(e.toString());
 // }
%>
<HTML>
<HEAD>
<TITLE>E-commerce Site</TITLE>
</HEAD>
<BODY bgcolor="#FFFFFF" text="#000000">
<TABLE cellpadding="6" border="0" width="750">
<TR>
  <TD COLSPAN=2><jsp:include page="header.jsp" flush="true"/></TD>
</TR>
<TR>
  <TD><jsp:include page="menu.jsp" flush="true"/></TD>
  <TD VALIGN="TOP">
<%
String contactName=request.getParameter("contactName");
String deliveryAddress =  request.getParameter("deliveryAddress");
String ccName= request.getParameter("ccName");
String  ccNumber =  request.getParameter("ccNumber");
String ccExpiryDate =   request.getParameter("ccExpiryDate");
Hashtable shoppingCart =   (Hashtable) session.getAttribute("shoppingCart");
 long orderId = System.currentTimeMillis();
Connection con = null;

  try {
	  
	  Class.forName("com.mysql.jdbc.Driver");
	  con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ecommweb","root","puni123");

String sql;
sql = "INSERT INTO Orders" +
        " (OrderId, ContactName, DeliveryAddress, CreditCardName, CreditCardNumber, CreditCardExpiryDate)" +
        " VALUES" + 
        "(" + orderId + ",'" + contactName + "','" + deliveryAddress + "'," +
        "'" + ccName + "','" + ccNumber + "','" + ccExpiryDate + "')";

Statement s = con.createStatement();
    s.executeUpdate(sql);
      // now insert items into OrderDetails table
      Enumeration enu = shoppingCart.elements();
    while (enu.hasMoreElements()) {
    ShoppingItem item = (ShoppingItem) enu.nextElement();
 sql = "INSERT INTO OrderDetails (OrderId, ProductId, Quantity, Price)" +
     " VALUES (" + orderId + "," + item.productcode + "," +
     item.quantity + "," + item.price + ")";
     s.executeUpdate(sql);
     
     
     
      }
    out.println("Thank you for your purchase");
    out.println("<br/> <br/>");		
   // out.println("You have ordered as below: ");
   // out.println("<br/> <br/>");
    out.println("Order ID is : " +orderId);
    out.println("<br/> <br/>");
    //out.println("Order ID is : " +ProductId);
    //out.println("<br/> <br/>");
    //out.println("Product ID is : " +item.productcode+ "Quantity is :" +item.quantity+ "Price is ;" +item.price);
   // out.println("<br/> <br/>");
    //out.println("Category is : " +item.category);
    //out.println("<br/> <br/>");
    
   // int p = (int)Math.round(item.price);
   // int newprice = item.quantity*p;
    //out.println("Total Price is : " +newprice);
    s.close();
      con.commit();
      con.close();
      
     
session.invalidate();

 }
  catch (SQLException e) {
  }
  catch (Exception e) {
  }

%>
  </TD>
</TR>
</TABLE>
</BODY>
</HTML>
