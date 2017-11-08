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
		int departmentID = 0;
		String companyName;
		String departmentName = null;
		int status = 0;
		String statusValue="null";
		String creationDateTime;		
		int createdByUserID;
		String createdByUserEmployeeID;
		String createdByUserFirstName;
		int currentSessionUserID = (Integer) session.getAttribute("currentSessionUserID");
		int currentSessionUserCompanyID = (Integer) session.getAttribute("currentSessionUserCompanyID");
		int selectedDepartmentID = (Integer) session.getAttribute("selectedDepartmentID");
		int selectedCompanyID = 0;
	 %>
	<body>
	<form class="form-horizontal" method="post" action="DepartmentServlet">
		<%
		if(selectedDepartmentID == 0)
		{	
			DepartmentBean departmentBeanOB1 = new DepartmentBean();
			if("rootadmin".equals(currentSessionUserRole))
			{
				departmentBeanOB1.setSearchQuery(" where departmentname!='admindepartment'");
			}
			else if("companyadmin".equals(currentSessionUserRole))
			{
				departmentBeanOB1.setSearchQuery(" where companyid='"+currentSessionUserCompanyID+"'");
			}			
			List<DepartmentBean> departmentBeanOB2 = new ArrayList<DepartmentBean>();
			departmentBeanOB2.add(departmentBeanOB1);		
			DepartmentDAO departmentDAOOB1 = new DepartmentDAO();
			List<DepartmentBean> departmentBeanOB3 = departmentDAOOB1.viewDepartment(departmentBeanOB2);
			int noOfDepartments = departmentBeanOB3.size();
			CapitalizeFirstLetter cfl = new CapitalizeFirstLetter();
		%>
			<div class="container-fluid">
				<div class="row">
					<div class="panel panel-primary">
						<div class="panel-heading">
							<h3 class="panel-title">Select Department</h3>
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
							<th>DepartmentName</th>																															
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
							<th>DepartmentName</th>
							<th>Status</th>
							<th>CreatedBy</th>
							<th>CreatedOn</th>
							<th>Edit</th>					
						</tr>
					</tfoot>
					<tbody>
						<%
						for(int i=0;i<noOfDepartments;i++)
						{
							companyID = departmentBeanOB3.get(i).getCompanyID();
							CompanyBean companyBeanOB1 = new CompanyBean();
							companyBeanOB1.setSearchQuery(" where companyid='"+companyID+"'");
							List<CompanyBean> companyBeanOB2 = new ArrayList<CompanyBean>();
							companyBeanOB2.add(companyBeanOB1);
							CompanyDAO companyDAOOB1 = new CompanyDAO();
							List<CompanyBean> companyBeanOB3 = companyDAOOB1.viewCompany(companyBeanOB2);
							companyName = cfl.capitalizeName(companyBeanOB3.get(0).getCompanyName());
							companyBeanOB1 = null;
							companyBeanOB2 = null;
							companyBeanOB3 = null;
							companyDAOOB1 = null;
							departmentName = cfl.capitalizeName(departmentBeanOB3.get(i).getDepartmentName());						
							status = departmentBeanOB3.get(i).getDepartmentStatus();
							if (status == 1)
							{
								statusValue="Active";
							}
							else
							{
								statusValue="DeActive";
							}				
							creationDateTime = departmentBeanOB3.get(i).getCreationDateTime();							
							createdByUserID = departmentBeanOB3.get(i).getCreatedByUserID();
							UserBean userBeanOB1 = new UserBean();
							userBeanOB1.setSearchQuery(" where userid='"+createdByUserID+"'");
							List<UserBean> userBeanOB2 = new ArrayList<UserBean>();
							userBeanOB2.add(userBeanOB1);
							UserDAO userDAOOB1 = new UserDAO();
							List<UserBean> userBeanOB3 = userDAOOB1.viewUser(userBeanOB2);
							createdByUserFirstName = cfl.capitalizeName(userBeanOB3.get(0).getUserFirstName());
							createdByUserEmployeeID = cfl.capitalizeName(userBeanOB3.get(0).getUserEmployeeID());
							departmentID = departmentBeanOB3.get(i).getDepartmentID();
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
								<td><%=departmentName%></td>
								<td><%=statusValue%></td>							
								<td>
									<%=createdByUserEmployeeID%>
									<br>
									<%=createdByUserFirstName%>
								</td>
								<td>
									<%=creationDateTime%>									
								</td>
								<td>
									<input type="hidden" name="sourceJSP" value="editDepartment.jsp"></input>
									<button type="submit" class="btn btn-info btn-sm" name="submitValue" value="<%=departmentID%>">Edit</button>
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
			DepartmentBean departmentBeanOB1 = new DepartmentBean();			
			departmentBeanOB1.setSearchQuery(" where departmentid='"+selectedDepartmentID+"'");
			List<DepartmentBean> departmentBeanOB2 = new ArrayList<DepartmentBean>();
			departmentBeanOB2.add(departmentBeanOB1);		
			DepartmentDAO departmentDAOOB1 = new DepartmentDAO();
			List<DepartmentBean> departmentBeanOB3 = departmentDAOOB1.viewDepartment(departmentBeanOB2);
			int noOfDepartments = departmentBeanOB3.size();
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
							<th>DepartmentName</th>																															
							<th>Status</th>
							<th>CreatedBy</th>
							<th>CreatedOn</th>							
						</tr>
					</thead>
					<tbody>
					<%
						for(int i=0;i<noOfDepartments;i++)
						{
							companyID = departmentBeanOB3.get(i).getCompanyID();
							CompanyBean companyBeanOB1 = new CompanyBean();
							companyBeanOB1.setSearchQuery(" where companyid='"+companyID+"'");
							List<CompanyBean> companyBeanOB2 = new ArrayList<CompanyBean>();
							companyBeanOB2.add(companyBeanOB1);
							CompanyDAO companyDAOOB1 = new CompanyDAO();
							List<CompanyBean> companyBeanOB3 = companyDAOOB1.viewCompany(companyBeanOB2);
							companyName = cfl.capitalizeName(companyBeanOB3.get(0).getCompanyName());
							departmentName = cfl.capitalizeName(departmentBeanOB3.get(i).getDepartmentName());						
							status = departmentBeanOB3.get(i).getDepartmentStatus();
							if (status == 1)
							{
								statusValue="Active";
							}
							else
							{
								statusValue="DeActive";
							}				
							creationDateTime = departmentBeanOB3.get(i).getCreationDateTime();							
							createdByUserID = departmentBeanOB3.get(i).getCreatedByUserID();
							UserBean userBeanOB1 = new UserBean();
							userBeanOB1.setSearchQuery(" where userid='"+createdByUserID+"'");
							List<UserBean> userBeanOB2 = new ArrayList<UserBean>();
							userBeanOB2.add(userBeanOB1);
							UserDAO userDAOOB1 = new UserDAO();
							List<UserBean> userBeanOB3 = userDAOOB1.viewUser(userBeanOB2);
							createdByUserFirstName = cfl.capitalizeName(userBeanOB3.get(0).getUserFirstName());
							createdByUserEmployeeID = cfl.capitalizeName(userBeanOB3.get(0).getUserEmployeeID());
							departmentID = departmentBeanOB3.get(i).getDepartmentID();
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
								<td><%=departmentName%></td>
								<td><%=statusValue%></td>							
								<td>
									<%=createdByUserEmployeeID%>
									<br>
									<%=createdByUserFirstName%>
								</td>
								<td>
									<%=creationDateTime%>									
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
							<div class="panel-heading" align="center">Edit Department</div>
							<div class="panel-body"> 
								<input type="hidden" class="form-control" name="departmentID" value="<%=departmentID%>"> 						  
  								<div class="form-group">  
      								<label class="control-label col-sm-4" for="departmentname">DepartmentName:</label>  
      								<div class="col-sm-8">
      									<input type="hidden" class="form-control" name="oldDepartmentName" value="<%=departmentName%>">  
        								<input type="text" class="form-control" name="newDepartmentName" placeholder="<%=departmentName%>" pattern="^(?=.*[A-Za-z0-9])[0-9a-zA-Z\s]{2,24}$"
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
	        							<button type="submit" class="btn btn-success" name="submitValue" value="updateDepartment">
        									<strong>Update</strong>
        								</button>
        								<input type="hidden" name="sourceJSP" value="editDepartment.jsp"></input>
        								<button type="submit" class="btn btn-info col-sm-offset-2" name="submitValue" value="selectanotherdepartment">
	        								<strong>Select Another Department</strong>
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