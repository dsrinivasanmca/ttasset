<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@ include file="actionBar.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<%
 if( session != null && session.getAttribute("currentSessionUserID") != null && session.getAttribute("currentSessionUserID") != null) 
 {
	int currentSessionUserID = (Integer) session.getAttribute("currentSessionUserID");
	String currentSessionUserRole = (String) session.getAttribute("currentSessionUserRole");
	if("rootadmin".equals(currentSessionUserRole) || "companyadmin".equals(currentSessionUserRole))
	{
 %>
		<body>
			<div class="container">
				<div class="row">
  					<div class="col-sm-2"></div>
  					<div class="col-sm-8">
  						<div class="panel panel-primary well well-sm">
							<div class="panel-heading" align="center">Add New Designation</div>
							<div class="panel-body">
  							<form class="form-horizontal" method="post" action="DesignationServlet">
	  							<%
	  							int currentSessionUserCompanyID = (Integer) session.getAttribute("currentSessionUserCompanyID");
	  							CompanyBean companyBeanOB1 = new CompanyBean();
	  							if("rootadmin".equals(currentSessionUserRole))
  								{
	  								companyBeanOB1.setSearchQuery(" where companyname!='admincompany' and status=1");
  								}
  								else
  								{
  									companyBeanOB1.setSearchQuery(" where companyid='"+currentSessionUserCompanyID+"'");
  								}
  								List<CompanyBean> companyBeanOB2 = new ArrayList<CompanyBean>();
  								companyBeanOB2.add(companyBeanOB1);
  								CompanyDAO companyDAOOB1 = new CompanyDAO();
  								List<CompanyBean> companyBeanOB3 = companyDAOOB1.viewCompany(companyBeanOB2);
  								int NoOfCompanies = companyBeanOB3.size();
  								int companyID;
								String companyFullName = null;
  								  								  								
  								%>	
  								<div class="form-group">  
	      							<label class="control-label col-sm-4" for="status">Company</label>
  									<div class="col-sm-8">  										        
    									<select class="form-control" name="selectedCompanyID" required>
    									<%
    									if("rootadmin".equals(currentSessionUserRole))
    									{
    									%>
    										<option value="">Select Company</option>
    									<%
    									}
    									%>    										
    									<%
    									for(int i=0;i<NoOfCompanies;i++)
										{
											companyID = companyBeanOB3.get(i).getCompanyID();
											companyFullName = companyBeanOB3.get(i).getCompanyName().toUpperCase();																																
										%>
											<option value=<%=companyID%>><%=companyFullName%></option>
										<%											
										}
										%>    										    										
										</select>							  
									</div>
								</div>
  								<div class="form-group">  
      								<label class="control-label col-sm-4" for="designationname">DesignationName:</label>  
      								<div class="col-sm-8">  
	        							<input type="text" class="form-control" name="designationname" placeholder="Enter DesignationName" required pattern="^(?=.*[A-Za-z0-9])[0-9a-zA-Z\s]{2,24}$"
        title="Olny Letters, Numbers and Special Characters(Space) Allowed(1 Alphanumeric Mandatory)-(Length Min-2 Max-24)">  
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
  								<div class="form-group">          
      								<div class="col-sm-offset-6 col-sm-8">  
        								<button type="submit" class="btn btn-success" name="submitValue" value="createDesignation">
        									<strong>CreateDesignation</strong>
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
		<%="YOU ARE NOT AUTHOROZED TO ACCESS THIS PAGE" %>
	<%	
	}
}
%>
</body>
</html>