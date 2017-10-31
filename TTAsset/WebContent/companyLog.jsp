<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@ page import="com.tt.asset.*"%>
<%@ include file="actionBar.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Date"%>
<%@page import="java.util.Collections"%>
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
	int currentSessionUserID = (Integer) session.getAttribute("currentSessionUserID");
	String currentSessionUserRole = (String) session.getAttribute("currentSessionUserRole");
	int selectedCompanyID = (Integer) session.getAttribute("selectedCompanyID");	
	int companyID;
	String companyName;
	Date openingDate;
	int status;
	String statusValue="null";
	Date creationDate;
	Date creationTime;
	int createdByUserID;
	String createdByUserEmployeeID;
	String createdByUserFirstName;
	String description;
	int NoOfCompanies;
	int currentSessionUserCompanyID = (Integer) session.getAttribute("currentSessionUserCompanyID");		
	CompanyBean companyBeanOB1 = new CompanyBean();
	if(!"rootadmin".equals(currentSessionUserRole))
	{
		selectedCompanyID = currentSessionUserCompanyID;
	}
	if(selectedCompanyID == 0)
	{
		companyBeanOB1.setSearchQuery(" where companyname!='admincompany'");	
	}
	else
	{
		companyBeanOB1.setSearchQuery(" where companyid='"+selectedCompanyID+"'");
	}	
	List<CompanyBean> companyBeanOB2 = new ArrayList<CompanyBean>();
	companyBeanOB2.add(companyBeanOB1);
	CompanyDAO companyDAOOB1 = new CompanyDAO();
	CapitalizeFirstLetter cfl = new CapitalizeFirstLetter();
 	%>
	<body>
	<form class="form-horizontal" method="post" action="CompanyServlet">
	<%
	if(selectedCompanyID == 0)
	{
		List<CompanyBean> companyBeanOB3 = companyDAOOB1.viewCompany(companyBeanOB2);	
		NoOfCompanies = companyBeanOB3.size();		
	%>
		<div class="container-fluid">
			<div class="row">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<h3 class="panel-title">Select Company</h3>
					</div>
				</div>
			</div>
		</div>
		<div class="container-fluid">
			<table id="dataTable" class="table table-striped table-bordered" cellspacing="0">
				<thead>
					<tr>
						<th>S.No</th>
						<th>Name</th>
						<th>OpeningDate</th>																									
						<th>Status</th>
						<th>CreatedBy</th>
						<th>CreatedOn</th>
						<th>Edit</th>
					</tr>
				</thead>
				<tfoot>
					<tr>
						<th>S.No</th>
						<th>Name</th>
						<th>OpeningDate</th>																			
						<th>Status</th>
						<th>CreatedBy</th>
						<th>CreatedOn</th>
						<td></td>
					</tr>
				</tfoot>
				<tbody>
					<%
					for(int i=0;i<NoOfCompanies;i++)
					{
						companyID = companyBeanOB3.get(i).getCompanyID();
						companyName =  companyBeanOB3.get(i).getCompanyName();
						openingDate =  companyBeanOB3.get(i).getOpeningDate();
						status = companyBeanOB3.get(i).getCompanyStatus();
						if (status == 1)
						{
							statusValue="Active";
						}
						else
						{
							statusValue="DeActive";
						}				
						creationDate = companyBeanOB3.get(i).getCreationDate();
						creationTime = companyBeanOB3.get(i).getCreationTime();
						createdByUserID = companyBeanOB3.get(i).getCreatedByUserID();
						UserBean userBeanOB1 = new UserBean();
						userBeanOB1.setSearchQuery(" where userid='"+createdByUserID+"'");
						List<UserBean> userBeanOB2 = new ArrayList<UserBean>();
						userBeanOB2.add(userBeanOB1);
						UserDAO userDAOOB1 = new UserDAO();
						List<UserBean> userBeanOB3 = userDAOOB1.viewUser(userBeanOB2);
						createdByUserFirstName = cfl.capitalizeName(userBeanOB3.get(0).getUserFirstName());
						createdByUserEmployeeID = cfl.capitalizeName(userBeanOB3.get(0).getUserEmployeeID());
						userBeanOB1 = null;
						userBeanOB2 = null;
						userBeanOB3 = null;
						userDAOOB1 = null;
					%>					
						<tr>
							<td><%=i+1%></td>
							<td><%=cfl.capitalizeName(companyName)%></td>
							<td><%=openingDate%></td>								
							<td><%=statusValue%></td>							
							<td>
								<%=createdByUserEmployeeID%>
								<br>
								<%=cfl.capitalizeName(createdByUserFirstName)%>
							</td>
							<td>
								<%=creationDate%>
								<br>
								<%=creationTime%>
							</td>
							<td>
								<input type="hidden" name="sourceJSP" value="companyLog.jsp"></input>
								<button type="submit" class="btn btn-info btn-sm" name="submitValue" value="<%=companyID%>">Log</button>
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
		List<CompanyBean> companyBeanOB3 = companyDAOOB1.companyLog(companyBeanOB2);	
		NoOfCompanies = companyBeanOB3.size();		
		int NoOfCompanyLogs = companyBeanOB3.size();
	%>	 		
		<div class="container-fluid">
			<div class="row">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<h3 class="panel-title">Selected Company</h3>
					</div>
				</div>
			</div>
		</div>
		<div class="container-fluid">
			<table id="dataTable" class="table table-striped table-bordered" cellspacing="0">
				<thead>
					<tr>
						<th>S.No</th>
						<th>Name</th>
						<th>OpeningDate</th>																								
						<th>Status</th>
						<th>ModifiedBy</th>
						<th>ModifiedOn</th>
						<th>Description</th>
					</tr>
				</thead>
				<tfoot>
					<tr>
						<th>S.No</th>
						<th>Name</th>
						<th>OpeningDate</th>																		
						<th>Status</th>
						<th>ModifiedBy</th>
						<th>ModifiedOn</th>
						<th>Description</th>
					</tr>
				</tfoot>
				<tbody>
					<%
					for(int i=0;i<NoOfCompanyLogs;i++)
					{
						companyName = cfl.capitalizeName(companyBeanOB3.get(i).getCompanyName());
						openingDate = companyBeanOB3.get(i).getOpeningDate();
						status = companyBeanOB3.get(i).getCompanyStatus();
						if (status == 1)
						{
							statusValue="Active";
						}
						else
						{
							statusValue="DeActive";
						}				
						creationDate = companyBeanOB3.get(i).getCreationDate();
						creationTime = companyBeanOB3.get(i).getCreationTime();
						createdByUserID = companyBeanOB3.get(i).getCreatedByUserID();
						UserBean userBeanOB1 = new UserBean();
						userBeanOB1.setSearchQuery(" where userid='"+createdByUserID+"'");
						List<UserBean> userBeanOB2 = new ArrayList<UserBean>();
						userBeanOB2.add(userBeanOB1);
						UserDAO userDAOOB1 = new UserDAO();
						List<UserBean> userBeanOB3 = userDAOOB1.viewUser(userBeanOB2);
						createdByUserFirstName = cfl.capitalizeName(userBeanOB3.get(0).getUserFirstName());
						createdByUserEmployeeID = cfl.capitalizeName(userBeanOB3.get(0).getUserEmployeeID());
						userBeanOB1 = null;
						userBeanOB2 = null;
						userBeanOB3 = null;
						userDAOOB1 = null;
						description = cfl.capitalizeName(companyBeanOB3.get(i).getDescription());
					%>					
						<tr>
							<td><%=i+1%></td>
							<td><%=companyName%></td>
							<td><%=openingDate%></td>							
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
								<%=description%>
							</td>
						</tr>
					<%
					}
					%>
				</tbody>
			</table>
			<%
			if("rootadmin".equals(currentSessionUserRole))
			{
			%>
				<div class="form-group">          
      				<div class="col-sm-offset-4 col-sm-8">
      					<input type="hidden" name="sourceJSP" value="companyLog.jsp"></input>  
	        			<button type="submit" class="btn btn-info col-sm-offset-1" name="submitValue" value="selectAnotherCompany">
	        				<strong>Select Another Company</strong>
        				</button>  
      				</div>  
    			</div>
			<%	
			}
			%>			
		</div>		
	<%
	}
	%>
	</form>
</body>
<%
}
%>
</html>