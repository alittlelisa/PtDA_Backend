<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 

<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Summary</title>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link rel="manifest" href="../site.webmanifest">
    <link rel="apple-touch-icon" href="../icon.png">
    <!-- Place favicon.ico in the root directory -->

    <link rel="stylesheet" href="../css/normalize.css">
    <link rel="stylesheet" href="../css/main.css">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/3/w3.css">

    <script type="text/javascript" src="https://cdn.emailjs.com/sdk/2.3.2/email.min.js"></script>
    <script type="text/javascript">
      (function(){
        emailjs.init("user_LlpLsb43ejpGbDfbPEpdL");
      })();
    </script>

</head>
<body>

<!--[if lte IE 9]>
<p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="https://browsehappy.com/">upgrade your browser</a> to improve your experience and security.</p>
<![endif]-->

<!-- Add your site or application content here -->
<script src="../js/vendor/modernizr-3.6.0.min.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" crossorigin="anonymous"></script>
<script>window.jQuery || document.write('<script src="../js/vendor/jquery-3.3.1.min.js"><\/script>')</script>
<script src="../js/plugins.js"></script>
<script src="../js/summary.js"></script>
<script type="text/javascript" src="../js/summary.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.debug.js" integrity="sha384-NaWTHo/8YCBYJ59830LTz/P4aQZK1sS0SneOgAvhsIl3zBu8r9RevNg5lHCHAuQ/" crossorigin="anonymous"></script>


<!-- Basic Navigation -->
<nav class="w3-bar w3-black">
  <a href="information.html" class="w3-button w3-bar-item">Information Content</a>
  <a href="decision.jsp" class="w3-button w3-bar-item">Decision Guide</a>
  <a href="../jsp/summary.jsp" class="w3-button w3-bar-item">Summary</a>
  <a href="../jsp/forumPosts.jsp" class="w3-button w3-bar-item">Forums</a>
  <a href="register.html" class="w3-button w3-bar-item">Sign Up</a>
  <a href="login.html" class="w3-button w3-bar-item">Sign In</a>
  <a href="contact.html" class="w3-button w3-bar-item">Contact</a>
  <a href="doctor.html" class="w3-button w3-bar-item">Doctor Portal</a>
</nav>
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

out.println("<div id = 'content'>");
out.println("<table class = 'gridtable' style = 'width: 100%'>");
out.println("<tr> <th>Summary #</th><th>Overall Score</th><th>Suggested Treatment</th></tr>");

while(rs.next())
{
	String num = rs.getString("summaryID");
	String results = rs.getString("results");
	results = results.replace("[", "");
	results = results.replace("]", "");
	results = results.replace("\"", "");
	int sum = 0;
	String data [] = results.split(",");
	for(int i = 0; i < data.length; i++)
	{
		sum += Integer.parseInt(data[i]);
	}
	String suggestion = "Surgery";
	if(sum >= 11)
	{
		suggestion = "Medication";
	}
	out.println("<tr> <td>"+num+"</td> <td>"+sum+"</td><td>"+suggestion+"</td></tr>");
	out.println("</table>");
	out.println("</div>");
	out.println("<div id = 'editor'></div>");
	out.println("<button id = 'cmd'> Export to PDF </button>");
	out.println("<br><br>");
	out.println("<form id = 'contact-form'>");
	out.println("<input type = 'hidden' name = 'contact_number'>");
	out.println("<label>Name</label>");
	out.println("<input type = 'text' name = 'user_name'>");
	out.println("<label>Email</label>");
	out.println("<input type = 'email' name = 'user_email'>");
	out.println("<label>Message</label>");
	out.println("<textarea name='contact'></textarea>");
	out.println("<input type = 'submit' value = 'Send'>");
	out.println("</form>");
	out.println("<button id='email'>Email</button>");
}
  } catch(Exception e) {
    out.println(e.getMessage());
  }
%>

</body>
</html>

