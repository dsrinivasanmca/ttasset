<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="com.tt.asset.*"%>
<%@ include file="actionBar.jsp"%>
<link rel="stylesheet" type="text/css" href="css/bootstrap.min1.css">
<link rel="stylesheet" type="text/css" href="css/dataTables.bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/dataTableWithSearch.css">
<script type="text/javascript" language="javascript" src="css/jquery-1.12.4.js"></script>
<script type="text/javascript" language="javascript" src="css/jquery.dataTables.min.js"></script>
<script type="text/javascript" language="javascript" src="css/dataTables.bootstrap.min.js"></script>
<script type="text/javascript" language="javascript" src="css/dataTableWithSearch.js"></script>
<script type="text/javascript">
$(document).ready(function() 
{
	$('#dataTable1').DataTable
	({
		"scrollX": true,
		"bPaginate": false,		
		"sDom": 'rt'
	});	
});
</script>
<body>
<form class="form-horizontal" method="post" action="ProfileServlet" id="updateProfile">
<%	
	int currentSessionUserID = (Integer)session.getAttribute("currentSessionUserID");
	UserBean userBeanOB1 = new UserBean();
	userBeanOB1.setSearchQuery(" where userid='"+currentSessionUserID+"'");					
	List<UserBean> userBeanOB2 = new ArrayList<UserBean>();
	userBeanOB2.add(userBeanOB1);				
	UserDAO userDAOOB1 = new UserDAO();
	List<UserBean> userBeanOB3 = userDAOOB1.viewUser(userBeanOB2);
	CapitalizeFirstLetter cfl = new CapitalizeFirstLetter();
	String userFirstName = cfl.capitalizeName(userBeanOB3.get(0).getUserFirstName());
	String userLastName = cfl.capitalizeName(userBeanOB3.get(0).getUserLastName());
	String mobileNo = userBeanOB3.get(0).getUserMobileNo();
	String emailID = userBeanOB3.get(0).getUserEmailID();
