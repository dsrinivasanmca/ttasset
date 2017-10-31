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
	if("companyadmin".equals(currentSessionUserRole) || "branchadmin".equals(currentSessionUserRole))
	{
		int companyID;
		String companyName;
		String vendorCompanyName;
		int vendorCompanyID;
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
		Date creationDate;
		Date creationTime;
		int createdByUserID;
		String createdByUserEmployeeID;
		String createdByUserFirstName;
		int currentSessionUserID = (Integer) session.getAttribute("currentSessionUserID");		
		int currentSessionUserCompanyID = (Integer) session.getAttribute("currentSessionUserCompanyID");
		int currentSessionUserVendorCompanyID = (Integer) session.getAttribute("currentSessionUserVendorCompanyID");
		int selectedVendorCompanyID = (Integer) session.getAttribute("selectedVendorCompanyID");		
		VendorCompanyBean vendorCompanyBeanOB1 = new VendorCompanyBean();		
		if(selectedVendorCompanyID == 0)
		{						
			vendorCompanyBeanOB1.setSearchQuery(" where companyid='"+currentSessionUserCompanyID+"'");			
		}
		else
		{			
			vendorCompanyBeanOB1.setSearchQuery(" where vendorCompanyid='"+selectedVendorCompanyID+"'");
		}		
		List<VendorCompanyBean> vendorCompanyBeanOB2 = new ArrayList<VendorCompanyBean>();
		vendorCompanyBeanOB2.add(vendorCompanyBeanOB1);		
		VendorCompanyDAO vendorCompanyDAOOB1 = new VendorCompanyDAO();
		List<VendorCompanyBean> vendorCompanyBeanOB3;
		int noOfVendorCompanyes;
		CapitalizeFirstLetter cfl = new CapitalizeFirstLetter();
	 %>
	<body>
	<form class="form-horizontal" method="post" action="VendorCompanyServlet">
		<%
		if(selectedVendorCompanyID == 0)
		{
			vendorCompanyBeanOB3 = vendorCompanyDAOOB1.viewVendorCompany(vendorCompanyBeanOB2);
			noOfVendorCompanyes = vendorCompanyBeanOB3.size();		
		%>
			<div class="container-fluid">
				<div class="row">
					<div class="panel panel-primary">
						<div class="panel-heading">
							<h3 class="panel-title">Select VendorCompany</h3>
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
							<th>VendorCompanyName</th>
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
							<th>VendorCompanyName</th>
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
						for(int i=0;i<noOfVendorCompanyes;i++)
						{
							companyID = vendorCompanyBeanOB3.get(i).getCompanyID();
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
							vendorCompanyName = cfl.capitalizeName(vendorCompanyBeanOB3.get(i).getVendorCompanyName());
							vendorCompanyID = vendorCompanyBeanOB3.get(i).getVendorCompanyID();
							address1 = cfl.capitalizeName(vendorCompanyBeanOB3.get(i).getAddress1());
							address2 = cfl.capitalizeName(vendorCompanyBeanOB3.get(i).getAddress2());
							address3 = vendorCompanyBeanOB3.get(i).getAddress3();
							address4 = vendorCompanyBeanOB3.get(i).getAddress4();
							postalCode = cfl.capitalizeName(vendorCompanyBeanOB3.get(i).getPostalCode());
							city = cfl.capitalizeName(vendorCompanyBeanOB3.get(i).getCity());
							state = cfl.capitalizeName(vendorCompanyBeanOB3.get(i).getState());
							country = cfl.capitalizeName(vendorCompanyBeanOB3.get(i).getCountry());
							status = vendorCompanyBeanOB3.get(i).getVendorCompanyStatus();
							if (status == 1)
							{
								statusValue="Active";
							}
							else
							{
								statusValue="DeActive";
							}				
							creationDate = vendorCompanyBeanOB3.get(i).getCreationDate();
							creationTime = vendorCompanyBeanOB3.get(i).getCreationTime();
							createdByUserID = vendorCompanyBeanOB3.get(i).getCreatedByUserID();							
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
								<td><%=vendorCompanyName%></td>
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
									<%=creationDate%>
									<br>
									<%=creationTime%>
								</td>
								<td>
									<input type="hidden" name="sourceJSP" value="vendorCompanyLog.jsp"></input>
									<button type="submit" class="btn btn-info btn-sm" name="submitValue" value="<%=vendorCompanyID%>">Log</button>
								</td>
							</tr>
						<%
						}
						vendorCompanyBeanOB1 = null;
						vendorCompanyBeanOB2 = null;
						vendorCompanyBeanOB3 = null;
						vendorCompanyDAOOB1 = null;
						%>
					</tbody>
				</table>
			</div>
		<%
		}
		else
		{
			vendorCompanyBeanOB3 = vendorCompanyDAOOB1.vendorCompanyLog(vendorCompanyBeanOB2);
			int noOfVendorCompanyLog = vendorCompanyBeanOB3.size();
			String description;
		%>	 		
			<div class="container-fluid">
				<div class="row">
					<div class="panel panel-primary">
						<div class="panel-heading">
							<h3 class="panel-title">Selected VendorCompany</h3>
						</div>
					</div>
				</div>
			</div>
			<div class="container-fluid">
				<table id="dataTable" class="table table-striped table-bordered" cellspacing="0">
					<thead>
						<tr>
							<th>S.No</th>
							<th>VendorCompanyName</th>
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
							<th>VendorCompanyName</th>
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
						for (int i=0; i < noOfVendorCompanyLog; i++ )
						{
							vendorCompanyName = cfl.capitalizeName(vendorCompanyBeanOB3.get(i).getVendorCompanyName());
							address1 = cfl.capitalizeName(vendorCompanyBeanOB3.get(i).getAddress1());
							address2 = cfl.capitalizeName(vendorCompanyBeanOB3.get(i).getAddress2());
							address3 = cfl.capitalizeName(vendorCompanyBeanOB3.get(i).getAddress3());							
							address4 = cfl.capitalizeName(vendorCompanyBeanOB3.get(i).getAddress4());							
							postalCode = cfl.capitalizeName(vendorCompanyBeanOB3.get(i).getPostalCode());
							city = cfl.capitalizeName(vendorCompanyBeanOB3.get(i).getCity());
							state = cfl.capitalizeName(vendorCompanyBeanOB3.get(i).getState());
							country = cfl.capitalizeName(vendorCompanyBeanOB3.get(i).getCountry());
							status = vendorCompanyBeanOB3.get(i).getVendorCompanyStatus();
							if (status == 1)
							{
								statusValue="Active";
							}
							else
							{
								statusValue="DeActive";
							}
							creationDate = vendorCompanyBeanOB3.get(i).getCreationDate();
							creationTime = vendorCompanyBeanOB3.get(i).getCreationTime();
							createdByUserID = vendorCompanyBeanOB3.get(i).getCreatedByUserID();
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
							description = cfl.capitalizeName(vendorCompanyBeanOB3.get(i).getDescription());
						%>
							<tr>
								<td><%=i+1%></td>
								<td><%=vendorCompanyName%></td>
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
									<%=creationDate%>
									<br>
									<%=creationTime%>
								</td>
								<td><%=description%></td>
							</tr>
						<%
						}
						vendorCompanyBeanOB1 = null;
						vendorCompanyBeanOB2 = null;
						vendorCompanyBeanOB3 = null;
						vendorCompanyDAOOB1 = null;
						%>
					</tbody>					
				</table>				
				<div class="form-group">          
      				<div class="col-sm-offset-4 col-sm-8">
      					<input type="hidden" name="sourceJSP" value="vendorCompanyLog.jsp"></input>  
	        			<button type="submit" class="btn btn-info col-sm-offset-1" name="submitValue" value="selectAnotherVendorCompany">
	        				<strong>Select Another VendorCompany</strong>
        				</button>  
      				</div>
      			</div>      			 
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