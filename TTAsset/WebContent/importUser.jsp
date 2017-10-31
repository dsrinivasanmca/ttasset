<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@ include file="actionBar.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.ArrayList"%>
<%
 if( session != null && session.getAttribute("currentSessionUserID") != null && session.getAttribute("currentSessionUserID") != null) 
 {
	int currentSessionUserID = (Integer) session.getAttribute("currentSessionUserID");
	String currentSessionUserRole = (String) session.getAttribute("currentSessionUserRole");
	if("companyadmin".equals(currentSessionUserRole))
	{
 %>
		<body>
			<div class="container">
				<div class="row">
  					<div class="col-sm-2"></div>
  					<div class="col-sm-8">
  						<div class="panel panel-primary well well-sm">
							<div class="panel-heading" align="center">Import New Users</div>
							<div class="panel-body">																				
  							<form class="form-horizontal" method="post" action="UserServlet">  								
  								<div class="form-group">  									        							
    								<div class="panel-heading" align="center"><h2>Instructions</h2></div>
    								<div class="panel-body">
    									<h3>
    									1.Download Sample Template [importUser.csv]<br>
        								2.Refer New User Page and Fill The Fields<br>
        								3.Delete Header Row<br>
        								4.Upload the File<br>
        								5.ImportUser<br>
        								</h3>
    								</div>									        									      							        							      						
    							</div>
    							<br><br>
  								<div class="form-group">  									
        							<div class="col-sm-offset-1 col-sm-8">    							      								      							               								
        								<button type="submit" class="btn btn-warning" name="submitValue" value="downloadTemplate">
        									<strong>Download Template</strong>        									
        								</button>
        							</div>        							        							      								
    							</div>
    							<br><br>  									  							  						
  								<div class="form-group">
  									<div class="btn btn-info col-sm-offset-1 col-sm-8">  								        							            						
            							<input type="file"> 
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
    												<strong>
    													<%=AlertMessage1%>
    												</strong>
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
        						<br><br><br><br>
  								<div class="form-group">  									         
      								<div class="col-sm-offset-1 col-sm-8">
        								<button type="submit" class="btn btn-success" name="submitValue" value="importUser">
        									<strong>Import User</strong>
        								</button>
        							</div>        							             						        							        							      								
    							</div>
    						</form>
    						</div>	
    					</div>
    				</div>
  					<div class="col-sm-2"></div>
				</div>
			</div>
		</body>
	<%
	}
	else
	{
	%>
		<%="YOU ARE NOTU AUTHORIZED TO ACCESS THIS PAGE"%>
	<%	
	}
}
%>
</html>