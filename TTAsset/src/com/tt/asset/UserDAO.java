package com.tt.asset;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;


public class UserDAO 
{
	Connection con;
	Statement stmt;	
	ResultSet rs;

	String searchQuery;
	String searchQuery1;
	String searchQuery2;
	String insertQuery;
	String actionResult;
	String actionReport;
	
	private int companyID;	
	
	public UserBean authendicateUser(UserBean userBeanOB1)
	{
		String userEmployeeID = userBeanOB1.getUserEmployeeID();
		String userPassword = userBeanOB1.getUserPassword();
		
		try
		{
			searchQuery ="select status,userid,rolename,companyid,branchid from users where employeeid='"+userEmployeeID+"' and loginpassword='"+userPassword+"'";
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery(searchQuery);
			if(!rs.next())
			{
				userBeanOB1.setActionResult("Error");
				userBeanOB1.setActionReport("LoginFaild Authendication Error");
			}
			else
			{
				int userStatus = rs.getInt("status");
				if(userStatus == 0)
				{
					userBeanOB1.setActionResult("Error");
					userBeanOB1.setActionReport("LoginFaild Account is disabled");
				}
				else if (userStatus == 1)
				{
					int createdByUserID = rs.getInt("userid");
					userBeanOB1.setUserID(createdByUserID);
					String currentSessionUserRole = rs.getString("rolename");
					userBeanOB1.setUserRole(currentSessionUserRole);
					int currentSessionUserCompanyID = rs.getInt("companyid");
					userBeanOB1.setUserCompanyID(currentSessionUserCompanyID);
					int currentSessionUserBranchID = rs.getInt("branchid");
					userBeanOB1.setUserBranchID(currentSessionUserBranchID);
					userBeanOB1.setActionResult("Success");
				}
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			if(rs != null){try{rs.close();}catch(SQLException e){e.printStackTrace();}}
			if(stmt != null){try{stmt.close();}catch(SQLException e){e.printStackTrace();}}
			if(con != null){try{con.close();}catch(SQLException e){e.printStackTrace();}}
		}
		return userBeanOB1;
	}
	public UserBean createUser(UserBean userBeanOB1)
	{
		int createdByUserID = userBeanOB1.getCreatedByUserID();
		String userType = userBeanOB1.getUserType();
		companyID = userBeanOB1.getUserCompanyID();
		int vendorCompanyID;
		if(userType.equals("employee"))
		{
			vendorCompanyID = 0;
		}
		else
		{
			vendorCompanyID = userBeanOB1.getUserVendorCompanyID();
		}		
		int branchID = userBeanOB1.getUserBranchID();
		String employeeID = userBeanOB1.getUserEmployeeID();
		String loginPassword = userBeanOB1.getUserPassword();
		String userFirstName = userBeanOB1.getUserFirstName();
		String userLastName = userBeanOB1.getUserLastName();
		String mobileNo = userBeanOB1.getUserMobileNo();
		String emailID = userBeanOB1.getUserEmailID();
		String joiningDate = userBeanOB1.getUserJoiningDate();
		String roleName = userBeanOB1.getUserRole();
		int departmentID = userBeanOB1.getUserDepartmentID();
		int designationID = userBeanOB1.getUserDesignationID();
		String gender = userBeanOB1.getUserGender();
		
		String employeeIDReport=null;
		String mobileNoReport=null;
		String emailIDReport=null;
		
		// Verifying Duplicate EmployeeID		
		CommonSearchBean commonSearchBeanOB1 = new CommonSearchBean();
		searchQuery = "select userid from users where employeeid='"+employeeID+"'";
		commonSearchBeanOB1.setSearchQuery(searchQuery);
		CommonSearchDAO commonSearchDAOOB1 = new CommonSearchDAO();
		CommonSearchBean commonSearchBeanOB2 = commonSearchDAOOB1.findData(commonSearchBeanOB1);
		actionReport = commonSearchBeanOB2.getActionReport();		
		// Verifying Duplicate EmployeeID
		
		if("NoData".equals(actionReport))
		{
			employeeIDReport="Success";
			
			// Verifying Duplicate EmployeeID In MobileNo		
			commonSearchBeanOB1 = new CommonSearchBean();
			searchQuery = "select userid from users where mobileno='"+employeeID+"'";
			commonSearchBeanOB1.setSearchQuery(searchQuery);
			commonSearchDAOOB1 = new CommonSearchDAO();
			commonSearchBeanOB2 = commonSearchDAOOB1.findData(commonSearchBeanOB1);
			actionReport = commonSearchBeanOB2.getActionReport();			
			// Verifying Duplicate EmployeeID In MobileNo
			
			if("NoData".equals(actionReport))
			{
				employeeIDReport="Success";
				
				// Verifying Duplicate EmployeeID In EmailID		
				commonSearchBeanOB1 = new CommonSearchBean();
				searchQuery = "select userid from users where emailid='"+employeeID+"'";
				commonSearchBeanOB1.setSearchQuery(searchQuery);
				commonSearchDAOOB1 = new CommonSearchDAO();
				commonSearchBeanOB2 = commonSearchDAOOB1.findData(commonSearchBeanOB1);
				actionReport = commonSearchBeanOB2.getActionReport();				
				// Verifying Duplicate EmployeeID In EmailID
				
				if("NoData".equals(actionReport))
				{
					employeeIDReport="Success";
				}
				else
				{
					employeeIDReport="Error";
					actionResult = "Error";
					actionReport = "EmployeeID "+employeeID.toUpperCase()+" Already Exist In EmailID";
					System.out.println(actionResult+" "+actionReport);
				}
			}
			else
			{
				employeeIDReport="Error";
				actionResult = "Error";
				actionReport = "EmployeeID "+employeeID.toUpperCase()+" Already Exist In MobileNo";
				System.out.println(actionResult+" "+actionReport);
			}
		}
		else
		{			
			employeeIDReport="Error";
			actionResult = "Error";
			actionReport = "EmployeeID "+employeeID.toUpperCase()+" Already Exist";
			System.out.println(actionResult+" "+actionReport);					
		}
		if("Success".equals(employeeIDReport))
		{
			// Verifying Duplicate MobileNo In EmployeeID		
			commonSearchBeanOB1 = new CommonSearchBean();
			searchQuery = "select userid from users where employeeid='"+mobileNo+"'";
			commonSearchBeanOB1.setSearchQuery(searchQuery);
			commonSearchDAOOB1 = new CommonSearchDAO();
			commonSearchBeanOB2 = commonSearchDAOOB1.findData(commonSearchBeanOB1);
			actionReport = commonSearchBeanOB2.getActionReport();		
			// Verifying Duplicate MobileNo In EmployeeID
			
			if("NoData".equals(actionReport))
			{
				mobileNoReport="Success";
				
				// Verifying Duplicate MobileNo		
				commonSearchBeanOB1 = new CommonSearchBean();
				searchQuery = "select userid from users where mobileno='"+mobileNo+"'";
				commonSearchBeanOB1.setSearchQuery(searchQuery);
				commonSearchDAOOB1 = new CommonSearchDAO();
				commonSearchBeanOB2 = commonSearchDAOOB1.findData(commonSearchBeanOB1);
				actionReport = commonSearchBeanOB2.getActionReport();			
				// Verifying Duplicate MobileNo
				
				if("NoData".equals(actionReport))
				{
					mobileNoReport="Success";
					
					// Verifying Duplicate MobileNo In EmailID		
					commonSearchBeanOB1 = new CommonSearchBean();
					searchQuery = "select userid from users where emailid='"+mobileNo+"'";
					commonSearchBeanOB1.setSearchQuery(searchQuery);
					commonSearchDAOOB1 = new CommonSearchDAO();
					commonSearchBeanOB2 = commonSearchDAOOB1.findData(commonSearchBeanOB1);
					actionReport = commonSearchBeanOB2.getActionReport();				
					// Verifying Duplicate MobileNo In EmailID
					
					if("NoData".equals(actionReport))
					{
						mobileNoReport="Success";
					}
					else
					{
						mobileNoReport="Error";
						actionResult = "Error";
						actionReport = "MobileNo "+mobileNo.toUpperCase()+" Already Exist In EmailID";
						System.out.println(actionResult+" "+actionReport);
					}
				}
				else
				{
					mobileNoReport="Error";
					actionResult = "Error";
					actionReport = "MobileNo "+mobileNo.toUpperCase()+" Already Exist";
					System.out.println(actionResult+" "+actionReport);
				}
			}
			else
			{			
				mobileNoReport="Error";
				actionResult = "Error";
				actionReport = "MobileNo "+mobileNo.toUpperCase()+" Already Exist In EmployeeID";
				System.out.println(actionResult+" "+actionReport);					
			}
		}
		else
		{
			mobileNoReport="Error";
		}
		if("Success".equals(employeeIDReport) && "Success".equals(mobileNoReport))
		{
			// Verifying Duplicate EmailID In EmployeeID		
			commonSearchBeanOB1 = new CommonSearchBean();
			searchQuery = "select userid from users where employeeid='"+emailID+"'";
			commonSearchBeanOB1.setSearchQuery(searchQuery);
			commonSearchDAOOB1 = new CommonSearchDAO();
			commonSearchBeanOB2 = commonSearchDAOOB1.findData(commonSearchBeanOB1);
			actionReport = commonSearchBeanOB2.getActionReport();		
			// Verifying Duplicate EmailID In EmployeeID
			
			if("NoData".equals(actionReport))
			{
				emailIDReport="Success";
				
				// Verifying Duplicate EmailID In MobileNo		
				commonSearchBeanOB1 = new CommonSearchBean();
				searchQuery = "select userid from users where mobileno='"+emailID+"'";
				commonSearchBeanOB1.setSearchQuery(searchQuery);
				commonSearchDAOOB1 = new CommonSearchDAO();
				commonSearchBeanOB2 = commonSearchDAOOB1.findData(commonSearchBeanOB1);
				actionReport = commonSearchBeanOB2.getActionReport();			
				// Verifying Duplicate EmailID In MobileNo
				
				if("NoData".equals(actionReport))
				{
					emailIDReport="Success";
					
					// Verifying Duplicate EmailID		
					commonSearchBeanOB1 = new CommonSearchBean();
					searchQuery = "select userid from users where emailid='"+emailID+"'";
					commonSearchBeanOB1.setSearchQuery(searchQuery);
					commonSearchDAOOB1 = new CommonSearchDAO();
					commonSearchBeanOB2 = commonSearchDAOOB1.findData(commonSearchBeanOB1);
					actionReport = commonSearchBeanOB2.getActionReport();				
					// Verifying Duplicate EmailID
					
					if("NoData".equals(actionReport))
					{
						emailIDReport="Success";
					}
					else
					{
						emailIDReport="Error";
						actionResult = "Error";
						actionReport = "EmailID "+emailID.toUpperCase()+" Already Exist";
						System.out.println(actionResult+" "+actionReport);
					}
				}
				else
				{
					emailIDReport="Error";
					actionResult = "Error";
					actionReport = "EmailID "+emailID.toUpperCase()+" Already Exist In MobileNo";
					System.out.println(actionResult+" "+actionReport);
				}
			}
			else
			{			
				mobileNoReport="Error";
				actionResult = "Error";
				actionReport = "EmailID "+emailID.toUpperCase()+" Already Exist In EmployeeID";
				System.out.println(actionResult+" "+actionReport);					
			}
		}
		else
		{
			emailIDReport="Error";
		}
		if("Success".equals(employeeIDReport) && "Success".equals(mobileNoReport) && "Success".equals(emailIDReport))
		{
			try
			{
				con = ConnectionManager.getConnection();
				stmt = con.createStatement();
			
				String insertColumns="userid,usertype,companyid,vendorcompanyid,branchid,employeeid,loginpassword,userfirstname,userlastname,mobileno,emailid,rolename,departmentid,designationid,joiningdate,gender,status,createdby,creationdatetime";
				String insertValues="userid.nextval,'"+userType+"','"+companyID+"','"+vendorCompanyID+"','"+branchID+"','"+employeeID+"','"+loginPassword+"','"+userFirstName+"','"+userLastName+"','"+mobileNo+"','"+emailID+"','"+roleName+"','"+departmentID+"','"+designationID+"','"+joiningDate+"','"+gender+"','1','"+createdByUserID+"',(select to_char(current_timestamp,'DD-MM-YYYY HH24:MI:SS') from dual)";
				insertQuery = "insert into users("+insertColumns+") values("+insertValues+")";						
				rs = stmt.executeQuery(insertQuery);
				searchQuery = "select userid from users where employeeid='"+employeeID+"' and companyid='"+companyID+"'";
				rs = stmt.executeQuery(searchQuery);
				if(rs.next())
				{	
					int userID = rs.getInt("userid");
					insertColumns="userid,usertype,vendorcompanyid,branchid,employeeid,userfirstname,userlastname,mobileno,emailid,rolename,departmentid,designationid,joiningdate,gender,status,modifiedby,modifydatetime,description";
					insertValues="'"+userID+"','"+userType+"','"+vendorCompanyID+"','"+branchID+"','"+employeeID+"','"+userFirstName+"','"+userLastName+"','"+mobileNo+"','"+emailID+"','"+roleName+"','"+departmentID+"','"+designationID+"','"+joiningDate+"','"+gender+"','1','"+createdByUserID+"',(select to_char(current_timestamp,'DD-MM-YYYY HH24:MI:SS') from dual),'newly created'";
					insertQuery = "insert into userlog("+insertColumns+") values("+insertValues+")";
					stmt.executeQuery(insertQuery);
					actionResult = "Success";
					actionReport = "Employee "+employeeID.toUpperCase()+" Created Successfully";
					System.out.println(actionResult+" "+actionReport);
					rs.close();
				}
				else
				{
					actionResult = "Error";
					actionReport = "UnExpected Error Occurred";
					System.out.println(actionResult+" "+actionReport);
					rs.close();
				}				
			}			
			catch (SQLException e)
		    {
		        e.printStackTrace();
		    }
			finally
			{
				if(rs != null){try{rs.close();}catch(SQLException e){e.printStackTrace();}}				
				if(stmt != null){try{stmt.close();}catch(SQLException e){e.printStackTrace();}}
				if(con != null){try{con.close();}catch(SQLException e){e.printStackTrace();}}
			}
		}
		commonSearchBeanOB1 = null;
		commonSearchBeanOB2 = null;
		commonSearchDAOOB1 = null;
		userBeanOB1.setActionResult(actionResult);
		userBeanOB1.setActionReport(actionReport);
		return userBeanOB1;
	}
	public List<UserBean> viewUser(List<UserBean> userBeanOB1)
	{
		searchQuery = userBeanOB1.get(0).getSearchQuery();		
		userBeanOB1.clear();
		
		try
		{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();			
			searchQuery1 = "select companyid,vendorcompanyid,branchid,departmentid,designationid,rolename,usertype,userid,employeeid,userfirstname,userlastname,emailid,mobileno,joiningdate,gender,status,createdby,creationdatetime from users";
			searchQuery1 = searchQuery1.concat(searchQuery);
			rs = stmt.executeQuery(searchQuery1);			
			while(rs.next())
			{
				UserBean userBeanOB2 = new UserBean();
				userBeanOB2.setUserCompanyID(rs.getInt("companyid"));
				userBeanOB2.setUserVendorCompanyID(rs.getInt("vendorcompanyid"));				
				userBeanOB2.setUserBranchID(rs.getInt("branchid"));
				userBeanOB2.setUserDepartmentID(rs.getInt("departmentid"));
				userBeanOB2.setUserDesignationID(rs.getInt("designationid"));
				userBeanOB2.setUserRole(rs.getString("rolename"));
				userBeanOB2.setUserType(rs.getString("usertype"));
				userBeanOB2.setUserID(rs.getInt("userid"));
				userBeanOB2.setUserEmployeeID(rs.getString("employeeid"));
				userBeanOB2.setUserFirstName(rs.getString("userfirstname"));
				userBeanOB2.setUserLastName(rs.getString("userlastname"));
				userBeanOB2.setUserEmailID(rs.getString("emailid"));
				userBeanOB2.setUserMobileNo(rs.getString("mobileno"));
				userBeanOB2.setUserJoiningDate(rs.getString("joiningdate"));
				userBeanOB2.setUserStatus(rs.getInt("status"));
				userBeanOB2.setUserGender(rs.getString("gender"));				
				userBeanOB2.setCreatedByUserID(rs.getInt("createdby"));
				userBeanOB2.setCreationDateTime(rs.getString("creationdatetime"));				
				userBeanOB1.add(userBeanOB2);
			}
		}		
		catch (SQLException e)
	    {
	        e.printStackTrace();
	    }
		finally
		{
			if(rs != null){try{rs.close();}catch(SQLException e){e.printStackTrace();}}
			if(stmt != null){try{stmt.close();}catch(SQLException e){e.printStackTrace();}}
			if(con != null){try{con.close();}catch(SQLException e){e.printStackTrace();}}
		}
		return userBeanOB1;
	}
	public UserBean editUser(UserBean userBeanOB1)
	{
			
		int userID=userBeanOB1.getUserID();
		String newUserType=userBeanOB1.getUserType();		
		String oldUserType=userBeanOB1.getOldUserType();		
		int newVendorCompanyID = userBeanOB1.getUserVendorCompanyID();
		int oldVendorCompanyID = userBeanOB1.getOldUserVendorCompanyID();
		int newBranchID = userBeanOB1.getUserBranchID();
		int oldBranchID = userBeanOB1.getOldUserBranchID();
		String newLoginPassword = userBeanOB1.getUserPassword();
		int newDepartmentID = userBeanOB1.getUserDepartmentID();
		int oldDepartmentID = userBeanOB1.getOldUserDepartmentID();
		int newDesignationID = userBeanOB1.getUserDesignationID();
		int oldDesignationID = userBeanOB1.getOldUserDesignationID();
		String newEmployeeID = userBeanOB1.getUserEmployeeID();	
		String oldEmployeeID = userBeanOB1.getOldUserEmployeeID();		
		String newFirstName = userBeanOB1.getUserFirstName();
		String oldFirstName = userBeanOB1.getOldUserFirstName();	
		String newLastName = userBeanOB1.getUserLastName();
		String oldLastName = userBeanOB1.getOldUserLastName();
		String newMobileNo = userBeanOB1.getUserMobileNo();
		String oldMobileNo = userBeanOB1.getOldUserMobileNo();
		String newEmailID = userBeanOB1.getUserEmailID();
		String oldEmailID = userBeanOB1.getOldUserEmailID();
		String newJoiningDate = userBeanOB1.getUserJoiningDate();
		String oldJoiningDate = userBeanOB1.getOldUserJoiningDate();
		String newRole = userBeanOB1.getUserRole();		
		String oldRole = userBeanOB1.getOldUserRole();		
		int newStatus = userBeanOB1.getUserStatus();
		int oldStatus = userBeanOB1.getOldUserStatus();
		String newGender = userBeanOB1.getUserGender();			
		String oldGender = userBeanOB1.getOldUserGender();		
		int createdByUserID = userBeanOB1.getCreatedByUserID();		
		String employeeIDReport=null;
		String mobileNoReport=null;
		String emailIDReport=null;
		
		String updateQuery="";
		String description="";
		
		// Verifying Duplicate EmployeeID		
		CommonSearchBean commonSearchBeanOB1 = new CommonSearchBean();
		searchQuery = "select userid from users where employeeid='"+newEmployeeID+"' and userid!='"+userID+"'";
		commonSearchBeanOB1.setSearchQuery(searchQuery);
		CommonSearchDAO commonSearchDAOOB1 = new CommonSearchDAO();
		CommonSearchBean commonSearchBeanOB2 = commonSearchDAOOB1.findData(commonSearchBeanOB1);
		actionReport = commonSearchBeanOB2.getActionReport();		
		// Verifying Duplicate EmployeeID
		
		if("NoData".equals(actionReport))
		{
			employeeIDReport="Success";
			
			// Verifying Duplicate EmployeeID In MobileNo		
			commonSearchBeanOB1 = new CommonSearchBean();
			searchQuery = "select userid from users where mobileno='"+newEmployeeID+"' and userid!='"+userID+"'";
			commonSearchBeanOB1.setSearchQuery(searchQuery);
			commonSearchDAOOB1 = new CommonSearchDAO();
			commonSearchBeanOB2 = commonSearchDAOOB1.findData(commonSearchBeanOB1);
			actionReport = commonSearchBeanOB2.getActionReport();			
			// Verifying Duplicate EmployeeID In MobileNo
			
			if("NoData".equals(actionReport))
			{
				employeeIDReport="Success";
				
				// Verifying Duplicate EmployeeID In EmailID		
				commonSearchBeanOB1 = new CommonSearchBean();
				searchQuery = "select userid from users where emailid='"+newEmployeeID+"' and userid!='"+userID+"'";
				commonSearchBeanOB1.setSearchQuery(searchQuery);
				commonSearchDAOOB1 = new CommonSearchDAO();
				commonSearchBeanOB2 = commonSearchDAOOB1.findData(commonSearchBeanOB1);
				actionReport = commonSearchBeanOB2.getActionReport();				
				// Verifying Duplicate EmployeeID In EmailID
				
				if("NoData".equals(actionReport))
				{
					employeeIDReport="Success";
				}
				else
				{
					employeeIDReport="Error";
					actionResult = "Error";
					actionReport = "EmployeeID "+newEmployeeID.toUpperCase()+" Already Exist In EmailID";
					System.out.println(actionResult+" "+actionReport);
				}
			}
			else
			{
				employeeIDReport="Error";
				actionResult = "Error";
				actionReport = "EmployeeID "+newEmployeeID.toUpperCase()+" Already Exist In MobileNo";
				System.out.println(actionResult+" "+actionReport);
			}
		}
		else
		{			
			employeeIDReport="Error";
			actionResult = "Error";
			actionReport = "EmployeeID "+newEmployeeID.toUpperCase()+" Already Exist";
			System.out.println(actionResult+" "+actionReport);					
		}
		if("Success".equals(employeeIDReport))
		{
			// Verifying Duplicate MobileNo In EmployeeID		
			commonSearchBeanOB1 = new CommonSearchBean();
			searchQuery = "select userid from users where employeeid='"+newMobileNo+"' and userid!='"+userID+"'";
			commonSearchBeanOB1.setSearchQuery(searchQuery);
			commonSearchDAOOB1 = new CommonSearchDAO();
			commonSearchBeanOB2 = commonSearchDAOOB1.findData(commonSearchBeanOB1);
			actionReport = commonSearchBeanOB2.getActionReport();		
			// Verifying Duplicate MobileNo In EmployeeID
			
			if("NoData".equals(actionReport))
			{
				mobileNoReport="Success";
				
				// Verifying Duplicate MobileNo		
				commonSearchBeanOB1 = new CommonSearchBean();
				searchQuery = "select userid from users where mobileno='"+newMobileNo+"' and userid!='"+userID+"'";
				commonSearchBeanOB1.setSearchQuery(searchQuery);
				commonSearchDAOOB1 = new CommonSearchDAO();
				commonSearchBeanOB2 = commonSearchDAOOB1.findData(commonSearchBeanOB1);
				actionReport = commonSearchBeanOB2.getActionReport();			
				// Verifying Duplicate MobileNo
				
				if("NoData".equals(actionReport))
				{
					mobileNoReport="Success";
					
					// Verifying Duplicate MobileNo In EmailID		
					commonSearchBeanOB1 = new CommonSearchBean();
					searchQuery = "select userid from users where emailid='"+newMobileNo+"' and userid!='"+userID+"'";
					commonSearchBeanOB1.setSearchQuery(searchQuery);
					commonSearchDAOOB1 = new CommonSearchDAO();
					commonSearchBeanOB2 = commonSearchDAOOB1.findData(commonSearchBeanOB1);
					actionReport = commonSearchBeanOB2.getActionReport();				
					// Verifying Duplicate MobileNo In EmailID
					
					if("NoData".equals(actionReport))
					{
						mobileNoReport="Success";
					}
					else
					{
						mobileNoReport="Error";
						actionResult = "Error";
						actionReport = "MobileNo "+newMobileNo.toUpperCase()+" Already Exist In EmailID";
						System.out.println(actionResult+" "+actionReport);
					}
				}
				else
				{
					mobileNoReport="Error";
					actionResult = "Error";
					actionReport = "MobileNo "+newMobileNo.toUpperCase()+" Already Exist";
					System.out.println(actionResult+" "+actionReport);
				}
			}
			else
			{			
				mobileNoReport="Error";
				actionResult = "Error";
				actionReport = "MobileNo "+newMobileNo.toUpperCase()+" Already Exist In EmployeeID";
				System.out.println(actionResult+" "+actionReport);					
			}
		}
		else
		{
			mobileNoReport="Error";
		}
		if("Success".equals(employeeIDReport) && "Success".equals(mobileNoReport))
		{
			// Verifying Duplicate EmailID In EmployeeID		
			commonSearchBeanOB1 = new CommonSearchBean();
			searchQuery = "select userid from users where employeeid='"+newEmailID+"' and userid!='"+userID+"'";
			commonSearchBeanOB1.setSearchQuery(searchQuery);
			commonSearchDAOOB1 = new CommonSearchDAO();
			commonSearchBeanOB2 = commonSearchDAOOB1.findData(commonSearchBeanOB1);
			actionReport = commonSearchBeanOB2.getActionReport();		
			// Verifying Duplicate EmailID In EmployeeID
			
			if("NoData".equals(actionReport))
			{
				emailIDReport="Success";
				
				// Verifying Duplicate EmailID In MobileNo		
				commonSearchBeanOB1 = new CommonSearchBean();
				searchQuery = "select userid from users where mobileno='"+newEmailID+"' and userid!='"+userID+"'";;
				commonSearchBeanOB1.setSearchQuery(searchQuery);
				commonSearchDAOOB1 = new CommonSearchDAO();
				commonSearchBeanOB2 = commonSearchDAOOB1.findData(commonSearchBeanOB1);
				actionReport = commonSearchBeanOB2.getActionReport();			
				// Verifying Duplicate EmailID In MobileNo
				
				if("NoData".equals(actionReport))
				{
					emailIDReport="Success";
					
					// Verifying Duplicate EmailID		
					commonSearchBeanOB1 = new CommonSearchBean();
					searchQuery = "select userid from users where emailid='"+newEmailID+"' and userid!='"+userID+"'";;
					commonSearchBeanOB1.setSearchQuery(searchQuery);
					commonSearchDAOOB1 = new CommonSearchDAO();
					commonSearchBeanOB2 = commonSearchDAOOB1.findData(commonSearchBeanOB1);
					actionReport = commonSearchBeanOB2.getActionReport();				
					// Verifying Duplicate EmailID
					
					if("NoData".equals(actionReport))
					{
						emailIDReport="Success";
					}
					else
					{
						emailIDReport="Error";
						actionResult = "Error";
						actionReport = "EmailID "+newEmailID.toUpperCase()+" Already Exist";
						System.out.println(actionResult+" "+actionReport);
					}
				}
				else
				{
					emailIDReport="Error";
					actionResult = "Error";
					actionReport = "EmailID "+newEmailID.toUpperCase()+" Already Exist In MobileNo";
					System.out.println(actionResult+" "+actionReport);
				}
			}
			else
			{			
				mobileNoReport="Error";
				actionResult = "Error";
				actionReport = "EmailID "+newEmailID.toUpperCase()+" Already Exist In EmployeeID";
				System.out.println(actionResult+" "+actionReport);					
			}
		}
		else
		{
			emailIDReport="Error";
		}
		if("Success".equals(employeeIDReport) && "Success".equals(mobileNoReport) && "Success".equals(emailIDReport))
		{				
			if(!oldUserType.equals(newUserType))
			{										
				if("".equals(updateQuery))
				{
					updateQuery = "usertype='"+newUserType+"'";					
				}
				else
				{
					updateQuery = updateQuery.concat(",usertype='"+newUserType+"'");
				}	
				if("".equals(description))
				{
					description = "UserType ";				
				}
				else
				{
					description = description.concat(",UserType ");
				}										
			}									
			if(oldVendorCompanyID != newVendorCompanyID)
			{
				if("".equals(updateQuery))
				{
					updateQuery = "vendorcompanyid='"+newVendorCompanyID+"'";					
				}
				else
				{
					updateQuery = updateQuery.concat(",vendorcompanyid='"+newVendorCompanyID+"'");
				}	
				if("".equals(description))
				{
					description = "VendorCompanyID ";				
				}
				else
				{
					description = description.concat(",VendorCompanyID" );
				}										
			}									
			if(oldBranchID != newBranchID)
			{
				if("".equals(updateQuery))
				{
					updateQuery = "branchid='"+newBranchID+"'";					
				}
				else
				{
					updateQuery = updateQuery.concat(",branchid='"+newBranchID+"'");
				}	
				if("".equals(description))
				{
					description = "BranchID";				
				}
				else
				{
					description = description.concat(",BranchID ");
				}
			}									
			if(!oldEmployeeID.equals(newEmployeeID))
			{
				userBeanOB1.setUserEmployeeID(newEmployeeID);
				if("".equals(updateQuery))
				{
					updateQuery = "employeeid='"+newEmployeeID+"'";					
				}
				else
				{
					updateQuery = updateQuery.concat(",employeeid='"+newEmployeeID+"'");
				}	
				if("".equals(description))
				{
					description = "EmployeeID ";				
				}
				else
				{
					description = description.concat(",EmployeeID ");
				}
			}			
			if(!"".equals(newLoginPassword))
			{
				PasswordEncoder passwordEncoderOB1 = new PasswordEncoder();
				String encryptedPassword = passwordEncoderOB1.encodePassword(newLoginPassword);
				passwordEncoderOB1 = null;
				if("".equals(updateQuery))
				{
					updateQuery = "loginpassword='"+encryptedPassword+"'";					
				}
				else
				{
					updateQuery = updateQuery.concat(",loginpassword='"+encryptedPassword+"',");
				}	
				if("".equals(description))
				{
					description = "Password ";				
				}
				else
				{
					description = description.concat(",Password ");
				}										
			}									
			if(!oldFirstName.equals(newFirstName))
			{
				if("".equals(updateQuery))
				{
					updateQuery = "userfirstname='"+newFirstName+"'";					
				}
				else
				{
					updateQuery = updateQuery.concat(",userfirstname='"+newFirstName+"'");
				}	
				if("".equals(description))
				{
					description = "UserFirstName";				
				}
				else
				{
					description = description.concat(",UserFirstName");
				}
			}									
			if(!oldLastName.equals(newLastName))
			{
				if("".equals(updateQuery))
				{
					updateQuery = "userlastname='"+newLastName+"'";					
				}
				else
				{
					updateQuery = updateQuery.concat(",userlastname='"+newLastName+"'");
				}	
				if("".equals(description))
				{
					description = "UserLastName";				
				}
				else
				{
					description = description.concat(",UserLastName");
				}
			}									
			if(!oldMobileNo.equals(newMobileNo))
			{
				userBeanOB1.setUserMobileNo(newMobileNo);
				if("".equals(updateQuery))
				{
					updateQuery = "mobileno='"+newMobileNo+"'";					
				}
				else
				{
					updateQuery = updateQuery.concat(",mobileno='"+newMobileNo+"'");
				}	
				if("".equals(description))
				{
					description = "MobileNo";				
				}
				else
				{
					description = description.concat(",MobileNo");
				}
			}			
			if(!oldEmailID.equals(newEmailID))
			{
				userBeanOB1.setUserEmailID(newEmailID);
				if("".equals(updateQuery))
				{
					updateQuery = "emailid='"+newEmailID+"'";					
				}
				else
				{
					updateQuery = updateQuery.concat(",emailid='"+newEmailID+"'");
				}	
				if("".equals(description))
				{
					description = "EmailID";				
				}
				else
				{
					description = description.concat(",EmailID");
				}
			}
			if(!oldJoiningDate.equals(newJoiningDate))
			{
				
				if("".equals(updateQuery))
				{
					updateQuery = "joiningdate='"+newJoiningDate+"'";					
				}
				else
				{
					updateQuery = updateQuery.concat(",joiningdate='"+newJoiningDate+"'");
				}	
				if("".equals(description))
				{
					description = "JoiningDate";				
				}
				else
				{
					description = description.concat(",JoiningDate");
				}										
			}									
			if(!oldRole.equals(newRole))										
			{
				if("".equals(updateQuery))
				{
					updateQuery = "rolename='"+newRole+"'";					
				}
				else
				{
					updateQuery = updateQuery.concat(",rolename='"+newRole+"'");
				}	
				if("".equals(description))
				{
					description = "Role";				
				}
				else
				{
					description = description.concat(",Role");
				}
			}									
			if(oldDepartmentID != newDepartmentID)
			{
				if("".equals(updateQuery))
				{
					updateQuery = "departmentid='"+newDepartmentID+"'";					
				}
				else
				{
					updateQuery = updateQuery.concat(",departmentid='"+newDepartmentID+"'");
				}	
				if("".equals(description))
				{
					description = "Department";				
				}
				else
				{
					description = description.concat(",Department");
				}
			}									
			if(oldDesignationID != newDesignationID)
			{
				if("".equals(updateQuery))
				{
					updateQuery = "designationid='"+newDesignationID+"'";					
				}
				else
				{
					updateQuery = updateQuery.concat(",designationid='"+newDesignationID+"'");
				}	
				if("".equals(description))
				{
					description = "Designation";				
				}
				else
				{ 
					description = description.concat(",Designation");
				}
			}									
			if(!oldGender.equals(newGender))
			{
				if("".equals(updateQuery))
				{
					updateQuery = "gender='"+newGender+"'";					
				}
				else
				{
					updateQuery = updateQuery.concat(",gender='"+newGender+"'");
				}	
				if("".equals(description))
				{
					description = "Gender";				
				}
				else
				{
					description = description.concat(",Gender");
				}
			}
			if(oldStatus != newStatus)
			{
				userBeanOB1.setUserStatus(newStatus);
				if("".equals(updateQuery))
				{
					updateQuery = "status='"+newStatus+"'";					
				}
				else
				{
					updateQuery = updateQuery.concat(",status='"+newStatus+"'");
				}	
				if("".equals(description))
				{
					description = "Status";				
				}
				else
				{
					description = description.concat(",Status");
				}
			}
			else if(oldStatus != newStatus)
			{
				userBeanOB1.setUserStatus(2);
			}
			description = description.concat(" Modified");
			try
			{
				con = ConnectionManager.getConnection();
				stmt = con.createStatement();
				String updateQuery1="update users set "+updateQuery+ " where userid='"+userID+"'";
				System.out.println(updateQuery1);
				stmt.executeQuery(updateQuery1);
				//String searchQuery = "select employeeid from users where userid='"+userID+"' and usertype='"+newUserType+"' and vendorcompanyid='"+newVendorCompanyID+"' and branchid='"+newBranchID+"' and employeeid='"+newEmployeeID+"' and userfirstname='"+newFirstName+"' and userlastname='"+newLastName+"' and mobileno='"+newMobileNo+"' and emailid='"+newEmailID+"' and joiningdate<='"+newJoiningDateString+"' and rolename='"+newRole+"' and departmentid='"+newDepartmentID+"' and designationid='"+newDesignationID+"' and gender='"+newGender+"' and status='"+newStatus+"'";																	
				String searchQuery = "select employeeid from users where userid='"+userID+"' and usertype='"+newUserType+"' and vendorcompanyid='"+newVendorCompanyID+"' and branchid='"+newBranchID+"' and employeeid='"+newEmployeeID+"' and userfirstname='"+newFirstName+"' and userlastname='"+newLastName+"' and mobileno='"+newMobileNo+"' and emailid='"+newEmailID+"' and joiningdate = '"+newJoiningDate+"' and rolename='"+newRole+"' and departmentid='"+newDepartmentID+"' and designationid='"+newDesignationID+"' and gender='"+newGender+"' and status='"+newStatus+"'";
				System.out.println(searchQuery);
				userBeanOB1.setSearchQuery(searchQuery);											
				rs = stmt.executeQuery(searchQuery);															
				if(!rs.next())
				{
					actionResult = "Error";
					actionReport = "Unexpected Error While Updating User";
					System.out.print(actionReport);
					rs.close();
				}
				else
				{				
					newEmployeeID = rs.getString("employeeid");					
					String insertColumns="userid,usertype,vendorcompanyid,branchid,employeeid,userfirstname,userlastname,mobileno,emailid,rolename,departmentid,designationid,joiningdate,gender,status,modifiedby,modifydatetime,description";
					String insertValues="'"+userID+"','"+newUserType+"','"+newVendorCompanyID+"','"+newBranchID+"','"+newEmployeeID+"','"+newFirstName+"','"+newLastName+"','"+newMobileNo+"','"+newEmailID+"','"+newRole+"','"+newDepartmentID+"','"+newDesignationID+"','"+newJoiningDate+"','"+newGender+"','"+newStatus+"','"+createdByUserID+"',(select to_char(current_timestamp,'DD-MM-YYYY HH24:MI:SS') from dual),'"+description+"'";
					String insertQuery = "insert into userlog("+insertColumns+") values("+insertValues+")";
					stmt.executeQuery(insertQuery);
					actionResult = "Success";
					actionReport = "User "+newEmployeeID.toUpperCase()+" Updated Successfully";			
					System.out.print(actionReport);
					userBeanOB1.setUserStatus(newStatus);
					userBeanOB1.setUserType(oldUserType);
				}			
			}			
			catch (SQLException e)
		    {
		        e.printStackTrace();
		    }
			finally
			{
				if(rs != null){try{rs.close();}catch(SQLException e){e.printStackTrace();}}							
				if(stmt != null){try{stmt.close();}catch(SQLException e){e.printStackTrace();}}				
				if(con != null){try{con.close();}catch(SQLException e){e.printStackTrace();}}
			}
		}
		userBeanOB1.setActionResult(actionResult);
		userBeanOB1.setActionReport(actionReport);
		return userBeanOB1;
	}
	public List<UserBean> userLog(List<UserBean> userBeanOB1)
	{
		searchQuery = userBeanOB1.get(0).getSearchQuery();
		userBeanOB1.clear();
		
		try
		{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();			
			searchQuery1 = "select vendorcompanyid,branchid,departmentid,designationid,rolename,usertype,userid,employeeid,userfirstname,userlastname,emailid,mobileno,joiningdate,gender,status,modifiedby,modifydatetime,description from userlog";
			searchQuery1 = searchQuery1.concat(searchQuery);	
			rs = stmt.executeQuery(searchQuery1);			
			while(rs.next())
			{
				UserBean userBeanOB2 = new UserBean();				
				userBeanOB2.setUserVendorCompanyID(rs.getInt("vendorcompanyid"));				
				userBeanOB2.setUserBranchID(rs.getInt("branchid"));
				userBeanOB2.setUserDepartmentID(rs.getInt("departmentid"));
				userBeanOB2.setUserDesignationID(rs.getInt("designationid"));
				userBeanOB2.setUserRole(rs.getString("rolename"));
				userBeanOB2.setUserType(rs.getString("usertype"));
				userBeanOB2.setUserID(rs.getInt("userid"));
				userBeanOB2.setUserEmployeeID(rs.getString("employeeid"));
				userBeanOB2.setUserFirstName(rs.getString("userfirstname"));
				userBeanOB2.setUserLastName(rs.getString("userlastname"));
				userBeanOB2.setUserEmailID(rs.getString("emailid"));
				userBeanOB2.setUserMobileNo(rs.getString("mobileno"));
				userBeanOB2.setUserJoiningDate(rs.getString("joiningdate"));
				userBeanOB2.setUserStatus(rs.getInt("status"));
				userBeanOB2.setUserGender(rs.getString("gender"));				
				userBeanOB2.setCreatedByUserID(rs.getInt("modifiedby"));
				userBeanOB2.setCreationDateTime(rs.getString("modifydatetime"));				
				userBeanOB2.setDescription(rs.getString("description"));
				userBeanOB1.add(userBeanOB2);
			}
		}		
		catch (SQLException e)
	    {
	        e.printStackTrace();
	    }
		finally
		{
			if(rs != null){try{rs.close();}catch(SQLException e){e.printStackTrace();}}
			if(stmt != null){try{stmt.close();}catch(SQLException e){e.printStackTrace();}}
			if(con != null){try{con.close();}catch(SQLException e){e.printStackTrace();}}
		}
		return userBeanOB1;
	}
	public List<UserBean> distinctUserCompanyID(List<UserBean> userBeanOB1)
	{
		searchQuery = userBeanOB1.get(0).getSearchQuery();
		userBeanOB1.clear();
		try
		{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
			searchQuery1="select distinct companyid from users";
			searchQuery1=searchQuery1.concat(searchQuery);			
			rs = stmt.executeQuery(searchQuery1);
			while(rs.next())
			{
				UserBean userBeanOB2 = new UserBean();
				userBeanOB2.setUserCompanyID(rs.getInt("companyid"));
				userBeanOB1.add(userBeanOB2);
			}
		}
		catch (SQLException e)
	    {
	        e.printStackTrace();
	    }
		finally
		{
			if(rs != null){try{rs.close();}catch(SQLException e){e.printStackTrace();}}
			if(stmt != null){try{stmt.close();}catch(SQLException e){e.printStackTrace();}}
			if(con != null){try{con.close();}catch(SQLException e){e.printStackTrace();}}
		}
		return userBeanOB1;
	}
	public List<UserBean> distinctUserType(List<UserBean> userBeanOB1)
	{
		searchQuery = userBeanOB1.get(0).getSearchQuery();
		userBeanOB1.clear();
		try
		{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
			searchQuery1="select distinct usertype from users";
			searchQuery1=searchQuery1.concat(searchQuery);			
			rs = stmt.executeQuery(searchQuery1);
			while(rs.next())
			{
				UserBean userBeanOB2 = new UserBean();
				userBeanOB2.setUserType(rs.getString("usertype"));
				userBeanOB1.add(userBeanOB2);
			}
		}		
		catch (SQLException e)
	    {
	        e.printStackTrace();
	    }
		finally
		{
			if(rs != null){try{rs.close();}catch(SQLException e){e.printStackTrace();}}
			if(stmt != null){try{stmt.close();}catch(SQLException e){e.printStackTrace();}}
			if(con != null){try{con.close();}catch(SQLException e){e.printStackTrace();}}
		}
		return userBeanOB1;
	}
	public List<UserBean> distinctUserStatus(List<UserBean> userBeanOB1)
	{
		searchQuery = userBeanOB1.get(0).getSearchQuery();
		userBeanOB1.clear();
		try
		{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
			searchQuery1="select distinct status from users";
			searchQuery1=searchQuery1.concat(searchQuery);			
			rs = stmt.executeQuery(searchQuery1);
			while(rs.next())
			{
				UserBean userBeanOB2 = new UserBean();
				userBeanOB2.setUserStatus(rs.getInt("status"));
				userBeanOB1.add(userBeanOB2);
			}
		}		
		catch (SQLException e)
	    {
	        e.printStackTrace();
	    }
		finally
		{
			if(rs != null){try{rs.close();}catch(SQLException e){e.printStackTrace();}}
			if(stmt != null){try{stmt.close();}catch(SQLException e){e.printStackTrace();}}
			if(con != null){try{con.close();}catch(SQLException e){e.printStackTrace();}}
		}
		return userBeanOB1;
	}
}
