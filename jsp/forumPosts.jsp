<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 

<!doctype html>
<html class="no-js" lang="">

<head>
  <meta charset="utf-8">
  <meta http-equiv="x-ua-compatible" content="ie=edge">
  <title></title>
  <meta name="description" content="">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <link rel="manifest" href="../site.webmanifest">
  <link rel="apple-touch-icon" href="../icon.png">
  <!-- Place favicon.ico in the root directory -->

  <link rel="stylesheet" href="../css/normalize.css">
  <link rel="stylesheet" href="../css/main.css">
  <link rel="stylesheet" href="https://www.w3schools.com/w3css/3/w3.css">
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
<script src="../js/main.js"></script>
<script type="text/javascript" src="../js/main.js"></script>
 <style type="text/css">
    #likert { text-align:center; }
    #likert td { width: 70px; }
 </style>

<!-- Basic Navigation -->
<nav class="w3-bar w3-black">
  <a href="index.html" class="w3-button w3-bar-item">Home</a>
  <a href="account.html" class="w3-button w3-bar-item">Your account</a>
  <a href="../jsp/decision.jsp" class="w3-button w3-bar-item">Decision Guide</a>
  <a href="../jsp/summary.jsp" class="w3-button w3-bar-item">Summary</a>
  <a href="../jsp/forumPosts.jsp" class="w3-button w3-bar-item">Forums</a>
  <a href="register.html" class="w3-button w3-bar-item">Sign Up</a>
  <a href="login.html" class="w3-button w3-bar-item">Sign In</a>
  <a href="../jsp/doctor.jsp" class="w3-button w3-bar-item">Doctor Portal</a>
</nav>

	<a href = "../html/newPost.html">Create a Post</a>
	
	<% 
	  try {

			Class.forName("com.mysql.jdbc.Driver").newInstance(); 

			String url="jdbc:mysql://localhost:3306/mydb";
			String user="root";
			String pword="root";

			Connection conn = DriverManager.getConnection(url, user, pword);


			String sql = "SELECT * FROM posts";

			PreparedStatement ps = conn.prepareStatement(sql);

			ResultSet rs = ps.executeQuery();

			out.println("<table class = 'gridtable' style = 'width: 100%'>");
			out.println("<tr><th>Posts</th><th>Date Posted</th></tr>");

while(rs.next())
{
	String currentTitle = rs.getString("Title");
	String datePosted = rs.getString("timeStamp");
	String post = rs.getString("postID");
	out.println("<tr> <td> <a href = 'singlePost.jsp?postID="+post+"' class = 'button'>"+currentTitle+"</submit></td><td>"+datePosted+"</td></tr>");
}
  } catch(Exception e) {
    out.println(e.getMessage());
  }
	
	%>

</body>

</html>
