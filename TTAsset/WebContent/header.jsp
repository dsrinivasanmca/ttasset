<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.tt.asset.*"%>
<%@ page import="java.util.List"%>
<%@page import="java.util.ArrayList"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
if ( (session != null) && (session.getAttribute("currentSessionUserID") != null) )
{
	int currentSessionUserID = (Integer)session.getAttribute("currentSessionUserID");	
	UserBean userBeanOB1 = new UserBean();	
	String searchQuery=" where userid='"+currentSessionUserID+"'";
	userBeanOB1.setSearchQuery(searchQuery);
	List<UserBean> userBeanOB2 = new ArrayList<UserBean>();
	userBeanOB2.add(userBeanOB1);
	UserDAO userDAOOB1 = new UserDAO();
	List<UserBean> userBeanOB3 = userDAOOB1.viewUser(userBeanOB2);
	CapitalizeFirstLetter cfl = new CapitalizeFirstLetter();
	String userFirstName = cfl.capitalizeName(userBeanOB3.get(0).getUserFirstName());
	String userLastName = cfl.capitalizeName(userBeanOB3.get(0).getUserLastName());	 
%>	
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title></title>				
 	</head>
	<!-- <meta charset="utf-8"> -->
	<meta name="viewport" content="width=device-width, initial-scale=1">
  	<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
  	<script type="text/javascript" src="css/jquery.min.js"></script>
  	<script type="text/javascript" src="css/bootstrap.min.js"></script>		
  	<body>
  		<form class="form-horizontal" method="post" action="LogoutServlet">				
			<div class="container-fluid">
				<div class="row">
					<div class="panel panel-primary">
						<div class="panel-heading">			
							<div class="row" class="col-sm-12">		
								<div class="col-sm-11">					
									<%="Welcome "+userFirstName+" "+userLastName%>
								</div>		
								<div class="col-sm-1">
									<button type="submit" class="btn btn-success">
        							<strong>Logout</strong>
        							</button>
        						</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</form>
	</body>
<%
}
else
{
	session.setAttribute("Message1","Authendication Failed");
	session.setAttribute("AlertMessage1","Error!");
	session.setAttribute("AlertType1","alert-danger");
	response.sendRedirect("index.jsp"); //error page
}
%>
</html>