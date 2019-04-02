<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Register</title>
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

  <form action="../jsp/updateProfile.jsp" style="border:1px solid #ccc">
    <div class="container">
      <h1>Change email</h1>
      <p>Please enter your email</p>
      <hr>

      <label for="email"><b>Email</b></label>
      <input type="text" placeholder="Enter Email" name="email" required>
	  <%


  try {
HttpSession sess = request.getSession();
String id = (String)sess.getAttribute("ID");
Class.forName("com.mysql.jdbc.Driver").newInstance(); 

String url="jdbc:mysql://localhost:3306/mydb";
String user="root";
String pword="root";

Connection conn = DriverManager.getConnection(url, user, pword);


String sql = "SELECT * FROM users WHERE userID = ?";

PreparedStatement ps = conn.prepareStatement(sql);
ps.setString(1, id);

ResultSet rs = ps.executeQuery();

while(rs.next())
{
	out.println("<input type = 'hidden' id ='psw' name = 'psw' value = "+rs.getString("userPassword")+">");
	out.println("<input type = 'hidden' id ='name' name = 'name' value = "+rs.getString("userName")+">");
	out.println("<input type = 'hidden' id ='level' name = 'level' value = "+rs.getString("informationType")+">");
	out.println("<input type = 'hidden' id ='role' name = 'role' value = "+rs.getString("userRole")+">");
}
  } catch(Exception e) {
    out.println(e.getMessage());
  }
	  
	  %>


      <div class="clearfix">
        <button type="submit" class="signupbtn" >Submit</button>
      </div>
    </div>
  </form>
</body>
</html>