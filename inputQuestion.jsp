<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 

<%
String inputText = request.getParameter("newQuestion");
String questionType = request.getParameter("treatment");

  try {

Class.forName("com.mysql.jdbc.Driver").newInstance(); 

String url="jdbc:mysql://localhost:3306/mydb";
String user="root";
String pword="root";

Connection conn = DriverManager.getConnection(url, user, pword);

Statement st=conn.createStatement();

	int i=st.executeUpdate("insert into questions(questionText, suggestedTreatment)values('"+inputText+"','"+questionType+"')");
	
	response.sendRedirect("../index.html");
  }
  catch(Exception e) {
    out.println(e.getMessage());
  }
%>