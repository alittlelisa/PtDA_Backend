<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 

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

<%
//HttpSession sess = request.getSession();
//String id = (String)sess.getAttribute("ID");

	  try {

			Class.forName("com.mysql.jdbc.Driver").newInstance(); 

			String url="jdbc:mysql://localhost:3306/mydb";
			String user="root";
			String pword="root";

			Connection conn = DriverManager.getConnection(url, user, pword);


			String sql = "SELECT * FROM questions";

			PreparedStatement ps = conn.prepareStatement(sql);

			ResultSet rs = ps.executeQuery();
			
			rs.last();
			
			int size = rs.getRow();
			
			rs.beforeFirst();
			
			String questions [] = new String[size];
			int originalValues [] = new int[size];
			int values [] = new int[size];
			
			int counter = 0;

while(rs.next())
{
	questions[counter] = rs.getString("questionText");
	values [counter] = Math.abs(Integer.parseInt(rs.getString("value")));
	originalValues [counter] = Integer.parseInt(rs.getString("value"));
	counter++;
}


for(int i = 0; i < size; i++)
{
	for(int j = 0; j < size; j++)
	{
		if((values[i] < values[j]) && (i != j))
		{
		
			int tempVal = values[j];
			values[j] = values[i];
			values[i] = tempVal;
			
			String tempText = questions[j];
			questions[j] = questions[i];
			questions[i] = tempText;
			
			tempVal = originalValues[j];
			originalValues[j] = originalValues[i];
			originalValues[i] = tempVal;
		}
	}
}

	out.println("<form action = 'decisionGuide.jsp'>");
	out.println("<center>");
	out.println("<p id = 'question'></p>");
	out.println("<table id='likert'> <tr>");
	out.println("<td><input id='radScoreStart' type='radio' name='Score' value='1' /></td>");
	out.println("<td><input type='radio' name='Score' value='2' /></td>");
	out.println("<td><input type='radio' name='Score' value='3' /></td>");
	out.println("<td><input type='radio' name='Score' value='4' /></td>");
    out.println("<td><input id='radScoreEnd' type='radio' name='Score' value='5' /></td> </tr>");
	out.println("<tr><td>Strongly Disagree </td> <td></td> <td></td> <td></td> <td> Strongly Agree </td> </tr> </table>");
	out.println("<button id = 'next' type = 'button' onClick = 'nextQuestion()'> Next Question </button>");
	out.println("<button id = 'finish' type = 'submit'> Complete </button> </center>");
	out.println("<input type = 'hidden' id ='responseField' name = 'responseField' value = '1'>");
	out.println("<input type = 'hidden' id ='valueField' name = 'valueField' value = '1'>");
	out.println("</form>");
	
	
	out.println("<script> var currentQuestion = 0; var responses = []");
	out.println("var questions = [");
	for(int i = 0; i < size-1; i++)
	{
		out.println("'"+questions[i]+"',");
	}
	out.println("'"+questions[size-1]+"'];");
		out.println("var values = [");
	for(int i = 0; i < size-1; i++)
	{
		out.println("'"+originalValues[i]+"',");
	}
	out.println("'"+originalValues[size-1]+"'];");
	out.println("$(window).on('load', function(){ document.getElementById('question').innerHTML = questions[currentQuestion]; document.getElementById('finish').disabled = true;});");
	
	out.println("function nextQuestion() {");
	out.println("if(currentQuestion < questions.length) {  var radios = document.getElementsByName('Score');");
	out.println("for(var i = 0; i < 5; i++) {if(radios[i].checked) { responses[currentQuestion] = radios[i].value;}}");
	out.println("currentQuestion++; if(currentQuestion != questions.length){document.getElementById('question').innerHTML = questions[currentQuestion];}}"); 
	out.println("completed();}");
	
	out.println("function completed(){if(typeof(responses["+size+"-1])!='undefined') {document.getElementById('responseField').value = (JSON.stringify(responses)); document.getElementById('valueField').value = (JSON.stringify(values)); document.getElementById('next').disabled = true; document.getElementById('finish').disabled = false;}}");

	out.println("</script>");

  } catch(Exception e) {
    out.println(e.getMessage());
  }


%>


</body>

</html>
