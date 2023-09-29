package beans;

import java.util.Hashtable;
import java.util.ArrayList;
import java.util.Enumeration;
import java.sql.*;

public class User {
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

    public boolean insertrec(String firstName, String lastName,
    String emailAddress, String companyName, String address1, String address2, String city,
    String state, String pin, String country) {
    boolean returnValue = false;
    Connection connection=null;
       try {
    	   Class.forName("com.mysql.jdbc.Driver");
 connection = DriverManager.getConnection(connectionUrl, "root", "puni123");
        Statement s = connection.createStatement();
      String sql = "INSERT INTO User" +
        " (FirstName, LastName, EmailAddress, CompanyName, Address1, Address2, City, State, Pin, Country)" +
        " VALUES" +
        " ('" + firstName + "','" + lastName + "','" + emailAddress + "'," +
        "'" + companyName + "','" + address1 + "','" + address2+ "','" + city + "','" + state + "','" + pin + "'," +
        "'" + country + "')";
      s.executeUpdate(sql);
        s.close();
       connection.close();
      returnValue = true;
    }
    catch (SQLException | ClassNotFoundException e) {
      try {
        connection.rollback();
        connection.close();
      }
      catch (SQLException se) {}
    }
    return returnValue;
  }
}
