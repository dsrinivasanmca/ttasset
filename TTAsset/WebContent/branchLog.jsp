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
	if("rootadmin".equals(currentSessionUserRole) || "companyadmin".equals(currentSessionUserRole) || "branchadmin".equals(currentSessionUserRole))
	{
		int companyID;
		String companyName;
		String branchName;
		int branchID;
		String address1;
		String address2;
		String address3;
		String address4;
		String postalCode;
		String city;
		String state;
		String country;
		int status;
		String statusValue="null";
		String creationDateTime;		
		int createdByUserID;
		String createdByUserEmployeeID;
		String createdByUserFirstName;
		int currentSessionUserID = (Integer) session.getAttribute("currentSessionUserID");		
		int currentSessionUserCompanyID = (Integer) session.getAttribute("currentSessionUserCompanyID");
		int currentSessionUserBranchID = (Integer) session.getAttribute("currentSessionUserBranchID");
		int selectedBranchID = (Integer) session.getAttribute("selectedBranchID");		
		BranchBean branchBeanOB1 = new BranchBean();
		if("branchadmin".equals(currentSessionUserRole))
		{
			selectedBranchID = currentSessionUserBranchID;
		}
		if(selectedBranchID == 0)
		{			
			if("rootadmin".equals(currentSessionUserRole))
			{
				branchBeanOB1.setSearchQuery(" where branchname!='adminbranch'");	
			}
			else if("companyadmin".equals(currentSessionUserRole))
			{
				branchBeanOB1.setSearchQuery(" where companyid='"+currentSessionUserCompanyID+"'");
			}
		}
		else
		{			
			branchBeanOB1.setSearchQuery(" where branchid='"+selectedBranchID+"'");
		}		
		List<BranchBean> branchBeanOB2 = new ArrayList<BranchBean>();
		branchBeanOB2.add(branchBeanOB1);		
		BranchDAO branchDAOOB1 = new BranchDAO();
		List<BranchBean> branchBeanOB3;
		int noOfBranches;
		CapitalizeFirstLetter cfl = new CapitalizeFirstLetter();
	 %>
	<body>
	<form class="form-horizontal" method="post" action="BranchServlet">
		<%
		if(selectedBranchID == 0)
		{
			branchBeanOB3 = branchDAOOB1.viewBranch(branchBeanOB2);
			noOfBranches = branchBeanOB3.size();		
		%>
			<div class="container-fluid">
				<div class="row">
					<div class="panel panel-primary">
						<div class="panel-heading">
							<h3 class="panel-title">Select Branch</h3>
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
							<th>BranchName</th>
							<th>Address</th>
							<th>City</th>
							<th>State</th>
							<th>Country</th>																			
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
							<th>BranchName</th>
							<th>Address</th>
							<th>City</th>
							<th>State</th>
							<th>Country</th>													
							<th>Status</th>
							<th>CreatedBy</th>
							<th>CreatedOn</th>
							<td></td>					
						</tr>
					</tfoot>
					<tbody>
						<%
						for(int i=0;i<noOfBranches;i++)
						{
							companyID = branchBeanOB3.get(i).getCompanyID();
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
							branchName = cfl.capitalizeName(branchBeanOB3.get(i).getBranchName());
							branchID = branchBeanOB3.get(i).getBranchID();
							address1 = cfl.capitalizeName(branchBeanOB3.get(i).getAddress1());
							address2 = cfl.capitalizeName(branchBeanOB3.get(i).getAddress2());
							address3 = branchBeanOB3.get(i).getAddress3();
							address4 = branchBeanOB3.get(i).getAddress4();
							postalCode = cfl.capitalizeName(branchBeanOB3.get(i).getPostalCode());
							city = cfl.capitalizeName(branchBeanOB3.get(i).getCity());
							state = cfl.capitalizeName(branchBeanOB3.get(i).getState());
							country = cfl.capitalizeName(branchBeanOB3.get(i).getCountry());
							status = branchBeanOB3.get(i).getBranchStatus();
							if (status == 1)
							{
								statusValue="Active";
							}
							else
							{
								statusValue="DeActive";
							}				
							creationDateTime = branchBeanOB3.get(i).getCreationDateTime();							
							createdByUserID = branchBeanOB3.get(i).getCreatedByUserID();							
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
								<%
								if("rootadmin".equals(currentSessionUserRole))
								{
								%>
									<td><%=companyName%></td>
								<%
								}
								%>
								<td><%=branchName%></td>
								<td>
									<%=address1%>
									<br>
									<%=address2%>
									<%if(address3 != null)
									{
									%>
										<br>
									<%		
										out.println(cfl.capitalizeName(address3));
									}
									if(address4 != null)
									{
									%>
										<br>
									<%		
										out.println(cfl.capitalizeName(address4));
									}
									%>
									<br>
									PostalCode=<%=postalCode%>
								</td>							
								<td><%=city%></td>
								<td><%=state%></td>
								<td><%=country%></td>
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
									<input type="hidden" name="sourceJSP" value="branchLog.jsp"></input>
									<button type="submit" class="btn btn-info btn-sm" name="submitValue" value="<%=branchID%>">Log</button>
								</td>
							</tr>
						<%
						}
						branchBeanOB1 = null;
						branchBeanOB2 = null;
						branchBeanOB3 = null;
						branchDAOOB1 = null;
						%>
					</tbody>
				</table>
			</div>
		<%
		}
		else
		{
			branchBeanOB3 = branchDAOOB1.branchLog(branchBeanOB2);
			int noOfBranchLog = branchBeanOB3.size();
			String description;
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
				<table id="dataTable" class="table table-striped table-bordered" cellspacing="0">
					<thead>
						<tr>
							<th>S.No</th>
							<th>BranchName</th>
							<th>Address</th>
							<th>City</th>
							<th>State</th>
							<th>Country</th>																				
							<th>Status</th>						
							<th>ModifiedBy</th>
							<th>ModifiedOn</th>
							<th>Description</th>
						</tr>
					</thead>
					<tfoot>
						<tr>
							<th>S.No</th>
							<th>BranchName</th>
							<th>Address</th>
							<th>City</th>
							<th>State</th>
							<th>Country</th>																				
							<th>Status</th>						
							<th>ModifiedBy</th>
							<th>ModifiedOn</th>
							<th>Description</th>
						</tr>
					</tfoot>
					<tbody>
						<%
						for (int i=0; i < noOfBranchLog; i++ )
						{
							branchName = cfl.capitalizeName(branchBeanOB3.get(i).getBranchName());
							address1 = cfl.capitalizeName(branchBeanOB3.get(i).getAddress1());
							address2 = cfl.capitalizeName(branchBeanOB3.get(i).getAddress2());
							address3 = cfl.capitalizeName(branchBeanOB3.get(i).getAddress3());							
							address4 = cfl.capitalizeName(branchBeanOB3.get(i).getAddress4());							
							postalCode = cfl.capitalizeName(branchBeanOB3.get(i).getPostalCode());
							city = cfl.capitalizeName(branchBeanOB3.get(i).getCity());
							state = cfl.capitalizeName(branchBeanOB3.get(i).getState());
							country = cfl.capitalizeName(branchBeanOB3.get(i).getCountry());
							status = branchBeanOB3.get(i).getBranchStatus();
							if (status == 1)
							{
								statusValue="Active";
							}
							else
							{
								statusValue="DeActive";
							}
							creationDateTime = branchBeanOB3.get(i).getCreationDateTime();							
							createdByUserID = branchBeanOB3.get(i).getCreatedByUserID();
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
							description = cfl.capitalizeName(branchBeanOB3.get(i).getDescription());
						%>
							<tr>
								<td><%=i+1%></td>
								<td><%=branchName%></td>
								<td>
									<%=address1%>
									<br>
									<%=address2%>
									<%if(address3 != null)
									{
									%>
										<br>
									<%		
										out.println(address3);
									}
									if(address4 != null)
									{
									%>
										<br>
									<%		
										out.println(address4);
									}
									%>
									<br>
									PostalCode=<%=postalCode%>
								</td>							
								<td><%=city%></td>
								<td><%=state%></td>
								<td><%=country%></td>							
								<td><%=statusValue%></td>												
								<td>
									<%=createdByUserEmployeeID%>
									<br>	
									<%=createdByUserFirstName%>
								</td>
								<td>
									<%=creationDateTime%>
								</td>
								<td><%=description%></td>
							</tr>
						<%
						}
						branchBeanOB1 = null;
						branchBeanOB2 = null;
						branchBeanOB3 = null;
						branchDAOOB1 = null;
						%>
					</tbody>					
				</table>
				<%
  				if("rootadmin".equals(currentSessionUserRole) || "companyadmin".equals(currentSessionUserRole))
  				{
  				%>
					<div class="form-group">          
      					<div class="col-sm-offset-4 col-sm-8">
      						<input type="hidden" name="sourceJSP" value="branchLog.jsp"></input>  
	        				<button type="submit" class="btn btn-info col-sm-offset-1" name="submitValue" value="selectAnotherBranch">
	        					<strong>Select Another Branch</strong>
        					</button>  
      					</div>
      				</div>
      			<%
  				}
      			%>  
    		</div>					
		<%
		}
	}
	%>
	</form>
</body>
<%
}
%>
</html>