%>
	<div class="container-fluid">
		<div class="row">
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h3 class="panel-title">Update Profile</h3>
				</div>
			</div>
		</div>
	</div>
	<div class="container-fluid">
		<div class="col-sm-4"></div>
  		<div class="col-sm-6">
			<table id="dataTable1" class="table table-striped table-bordered" cellspacing="0">
				<thead>
					<tr>										
						<th>FirstName</th>
						<th>LastName</th>
						<th>MobileNo</th>
						<th>EmailID</th>				
					</tr>
				</thead>
				<tbody>						
					<tr>												
						<td><%=userFirstName%></td>
						<td><%=userLastName%></td>
						<td><%=mobileNo%></td>
						<td><%=emailID%></td>				
					</tr>											
				</tbody>				
			</table>
		</div>
		<div class="col-sm-2"></div>
	</div>
	<br></br>
	<div class="container">
		<div class="row">
  			<div class="col-sm-2"></div>
  			<div class="col-sm-8">
	  			<div class="panel panel-primary well well-sm">
					<div class="panel-heading" align="center">Update User</div>
					<div class="panel-body">
						<input type="hidden" class="form-control" name="userID" value="<%=currentSessionUserID%>">
						<div class="form-group">  
		      				<label class="control-label col-sm-4" for="LoginPassword">CurrentLoginPassword</label>  
      						<div class="col-sm-8">  
	        					<input type="password" class="form-control" name="currentLoginPassword" placeholder="Enter CurrentPassword" pattern="^(?=.*[A-Za-z0-9])[0-9a-zA-Z\@\#\-\.\!\^\$]{2,34}$"
        		title="Only Letters,numbers and Special Characters(@,#,-,.,!,%,$) Allowed(1 Alphanumeric Mandatory)-(Length Min-3 Max-34)">  
      						</div>  
    					</div>
    					<br><br>
						<fieldset>                            		
    					<div class="form-group">  
		      				<label class="control-label col-sm-4" for="LoginPassword">LoginPassword</label>  
      						<div class="col-sm-8">  
	        					<input type="password" class="form-control" name="newLoginPassword" placeholder="Enter Password" pattern="^(?=.*[A-Za-z0-9])[0-9a-zA-Z\@\#\-\.\!\^\$]{2,34}$"
        		title="Only Letters,numbers and Special Characters(@,#,-,.,!,%,$) Allowed(1 Alphanumeric Mandatory)-(Length Min-3 Max-34)">  
      						</div>  
    					</div>
    					<div class="form-group">  
      						<label class="control-label col-sm-4" for="ConfirmLoginPassword">ConfirmLoginPassword</label>  
      						<div class="col-sm-8">  
	        					<input type="password" class="form-control" name="newConfirmLoginPassword" placeholder="Enter ConfirmPassword" pattern="^(?=.*[A-Za-z0-9])[0-9a-zA-Z\@\#\-\.\!\^\$]{2,34}$"
        		title="Only Letters,Numbers and Special Characters(@,#,-,.,!,%,$) Allowed(1 Alphanumeric Mandatory)-(Length Min-3 Max-34)">  
      						</div>  
    					</div>
    					</fieldset>
    					<div class="form-group">  
      						<label class="control-label col-sm-4" for="UserFirstName">UserFirstName</label>
      						<div class="col-sm-8">
      							<input type="hidden" name="oldUserFirstName" value="<%=userFirstName%>">  
	        					<input type="text" class="form-control" name="newUserFirstName" placeholder="<%=userFirstName%>" pattern="^(?=.*[A-Za-z0-9])[0-9a-zA-Z\s]{2,34}$"
        		titl="Only Letters,Numbers and Special Characters(Space) Allowed(1 Alphanumeric Mandatory)-(Length Min-2 Max-34)">  
      						</div>  
    					</div>
    					<div class="form-group">  
      						<label class="control-label col-sm-4" for="UserLastName">UserLastName</label>  
      						<div class="col-sm-8">
      							<input type="hidden" name="oldUserLastName" value="<%=userLastName%>">  
	        					<input type="text" class="form-control" name="newUserLastName" placeholder="<%=userLastName%>" pattern="^(?=.*[A-Za-z0-9])[0-9a-zA-Z\s]{2,34}$"
        		title="Only Letters,Numbers and Special Characters(Space) Allowed(1 Alphanumeric Mandatory)-(Length Min-2 Max-34)">  
      						</div>  
    					</div>      			 		    							
    					<div class="form-group">  
      						<label class="control-label col-sm-4" for="MobileNo">MobileNo</label>  
      						<div class="col-sm-8">
      							<input type="hidden" name="oldMobileNo" value="<%=mobileNo%>">  
        						<input type="text" class="form-control" name="newMobileNo" placeholder="<%=mobileNo%>" pattern="^(?=.*[A-Za-z0-9])[0-9a-zA-Z\/]{2,34}$"
        		title="Olny Letters,Numbers and Special Characters(/) Allowed(1 Alphanumeric Mandatory)-(Length Min-2 Max-34)">  
      						</div>  
    					</div>
    					<div class="form-group">  
      						<label class="control-label col-sm-4" for="EmailID">EmailID</label>  
      						<div class="col-sm-8">
      							<input type="hidden" name="oldEmailID" value="<%=emailID%>">  
        						<input type="text" class="form-control" name="newEmailID" placeholder="<%=emailID%>" pattern="^(?=.*[A-Za-z0-9])[0-9a-zA-Z\/\-\.\@]{2,34}$"
        		title="Olny Letters,Numbers and Special Characters(/,-,.,@) Allowed(1 Alphanumeric Mandatory)-(Length Min-2 Max-34)">  
      						</div>  
    					</div>
    					<%    					 
    					if (session != null) 
						{	
							if (session.getAttribute("Message1") != null) 
							{
								String Message1 = (String)session.getAttribute("Message1");
								String AlertType1 = (String)session.getAttribute("AlertType1");
								String AlertMessage1 = (String)session.getAttribute("AlertMessage1");
							%>
								<div class="form-group">          
      								<div class="col-sm-offset-4 col-sm-8">
				 						<div class="alert <% out.println(AlertType1); %> fade in">    								
    										<strong><%=AlertMessage1%></strong>
											<%=Message1%>
										</div>
									</div>
								</div>
							<%
	        					session.removeAttribute("AlertType1");
    	    					session.removeAttribute("AlertMessage1");
        						session.removeAttribute("Message1");
							}
						}
        				%>
  						<div class="form-group">          
      						<div class="col-sm-offset-4 col-sm-8">  
	        					<button type="submit" class="btn btn-success" name="submitValue" value="updateUser">
        							<strong>Update</strong>
        						</button>        						
        						<button type="submit" class="btn btn-info col-sm-offset-2" name="submitValue" value="home">
			        				<strong>Home</strong>
        						</button>	        								        								       						
      						</div>  
    					</div>
    				</div>
    			</div>
    		</div>
  			<div class="col-sm-2"></div>
		</div>
	</div>
</form>
</body>
</html>