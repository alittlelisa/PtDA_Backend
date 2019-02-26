<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 
<%
HttpSession sess = request.getSession();
String id = (String)sess.getAttribute("ID");
try {
	
	String q1 = request.getParameter("response1");
	String q2 = request.getParameter("response2");
	String q3 = request.getParameter("response3");
	String q4 = request.getParameter("response4");
	String q5 = request.getParameter("response5");

Class.forName("com.mysql.jdbc.Driver").newInstance(); 

String url="jdbc:mysql://localhost:3306/mydb";
String user="root";
String pword="root";

Connection conn = DriverManager.getConnection(url, user, pword);


String sql = "INSERT INTO summaries(result_1, result_2, result_3, result_4, result_5, Users_userID, status) values ('"+q1+"','"+q2+"','"+q3+"','"+q4+"','"+q5+"','"+id+"', 'complete')";

Statement st = conn.createStatement();

int i = st.executeUpdate(sql);

response.sendRedirect("../html/summary.html");

  } catch(Exception e) {
    out.println(e.getMessage());
  }

%>