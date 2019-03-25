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
  <a href="../index.html" class="w3-button w3-bar-item">Home</a>
  <a href="../html/information.html" class="w3-button w3-bar-item">Information Content</a>
  <a href="../html/decision.html" class="w3-button w3-bar-item">Decision Guide</a>
  <a href="summary.jsp" class="w3-button w3-bar-item">Summary</a>
  <a href="forumPosts.jsp" class="w3-button w3-bar-item">Forums</a>
  <a href="../html/register.html" class="w3-button w3-bar-item">Sign Up</a>
  <a href="../html/login.html" class="w3-button w3-bar-item">Sign In</a>
  <a href="../html/contact.html" class="w3-button w3-bar-item">Contact</a>
  <a href="../html/doctor.html" class="w3-button w3-bar-item">Doctor Portal</a>
</nav>
	
	<% 
	String postID = request.getParameter("postID");
	  try {

			Class.forName("com.mysql.jdbc.Driver").newInstance(); 

			String url="jdbc:mysql://localhost:3306/mydb";
			String user="root";
			String pword="root";

			Connection conn = DriverManager.getConnection(url, user, pword);


			String sql = "SELECT * FROM posts WHERE postID = ?";
			
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, postID);

			ResultSet rs = ps.executeQuery();

			out.println("<center>");
			while(rs.next())
			{
				String currentTitle = rs.getString("Title");
				String datePosted = rs.getString("timeStamp");
				String content = rs.getString("postContent");
				String posterID = rs.getString("posterID");
				
				out.println("<h1>"+currentTitle+"</h1><p>"+content+"</p>");
				
				String sql2 = "SELECT * From users WHERE userID = ?";
			
				PreparedStatement ps2 = conn.prepareStatement(sql2);
				ps2.setString(1, posterID);
				
				ResultSet rs2 = ps2.executeQuery();
				
				while(rs2.next())
				{
					String name = rs2.getString("userName");
					out.println("<p> posted by "+name+"</p>");
					
					String sql3 = "SELECT * FROM comments WHERE postID = ?";
					
					PreparedStatement ps3 = conn.prepareStatement(sql3);
					ps3.setString(1, postID);
					
					ResultSet rs3 = ps3.executeQuery();
					
					out.println("<b>Comments: </b>");
					
					while(rs3.next())
					{
						String comments = rs3.getString("commentContent");
						String commenterID = rs3.getString("commenterID");
						
						String sql4 = "SELECT * FROM users WHERE userID = ?";
						
						PreparedStatement ps4 = conn.prepareStatement(sql4);
						ps4.setString(1, commenterID);
						
						ResultSet rs4 = ps4.executeQuery();
						
						out.println("<p>"+comments+"</p>");
						
						while(rs4.next())
						{
							String commenter = rs4.getString("userName");
							out.println("<p> posted by: "+commenter+"</p><br>");
						}
						
						
					}
				}
				
				out.println("</center>");
			out.println("<form action = 'submitComment.jsp'>");
			out.println("<input type = 'hidden' id ='postID' name = 'postID' value = "+postID+">");
			out.println("<input type = 'hidden' id ='posterID' name = 'posterID' value = "+posterID+">");
			out.println("<label for='commentText'><b>Create Comment</b></label>");
			out.println("<input type = 'text' name = 'commentText' placeholder = 'Enter comment here'>");
			out.println("<button type = 'submit' > Post Comment </button>");
			out.println("</form>");
			}
			
			

			
  } catch(Exception e) {
    out.println(e.getMessage());
  }
	
	%>

</body>