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
		String joiningDate;
		String roleName;
		int departmentID;
		String departmentName;
		int designationID;
		String designationName;
		String gender;
		String genderValue="null";
		int status;
		String statusValue="null";
		String creationDateTime;		
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
	<form class="form-horizontal" method="post" action="UserServlet" id="userLog">
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
			<input type="hidden" name="sourceJSP" value="userLog.jsp"></input>		
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
	      											userBeanOB1.setSearchQuery(" where userid='"+currentSessionUserID+"'");      											
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
								<th>Edit</th>
							</tr>
						</thead>
						<tfoot>
							<tr>
								<th>S.No</th>
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
								userBeanOB1.setSearchQuery(" where branchid='"+currentSessionUserBranchID+"' and "+userTypeFilter+" and +"+userStatusFilter);
							}
							else if("systemadmin".equals(currentSessionUserRole))
							{
								userBeanOB1.setSearchQuery(" where branchid='"+currentSessionUserBranchID+"' and "+userTypeFilter+" and +"+userStatusFilter);
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
								creationDateTime = userBeanOB3.get(i).getCreationDateTime();								
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
										<%=creationDateTime%>										
									</td>
									<td>
										<input type="hidden" name="sourceJSP" value="userLog.jsp"></input>
										<input type="hidden" name="newUserType" value="<%=newUserType%>"></input>
										<button type="submit" class="btn btn-info btn-sm" name="submitValue" value="<%=userID%>">Log</button>
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
			userBeanOB1.setSearchQuery(" where userid='"+selectedUserID+"'");			
			userBeanOB2.add(userBeanOB1);
			List<UserBean> userBeanOB3 = userDAOOB1.userLog(userBeanOB2);
			int NoOfLog = userBeanOB3.size();
			String description;
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
							<h3 class="panel-title">UserLog</h3>
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
							if("adminuser".equals(currentSessionUserRole))
							{
							%>																		
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
							<th>ModifiedBy</th>
							<th>ModifiedOn</th>
							<th>Description</th>
						</tr>
					</thead>
					<tfoot>
						<tr>
							<th>S.No</th>						
							<%
							if("adminuser".equals(currentSessionUserRole))
							{
							%>																		
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
							<th>ModifiedBy</th>
							<th>ModifiedOn</th>
							<th>Description</th>
						</tr>
					</tfoot>
					<tbody>
						<%
						UserBean userBeanOB7 = new UserBean();
						userBeanOB7.setSearchQuery(" where userid='"+selectedUserID+"'");
						List<UserBean> userBeanOB8 = new ArrayList<UserBean>();
						userBeanOB8.add(userBeanOB7);
						UserDAO userDAOOB3 = new UserDAO();
						List<UserBean> userBeanOB9 = userDAOOB3.viewUser(userBeanOB8);						
						companyID = userBeanOB9.get(0).getUserCompanyID();
						userBeanOB7 = null;
						userBeanOB8 = null;
						userBeanOB9 = null;
						userDAOOB3 = null;
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
						for(int j=0;j<NoOfLog;j++)
						{																																	 						
							vendorCompanyID = userBeanOB3.get(j).getUserVendorCompanyID();
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
							userType = cfl.capitalizeName(userBeanOB3.get(j).getUserType());
							employeeID = userBeanOB3.get(j).getUserEmployeeID();
							userFirstName = cfl.capitalizeName(userBeanOB3.get(j).getUserFirstName());
							userLastName = cfl.capitalizeName(userBeanOB3.get(j).getUserLastName());
							mobileNo = userBeanOB3.get(j).getUserMobileNo();
							emailID = userBeanOB3.get(j).getUserEmailID();
							joiningDate = userBeanOB3.get(j).getUserJoiningDate();
							branchID = userBeanOB3.get(j).getUserBranchID();
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
							departmentID = userBeanOB3.get(j).getUserDepartmentID();
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
							designationID = userBeanOB3.get(j).getUserDesignationID();
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
							roleName = userBeanOB3.get(j).getUserRole();
							gender = userBeanOB3.get(j).getUserGender();						
							if ("m".equals(gender))
							{
								genderValue="Male";
							}
							else if ("f".equals(gender))
							{
								genderValue="FeMale";
							}
							status = userBeanOB3.get(j).getUserStatus();
							if (	status == 1)
							{
								statusValue="Active";
							}
							else
							{
								statusValue="DeActive";
							}				
							creationDateTime = userBeanOB3.get(j).getCreationDateTime();							
							createdByUserID = userBeanOB3.get(j).getCreatedByUserID();						
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
							description = userBeanOB3.get(j).getDescription();
						%>						
						<tr>	
							<td><%=j+1%></td>							
							<%
							if("adminuser".equals(currentSessionUserRole))
							{
							%>													
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
								<%=creationDateTime%>								
							</td>
							<td><%=description%></td>
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
				<%
  				if(!"staff".equals(currentSessionUserRole) && !"guest".equals(currentSessionUserRole))
  				{
  				%>
					<div class="form-group">          
      					<div class="col-sm-offset-4 col-sm-8">
      						<input type="hidden" name="sourceJSP" value="userLog.jsp"></input>  
	        				<button type="submit" class="btn btn-info col-sm-offset-1" name="submitValue" value="selectAnotherUser">
	        					<strong>Select Another User</strong>
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