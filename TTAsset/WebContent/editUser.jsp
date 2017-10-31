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
<link rel="stylesheet" type="text/css" href="css/bootstrap-datetimepicker.min.css">
<script type="text/javascript" language="javascript" src="css/jquery-1.12.4.js"></script>
<script type="text/javascript" language="javascript" src="css/jquery.dataTables.min.js"></script>
<script type="text/javascript" language="javascript" src="css/dataTables.bootstrap.min.js"></script>
<script type="text/javascript" language="javascript" src="css/dataTableWithSearch.js"></script>
<script type="text/javascript" src="css/bootstrap-datetimepicker.js"></script>
<script type="text/javascript">
$(document).ready(function() 
{
	$('#dataTable1').DataTable
	({
		"scrollX": true,
		"bPaginate": false,		
		"sDom": 'rt'
	});	
});
</script>

<%
if( session != null && session.getAttribute("currentSessionUserID") != null && session.getAttribute("currentSessionUserRole") != null) 
{
	String currentSessionUserRole = (String) session.getAttribute("currentSessionUserRole");	
	if("rootadmin".equals(currentSessionUserRole) || "companyadmin".equals(currentSessionUserRole) || "branchadmin".equals(currentSessionUserRole))
	{
		int companyID;
		String companyName;
		int vendorCompanyID;
		String vendorCompanyName;
		int workingCompanyID;
		String workingCompanyName;
		int branchID;
		String branchName;
		int userID;
		String userType;
		String newUserType;
		String oldUserType;
		String employeeID;
		String userFirstName;
		String userLastName;
		String mobileNo;
		String emailID;
		Date joiningDate;
		String roleName;
		int departmentID;
		String departmentName;
		int designationID;
		String designationName;
		String gender;
		String genderValue="null";
		int status;
		String statusValue="null";
		Date creationDate;
		Date creationTime;
		int createdByUserID;
		String createdByUserEmployeeID;
		String createdByUserFirstName;
		int currentSessionUserID = (Integer) session.getAttribute("currentSessionUserID");		
		int currentSessionUserCompanyID = (Integer) session.getAttribute("currentSessionUserCompanyID");
		int currentSessionUserBranchID = (Integer) session.getAttribute("currentSessionUserBranchID");
		int selectedUserID = (Integer) session.getAttribute("selectedUserID");		
		UserBean userBeanOB1 = new UserBean();		
		List<UserBean> userBeanOB2 = new ArrayList<UserBean>();				
		UserDAO userDAOOB1 = new UserDAO();		
		CapitalizeFirstLetter cfl = new CapitalizeFirstLetter();
				
	 %>
		<body>
		<form class="form-horizontal" method="post" action="UserServlet" id="editUser">
	<%
			int selectedCompanyID= (Integer)session.getAttribute("selectedCompanyID");
			int oldSelectedCompanyID = (Integer) session.getAttribute("oldSelectedCompanyID");
			String selectedUserType = (String)session.getAttribute("selectedUserType");
			String oldSelectedUserType = (String) session.getAttribute("oldSelectedUserType");
			int selectedUserStatus = (Integer)session.getAttribute("selectedUserStatus");
			int oldSelectedUserStatus = (Integer) session.getAttribute("oldSelectedUserStatus");			
			if(selectedUserID == 0)
			{
			%>
				<input type="hidden" name="sourceJSP" value="editUser.jsp"></input>		
				<div class="container">
					<div class="row">
						<div class="col-sm-2"></div>
						<div class="col-sm-8">
							<div class="panel panel-primary well well-sm">
								<div class="panel-heading" align="center">User</div>
								<div class="panel-body">						
									<div class="form-group">  
  		      							<label class="control-label col-sm-4" for="status">Company</label>
  	  									<div class="col-sm-8">  	  									
  	  										<input type="hidden" name="oldSelectedCompanyID" value=<%=oldSelectedCompanyID%>>  	  									 	  										 										     
  	    									<select class="form-control" name="selectedCompanyID" required onchange="this.form.submit()">
  	    										<% 
  	    										String companyFilter = null;
    											if(selectedCompanyID == 1000)
    											{
    												companyFilter = "companyid like '%%'";
    											}
    											else
    											{
	    											companyFilter = "companyid ='"+selectedCompanyID+"'";
    											}
    											String userTypeFilter = null;
    											if("ALL".equals(selectedUserType))
    											{
	    											userTypeFilter = "usertype like '%%'";
    											}
    											else
    											{
	    											userTypeFilter = "usertype ='"+selectedUserType+"'";
    											}
    											String userStatusFilter = null;
    											if(selectedUserStatus == 2)
    											{
	    											userStatusFilter = "status like '%%'";
    											}
    											else
    											{
	    											userStatusFilter = "status ='"+selectedUserStatus+"'";
    											}
    											userBeanOB1 = new UserBean();        										
  												if("rootadmin".equals(currentSessionUserRole))
  												{
	      											userBeanOB1.setSearchQuery(" where employeeid!='adminuser'");
  													//userTypeBeanOB1.setSearchQuery(" where usertype like '%%'");
  												}
  												else if("companyadmin".equals(currentSessionUserRole))
  												{
	      											userBeanOB1.setSearchQuery(" where userid='"+currentSessionUserID+"'");      											
  												}
  												userBeanOB2 = new ArrayList<UserBean>();
  												userBeanOB2.add(userBeanOB1);
  												userDAOOB1 = new UserDAO();
  												List<UserBean> userBeanOB3 = userDAOOB1.distinctUserCompanyID(userBeanOB2);	  											
  	  											int NoOfCompanies = userBeanOB3.size();  																		
  	  											if("rootadmin".equals(currentSessionUserRole))
  												{
  	  											%>
		  	  										<option value="">Select Company</option>
  	  											<%
  												}  	  											  	  										
    											for(int i=0;i<NoOfCompanies;i++)
												{
													companyID = userBeanOB3.get(i).getUserCompanyID();													
													CompanyBean companyBeanOB1 = new CompanyBean();
	  	  											List<CompanyBean> companyBeanOB2 = new ArrayList<CompanyBean>();
	  	  										    CompanyDAO companyDAOOB1 = new CompanyDAO();
		  											companyBeanOB1.setSearchQuery(" where companyid='"+companyID+"'"); 	  												  								  	  											
	  	  											companyBeanOB2.add(companyBeanOB1);	  	  											
	  	  											List<CompanyBean> companyBeanOB3 = companyDAOOB1.viewCompany(companyBeanOB2);
													companyName = companyBeanOB3.get(0).getCompanyName().toUpperCase();
													companyBeanOB1 = null;
	  	    										companyBeanOB2 = null;  	    										
	  	    										companyDAOOB1 = null;
													companyBeanOB3 = null;
													if(selectedCompanyID == companyID)
													{
													%>
														<option value=<%=companyID%> selected><%=companyName%></option>
													<%											
													}
													else
													{
													%>
														<option value=<%=companyID%>><%=companyName%></option>
													<%	
													}
												}
    											if(NoOfCompanies > 1)
    											{
    												if(selectedCompanyID == 1000)
    												{
    												%>
		    											<option value="1000" selected>ALL</option>
    												<%
    												}
    												else
    												{
    												%>
		    											<option value="1000">ALL</option>
    												<%
    												}
    											}
    											userBeanOB1 = null;
  												userBeanOB2 = null;
  												userBeanOB3 = null;
  												userDAOOB1 = null;  	    										
  	    										%>    										    										
											</select>															 
										</div>
									</div>					
									<div class="form-group">  
	  		      						<label class="control-label col-sm-4" for="status">UserType</label>
  		  								<div class="col-sm-8">  	  									
	  	  									<input type="hidden" name="oldSelectedUserType" value=<%=oldSelectedUserType%>>  		  								
  	  										<%
  	  										if(selectedCompanyID == 0)
  	  										{
  	  										%>
  	  										 	<select class="form-control" name="selectedUserType" disabled></select>
  	  										<%
  	  										}
  	  										else
  	  										{
  	  										%>
		  	  									<select class="form-control" name="selectedUserType" required onchange="this.form.submit()">  	    							
  		    										<option value="">Select UserType</option>
        											<%
        											userBeanOB1 = new UserBean();        										
      												if("rootadmin".equals(currentSessionUserRole))
      												{
    	      											userBeanOB1.setSearchQuery(" where "+companyFilter);
      													//userTypeBeanOB1.setSearchQuery(" where usertype like '%%'");
      												}
      												else if("companyadmin".equals(currentSessionUserRole))
      												{
      													userBeanOB1.setSearchQuery(" where companyid='"+currentSessionUserCompanyID+"'");      											
      												}
      												else if("branchadmin".equals(currentSessionUserRole))
      												{
      													userBeanOB1.setSearchQuery(" where companyid='"+currentSessionUserCompanyID+"' and branchid='"+currentSessionUserBranchID+"'");      											
      												}
      												userBeanOB2 = new ArrayList<UserBean>();
      												userBeanOB2.add(userBeanOB1);
      												userDAOOB1 = new UserDAO();
      												userBeanOB3 = userDAOOB1.distinctUserType(userBeanOB2);        											
      												int noOfUserTypes = userBeanOB3.size();
      												String userTypeValue = null;      										  	    							
      												for(int i=0;i<noOfUserTypes;i++)
      												{      										
		      											userTypeValue = userBeanOB3.get(i).getUserType();
      													if(userTypeValue.equals(selectedUserType))
      													{
      												%>	
    	      												<option value="<%=userTypeValue.toLowerCase()%>" selected><%=userTypeValue.toUpperCase()%></option>
          											<%	
		      											}
      													else
      													{
      												%>	
    	      												<option value="<%=userTypeValue.toLowerCase()%>"><%=userTypeValue.toUpperCase()%></option>
          											<%	
		      											}
      												}
      												if(noOfUserTypes > 1)
      												{
      													if("ALL".equals(selectedUserType))
        												{
        												%>
		        											<option value="ALL" selected>ALL</option>
        												<%
        												}
        												else
        												{
        												%>
		        											<option value="ALL">ALL</option>
        												<%
        												}
      												}
      												userBeanOB1 = null;
      												userBeanOB2 = null;
      												userBeanOB3 = null;
      												userDAOOB1 = null;  	    							
        											%>  	    								    										    								
												</select>
  	  										<%
  	  										}
  	  										%>  	  										 										         	    																						
										</div>
									</div>
									<div class="form-group">  
		  		      					<label class="control-label col-sm-4" for="status">UserStatus</label>
  		  								<div class="col-sm-8">  	  									
	  		  								<input type="hidden" name="oldSelectedUserStatus" value=<%=oldSelectedUserStatus%>>  	  									
  	  										<%
  	  										if("unKnown".equals(selectedUserType))
  	  										{
  	  										%>
  	  										 	<select class="form-control" name="selectedUserStatus" disabled></select>
  	  										<%
  	  										}
  	  										else
  	  										{
  	  										%>	
	  	  										<select class="form-control" name="selectedUserStatus" required onchange="this.form.submit()">  	    							
  	    											<option value="">Select UserStatus</option>
        											<%
        											userBeanOB1 = new UserBean();        										
      												if("rootadmin".equals(currentSessionUserRole))
      												{
		      											userBeanOB1.setSearchQuery(" where "+companyFilter+" and "+userTypeFilter);
      													//userTypeBeanOB1.setSearchQuery(" where usertype like '%%'");
      												}
      												else if("companyadmin".equals(currentSessionUserRole))
      												{
		      											userBeanOB1.setSearchQuery(" where companyid='"+currentSessionUserCompanyID+"' and "+userTypeFilter);      											
      												}
      												else if("branchadmin".equals(currentSessionUserRole))
      												{
		      											userBeanOB1.setSearchQuery(" where companyid='"+currentSessionUserCompanyID+"' and "+userTypeFilter+" and branchid='"+currentSessionUserBranchID+"'");      											
      												}
      												else if("systemadmin".equals(currentSessionUserRole))
      												{
		      											userBeanOB1.setSearchQuery(" where companyid='"+currentSessionUserCompanyID+"' and "+userTypeFilter+" and branchid='"+currentSessionUserBranchID+"' and status=1");      											
      												}
      												userBeanOB2 = new ArrayList<UserBean>();
      												userBeanOB2.add(userBeanOB1);
      												userDAOOB1 = new UserDAO();
      												userBeanOB3 = userDAOOB1.distinctUserStatus(userBeanOB2);
      												int noOfUserStatus = userBeanOB3.size();
      												int userStatus;      										  	    							
      												for(int i=0;i<noOfUserStatus;i++)
      												{      										
		      											userStatus = userBeanOB3.get(i).getUserStatus();
      													if(userStatus == selectedUserStatus)
      													{
		      												if(userStatus==1)
      														{
      												%>	      										
    	      													<option value="<%=userStatus%>" selected>Active</option>
          											<%	
      														}
      														else
      														{
      												%>
      															<option value="<%=userStatus%>" selected>DeActive</option>
      												<%
      														}
      													}
      													else
      													{
		      												if(userStatus==1)
  															{
  													%>	      										
	      														<option value="<%=userStatus%>">Active</option>
      												<%	
  															}
  															else
  															{
  													%>
  																<option value="<%=userStatus%>">DeActive</option>
  													<%
  															}
      													}
      												}
      												if(noOfUserStatus > 1)
      												{
      													if(selectedUserStatus == 2)
        												{
        												%>
		        											<option value="2" selected>ALL</option>
        												<%
        												}
        												else
        												{
        												%>
		        											<option value="2">ALL</option>
        												<%
        												}
      												}
      												userBeanOB1 = null;
      												userBeanOB2 = null;
      												userBeanOB3 = null;
      												userDAOOB1 = null;  	    							
        											%>  	    								    										    								
												</select>
  	  										<%
	  	  									}
  	  										%>    	  								  										 										         	    																					
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>	
				<%
				if(selectedCompanyID != 0 && !("unKnown").equals(selectedUserType) && selectedUserStatus != 100)
				{										
				%>					
					<div class="container-fluid">
						<div class="row">
							<div class="panel panel-primary">
								<div class="panel-heading">
									<h3 class="panel-title">Select User</h3>
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
											<th>VendorCompanyName</th>
									<%	
										}
										else
										{
									%>
											<th>CompanyName</th>								
									<%	
										}
									%>																		
									<th>UserType</th>
									<th>EmployeeID</th>
									<th>FirstName</th>
									<th>LastName</th>
									<th>MobileNo</th>
									<th>EmailID</th>
									<th>JoiningDate</th>						
									<th>Branch</th>
									<th>Department</th>
									<th>Designation</th>
									<th>Role</th>
									<th>Gender</th>																			
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
											<th>VendorCompanyName</th>
									<%		
										}		
										else
										{
									%>
											<th>CompanyName</th>								
									<%	
										}
									%>						
									<th>UserType</th>
									<th>EmployeeID</th>
									<th>FirstName</th>
									<th>LastName</th>
									<th>MobileNo</th>
									<th>EmailID</th>
									<th>JoiningDate</th>						
									<th>Branch</th>
									<th>Department</th>
									<th>Designation</th>
									<th>Role</th>
									<th>Gender</th>																			
									<th>Status</th>
									<th>CreatedBy</th>
									<th>CreatedOn</th>	
									<td></td>				
								</tr>
							</tfoot>
							<tbody>
								<%
								userBeanOB1 = new UserBean();
								if("rootadmin".equals(currentSessionUserRole))
								{
									//userBeanOB1.setSearchQuery(" where companyid like '%%'");
									userBeanOB1.setSearchQuery(" where employeeid!='adminuser' and "+companyFilter+" and "+userTypeFilter+" and +"+userStatusFilter);
								}
								else if("companyadmin".equals(currentSessionUserRole))
								{
									userBeanOB1.setSearchQuery(" where companyid='"+currentSessionUserCompanyID+"' and "+userTypeFilter+" and +"+userStatusFilter);
								}																
								else if("branchadmin".equals(currentSessionUserRole))
								{
									userBeanOB1.setSearchQuery(" where companyid='"+currentSessionUserCompanyID+"' and branchid='"+currentSessionUserBranchID+"' and "+userTypeFilter+" and +"+userStatusFilter);
								}
								else if("systemadmin".equals(currentSessionUserRole))
								{
									userBeanOB1.setSearchQuery(" where companyid='"+currentSessionUserCompanyID+"' and branchid='"+currentSessionUserBranchID+"' and "+userTypeFilter+" and +"+userStatusFilter);
								}
								userBeanOB2 = new ArrayList<UserBean>();
								userBeanOB2.add(userBeanOB1);
								userDAOOB1 = new UserDAO();
								userBeanOB3 = userDAOOB1.viewUser(userBeanOB2);
								int noOfUsers = userBeanOB3.size();
								for(int i=0;i<noOfUsers;i++)
								{
									companyID = userBeanOB3.get(i).getUserCompanyID();																																							     	  	  																	
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
									vendorCompanyID = userBeanOB3.get(i).getUserVendorCompanyID();
									if(vendorCompanyID == 0)
									{
										vendorCompanyName = companyName;
									}
									else
									{
										companyBeanOB1 = new CompanyBean();
										companyBeanOB1.setSearchQuery(" where companyid='"+companyID+"'");
										companyBeanOB2 = new ArrayList<CompanyBean>();
										companyBeanOB2.add(companyBeanOB1);
										companyDAOOB1 = new CompanyDAO();
										companyBeanOB3 = companyDAOOB1.viewCompany(companyBeanOB2);
										vendorCompanyName = cfl.capitalizeName(companyBeanOB3.get(0).getCompanyName());
										companyBeanOB1 = null;
										companyBeanOB2 = null;
										companyBeanOB3 = null;
										companyDAOOB1 = null;
									}
									userID = userBeanOB3.get(i).getUserID();
									userType = cfl.capitalizeName(userBeanOB3.get(i).getUserType());
									newUserType = userBeanOB3.get(i).getUserType();
									employeeID = userBeanOB3.get(i).getUserEmployeeID();
									userFirstName = cfl.capitalizeName(userBeanOB3.get(i).getUserFirstName());
									userLastName = cfl.capitalizeName(userBeanOB3.get(i).getUserLastName());
									mobileNo = userBeanOB3.get(i).getUserMobileNo();
									emailID = userBeanOB3.get(i).getUserEmailID();
									joiningDate = userBeanOB3.get(i).getUserJoiningDate();
									branchID = userBeanOB3.get(i).getUserBranchID();
									BranchBean branchBeanOB1 = new BranchBean();
									branchBeanOB1.setSearchQuery(" where branchid='"+branchID+"'");
									List<BranchBean> branchBeanOB2 = new ArrayList<BranchBean>();
									branchBeanOB2.add(branchBeanOB1);
									BranchDAO branchDAOOB1 = new BranchDAO();
									List<BranchBean> branchBeanOB3 = branchDAOOB1.viewBranch(branchBeanOB2);
									branchName = cfl.capitalizeName(branchBeanOB3.get(0).getBranchName());
									branchBeanOB1 = null;
									branchBeanOB2 = null;
									branchBeanOB3 = null;
									branchDAOOB1 = null;
									departmentID = userBeanOB3.get(i).getUserDepartmentID();
									DepartmentBean departmentBeanOB1 = new DepartmentBean();
									departmentBeanOB1.setSearchQuery(" where departmentid='"+departmentID+"'");
									List<DepartmentBean> departmentBeanOB2 = new ArrayList<DepartmentBean>();
									departmentBeanOB2.add(departmentBeanOB1);
									DepartmentDAO departmentDAOOB1 = new DepartmentDAO();
									List<DepartmentBean> departmentBeanOB3 = departmentDAOOB1.viewDepartment(departmentBeanOB2);
									departmentName = cfl.capitalizeName(departmentBeanOB3.get(0).getDepartmentName());
									departmentBeanOB1 = null;
									departmentBeanOB2 = null;
									departmentBeanOB3 = null;
									departmentDAOOB1 = null;
									designationID = userBeanOB3.get(i).getUserDesignationID();
									DesignationBean designationBeanOB1 = new DesignationBean();
									designationBeanOB1.setSearchQuery(" where designationid='"+designationID+"'");
									List<DesignationBean> designationBeanOB2 = new ArrayList<DesignationBean>();
									designationBeanOB2.add(designationBeanOB1);
									DesignationDAO designationDAOOB1 = new DesignationDAO();
									List<DesignationBean> designationBeanOB3 = designationDAOOB1.viewDesignation(designationBeanOB2);
									designationName = cfl.capitalizeName(designationBeanOB3.get(0).getDesignationName());
									designationBeanOB1 = null;
									designationBeanOB2 = null;
									designationBeanOB3 = null;
									designationDAOOB1 = null;
									roleName = userBeanOB3.get(i).getUserRole();
									gender = userBeanOB3.get(i).getUserGender();						
									if ("m".equals(gender))
									{
										genderValue="Male";
									}
									else if ("f".equals(gender))
									{
										genderValue="FeMale";
									}
									status = userBeanOB3.get(i).getUserStatus();
									if (	status == 1)
									{
										statusValue="Active";
									}
									else
									{
										statusValue="DeActive";
									}				
									creationDate = userBeanOB3.get(i).getCreationDate();
									creationTime = userBeanOB3.get(i).getCreationTime();
									createdByUserID = userBeanOB3.get(i).getCreatedByUserID();						
									UserBean userBeanOB4 = new UserBean();
									userBeanOB4.setSearchQuery(" where userid='"+createdByUserID+"'");
									List<UserBean> userBeanOB5 = new ArrayList<UserBean>();
									userBeanOB5.add(userBeanOB4);
									UserDAO userDAOOB2 = new UserDAO();
									List<UserBean> userBeanOB6 = userDAOOB2.viewUser(userBeanOB5);
									createdByUserFirstName = cfl.capitalizeName(userBeanOB6.get(0).getUserFirstName());
									createdByUserEmployeeID = cfl.capitalizeName(userBeanOB6.get(0).getUserEmployeeID());
									userBeanOB4 = null;
									userBeanOB5 = null;
									userBeanOB6 = null;
									userDAOOB2 = null;
									%>					
									<tr>
										<td><%=i+1%></td>
										<%
										if("adminuser".equals(currentSessionUserRole))
										{
										%>
											<td><%=companyName%></td>							
											<td><%=vendorCompanyName%></td>
										<%	
										}
										else
										{
										%>	
											<td><%=vendorCompanyName%></td>								
										<%	
										}
										%>																					
										<td><%=userType%></td>
										<td><%=employeeID%></td>
										<td><%=userFirstName%></td>
										<td><%=userLastName%></td>
										<td><%=mobileNo%></td>
										<td><%=emailID%></td>
										<td><%=joiningDate%></td>						
										<td><%=branchName%></td>
										<td><%=departmentName%></td>
										<td><%=designationName%></td>
										<td><%=roleName%></td>
										<td><%=genderValue%></td>
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
											<input type="hidden" name="sourceJSP" value="editUser.jsp"></input>
											<input type="hidden" name="newUserType" value="<%=newUserType%>"></input>
											<button type="submit" class="btn btn-info btn-sm" name="submitValue" value="<%=userID%>">Edit</button>
										</td>
									</tr>
								<%
								}
								userBeanOB1 = null;
								userBeanOB2 = null;
								userBeanOB3 = null;
								userDAOOB1 = null;
								%>
							</tbody>
						</table>
					</div>
				<%	
				}
			}
			else
			{			
				userBeanOB1 = new UserBean();
				userBeanOB1.setSearchQuery(" where userid='"+selectedUserID+"'");					
				userBeanOB2 = new ArrayList<UserBean>();
				userBeanOB2.add(userBeanOB1);				
				userDAOOB1 = new UserDAO();
				List<UserBean> userBeanOB3 = userDAOOB1.viewUser(userBeanOB2);
				oldUserType=(String) session.getAttribute("oldUserType");
				newUserType=(String) session.getAttribute("newUserType");
				companyID = userBeanOB3.get(0).getUserCompanyID();						
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
				vendorCompanyID = userBeanOB3.get(0).getUserVendorCompanyID();
				if(vendorCompanyID == 0)
				{
					vendorCompanyName = companyName;
				}
				else
				{
					companyBeanOB1 = new CompanyBean();
					companyBeanOB1.setSearchQuery(" where companyid='"+vendorCompanyID+"'");
					companyBeanOB2 = new ArrayList<CompanyBean>();
					companyBeanOB2.add(companyBeanOB1);
					companyDAOOB1 = new CompanyDAO();
					companyBeanOB3 = companyDAOOB1.viewCompany(companyBeanOB2);
					vendorCompanyName = cfl.capitalizeName(companyBeanOB3.get(0).getCompanyName());
					companyBeanOB1 = null;
					companyBeanOB2 = null;
					companyBeanOB3 = null;
					companyDAOOB1 = null;
				}
				userID = userBeanOB3.get(0).getUserID();
				userType = cfl.capitalizeName(userBeanOB3.get(0).getUserType());
				employeeID = userBeanOB3.get(0).getUserEmployeeID();
				userFirstName = cfl.capitalizeName(userBeanOB3.get(0).getUserFirstName());
				userLastName = cfl.capitalizeName(userBeanOB3.get(0).getUserLastName());
				mobileNo = userBeanOB3.get(0).getUserMobileNo();
				emailID = userBeanOB3.get(0).getUserEmailID();
				joiningDate = userBeanOB3.get(0).getUserJoiningDate();
				branchID = userBeanOB3.get(0).getUserBranchID();
				BranchBean branchBeanOB1 = new BranchBean();
				branchBeanOB1.setSearchQuery(" where branchid='"+branchID+"'");
				List<BranchBean> branchBeanOB2 = new ArrayList<BranchBean>();
				branchBeanOB2.add(branchBeanOB1);
				BranchDAO branchDAOOB1 = new BranchDAO();
				List<BranchBean> branchBeanOB3 = branchDAOOB1.viewBranch(branchBeanOB2);
				branchName = cfl.capitalizeName(branchBeanOB3.get(0).getBranchName());
				branchBeanOB1 = null;
				branchBeanOB2 = null;
				branchBeanOB3 = null;
				branchDAOOB1 = null;
				departmentID = userBeanOB3.get(0).getUserDepartmentID();
				DepartmentBean departmentBeanOB1 = new DepartmentBean();
				departmentBeanOB1.setSearchQuery(" where departmentid='"+departmentID+"'");
				List<DepartmentBean> departmentBeanOB2 = new ArrayList<DepartmentBean>();
				departmentBeanOB2.add(departmentBeanOB1);
				DepartmentDAO departmentDAOOB1 = new DepartmentDAO();
				List<DepartmentBean> departmentBeanOB3 = departmentDAOOB1.viewDepartment(departmentBeanOB2);
				departmentName = cfl.capitalizeName(departmentBeanOB3.get(0).getDepartmentName());
				departmentBeanOB1 = null;
				departmentBeanOB2 = null;
				departmentBeanOB3 = null;
				departmentDAOOB1 = null;
				designationID = userBeanOB3.get(0).getUserDesignationID();
				DesignationBean designationBeanOB1 = new DesignationBean();
				designationBeanOB1.setSearchQuery(" where designationid='"+designationID+"'");
				List<DesignationBean> designationBeanOB2 = new ArrayList<DesignationBean>();
				designationBeanOB2.add(designationBeanOB1);
				DesignationDAO designationDAOOB1 = new DesignationDAO();
				List<DesignationBean> designationBeanOB3 = designationDAOOB1.viewDesignation(designationBeanOB2);
				designationName = cfl.capitalizeName(designationBeanOB3.get(0).getDesignationName());
				designationBeanOB1 = null;
				designationBeanOB2 = null;
				designationBeanOB3 = null;
				designationDAOOB1 = null;
				roleName = userBeanOB3.get(0).getUserRole();
				gender = userBeanOB3.get(0).getUserGender();						
				if ("m".equals(gender))
				{
					genderValue="Male";
				}
				else if ("f".equals(gender))
				{
					genderValue="FeMale";
				}
				status = userBeanOB3.get(0).getUserStatus();
				if (	status == 1)
				{
					statusValue="Active";
				}
				else
				{
					statusValue="DeActive";
				}				
				creationDate = userBeanOB3.get(0).getCreationDate();
				creationTime = userBeanOB3.get(0).getCreationTime();
				createdByUserID = userBeanOB3.get(0).getCreatedByUserID();						
				UserBean userBeanOB4 = new UserBean();
				userBeanOB4.setSearchQuery(" where userid='"+createdByUserID+"'");
				List<UserBean> userBeanOB5 = new ArrayList<UserBean>();
				userBeanOB5.add(userBeanOB4);
				UserDAO userDAOOB2 = new UserDAO();
				List<UserBean> userBeanOB6 = userDAOOB2.viewUser(userBeanOB5);
				createdByUserFirstName = cfl.capitalizeName(userBeanOB6.get(0).getUserFirstName());
				createdByUserEmployeeID = cfl.capitalizeName(userBeanOB6.get(0).getUserEmployeeID());
				userBeanOB4 = null;
				userBeanOB5 = null;
				userBeanOB6 = null;
				userDAOOB2 = null;
			%>	
				<input type="hidden" name="selectedCompanyID" value=<%=selectedCompanyID%>>
				<input type="hidden" name="oldSelectedCompanyID" value=<%=oldSelectedCompanyID%>>
				<input type="hidden" name="selectedUserType" value=<%=selectedUserType%>>
				<input type="hidden" name="oldSelectedUserType" value=<%=oldSelectedUserType%>>
				<input type="hidden" name="selectedUserStatus" value=<%=selectedUserStatus%>>
				<input type="hidden" name="oldSelectedUserStatus" value=<%=oldSelectedUserStatus%>> 		
				<div class="container-fluid">
					<div class="row">
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h3 class="panel-title">Selected User</h3>
							</div>
						</div>
					</div>
				</div>
				<div class="container-fluid">
					<table id="dataTable1" class="table table-striped table-bordered" cellspacing="0">
						<thead>
							<tr>						
								<%
								if("adminuser".equals(currentSessionUserRole))
								{
								%>
									<th>CompanyName</th>											
									<th>VendorCompanyName</th>
								<%	
								}
								else
								{
								%>
									<th>CompanyName</th>								
								<%	
								}
								%>
								<th>UserType</th>
								<th>EmployeeID</th>
								<th>FirstName</th>
								<th>LastName</th>
								<th>MobileNo</th>
								<th>EmailID</th>
								<th>JoiningDate</th>						
								<th>Branch</th>
								<th>Department</th>
								<th>Designation</th>
								<th>Role</th>
								<th>Gender</th>																			
								<th>Status</th>
								<th>CreatedBy</th>
								<th>CreatedOn</th>
							</tr>
						</thead>
						<tbody>						
							<tr>								
								<%
								if("adminuser".equals(currentSessionUserRole))
								{
								%>
									<td><%=companyName%></td>							
									<td><%=vendorCompanyName%></td>
								<%	
								}
								else
								{
								%>
									<td><%=vendorCompanyName%></td>								
								<%	
								}
								%>																					
								<td><%=userType%></td>
								<td><%=employeeID%></td>
								<td><%=userFirstName%></td>
								<td><%=userLastName%></td>
								<td><%=mobileNo%></td>
								<td><%=emailID%></td>
								<td><%=joiningDate%></td>						
								<td><%=branchName%></td>
								<td><%=departmentName%></td>
								<td><%=designationName%></td>
								<td><%=roleName%></td>
								<td><%=genderValue%></td>
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
						</tbody>				
					</table>
				</div>
				<br></br>
				<div class="container">
					<div class="row">
  						<div class="col-sm-2"></div>
  						<div class="col-sm-8">
	  						<div class="panel panel-primary well well-sm">
								<div class="panel-heading" align="center">Edit User</div>
								<div class="panel-body">
									<input type="hidden" class="form-control" name="userID" value="<%=userID%>">  								
    								<div class="form-group">  
    	  								<label class="control-label col-sm-4" for="userType">UserType</label>
										<div class="col-sm-8">										
											<input type="hidden" name="orgUserType" value=<%=userType.toLowerCase()%>>
											<input type="hidden" name="oldUserType" value=<%=oldUserType%>>
											<input type="hidden" name="onChangeValue" value="updateUser">																				  										      
											<select class="form-control" name="newUserType" onchange="this.form.submit()">    																				
												<%
        										UserTypeBean userTypeBeanOB1 = new UserTypeBean();      										
      											userTypeBeanOB1.setSearchQuery(" where usertype like '%%'");      											      										
      											List<UserTypeBean> userTypeBeanOB2 = new ArrayList<UserTypeBean>();
      											userTypeBeanOB2.add(userTypeBeanOB1);
      											UserTypeDAO userTypeDAOOB1 = new UserTypeDAO();
      											List<UserTypeBean> userTypeBeanOB3 = userTypeDAOOB1.viewUserType(userTypeBeanOB2);
      											int noOfUserTypes = userTypeBeanOB3.size();
      											String userTypeValue = null;      										  	    							
      											for(int i=0;i<noOfUserTypes;i++)
      											{      										
      												userTypeValue = userTypeBeanOB3.get(i).getUserType();
      												if(userTypeValue.equals(newUserType))
      												{
      											%>	
		          										<option value="<%=userTypeValue.toLowerCase()%>" selected><%=userTypeValue.toUpperCase()%></option>
          										<%	
      												}
      												else
      												{
      											%>	
		          										<option value="<%=userTypeValue.toLowerCase()%>"><%=userTypeValue.toUpperCase()%></option>
          										<%	
      												}
      											}
      											userTypeBeanOB1 = null;
      											userTypeBeanOB2 = null;
      											userTypeBeanOB3 = null;
      											userTypeDAOOB1 = null;  	    							
        										%>																																    										    						
											</select>							  
										</div>
									</div>
									<div class="form-group">  
  		      							<label class="control-label col-sm-4" for="status">Vendor Company</label>
  	  									<div class="col-sm-8">  	  									
											<input type="hidden" name="oldVendorCompanyID" value=<%=vendorCompanyID%>>  										        
  	    									<select class="form-control" name="newVendorCompanyID">
  	    										<%
  												if("employee".equals(newUserType))
  												{  																
  	  											%>
  	    												<option value="0">Own Company</option>
  	    										<%
  												}
  												else if(!"employee".equals(newUserType))
  												{  																
  	  	  										%>
		  	  	    									<option value="0">Select Vendor Company</option>
  	  	    									<%
  	  											}  											
  	    										%>  	    						    										    										
											</select>							  
										</div>
									</div>
									<div class="form-group">  
      									<label class="control-label col-sm-4" for="branch">Branch</label>  
      									<div class="col-sm-8">
      										<%      									      							
      										branchBeanOB1 = new BranchBean();
      										branchBeanOB1.setSearchQuery(" where companyid='"+companyID+"' and status=1");
      										branchBeanOB2 = new ArrayList<BranchBean>();
      										branchBeanOB2.add(branchBeanOB1);		
      										branchDAOOB1 = new BranchDAO();
      										branchBeanOB3 = branchDAOOB1.viewBranch(branchBeanOB2);
      										int noOfBranches = branchBeanOB3.size();
      										int newBranchID;
      										String newBranchName;
  	  										%>
  	  										<input type="hidden" name="oldBranchID" value=<%=branchID%>>	  	  									  	  									 										       
  	    									<select class="form-control" name="newBranchID">  	    									
  	    										<%  	    									  	    								
  	    										for(int i=0;i<noOfBranches;i++)
												{
													newBranchID = branchBeanOB3.get(i).getBranchID();
													newBranchName = branchBeanOB3.get(i).getBranchName().toUpperCase();
													if(newBranchID == branchID)
													{
													%>
														<option value=<%=newBranchID%> selected><%=newBranchName%></option>
													<%											
													}
													else
													{
													%>	
														<option value=<%=newBranchID%>><%=newBranchName%></option>
													<%	
													}
												}
  	    										branchBeanOB1 = null;
  	    										branchBeanOB2 = null;
  	    										branchBeanOB3 = null;
  	    										branchDAOOB1 = null;  	    									
												%>    										    										
										</select>							  
										</div>
									</div>    																
  									<div class="form-group">  
      									<label class="control-label col-sm-4" for="EmployeeID">EmployeeID</label>  
      									<div class="col-sm-8">
      										<input type="hidden" name="oldEmployeeID" value="<%=employeeID%>">  
	        								<input type="text" class="form-control" name="newEmployeeID" placeholder="<%=employeeID%>" pattern="^(?=.*[A-Za-z0-9])[0-9a-zA-Z\/]{2,34}$"
        		title="Olny Letters,Numbers and Special Characters(/) Allowed(1 Alphanumeric Mandatory)-(Length Min-2 Max-34)">  
      										</div>  
    								</div>
    								<fieldset>                            		
    									<div class="form-group">  
		      								<label class="control-label col-sm-4" for="LoginPassword">LoginPassword</label>  
      										<div class="col-sm-8">  
	        									<input type="password" class="form-control" name="newLoginPassword" placeholder="Enter Password" pattern="^(?=.*[A-Za-z0-9])[0-9a-zA-Z\@\#\-\.\!\^\$]{2,34}$"
        		title="Olny Letters,Numbers and Special Characters(@,#,-,.,!,%,$) Allowed(1 Alphanumeric Mandatory)-(Length Min-3 Max-34)">  
      										</div>  
    										</div>
    										<div class="form-group">  
      										<label class="control-label col-sm-4" for="ConfirmLoginPassword">ConfirmLoginPassword</label>  
      										<div class="col-sm-8">  
	        									<input type="password" class="form-control" name="newConfirmLoginPassword" placeholder="Enter ConfirmPassword" pattern="^(?=.*[A-Za-z0-9])[0-9a-zA-Z\@\#\-\.\!\^\$]{2,34}$"
        		title="Olny Letters,Numbers and Special Characters(@,#,-,.,!,%,$) Allowed(1 Alphanumeric Mandatory)-(Length Min-3 Max-34)">  
      										</div>  
    									</div>
    								</fieldset>
    								<div class="form-group">  
      									<label class="control-label col-sm-4" for="UserFirstName">UserFirstName</label>
      									<div class="col-sm-8">
      										<input type="hidden" name="oldUserFirstName" value="<%=userFirstName%>">  
	        								<input type="text" class="form-control" name="newUserFirstName" placeholder="<%=userFirstName%>" pattern="^(?=.*[A-Za-z0-9])[0-9a-zA-Z\s]{2,34}$"
        		title="Olny Letters,Numbers and Special Characters(Space) Allowed(1 Alphanumeric Mandatory)-(Length Min-2 Max-34)">  
      									</div>  
    								</div>
    								<div class="form-group">  
      									<label class="control-label col-sm-4" for="UserLastName">UserLastName</label>  
      									<div class="col-sm-8">
      										<input type="hidden" name="oldUserLastName" value="<%=userLastName%>">  
	        								<input type="text" class="form-control" name="newUserLastName" placeholder="<%=userLastName%>" pattern="^(?=.*[A-Za-z0-9])[0-9a-zA-Z\s]{2,34}$"
        		title="Olny Letters,Numbers and Special Characters(Space) Allowed(1 Alphanumeric Mandatory)-(Length Min-2 Max-34)">  
      								</div>  
    								</div>      			 		    							
    								<div class="form-group">  
      									<label class="control-label col-sm-4" for="MobileNo">MobileNo</label>  
      									<div class="col-sm-8">
      										<input type="hidden" name="oldMobileNo" value="<%=mobileNo%>">  
        									<input type="text" class="form-control" name="newMobileNo" placeholder="<%=mobileNo%>" pattern="^(?=.*[A-Za-z0-9])[0-9a-zA-Z\/]{2,34}$"
        		title="Olny Letters,Numbers and Special Characters(/) Allowed(1 Alphanumeric Mandatory)-(Length Min-2 Max-34)">  
      									</div>  
    								</div>
    								<div class="form-group">  
      									<label class="control-label col-sm-4" for="EmailID">EmailID</label>  
      									<div class="col-sm-8">
      										<input type="hidden" name="oldEmailID" value="<%=emailID%>">  
        									<input type="text" class="form-control" name="newEmailID" placeholder="<%=emailID%>" pattern="^(?=.*[A-Za-z0-9])[0-9a-zA-Z\/\-\.\@]{2,34}$"
        		title="Olny Letters,Numbers and Special Characters(/,-,.,@) Allowed(1 Alphanumeric Mandatory)-(Length Min-2 Max-34)">  
      									</div>  
    								</div>
    								<div class="form-group">  
      									<label class="control-label col-sm-4" for="joiningdate">JoiningDate</label>  
      									<div class="col-sm-8">
      									<%        								                    					
                    						companyBeanOB1 = new CompanyBean();
          	  								companyBeanOB1.setSearchQuery(" where companyid='"+companyID+"'");
          	  								companyBeanOB2 = new ArrayList<CompanyBean>();
          	  								companyBeanOB2.add(companyBeanOB1);
          	  								companyDAOOB1 = new CompanyDAO();
          	  								companyBeanOB3 = companyDAOOB1.viewCompany(companyBeanOB2);
          	  								Date companyOpeningDate = companyBeanOB3.get(0).getOpeningDate();          	  								
                    						DateBean dateBeanOB1 = new DateBean();	
                    						String todayDate = dateBeanOB1.getTodayDate();
                    						dateBeanOB1.setDateFormat1(companyOpeningDate);
                    						String companyOpeningDateString = dateBeanOB1.getDateFormat2();
                    						dateBeanOB1.setDateFormat1(joiningDate);
                    						String joiningDateString = dateBeanOB1.getDateFormat2();
                    						dateBeanOB1 = null;
                    						companyBeanOB1 = null;
                    						companyBeanOB2 = null;
                    						companyBeanOB3 = null;
                    						companyDAOOB1 = null;
                    					%>
											<input type="hidden" name="oldJoiningDate" value="<%=joiningDateString%>">                   					
    										<input type="hidden" id="startDate" value=<%=companyOpeningDateString%>>
    										<input type="hidden" id="endDate" value="<%=todayDate%>">      										        									        								                    
                    						<div class="input-group date form_date" data-date="" data-date-format="dd-mm-yyyy" data-link-field="newJoiningDate" data-link-format="dd-mm-yyyy">
                    							<input class="form-control" size="16" type="text" name="newJoiningDate1" value="<%=joiningDateString%>" placeholder="<%=joiningDateString%>" readonly>                    							
												<span class="input-group-addon">
													<span class="glyphicon glyphicon-calendar"></span>
												</span>
                							</div>                       							                		                     						                							                   						                    			
											<input type="hidden" id="newJoiningDate" name="newJoiningDate" value=""/>	                					                   						                							                   						                    													
      									</div> 
    								</div>
    								<div class="form-group">  
      									<label class="control-label col-sm-4" for="role">Role</label>  
      									<div class="col-sm-8">
      										<input type="hidden" name="oldRoleName" value="<%=roleName%>">  
        									<select class="form-control" name="newRoleName">  	    									
        										<%
        										RoleBean roleBeanOB1 = new RoleBean();      									
      											if("employee".equals(newUserType.toLowerCase()))
      											{
      												roleBeanOB1.setSearchQuery(" where rolename!='rootadmin' and rolename!='guest'");	
      											}
      											else if(!"employee".equals(newUserType.toLowerCase()))
      											{
      												roleBeanOB1.setSearchQuery(" where rolename='guest'");      										
      											}
      											List<RoleBean> roleBeanOB2 = new ArrayList<RoleBean>();
      											roleBeanOB2.add(roleBeanOB1);
      											RoleDAO roleDAOOB1 = new RoleDAO();
      											List<RoleBean> roleBeanOB3 = roleDAOOB1.viewRole(roleBeanOB2);
      											int noOfRoles = roleBeanOB3.size();
      											String newRoleName = null;      										  	    									
      											for(int i=0;i<noOfRoles;i++)
      											{      										
      												newRoleName = roleBeanOB3.get(i).getRoleName();      												      												      									
      												if(newRoleName.equals(roleName))
      												{
      												%>      											
    	      											<option value="<%=newRoleName.toLowerCase()%>" selected><%=newRoleName.toUpperCase()%></option>
    	      										<%
      												}
    	      										else
    	      										{
    	      										%>
    	      											<option value="<%=newRoleName.toLowerCase()%>"><%=newRoleName.toUpperCase()%></option>
    	      										<%
    	      										}	
      											}
      											roleBeanOB1 = null;
      											roleBeanOB2 = null;
      											roleBeanOB3 = null;
      											roleDAOOB1 = null;  	    									
        										%>
        									</select>
      									</div>  
    								</div>
    								<div class="form-group">  
      									<label class="control-label col-sm-4" for="department">Department</label>  
      									<div class="col-sm-8">
      										<input type="hidden" name="oldDepartmentID" value="<%=departmentID%>">          						
        									<select class="form-control" name="newDepartmentID">  	    									
        										<%
        										departmentBeanOB1 = new DepartmentBean();
      											departmentBeanOB1.setSearchQuery(" where companyid='"+companyID+"' and status=1");      										
      											departmentBeanOB2 = new ArrayList<DepartmentBean>();
      											departmentBeanOB2.add(departmentBeanOB1);
      											departmentDAOOB1 = new DepartmentDAO();
      											departmentBeanOB3 = departmentDAOOB1.viewDepartment(departmentBeanOB2);
      											int noOfDepartments = departmentBeanOB3.size();
      											String newDepartmentName = null;
      											int newDepartmentID;      										
      											for(int i=0;i<noOfDepartments;i++)
      											{      										
      												newDepartmentName = departmentBeanOB3.get(i).getDepartmentName();
      												newDepartmentID = departmentBeanOB3.get(i).getDepartmentID();
      												if(newDepartmentID == departmentID)
      												{
      												%>
	      												<option value="<%=newDepartmentID%>" selected><%=newDepartmentName.toUpperCase()%></option>
    	  											<%
      												}
    	  											else
    	  											{
    	  											%>
    	  												<option value="<%=newDepartmentID%>"><%=newDepartmentName.toUpperCase()%></option>
    	  											<%
    	  											}
      											}
      											departmentBeanOB1 = null;
      											departmentBeanOB2 = null;
      											departmentBeanOB3 = null;
      											departmentDAOOB1 = null;  	    									
        										%>
        									</select>
      									</div>  
    								</div>
    								<div class="form-group">  
      									<label class="control-label col-sm-4" for="designation">Designation</label>  
      									<div class="col-sm-8">
      										<input type="hidden" name="oldDesignationID" value="<%=designationID%>">  
        									<select class="form-control" name="newDesignationID">  	    									
        										<%
        										designationBeanOB1 = new DesignationBean();
      											designationBeanOB1.setSearchQuery(" where companyid='"+companyID+"' and status=1");      										
      											designationBeanOB2 = new ArrayList<DesignationBean>();
      											designationBeanOB2.add(designationBeanOB1);
      											designationDAOOB1 = new DesignationDAO();
      											designationBeanOB3 = designationDAOOB1.viewDesignation(designationBeanOB2);
      											int noOfDesignations = designationBeanOB3.size();
      											String newDesignationName = null;
      											int newDesignationID;      										
      											for(int i=0;i<noOfDesignations;i++)
      											{      										
      												newDesignationName = designationBeanOB3.get(i).getDesignationName();
      												newDesignationID = designationBeanOB3.get(i).getDesignationID();
      												if(newDesignationID == designationID)
      												{
      												%>
	      												<option value="<%=newDesignationID%>" selected><%=newDesignationName.toUpperCase()%></option>	      											
    	  											<%
      												}
      												else
      												{
      												%>
      													<option value="<%=newDesignationID%>"><%=newDesignationName.toUpperCase()%></option>
      												<%
      												}
      											}
      											designationBeanOB1 = null;
      											designationBeanOB2 = null;
      											designationBeanOB3 = null;
      											designationDAOOB1 = null;      											  	    									
        										%>
        									</select>
      									</div>  
    								</div>    							    						
    								<div class="form-group">  
      									<label class="control-label col-sm-4" for="gender">Gender</label>  
      									<div class="col-sm-8">
      										<input type="hidden" name="oldGender" value=<%=gender%>>
        									<select class="form-control" name="newGender">  	    									
  	    										<%
  	    										if("m".equals(gender))
  	    										{
  	    										%>
  	    											<option value="m" selected>MALE</option>
  	    											<option value="f">FEMALE</option>
  	    										<%
  	    										}	
  	    										else if("f".equals(gender))
  	    										{
  	    										%>
  	    											<option value="m">MALE</option>
  	    											<option value="f" selected>FEMALE</option>
  	    										<%
  	    										}
  	    										%>
  	    								</select>
      									</div>  
    								</div>
    								<input type="hidden" class="form-control" name="oldStatus" value="<%=status%>">
    								<div class="form-group">  
	      								<label class="control-label col-sm-4" for="status">Status:</label>
      									<div class="col-sm-8">        	
	    									<select class="form-control" name="newStatus">
	    										<%	    									
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
				 									<div class="alert <% out.println(AlertType1); %> fade in">    								
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
	        								<button type="submit" class="btn btn-success" name="submitValue" value="updateUser">
        										<strong>Update</strong>
        									</button>
        									<input type="hidden" name="sourceJSP" value="editUser.jsp"></input>
        									<button type="submit" class="btn btn-info col-sm-offset-2" name="submitValue" value="selectAnotherUser">
			        							<strong>Select Another User</strong>
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
		<script type="text/javascript">
			var startDate=document.getElementById("startDate");
			var endDate=document.getElementById("endDate");
			$('.form_date').datetimepicker
			({
				startDate: startDate.value,
				endDate: endDate.value,
				orientation: "auto",
	       		language:  'en',
	       		weekStart: 1,
	       		todayBtn:  1,
				autoclose: 1,
				todayHighlight: 1,
				startView: 2,
				minView: 2,
				forceParse: 0,
				sideBySide: true,
		       	widgetPositioning: 
		       	{
		            horizontal: 'right',
		           	vertical: 'top'
		       	}
	    	});							    	
		</script>
		</body>
	<%
	}
}
%>
</html>