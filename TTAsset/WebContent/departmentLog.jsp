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
	String currentSessionUserRole = (String) session.getAttribute("currentSessionUserRole");
	if("rootadmin".equals(currentSessionUserRole) || "companyadmin".equals(currentSessionUserRole) || "branchadmin".equals(currentSessionUserRole))
	{
		int companyID;
		int departmentID = 0;
		String companyName;
		String departmentName = null;
		int status = 0;
		String statusValue="null";
		String modifiedDateTime;		
		int modifiedByUserID;
		String modifiedByUserEmployeeID;
		String modifiedByUserFirstName;
		String description;
		int currentSessionUserID = (Integer) session.getAttribute("currentSessionUserID");	
		int currentSessionUserCompanyID = (Integer) session.getAttribute("currentSessionUserCompanyID");
		int selectedDepartmentID = (Integer) session.getAttribute("selectedDepartmentID");
		int selectedCompanyID = 0;
		%>
		<body>
			<form name="departmentLog" method="post" action="DepartmentServlet">
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
				else if("branchadmin".equals(currentSessionUserRole))
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
								<th>ModifiedBy</th>
								<th>ModifiedOn</th>
								<th>Log</th>
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
								<th>ModifiedBy</th>
								<th>ModifiedOn</th>
								<th>Log</th>					
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
								modifiedDateTime = departmentBeanOB3.get(i).getCreationDateTime();								
								modifiedByUserID = departmentBeanOB3.get(i).getCreatedByUserID();
								UserBean userBeanOB1 = new UserBean();
								userBeanOB1.setSearchQuery(" where userid='"+modifiedByUserID+"'");
								List<UserBean> userBeanOB2 = new ArrayList<UserBean>();
								userBeanOB2.add(userBeanOB1);
								UserDAO userDAOOB1 = new UserDAO();
								List<UserBean> userBeanOB3 = userDAOOB1.viewUser(userBeanOB2);
								modifiedByUserFirstName = cfl.capitalizeName(userBeanOB3.get(0).getUserFirstName());
								modifiedByUserEmployeeID = cfl.capitalizeName(userBeanOB3.get(0).getUserEmployeeID());
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
										<%=modifiedByUserEmployeeID%>
										<br>
										<%=modifiedByUserFirstName%>
									</td>
									<td>
										<%=modifiedDateTime%>										
									</td>
									<td>
										<input type="hidden" name="sourceJSP" value="departmentLog.jsp"></input>
										<button type="submit" class="btn btn-info btn-sm" name="submitValue" value="<%=departmentID%>">Log</button>
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
				List<DepartmentBean> departmentBeanOB3 = departmentDAOOB1.departmentLog(departmentBeanOB2);
				int noOfDepartmentLog = departmentBeanOB3.size();
				CapitalizeFirstLetter cfl = new CapitalizeFirstLetter();
			%>
				<div class="container-fluid">
					<table id="dataTable" class="table table-striped table-bordered" cellspacing="0">
						<thead>
							<tr>
								<th>S.No</th>
								<th>DepartmentName</th>																															
								<th>Status</th>						
								<th>ModifiedBy</th>
								<th>ModifiedOn</th>
								<th>Description</th>
							</tr>
						</thead>
						<tfoot>
							<tr>
								<th>S.No</th>
								<th>DepartmentName</th>																				
								<th>Status</th>						
								<th>ModifiedBy</th>
								<th>ModifiedOn</th>
								<th>Description</th>
							</tr>
						</tfoot>
						<tbody>
							<%
							for (int i=0; i < noOfDepartmentLog; i++ )
							{
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
								modifiedDateTime = departmentBeanOB3.get(i).getCreationDateTime();								
								modifiedByUserID = departmentBeanOB3.get(i).getCreatedByUserID();
								UserBean userBeanOB1 = new UserBean();
								userBeanOB1.setSearchQuery(" where userid='"+modifiedByUserID+"'");
								List<UserBean> userBeanOB2 = new ArrayList<UserBean>();
								userBeanOB2.add(userBeanOB1);
								UserDAO userDAOOB1 = new UserDAO();
								List<UserBean> userBeanOB3 = userDAOOB1.viewUser(userBeanOB2);
								modifiedByUserFirstName = cfl.capitalizeName(userBeanOB3.get(0).getUserFirstName());
								modifiedByUserEmployeeID = cfl.capitalizeName(userBeanOB3.get(0).getUserEmployeeID());
								description = cfl.capitalizeName(departmentBeanOB3.get(i).getDescription());
							%>
								<tr>
									<td><%=i+1%></td>
									<td><%=departmentName%></td>														
									<td><%=statusValue%></td>												
									<td>
										<%=modifiedByUserEmployeeID%>
										<br>	
										<%=modifiedByUserFirstName%>
									</td>
									<td>
										<%=modifiedDateTime%>
									</td>
									<td><%=description%></td>
								</tr>
							<%
							}
							%>
						</tbody>					
					</table>
					<div class="form-group">          
	      				<div class="col-sm-offset-4 col-sm-8">
      						<input type="hidden" name="sourceJSP" value="departmentLog.jsp"></input>  
	        				<button type="submit" class="btn btn-info col-sm-offset-1" name="submitValue" value="selectanotherdepartment">
		        				<strong>Select Another Department</strong>
        					</button>  
      					</div>
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