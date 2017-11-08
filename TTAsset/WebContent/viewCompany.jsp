<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@ page import="com.tt.asset.*"%>
<%@ include file="actionBar.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/dataTables.bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/dataTableWithSearch.css">
<script type="text/javascript" language="javascript" src="css/jquery-1.12.4.js"></script>
<script type="text/javascript" language="javascript" src="css/jquery.dataTables.min.js"></script>
<script type="text/javascript" language="javascript" src="css/dataTables.bootstrap.min.js"></script>
<script type="text/javascript" language="javascript" src="css/dataTableWithSearch.js"></script>
<%
if( session != null && session.getAttribute("currentSessionUserID") != null)
{
	int companyID;
	String companyName;
	String openingDate;
	int status;
	String statusValue="null";
	String creationDateTime;	
	int createdByUserID;
	String createdByUserEmployeeID;
	String createdByUserFirstName;
	int currentSessionUserID = (Integer) session.getAttribute("currentSessionUserID");
	String currentSessionUserRole = (String) session.getAttribute("currentSessionUserRole");
	int currentSessionUserCompanyID = (Integer) session.getAttribute("currentSessionUserCompanyID");	
	String searchQuery;
	if("rootadmin".equals(currentSessionUserRole))
	{
		searchQuery = " where companyname!='admincompany'";
	}
	else
	{
		searchQuery = " where companyid='"+currentSessionUserCompanyID+"'";
	}	
	CompanyBean companyBeanOB1 = new CompanyBean();
	companyBeanOB1.setSearchQuery(searchQuery);
	List<CompanyBean> companyBeanOB2 = new ArrayList<CompanyBean>();
	companyBeanOB2.add(companyBeanOB1);
	CompanyDAO companyDAOOB1 = new CompanyDAO();
	List<CompanyBean> companyBeanOB3 = companyDAOOB1.viewCompany(companyBeanOB2);	
	int NoOfCompanies = companyBeanOB3.size();
	CapitalizeFirstLetter cfl = new CapitalizeFirstLetter();
 %>
<body>
	<div class="container-fluid">
		<div class="row">
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h3 class="panel-title">Company List</h3>
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
				</tr>
			<tbody>				
				<%
				for(int i=0;i<NoOfCompanies;i++)
				{
					companyID = companyBeanOB3.get(i).getCompanyID();
					companyName =  companyBeanOB3.get(i).getCompanyName();
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
					creationDateTime = companyBeanOB3.get(i).getCreationDateTime();					
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
							<%=creationDateTime%>													
						</td>
					</tr>
				<%
				}
				companyBeanOB1 = null;
				companyBeanOB2 = null;
				companyBeanOB3 = null;
				companyDAOOB1 = null;
				%>
			</tbody>
		</table>			
	</div>		
</body>
<%
}
%>
</html>