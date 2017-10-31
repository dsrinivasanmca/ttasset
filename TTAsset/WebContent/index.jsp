<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Teknoturf</title>
</head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" type="text/css" href="css\bootstrap.min.css">
  <!-- <link rel="script" type="text/js" href="css\jquery.min.js">  -->
  <!-- <link rel="script" type="text/js" href="css\bootstrap.min.js"> -->
  <script type="text/javascript" src="css\jquery.min.js"></script>
  <script type="text/javascript" src="css\bootstrap.min.js"></script>
  <script>
  $('#apply-form input').blur(function()
		  {
		      if( $(this).val().trim() == '' ) {
		            $(this).parents('p').addClass('warning');
		      }
		  });
  </script>
  
<body>
<div class="container">
<div class="row">
		<div class="col-sm-3"></div>
  		<div class="col-sm-6">
			<div class="form-group">          
    			<div class="col-sm-12">
					<img src="Images/IT.jpg" class="img-thumbnail" alt="Cinque Terre" width="530" height="100">
					
				</div>
			</div>
		</div>
		<div class="col-sm-3"></div>
	</div>
</div>
<div class="container">
	<div class="row">
		<div class="col-sm-3"></div>
  		<div class="col-sm-6">
 			<div class="panel panel-primary well well-sm">
				<div class="panel-heading">Login</div>
				<div class="panel-body">
  					<form class="form-horizontal" method="post" action="LoginServlet">   
  					<div class="form-group">  
      					<label class="control-label col-sm-2" for="userid">EmployeeID:</label>  
      					<div class="col-sm-10">  
        					<input type="text" class="form-control" name="employeeID" placeholder="Enter employeeid" required pattern="^(?=.*[A-Za-z0-9])[0-9a-zA-Z\/]{2,24}$"
        title="Olny Letters, Numbers and Special Character(/) Allowed(1 Alphanumeric Mandatory)-(Length Min-2 Max-34)">
      					</div>  
    				</div>  
    				<div class="form-group">  
      					<label class="control-label col-sm-2" for="pwd">Password:</label>  
      					<div class="col-sm-10">            
        					<input type="password" class="form-control" name="employeePassword" placeholder="Enter password" required pattern="^(?=.*[A-Za-z0-9])[^\s]{2,24}$" title="Space not Allowed(1 Alphanumeric Mandatory)-(Length Min-2 Max-34)">  
      					</div>  
    				</div> 
                 
    	<%    	
			if (session != null) 
			{
				if (session.getAttribute("Message1") != null) 
				{
					String AlertType1 = (String)session.getAttribute("AlertType1");
					String AlertMessage1 = (String)session.getAttribute("AlertMessage1");
		%>
					<div class="form-group">          
      					<div class="col-sm-offset-2 col-sm-10">
		 					<div class="alert <% out.println(AlertType1); %> fade in">
    							<a href="index.jsp" class="close" data-dismiss="alert">&times;</a>
    							<strong>
    							<% out.println(AlertMessage1); %>
    							</strong>
								<% 
									String Message1 = (String) session.getAttribute("Message1");
									out.println(Message1);
								%>
							</div>
						</div>
					</div>
		<%
				}
			}
         
        session.invalidate();
        %>     
  					<div class="form-group">          
      					<div class="col-sm-offset-2 col-sm-10">  
        					<button type="submit" class="btn btn-success">
        						<strong>Submit</strong>
        					</button>  
      					</div>  
    				</div>  
  				</form>
  			</div>
  		</div>
  		</div>
  		<div class="col-sm-3"></div>
  	</div>  
</div>
</body>
</html>