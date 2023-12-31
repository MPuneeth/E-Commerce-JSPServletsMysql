package beans;

import java.sql.*;

public class ProductBean {
  public String UserName = "";
  public String Password = "";
  public String connectionUrl = "";

  public void setconnectionUrl(String url) {
    connectionUrl = url;
  }

  public void setUserName(String username) {
    UserName = username;
  }
  public void setPassword(String password) {
    Password = password;
  }

  public String getconnectionUrl() {
    return connectionUrl;
  }

public String getUserName() {
    return UserName;
  }

public String getPassword() {
    return Password;
  }

    public Product getProductDetails(int productId) {
    Product product = null;
    try {
    	
			Class.forName("com.mysql.jdbc.Driver");
		
      Connection connection = DriverManager.getConnection(connectionUrl, "root", "puni123");
      Statement s = connection.createStatement();
      String sql = "SELECT Pcode, Pname, Description, Price , Category FROM Products" +
        " WHERE Pcode=" + productId;
      ResultSet rs = s.executeQuery(sql);
      if (rs.next()) {
        product = new Product();
        product.code = rs.getInt(1);
        product.name = rs.getString(2);
        product.description = rs.getString(3);
        product.price = rs.getDouble(4);
        product.category = rs.getString(5);
      }
      rs.close();
      s.close();
      connection.close();
    }
    catch (SQLException | ClassNotFoundException e) {}
    return product;
  }

  
}
