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
		String currentSessionUserRole = (String) session.getAttribute("currentSessionUserRole");
		UserBean userBeanOB1 = new UserBean();		
		List<UserBean> userBeanOB2 = new ArrayList<UserBean>();				
		UserDAO userDAOOB1 = new UserDAO();		
		CapitalizeFirstLetter cfl = new CapitalizeFirstLetter();				
	 %>
	<body>
	<form class="form-horizontal" method="post" action="ProfileServlet" id="profileLog">
		<%		
		userBeanOB1.setSearchQuery(" where userid='"+currentSessionUserID+"'");			
		userBeanOB2.add(userBeanOB1);
		List<UserBean> userBeanOB3 = userDAOOB1.userLog(userBeanOB2);
		int NoOfLog = userBeanOB3.size();
		String description;
		%>			 	
		<div class="container-fluid">
			<div class="row">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<h3 class="panel-title">ProfileLog</h3>
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
					userBeanOB7.setSearchQuery(" where userid='"+currentSessionUserID+"'");
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
			<div class="form-group">          
      			<div class="col-sm-offset-5 col-sm-8">      				 
	        		<button type="submit" class="btn btn-info col-sm-offset-1" name="submitValue" value="home">
	        			<strong>Home</strong>
        			</button>  
      			</div>
      		</div>
		</div>		
	</form>	
</body>
<%
}
%>
</html>