<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 

<%
HttpSession sess = request.getSession();
String userID = (String)sess.getAttribute("ID");

  try {

Class.forName("com.mysql.jdbc.Driver").newInstance(); 

String url="jdbc:mysql://localhost:3306/mydb";
String user="root";
String pword="root";

Connection conn = DriverManager.getConnection(url, user, pword);


String sql = "SELECT * FROM summaries WHERE Users_userID = ?";

PreparedStatement ps = conn.prepareStatement(sql);
ps.setString(1, userID);

ResultSet rs = ps.executeQuery();

out.println("<table class = 'gridtable' style = 'width: 100%'>");
out.println("<tr> <th>Summary #</th><th>Overall Score</th><th>Suggested Treatment</th></tr>");

while(rs.next())
{
	String num = rs.getString("summaryID");
	int q1 = Integer.parseInt(rs.getString("result_1"));
	int q2 = Integer.parseInt(rs.getString("result_2"));
	int q3 = Integer.parseInt(rs.getString("result_3"));
	int q4 = Integer.parseInt(rs.getString("result_4"));
	int q5 = Integer.parseInt(rs.getString("result_5"));
	int score = q1+q2+q3+q4+q5;
	String suggestion = "Surgery";
	if(score >= 11)
	{
		suggestion = "Medication";
	}
	out.println("<tr> <td>"+num+"</td> <td>"+score+"</td><td>"+suggestion+"</td></tr>");
}
  } catch(Exception e) {
    out.println(e.getMessage());
  }
%>