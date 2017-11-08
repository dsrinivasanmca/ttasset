package com.tt.asset;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class ProfileServlet
 */
@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProfileServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
	// TODO Auto-generated method stub
		HttpSession session = request.getSession(true);
		if( session != null && session.getAttribute("currentSessionUserID") != null)
		{
			int currentSessionUserID = (Integer)session.getAttribute("currentSessionUserID");
			String submitValue = request.getParameter("submitValue");
			if("Update".equals(submitValue))
			{
				session.setAttribute("currentSessionUserID",currentSessionUserID);								
				response.sendRedirect("updateProfile.jsp");
			}
			else if("updateUser".equals(submitValue))
			{
				String newLoginPassword=request.getParameter("newLoginPassword").replaceAll("\\s+","").trim();
				String newConfirmLoginPassword=request.getParameter("newConfirmLoginPassword").replaceAll("\\s+","").trim();							
				if(!newLoginPassword.equals(newConfirmLoginPassword))
				{
					session.setAttribute("Message1","Password and ConfirmPassword Do not Match");
					session.setAttribute("AlertMessage1","Error!");
					session.setAttribute("AlertType1","alert-danger");								
				}
				else
				{
					if(newLoginPassword.length() == 0 && newLoginPassword.equals(newConfirmLoginPassword))
					{
						newLoginPassword = "";
					}
					String newUserFirstName=request.getParameter("newUserFirstName").toLowerCase().replaceAll("( +)"," ").trim();
					String oldUserFirstName=request.getParameter("oldUserFirstName").toLowerCase().replaceAll("( +)"," ").trim();
					if("".equals(newUserFirstName))
					{
						newUserFirstName = oldUserFirstName;
					}
					String newUserLastName=request.getParameter("newUserLastName").toLowerCase().replaceAll("( +)"," ").trim();
					String oldUserLastName=request.getParameter("oldUserLastName").toLowerCase().replaceAll("( +)"," ").trim();
					if("".equals(newUserLastName))
					{
						newUserLastName = oldUserLastName;
					}
					String newMobileNo=request.getParameter("newMobileNo").replaceAll("\\s+","").trim();
					String oldMobileNo=request.getParameter("oldMobileNo").replaceAll("\\s+","").trim();
					if("".equals(newMobileNo))
					{
						newMobileNo = oldMobileNo;
					}
					String newEmailID=request.getParameter("newEmailID").replaceAll("\\s+","").trim();
					String oldEmailID=request.getParameter("oldEmailID").replaceAll("\\s+","").trim();
					if("".equals(newEmailID))
					{
						newEmailID = oldEmailID;
					}
					if("".equals(newLoginPassword) && "".equals(newConfirmLoginPassword) && oldUserFirstName.equals(newUserFirstName) && oldUserLastName.equals(newUserLastName) && oldMobileNo.equals(newMobileNo) && oldEmailID.equals(newEmailID))
					{	
						session.setAttribute("Message1","No Changes Occured");
						session.setAttribute("AlertMessage1","Info!");
						session.setAttribute("AlertType1","alert-info");				    
					}
					else
					{
						String currentLoginPassword=request.getParameter("currentLoginPassword").replaceAll("\\s+","").trim();
						if(currentLoginPassword.length() == 0)
						{
							session.setAttribute("Message1","Please Enter Current Password");
							session.setAttribute("AlertMessage1","Error!");
							session.setAttribute("AlertType1","alert-danger");
						}
						else
						{
							String currentSessionUserEmployeeID = (String)session.getAttribute("currentSessionUserEmployeeID");
							PasswordEncoder passwordEncoderOB1 = new PasswordEncoder();
							String encryptedPassword = passwordEncoderOB1.encodePassword(currentLoginPassword);
							passwordEncoderOB1 = null;
							UserBean userBeanOB1 = new UserBean();
							userBeanOB1.setUserEmployeeID(currentSessionUserEmployeeID);
							userBeanOB1.setUserPassword(encryptedPassword);
							UserDAO userDAOOB1 = new UserDAO();
							UserBean userBeanOB2 = userDAOOB1.authendicateUser(userBeanOB1);
							String actionResult = userBeanOB2.getActionResult();
							userBeanOB1 = null;
							userBeanOB2 = null;
							userDAOOB1 = null;
							
							if("Success".equals(actionResult))
							{
								userBeanOB1 = new UserBean();
								userBeanOB1.setSearchQuery(" where userid='"+currentSessionUserID+"'");
								List<UserBean> userBeanOB3 = new ArrayList<UserBean>();
								userBeanOB3.add(userBeanOB1);		
								userDAOOB1 = new UserDAO();
								List<UserBean> userBeanOB4 = userDAOOB1.viewUser(userBeanOB3);								
								String newUserType=userBeanOB4.get(0).getUserType();
								int newVendorCompanyID = userBeanOB4.get(0).getUserVendorCompanyID();
								int newBranchID = userBeanOB4.get(0).getUserBranchID();
								int newDepartmentID = userBeanOB4.get(0).getUserDepartmentID();
								int newDesignationID = userBeanOB4.get(0).getUserDesignationID();
								String newEmployeeID = userBeanOB4.get(0).getUserEmployeeID();
								String newJoiningDate = userBeanOB4.get(0).getUserJoiningDate();
								String newRole = userBeanOB4.get(0).getUserRole();
								int newStatus = userBeanOB4.get(0).getUserStatus();
								String newGender = userBeanOB4.get(0).getUserGender();
								userBeanOB1 = null;
								userBeanOB3 = null;
								userBeanOB4 = null;
								userDAOOB1 = null;
								userBeanOB1 = new UserBean();
								userBeanOB1.setUserID(currentSessionUserID);
								userBeanOB1.setUserPassword(newLoginPassword);							
								userBeanOB1.setUserFirstName(newUserFirstName);
								userBeanOB1.setOldUserFirstName(oldUserFirstName);	
								userBeanOB1.setUserLastName(newUserLastName);
								userBeanOB1.setOldUserLastName(oldUserLastName);
								userBeanOB1.setUserMobileNo(newMobileNo);
								userBeanOB1.setOldUserMobileNo(oldMobileNo);
								userBeanOB1.setUserEmailID(newEmailID);
								userBeanOB1.setOldUserEmailID(oldEmailID);
								userBeanOB1.setUserType(newUserType);
								userBeanOB1.setOldUserType(newUserType);
								userBeanOB1.setUserVendorCompanyID(newVendorCompanyID);
								userBeanOB1.setOldUserVendorCompanyID(newVendorCompanyID);
								userBeanOB1.setUserBranchID(newBranchID);
								userBeanOB1.setOldUserBranchID(newBranchID);
								userBeanOB1.setUserDepartmentID(newDepartmentID);
								userBeanOB1.setOldUserDepartmentID(newDepartmentID);
								userBeanOB1.setUserDesignationID(newDesignationID);
								userBeanOB1.setOldUserDesignationID(newDesignationID);
								userBeanOB1.setUserEmployeeID(newEmployeeID);
								userBeanOB1.setOldUserEmployeeID(newEmployeeID);
								userBeanOB1.setUserJoiningDate(newJoiningDate);
								userBeanOB1.setOldUserJoiningDate(newJoiningDate);
								userBeanOB1.setUserRole(newRole);
								userBeanOB1.setOldUserRole(newRole);
								userBeanOB1.setUserStatus(newStatus);
								userBeanOB1.setOldUserStatus(newStatus);
								userBeanOB1.setUserGender(newGender);
								userBeanOB1.setOldUserGender(newGender);
								userBeanOB1.setCreatedByUserID(currentSessionUserID);
								userDAOOB1 = new UserDAO();									
								userBeanOB2 = userDAOOB1.editUser(userBeanOB1);
								actionResult=userBeanOB2.getActionResult();
								String actionReport=userBeanOB2.getActionReport();							
								String alertType1 = null;
								userBeanOB1 = null;
								userBeanOB2 = null;
								userDAOOB1 = null;
								if("Error".equals(actionResult))
								{					
									alertType1="alert-danger";
								}
								else
								{	
									if("Success".equals(actionResult))
									{						
										alertType1="alert-success";
									}
								}													
								session.setAttribute("Message1",actionReport);
								session.setAttribute("AlertMessage1",actionResult+"!");
								session.setAttribute("AlertType1",alertType1);												
							}
							else
							{
								session.setAttribute("Message1","Current Password Is Wrong");
								session.setAttribute("AlertMessage1","Error!");
								session.setAttribute("AlertType1","alert-danger");							
							}
						}
					}
				}
				response.sendRedirect("updateProfile.jsp");
			}
			else if("home".equals(submitValue))
			{
				response.sendRedirect("home.jsp");
			}
			else if("Log".equals(submitValue))
			{
				response.sendRedirect("profileLog.jsp");
			}
		}
		else
		{
			session.setAttribute("Message1","Authendication Failed");
			session.setAttribute("AlertMessage1","Error!");
			session.setAttribute("AlertType1","alert-danger");
			response.sendRedirect("index.jsp");
		}
	}
}
