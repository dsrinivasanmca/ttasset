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
if( session != null && session.getAttribute("currentSessionUserID") != null)
{
	int companyID;
	String companyName;
	String departmentName;
	int status;
	String statusValue="null";
	String creationDateTime;	
	int createdByUserID;
	String createdByUserEmployeeID;
	String createdByUserFirstName;
	int currentSessionUserID = (Integer) session.getAttribute("currentSessionUserID");
	String currentSessionUserRole = (String) session.getAttribute("currentSessionUserRole");
	int currentSessionUserCompanyID = (Integer) session.getAttribute("currentSessionUserCompanyID");
	DepartmentBean departmentBeanOB1 = new DepartmentBean();
	if("rootadmin".equals(currentSessionUserRole))
	{
		departmentBeanOB1.setSearchQuery(" where departmentname!='admindepartment'");
	}
	else if("companyadmin".equals(currentSessionUserRole))
	{
		departmentBeanOB1.setSearchQuery(" where companyid='"+currentSessionUserCompanyID+"'");
	}
	else
	{
		departmentBeanOB1.setSearchQuery(" where companyid='"+currentSessionUserCompanyID+"' and status=1");
	}
	List<DepartmentBean> departmentBeanOB2 = new ArrayList<DepartmentBean>();
	departmentBeanOB2.add(departmentBeanOB1);		
	DepartmentDAO departmentDAOOB1 = new DepartmentDAO();
	List<DepartmentBean> departmentBeanOB3 = departmentDAOOB1.viewDepartment(departmentBeanOB2);
	int noOfDepartments = departmentBeanOB3.size();
	CapitalizeFirstLetter cfl = new CapitalizeFirstLetter();
 %>
<body>
		<div class="container-fluid">
			<div class="row">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<h3 class="panel-title">Department List</h3>
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
						</tr>
					<%
					}
					%>
				</tbody>
			</table>
		</div>	
</body>
<%
}
%>
</html>