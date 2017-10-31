<html>
<%@ page import="com.tt.asset.*"%>
<%@ include file="actionBar.jsp"%>
<body>
<%
if ( (session != null) && (session.getAttribute("currentSessionUserID") != null) && (session.getAttribute("currentSessionUserRole") != null))
{
	int currentSessionUserID = (Integer)session.getAttribute("currentSessionUserID");
	String currentSessionUserRole = (String)session.getAttribute("currentSessionUserRole");
	String searchQuery=" where userid='"+currentSessionUserID+"'";	
	UserBean userBeanOB1 = new UserBean();	
	userBeanOB1.setSearchQuery(searchQuery);
	List<UserBean> userBeanOB2 = new ArrayList<UserBean>();
	userBeanOB2.add(userBeanOB1);
	UserDAO userDAOOB1 = new UserDAO();
	List<UserBean> userBeanOB3 = userDAOOB1.viewUser(userBeanOB2);
	CapitalizeFirstLetter cfl = new CapitalizeFirstLetter();
	String userFirstName = cfl.capitalizeName(userBeanOB3.get(0).getUserFirstName());
	String userLastName = cfl.capitalizeName(userBeanOB3.get(0).getUserLastName());
	String userEmployeeID = userBeanOB3.get(0).getUserEmployeeID();
	String userEmailID = userBeanOB3.get(0).getUserEmailID();
	String userMobileNo = userBeanOB3.get(0).getUserMobileNo();
	
	int userCompanyID = userBeanOB3.get(0).getUserCompanyID();
	CompanyBean companyBeanOB1 = new CompanyBean();
	searchQuery=" where companyid='"+userCompanyID+"'";
	companyBeanOB1.setSearchQuery(searchQuery);
	List<CompanyBean> companyBeanOB2 = new ArrayList<CompanyBean>();
	companyBeanOB2.add(companyBeanOB1);
	CompanyDAO companyDAOOB1 = new CompanyDAO();
	List<CompanyBean> companyBeanOB3 = companyDAOOB1.viewCompany(companyBeanOB2);
	String userCompanyName = companyBeanOB3.get(0).getCompanyName();
	companyBeanOB1 = null;
	companyBeanOB2 = null;
	companyBeanOB3 = null;
	companyDAOOB1 = null;
	
	int userBranchID = userBeanOB3.get(0).getUserBranchID();
	BranchBean branchBeanOB1 = new BranchBean();
	branchBeanOB1.setSearchQuery(" where branchid='"+userBranchID+"'");
	List<BranchBean> branchBeanOB2 = new ArrayList<BranchBean>();
	branchBeanOB2.add(branchBeanOB1);
	BranchDAO branchDAOOB1 = new BranchDAO();
	List<BranchBean> branchBeanOB3 = branchDAOOB1.viewBranch(branchBeanOB2);
	String userBranchName = branchBeanOB3.get(0).getBranchName();
	branchBeanOB1 = null;
	branchBeanOB2 = null;
	branchBeanOB3 = null;
	branchDAOOB1 = null;
	
	int userDepartmentID = userBeanOB3.get(0).getUserDepartmentID();
	DepartmentBean departmentBeanOB1 = new DepartmentBean();
	departmentBeanOB1.setSearchQuery(" where departmentid='"+userDepartmentID+"'");
	List<DepartmentBean> departmentBeanOB2 = new ArrayList<DepartmentBean>();
	departmentBeanOB2.add(departmentBeanOB1);
	DepartmentDAO departmentDAOOB1 = new DepartmentDAO();
	List<DepartmentBean> departmentBeanOB3 = departmentDAOOB1.viewDepartment(departmentBeanOB2);
	String userDepartmentName = departmentBeanOB3.get(0).getDepartmentName();
	departmentBeanOB1 = null;
	departmentBeanOB2 = null;
	departmentBeanOB3 = null;
	departmentDAOOB1 = null;
	
	int userDesignationID = userBeanOB3.get(0).getUserDesignationID();
	DesignationBean designationBeanOB1 = new DesignationBean();
	designationBeanOB1.setSearchQuery(" where designationid='"+userDesignationID+"'");
	List<DesignationBean> designationBeanOB2 = new ArrayList<DesignationBean>();
	designationBeanOB2.add(designationBeanOB1);
	DesignationDAO designationDAOOB1 = new DesignationDAO();
	List<DesignationBean> designationBeanOB3 = designationDAOOB1.viewDesignation(designationBeanOB2);		
	String userDesignationName = designationBeanOB3.get(0).getDesignationName();
	designationBeanOB1 = null;
	designationBeanOB2 = null;
	designationBeanOB3 = null;
	designationDAOOB1 = null;
	
	userBeanOB1 = null;
	userBeanOB2 = null;
	userBeanOB3 = null;
	userDAOOB1 = null;
%>
<form class="form-horizontal" method="post" action="ProfileServlet">
	<div class="container">
		<div class="row">
			<div class="panel panel-primary">
				<div class="panel-heading">
					<div class="row" class="col-sm-12">												
						<div class="panel-title pull-left">
							<h4><strong>Profile</strong></h4>
						</div>						
					<!-- <input type="hidden" name="submitValue" value="updateProfile">
						<button type="submit" class="panel-title pull-right btn btn-info">						
        					<strong>Update</strong>
        					<strong>Log</strong>
        				</button>
        				<button type="submit" class="panel-title pull-right btn btn-info">						
        					<strong>Log</strong>
        				</button> -->
        				<div class="panel-title pull-right">
        				<input type="submit" name="submitValue" value="Update" class="btn btn-info">
        				<input type="submit" name="submitValue" value="Log" class="btn btn-warning">
        				</div>        										
					</div>        	        
        		</div>
                	
				<table class="table">
					<tbody>
						<tr class="success">
							<td><strong>FirstName</strong></td>
							<td><%=userFirstName%></td>
						</tr>
						<tr class="danger">
							<td><strong>LastName</strong></td>
							<td><%=userLastName%></td>
						</tr>
						<tr class="info">
							<td><strong>EmployeeID</strong></td>
							<td><%=userEmployeeID%></td>
						</tr>
						<tr class="warning">
							<td><strong>EmailID</strong></td>
							<td><%=userEmailID%></td>
						</tr>
						<tr class="active">
							<td><strong>MobileNo</strong></td>
							<td><%=userMobileNo%></td>
						</tr>
						<tr class="success">
							<td><strong>CompanyName</strong></td>
							<td><%=cfl.capitalizeName(userCompanyName)%></td>
						</tr>
						<tr class="danger">
							<td><strong>BranchName</strong></td>
							<td><%=cfl.capitalizeName(userBranchName)%></td>
						</tr>
						<tr class="info">
							<td><strong>Designation</strong></td>
							<td><%=cfl.capitalizeName(userDesignationName)%></td>
						</tr>
						<tr class="warning">
							<td><strong>Department</strong></td>
							<td><%=cfl.capitalizeName(userDepartmentName)%></td>
						</tr>
						<tr class="active">
							<td><strong>Role</strong></td>
							<td><%=cfl.capitalizeName(currentSessionUserRole)%></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</form>
<%
}
%>
</body>
</html>