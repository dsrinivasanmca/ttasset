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
<link rel="stylesheet" type="text/css" href="css/jquery.dataTables.min.css">
<link rel="stylesheet" type="text/css" href="css/dataTableWithSearch.css">
<script type="text/javascript" language="javascript" src="css/jquery-1.12.4.js"></script>
<script type="text/javascript" language="javascript" src="css/jquery.dataTables.min.js"></script>
<script type="text/javascript" language="javascript" src="css/dataTables.bootstrap.min.js"></script>
<script type="text/javascript" language="javascript" src="css/dataTableWithSearch.js"></script>
<%
if( session != null && session.getAttribute("currentSessionUserID") != null)
{
	int currentSessionUserID = (Integer)session.getAttribute("currentSessionUserID");
	int selectedCompanyID= (Integer)session.getAttribute("selectedCompanyID");
	int oldSelectedCompanyID = (Integer) session.getAttribute("oldSelectedCompanyID");
	String selectedUserType = (String)session.getAttribute("selectedUserType");
	String oldSelectedUserType = (String) session.getAttribute("oldSelectedUserType");
	int selectedUserStatus = (Integer)session.getAttribute("selectedUserStatus");
	int oldSelectedUserStatus = (Integer) session.getAttribute("oldSelectedUserStatus");
	int currentSessionUserCompanyID = (Integer)session.getAttribute("currentSessionUserCompanyID");	
	String currentSessionUserRole = (String) session.getAttribute("currentSessionUserRole");
	int companyID;
	String companyName;
	UserBean userBeanOB1 = new UserBean();		
	List<UserBean> userBeanOB2 = new ArrayList<UserBean>();				
	UserDAO userDAOOB1 = new UserDAO();
	%>
	<body>
		<form class="form-horizontal" name="newUser" method="post" action="UserServlet">
			<input type="hidden" name="sourceJSP" value="viewUser.jsp"></input>		
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
  	  									<input type="hidden" name="submitValue" value="viewUser">  	  										 										       
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
											if (NoOfCompanies > 1)
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
  		  								<input type="hidden" name="submitValue" value="viewUser">
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
  	  									<input type="hidden" name="submitValue" value="viewUser">
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
				int vendorCompanyID;
				String vendorCompanyName;
				int workingCompanyID;
				String workingCompanyName;
				int branchID;
				String branchName;
				String userType;
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
				currentSessionUserID = (Integer) session.getAttribute("currentSessionUserID");
				int currentSessionUserVendorCompanyID = (Integer) session.getAttribute("currentSessionUserVendorCompanyID");
				String currentSessionUserType = (String) session.getAttribute("currentSessionUserType");
				userBeanOB1 = new UserBean();
				if("rootadmin".equals(currentSessionUserRole))
				{
					//userBeanOB1.setSearchQuery(" where companyid like '%%'");
					userBeanOB1.setSearchQuery(" where employeeid!='adminuser' and "+companyFilter+" and "+userTypeFilter+" and +"+userStatusFilter);
				}
				else if("companyadmin".equals(currentSessionUserRole) || "branchadmin".equals(currentSessionUserRole))
				{
					userBeanOB1.setSearchQuery(" where companyid='"+currentSessionUserCompanyID+"' and "+userTypeFilter+" and "+userStatusFilter);
				}
				else if("systemadmin".equals(currentSessionUserRole))
				{
					userBeanOB1.setSearchQuery(" where companyid='"+currentSessionUserCompanyID+"' and "+userTypeFilter+" and status=1");
				}
				else if("staff".equals(currentSessionUserRole))
				{
					userBeanOB1.setSearchQuery(" where companyid='"+currentSessionUserCompanyID+"' and status=1 and usertype!='trainee'");
				}
				else if("guest".equals(currentSessionUserRole) &&  "partner".equals(currentSessionUserType))
				{		
					userBeanOB1.setSearchQuery(" where (companyid='"+currentSessionUserCompanyID+"' and status=1 and usertype='employee') or (usertype='partner' and vendorcompanyid='"+currentSessionUserVendorCompanyID+"' and status=1)");
				}
				else if("guest".equals(currentSessionUserRole) &&  "consultant".equals(currentSessionUserType))
				{
					userBeanOB1.setSearchQuery(" where (companyid='"+currentSessionUserCompanyID+"' and status=1 and usertype='employee') or (usertype='consultant' and vendorcompanyid='"+currentSessionUserVendorCompanyID+"' and status=1)");
				}
				else if("guest".equals(currentSessionUserRole) &&  "trainee".equals(currentSessionUserType))
				{
					userBeanOB1.setSearchQuery(" where companyid='"+currentSessionUserCompanyID+"' and status=1 and usertype='trainee' and vendorcompanyid='"+currentSessionUserVendorCompanyID+"'");
				}
				userBeanOB2 = new ArrayList<UserBean>();
				userBeanOB2.add(userBeanOB1);		
				userDAOOB1 = new UserDAO();
				userBeanOB3 = userDAOOB1.viewUser(userBeanOB2);
				int noOfUsers = userBeanOB3.size();
				CapitalizeFirstLetter cfl = new CapitalizeFirstLetter();
 			%>
				<div class="container-fluid">
					<div class="row">
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h3 class="panel-title">User List</h3>
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
							</tr>
						</tfoot>
						<tbody>
							<%
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
									VendorCompanyBean vendorCompanyBeanOB1 = new VendorCompanyBean();
									vendorCompanyBeanOB1.setSearchQuery(" where vendorcompanyid='"+vendorCompanyID+"'");
									List<VendorCompanyBean> vendorCompanyBeanOB2 = new ArrayList<VendorCompanyBean>();
  									vendorCompanyBeanOB2.add(vendorCompanyBeanOB1);		
  									VendorCompanyDAO vendorCompanyDAOOB1 = new VendorCompanyDAO();
  									List<VendorCompanyBean> vendorCompanyBeanOB3 = vendorCompanyDAOOB1.viewVendorCompany(vendorCompanyBeanOB2);
  									vendorCompanyName = cfl.capitalizeName(vendorCompanyBeanOB3.get(0).getVendorCompanyName());  										
  									vendorCompanyBeanOB1 = null;
  									vendorCompanyBeanOB2 = null;
  									vendorCompanyBeanOB3 = null;
  									vendorCompanyDAOOB1 = null;
								}												
								userType = cfl.capitalizeName(userBeanOB3.get(i).getUserType());
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
								if (status == 1)
								{
									statusValue="Active";
								}
								else
								{
									statusValue="Disabled";
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
									if("rootadmin".equals(currentSessionUserRole))
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
				<script>
				$(document).ready(function() 
				{
			    	$('#example').DataTable
			    	({
		    	   		"scrollY": 200,
		        		"scrollX": true
		    		});
				});
				</script>
			<%
			}
			%>
		</form>
	</body>
<%
}
%>
</html>