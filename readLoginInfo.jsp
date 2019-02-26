<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 

<%
String email = request.getParameter("email");
String password = request.getParameter("psw");

  try {

Class.forName("com.mysql.jdbc.Driver").newInstance(); 

String url="jdbc:mysql://localhost:3306/mydb";
String user="root";
String pword="root";

Connection conn = DriverManager.getConnection(url, user, pword);


String sql = "SELECT * FROM users WHERE userEmail = ? AND userPassword = ?";

PreparedStatement ps = conn.prepareStatement(sql);
ps.setString(1, email);
ps.setString(2, password);

ResultSet rs = ps.executeQuery();

if(!rs.next())
{
	out.println("Incorrect username or password");
}

else
{
	response.sendRedirect("../index.html");
}
  } catch(Exception e) {
    out.println(e.getMessage());
  }
%>
