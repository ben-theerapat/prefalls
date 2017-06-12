<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*"%>
<jsp:useBean id="dbm" class="th.ac.utcc.database.DBManager" />
<!doctype html>
<head>
<title>mobilise</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="Shortcut Icon" href="images/icon.png"/>
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css"/>
<link rel="stylesheet" type="text/css" href="css/style.css"/>
<style>
@media (min-width:500px){
   .container-login{width:300px;margin-left:auto;margin-right:auto;}
   .container-header{width:300px;margin-left:auto;margin-right:auto;}
}
</style>
</head>
<body>
<nav class="navbar navbar-default navbar-static-top">
	<div class="container-fluid">
		<div class="navbar-header">
			<a class="header-brand" href="#"><img src="images/logo.png"></a>
		</div>
	</div>
</nav>
<div class="container">
	<div class="container-header line"><font class="s17">Sign in</font></div>
	<div class="container-login">
		<form name="frmLogin" method="post" action="index.jsp?checkLogin">
		<input type="text" name="email" placeholder="username" />
		<input type="password" name="pass" placeholder="password" />
		<input type="submit" name="submit" value="Sign in"/ >
		</form>
	</div>

<% 
	if(session.getAttribute("ssuid") != null){
		response.sendRedirect("./listname/");
	}
	
	if(request.getParameter("checkLogin") != null){
		
		dbm.createConnection();
		
		try {
		
			String email = request.getParameter("email");
			String pass = request.getParameter("pass");
		
			String sql = "select * from caregiver where email = '" + email +"' and password = '" + pass + "' ;";
			ResultSet rs = dbm.executeQuery(sql);
		
			if(!rs.next()) out.print("<center><div ><br><font style='color:#ff0000'>ที่อยู่อีเมลหรือรหัสผ่านไม่ถูกต้อง</font></div></center");
		
			else {
			
				rs.first();
				session.setAttribute("ssfn",rs.getString("firstname"));
				session.setAttribute("ssln",rs.getString("lastname"));
				session.setAttribute("ssuid",rs.getString("UID"));
				session.setAttribute("sstypeid",rs.getString("type_id"));
				response.sendRedirect("./listname/");
			}
		
		}	catch (Exception e) {
			out.println(e.getMessage());
			e.printStackTrace();
		}
		
		dbm.closeConnection();
		
	} 
%>

</div>
</body>
</html>