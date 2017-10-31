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
	String designationName;
	int status;
	String statusValue="null";
	Date creationDate;
	Date creationTime;
	int createdByUserID;
	String createdByUserEmployeeID;
	String createdByUserFirstName;
	int currentSessionUserID = (Integer) session.getAttribute("currentSessionUserID");
	String currentSessionUserRole = (String) session.getAttribute("currentSessionUserRole");
	int currentSessionUserCompanyID = (Integer) session.getAttribute("currentSessionUserCompanyID");
	DesignationBean designationBeanOB1 = new DesignationBean();
	if("rootadmin".equals(currentSessionUserRole))
	{
		designationBeanOB1.setSearchQuery(" where designationname!='admindesignation'");
	}
	else if("companyadmin".equals(currentSessionUserRole))
	{
		designationBeanOB1.setSearchQuery(" where companyid='"+currentSessionUserCompanyID+"'");
	}
	else
	{
		designationBeanOB1.setSearchQuery(" where companyid='"+currentSessionUserCompanyID+"' and status=1");
	}
	List<DesignationBean> designationBeanOB2 = new ArrayList<DesignationBean>();
	designationBeanOB2.add(designationBeanOB1);		
	DesignationDAO designationDAOOB1 = new DesignationDAO();
	List<DesignationBean> designationBeanOB3 = designationDAOOB1.viewDesignation(designationBeanOB2);
	int noOfDesignations = designationBeanOB3.size();
	CapitalizeFirstLetter cfl = new CapitalizeFirstLetter();
 %>
<body>
		<div class="container-fluid">
			<div class="row">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<h3 class="panel-title">Designation List</h3>
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