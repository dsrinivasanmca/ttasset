<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@ page import="com.tt.asset.*"%>
<%@ include file="actionBar.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<link rel="stylesheet" type="text/css" href="css/bootstrap.min1.css">
<link rel="stylesheet" type="text/css" href="css/dataTables.bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/dataTableWithSearch.css">
<script type="text/javascript" language="javascript" src="css/jquery-1.12.4.js"></script>
<script type="text/javascript" language="javascript" src="css/jquery.dataTables.min.js"></script>
<script type="text/javascript" language="javascript" src="css/dataTables.bootstrap.min.js"></script>
<script type="text/javascript" language="javascript" src="css/dataTableWithSearch.js"></script>
<%
if( session != null && session.getAttribute("currentSessionUserID") != null && session.getAttribute("currentSessionUserRole") != null) 
{	
	String currentSessionUserRole = (String) session.getAttribute("currentSessionUserRole");	
	if("rootadmin".equals(currentSessionUserRole) || "companyadmin".equals(currentSessionUserRole))
	{
		int companyID;
		int designationID = 0;
		String companyName;
		String designationName = null;
		int status = 0;
		String statusValue="null";
		Date creationDate;
		Date creationTime;
		int createdByUserID;
		String createdByUserEmployeeID;
		String createdByUserFirstName;
		int currentSessionUserID = (Integer) session.getAttribute("currentSessionUserID");
		int currentSessionUserCompanyID = (Integer) session.getAttribute("currentSessionUserCompanyID");
		int selectedDesignationID = (Integer) session.getAttribute("selectedDesignationID");
		int selectedCompanyID = 0;
	 %>
	<body>
	<form class="form-horizontal" method="post" action="DesignationServlet">
		<%
		if(selectedDesignationID == 0)
		{						
			DesignationBean designationBeanOB1 = new DesignationBean();
			if("rootadmin".equals(currentSessionUserRole))
			{
				designationBeanOB1.setSearchQuery(" where designationname!='admindesignation'");
			}
			else
			{
				designationBeanOB1.setSearchQuery(" where companyid='"+currentSessionUserCompanyID+"'");
			}
			List<DesignationBean> designationBeanOB2 = new ArrayList<DesignationBean>();
			designationBeanOB2.add(designationBeanOB1);		
			DesignationDAO designationDAOOB1 = new DesignationDAO();
			List<DesignationBean> designationBeanOB3 = designationDAOOB1.viewDesignation(designationBeanOB2);
			int noOfDesignations = designationBeanOB3.size();
			CapitalizeFirstLetter cfl = new CapitalizeFirstLetter();
		%>
			<div class="container-fluid">
				<div class="row">
					<div class="panel panel-primary">
						<div class="panel-heading">
							<h3 class="panel-title">Select Designation</h3>
						</div>
					</div>
				</div>
			</div>
			<div class="container-fluid">
				<table id="dataTable" class="table table-striped table-bordered" cellspacing="0">
					<thead>
						<tr>
							<th>S.No</th>
							<%
							if("rootadmin".equals(currentSessionUserRole))
							{
							%>
								<th>CompanyName</th>
							<%
							}
							%>						
							<th>DesignationName</th>																															
							<th>Status</th>
							<th>CreatedBy</th>
							<th>CreatedOn</th>
							<th>Edit</th>
						</tr>
					</thead>
					<tfoot>
						<tr>
							<th>S.No</th>
							<%
							if("rootadmin".equals(currentSessionUserRole))
							{
							%>	
								<th>CompanyName</th>
							<%
							}
							%>
							<th>DesignationName</th>
							<th>Status</th>
							<th>CreatedBy</th>
							<th>CreatedOn</th>
							<th>Edit</th>					
						</tr>
					</tfoot>
					<tbody>
						<%
						for(int i=0;i<noOfDesignations;i++)
						{
							companyID = designationBeanOB3.get(i).getCompanyID();
							CompanyBean companyBeanOB1 = new CompanyBean();
							companyBeanOB1.setSearchQuery(" where companyid='"+companyID+"'");
							List<CompanyBean> companyBeanOB2 = new ArrayList<CompanyBean>();
							companyBeanOB2.add(companyBeanOB1);
							CompanyDAO companyDAOOB1 = new CompanyDAO();
							List<CompanyBean> companyBeanOB3 = companyDAOOB1.viewCompany(companyBeanOB2);
							companyName = cfl.capitalizeName(companyBeanOB3.get(0).getCompanyName());
							designationName = cfl.capitalizeName(designationBeanOB3.get(i).getDesignationName());						
							status = designationBeanOB3.get(i).getDesignationStatus();
							if (status == 1)
							{
								statusValue="Active";
							}
							else
							{
								statusValue="DeActive";
							}				
							creationDate = designationBeanOB3.get(i).getCreationDate();
							creationTime = designationBeanOB3.get(i).getCreationTime();
							createdByUserID = designationBeanOB3.get(i).getCreatedByUserID();
							UserBean userBeanOB1 = new UserBean();
							userBeanOB1.setSearchQuery(" where userid='"+createdByUserID+"'");
							List<UserBean> userBeanOB2 = new ArrayList<UserBean>();
							userBeanOB2.add(userBeanOB1);
							UserDAO userDAOOB1 = new UserDAO();
							List<UserBean> userBeanOB3 = userDAOOB1.viewUser(userBeanOB2);
							createdByUserFirstName = cfl.capitalizeName(userBeanOB3.get(0).getUserFirstName());
							createdByUserEmployeeID = cfl.capitalizeName(userBeanOB3.get(0).getUserEmployeeID());
							designationID = designationBeanOB3.get(i).getDesignationID();
						%>					
							<tr>
								<td><%=i+1%></td>
								<%
								if("rootadmin".equals(currentSessionUserRole))
								{
								%>
									<td><%=companyName%></td>
								<%
								}
								%>
								<td><%=designationName%></td>
								<td><%=statusValue%></td>							
								<td>
									<%=createdByUserEmployeeID%>
									<br>
									<%=createdByUserFirstName%>
								</td>
								<td>
									<%=creationDate%>
									<br>
									<%=creationTime%>
								</td>
								<td>
									<input type="hidden" name="sourceJSP" value="editDesignation.jsp"></input>
									<button type="submit" class="btn btn-info btn-sm" name="submitValue" value="<%=designationID%>">Edit</button>
								</td>
							</tr>
						<%
						}
						%>
					</tbody>
				</table>
			</div>
		<%
		}
		else
		{			
			DesignationBean designationBeanOB1 = new DesignationBean();			
			designationBeanOB1.setSearchQuery(" where designationid='"+selectedDesignationID+"'");
			List<DesignationBean> designationBeanOB2 = new ArrayList<DesignationBean>();
			designationBeanOB2.add(designationBeanOB1);		
			DesignationDAO designationDAOOB1 = new DesignationDAO();
			List<DesignationBean> designationBeanOB3 = designationDAOOB1.viewDesignation(designationBeanOB2);
			int noOfDesignations = designationBeanOB3.size();
			CapitalizeFirstLetter cfl = new CapitalizeFirstLetter();
		%>	 		
			<div class="container-fluid">
				<div class="row">
					<div class="panel panel-primary">
						<div class="panel-heading">
							<h3 class="panel-title">Selected Branch</h3>
						</div>
					</div>
				</div>
			</div>
			<div class="container-fluid">
				<table id="dataTable1" class="table table-striped table-bordered" cellspacing="0">
					<thead>
						<tr>							
							<%
							if("rootadmin".equals(currentSessionUserRole))
							{
							%>
								<th>CompanyName</th>
							<%
							}
							%>						
							<th>DesignationName</th>																															
							<th>Status</th>
							<th>CreatedBy</th>
							<th>CreatedOn</th>							
						</tr>
					</thead>
					<tbody>
					<%
						for(int i=0;i<noOfDesignations;i++)
						{
							companyID = designationBeanOB3.get(i).getCompanyID();
							CompanyBean companyBeanOB1 = new CompanyBean();
							companyBeanOB1.setSearchQuery(" where companyid='"+companyID+"'");
							List<CompanyBean> companyBeanOB2 = new ArrayList<CompanyBean>();
							companyBeanOB2.add(companyBeanOB1);
							CompanyDAO companyDAOOB1 = new CompanyDAO();
							List<CompanyBean> companyBeanOB3 = companyDAOOB1.viewCompany(companyBeanOB2);
							companyName = cfl.capitalizeName(companyBeanOB3.get(0).getCompanyName());
							designationName = cfl.capitalizeName(designationBeanOB3.get(i).getDesignationName());						
							status = designationBeanOB3.get(i).getDesignationStatus();
							if (status == 1)
							{
								statusValue="Active";
							}
							else
							{
								statusValue="DeActive";
							}				
							creationDate = designationBeanOB3.get(i).getCreationDate();
							creationTime = designationBeanOB3.get(i).getCreationTime();
							createdByUserID = designationBeanOB3.get(i).getCreatedByUserID();
							UserBean userBeanOB1 = new UserBean();
							userBeanOB1.setSearchQuery(" where userid='"+createdByUserID+"'");
							List<UserBean> userBeanOB2 = new ArrayList<UserBean>();
							userBeanOB2.add(userBeanOB1);
							UserDAO userDAOOB1 = new UserDAO();
							List<UserBean> userBeanOB3 = userDAOOB1.viewUser(userBeanOB2);
							createdByUserFirstName = cfl.capitalizeName(userBeanOB3.get(0).getUserFirstName());
							createdByUserEmployeeID = cfl.capitalizeName(userBeanOB3.get(0).getUserEmployeeID());
							designationID = designationBeanOB3.get(i).getDesignationID();
						%>
							<tr>								
								<%
								if("rootadmin".equals(currentSessionUserRole))
								{
								%>
									<td><%=companyName%></td>
								<%
								}
								%>
								<td><%=designationName%></td>
								<td><%=statusValue%></td>							
								<td>
									<%=createdByUserEmployeeID%>
									<br>
									<%=createdByUserFirstName%>
								</td>
								<td>
									<%=creationDate%>
									<br>
									<%=creationTime%>
								</td>								
							</tr>
						<%
						}
						%>
					</tbody>
				</table>
			</div>
			<div class="container">
				<div class="row">
  					<div class="col-sm-2"></div>
  					<div class="col-sm-8">
	  					<div class="panel panel-primary well well-sm">
							<div class="panel-heading" align="center">Edit Designation</div>
							<div class="panel-body"> 
								<input type="hidden" class="form-control" name="designationID" value="<%=designationID%>"> 						  
  								<div class="form-group">  
      								<label class="control-label col-sm-4" for="designationname">DesignationName:</label>  
      								<div class="col-sm-8">
      									<input type="hidden" class="form-control" name="oldDesignationName" value="<%=designationName%>">  
        								<input type="text" class="form-control" name="newDesignationName" placeholder="<%=designationName%>" pattern="^(?=.*[A-Za-z0-9])[0-9a-zA-Z\s]{2,24}$"
        title="Olny Letters, Numbers and Special Characters(Space) Allowed(1 Alphanumeric Mandatory)-(Length Min-2 Max-24)">  
      								</div>  
    							</div>  
    							<input type="hidden" class="form-control" name="oldStatus" value="<%=status%>">
    							<div class="form-group">  
	      							<label class="control-label col-sm-4" for="status">Status:</label>
      								<div class="col-sm-8">        	
	    								<select class="form-control" name="newStatus">
	    									<%
	    									if("rootadmin".equals(currentSessionUserRole) || "companyadmin".equals(currentSessionUserRole))
        									{
        										if("Active".equals(statusValue))
        										{
        										%>
	        										<option value=1 selected>Active</option>
													<option value=0>DeActive</option>
												<%
        										}
        										else
        										{
        										%>
	        										<option value=1>Active</option>
													<option value=0 selected>DeActive</option>
        										<%	
        										}
        									}											
	    									%>
    									</select>							  
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
				 								<div class="alert <% out.println(AlertType1); %> fadein">    								
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
	        							<button type="submit" class="btn btn-success" name="submitValue" value="updateDesignation">
        									<strong>Update</strong>
        								</button>
        								<input type="hidden" name="sourceJSP" value="editDesignation.jsp"></input>
        								<button type="submit" class="btn btn-info col-sm-offset-2" name="submitValue" value="selectanotherdesignation">
	        								<strong>Select Another Designation</strong>
        								</button>  
      								</div>  
    							</div>    			
    						</div>
    					</div>
    				</div>
  					<div class="col-sm-2"></div>
				</div>
			</div>
		<%
		}
		%>
	</form>
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
</html>