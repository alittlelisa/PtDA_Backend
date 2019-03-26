<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %>


<%
HttpSession sess = request.getSession();
String id = (String)sess.getAttribute("ID");
try {
	String responses = request.getParameter("responseField");

Class.forName("com.mysql.jdbc.Driver").newInstance(); 

String url="jdbc:mysql://localhost:3306/mydb";
String user="root";
String pword="root";

Connection conn = DriverManager.getConnection(url, user, pword);


String sql = "INSERT INTO summaries(results, Users_userID, status) values ('"+responses+"','"+id+"', 'complete')";

Statement st = conn.createStatement();

int i = st.executeUpdate(sql);

response.sendRedirect("../html/summary.html");

  } catch(Exception e) {
    out.println(e.getMessage());
  }

%>