package com.tt.asset;

import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class UserServlet
 */
@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		HttpSession session = request.getSession(true);
		if( session != null && session.getAttribute("currentSessionUserID") != null)
		{			
			if("rootadmin".equals(session.getAttribute("currentSessionUserRole")) || "companyadmin".equals(session.getAttribute("currentSessionUserRole")) || "branchadmin".equals(session.getAttribute("currentSessionUserRole")))
			{
				String currentSessionUserRole = (String)session.getAttribute("currentSessionUserRole");
				int currentSessionUserCompanyID = (Integer)session.getAttribute("currentSessionUserCompanyID");
				String submitValue = request.getParameter("submitValue");
				String onChangeValue = request.getParameter("onChangeValue");
				if("createUser".equals(submitValue))
				{
					if("rootadmin".equals(currentSessionUserRole) || "companyadmin".equals(currentSessionUserRole))
					{
						String userType = request.getParameter("userType");
						String oldUserType = request.getParameter("oldUserType");					
						if(!userType.equals(oldUserType))
						{						
							session.setAttribute("userType",userType);
							session.setAttribute("oldUserType",userType);
							if("rootadmin".equals(currentSessionUserRole))
							{
								session.setAttribute("selectedCompanyID",0);
								session.setAttribute("oldSelectedCompanyID",0);
							}
							else if("companyadmin".equals(currentSessionUserRole))
							{
								session.setAttribute("selectedCompanyID",currentSessionUserCompanyID);
								session.setAttribute("oldSelectedCompanyID",currentSessionUserCompanyID);
							}
							response.sendRedirect("newUser.jsp");
						}
						else
						{
							int selectedCompanyID;
							int oldSelectedCompanyID;
							if("".equals(request.getParameter("selectedCompanyID")))
							{
								selectedCompanyID=0;
							}
							else
							{
								selectedCompanyID = Integer.valueOf(request.getParameter("selectedCompanyID"));							
							}
							if("".equals(request.getParameter("oldSelectedCompanyID")))
							{
								oldSelectedCompanyID=0;
							}
							else	
							{							
								oldSelectedCompanyID = Integer.valueOf(request.getParameter("oldSelectedCompanyID"));
							}
							if(selectedCompanyID != oldSelectedCompanyID) 
							{							
								session.setAttribute("selectedCompanyID",selectedCompanyID);
								session.setAttribute("oldSelectedCompanyID",selectedCompanyID);
								session.setAttribute("selectedBranchID",0);
								session.setAttribute("oldSelectedBranchID",0);
								response.sendRedirect("newUser.jsp");
							}				
							else
							{
								int currentSessionUserID = (Integer)session.getAttribute("currentSessionUserID");
								int vendorCompanyID = Integer.valueOf(request.getParameter("vendorCompanyID"));
								int selectedBranchID = Integer.valueOf(request.getParameter("selectedBranchID"));
								String employeeID=request.getParameter("employeeID").toLowerCase().replaceAll("\\s+","").trim();
								String loginPassword=request.getParameter("loginPassword").replaceAll("\\s+","").trim();
								String confirmLoginPassword=request.getParameter("confirmLoginPassword").replaceAll("\\s+","").trim();
								if(!loginPassword.equals(confirmLoginPassword))
								{
									session.setAttribute("Message1","Password and ConfirmPassword Do not Match");
									session.setAttribute("AlertMessage1","Error!");
									session.setAttribute("AlertType1","alert-danger");
									response.sendRedirect("newUser.jsp");
								}
								else
								{								
									String userFirstName=request.getParameter("userFirstName").toLowerCase().replaceAll("( +)"," ").trim();
									String userLastName=request.getParameter("userLastName").toLowerCase().replaceAll("( +)"," ").trim();
									String mobileNo=request.getParameter("mobileNo").replaceAll("\\s+","").trim();
									String emailID=request.getParameter("emailID").replaceAll("\\s+","").trim();
									String joiningDateString=request.getParameter("joiningDate");
									String joiningDateString1=request.getParameter("joiningDate1");					
									if("".equals(joiningDateString))
									{
										joiningDateString = joiningDateString1;
									}					
									SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
									Date joiningDate = null;
									try 
									{
										joiningDate = dateFormat.parse(joiningDateString);
										joiningDateString = new SimpleDateFormat("dd-MM-yyyy").format(joiningDate);
									} 
									catch (ParseException e) 
									{						
										e.printStackTrace();
									}
									String roleName=request.getParameter("roleName").replaceAll("\\s+","").trim();
									int departmentID = Integer.valueOf(request.getParameter("departmentID"));
									int designationID = Integer.valueOf(request.getParameter("designationID"));
									String gender = request.getParameter("gender");
									UserBean userBeanOB1 = new UserBean();
									userBeanOB1.setUserType(userType);
									userBeanOB1.setUserCompanyID(selectedCompanyID);
									userBeanOB1.setUserVendorCompanyID(vendorCompanyID);
									userBeanOB1.setUserBranchID(selectedBranchID);
									userBeanOB1.setUserEmployeeID(employeeID);
									PasswordEncoder passwordEncoderOB1 = new PasswordEncoder();
									String encryptedPassword = passwordEncoderOB1.encodePassword(loginPassword);
									passwordEncoderOB1 = null;
									userBeanOB1.setUserPassword(encryptedPassword);
									userBeanOB1.setUserFirstName(userFirstName);
									userBeanOB1.setUserLastName(userLastName);
									userBeanOB1.setUserMobileNo(mobileNo);
									userBeanOB1.setUserEmailID(emailID);
									userBeanOB1.setUserJoiningDate(joiningDateString);
									userBeanOB1.setUserRole(roleName);
									userBeanOB1.setUserDepartmentID(departmentID);
									userBeanOB1.setUserDesignationID(designationID);
									userBeanOB1.setUserGender(gender);
									userBeanOB1.setCreatedByUserID(currentSessionUserID);
									UserDAO userDAOOB1 = new UserDAO();
									UserBean userBeanOB2 = userDAOOB1.createUser(userBeanOB1);
									String actionResult=userBeanOB2.getActionResult();
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
									if("rootadmin".equals(session.getAttribute("currentSessionUserRole")))
									{
										session.setAttribute("userType","employee");
										session.setAttribute("oldUserType","employee");
										session.setAttribute("selectedCompanyID",0);
										session.setAttribute("oldSelectedCompanyID",0);
									}								
									session.setAttribute("selectedBranchID",0);
									session.setAttribute("oldSelectedBranchID",0);								
									response.sendRedirect("newUser.jsp");
								}
							}
						}
					}
					else
					{
						response.sendRedirect("home.jsp");
					}
				}
				else if("downloadTemplate".equals(submitValue))
				{
					response.setContentType("text/csv");
				    response.setHeader("Content-Disposition", "attachment; filename=\"importUser.csv\"");
				    try
				    {
				        OutputStream outputStream = response.getOutputStream();
				        String outputResult = "USERTYPE,COMPANY,VENDORCOMPANY,BRANCH,EMPLOYEEID,PASSWORD,CONFIRMPASSWORD,USERFIRSTNAME,USERLASTNAME,MOBILENO,EMAILID,JOININGDATE,ROLE,DEPARTMENT,DESIGNATION,GENDER\n";
				        outputStream.write(outputResult.getBytes());
				        outputStream.flush();
				        outputStream.close();
				    }
				    catch(Exception e)
				    {
				        System.out.println(e.toString());
				    }
				}
				else if("importUser".equals(submitValue))
				{
					File importUserCSVFile;
					//ReadImportUserCSV readImportUserCSVOB1;
					//List<ImportUserBean> importUserBeanOB1 = readImportUserCSVOB1.readInputCSV(importUserCSVFile);
				}
				else if(!"createuser".equals(submitValue) && !"downloadTemplate".equals(submitValue))
				{
					String sourceJSP = request.getParameter("sourceJSP");										
					int selectedCompanyID;
					int oldSelectedCompanyID;
					if("".equals(request.getParameter("selectedCompanyID")))
					{
						selectedCompanyID=0;
					}
					else
					{
						selectedCompanyID = Integer.valueOf(request.getParameter("selectedCompanyID"));							
					}
					if("".equals(request.getParameter("oldSelectedCompanyID")))
					{
						oldSelectedCompanyID=0;
					}
					else	
					{							
						oldSelectedCompanyID = Integer.valueOf(request.getParameter("oldSelectedCompanyID"));
					}
					if(selectedCompanyID != oldSelectedCompanyID) 
					{							
						session.setAttribute("selectedCompanyID",selectedCompanyID);
						session.setAttribute("oldSelectedCompanyID",selectedCompanyID);
						session.setAttribute("selectedUserType","unKnown");
						session.setAttribute("oldSelectedUserType","unKnown");
						response.sendRedirect(sourceJSP);
					}
					else
					{
						String selectedUserType = "unKnown";
						String oldSelectedUserType = "unKnown";
						if("".equals(request.getParameter("selectedUserType")))
						{
							selectedUserType="unKnown";
						}
						else
						{
							selectedUserType = request.getParameter("selectedUserType");							
						}
						if("".equals(request.getParameter("oldSelectedUserType")))
						{
							oldSelectedUserType="unKnown";
						}
						else	
						{							
							oldSelectedUserType = request.getParameter("oldSelectedUserType");
						}
						if(!selectedUserType.equals(oldSelectedUserType)) 
						{							
							session.setAttribute("selectedUserType",selectedUserType);
							session.setAttribute("oldSelectedUserType",selectedUserType);
							session.setAttribute("selectedUserStatus",100);
							session.setAttribute("oldSelectedUserStatus",100);
							response.sendRedirect(sourceJSP);
						}
						else
						{
							int selectedUserStatus;
							int oldSelectedUserStatus;
							if("".equals(request.getParameter("selectedUserStatus")))
							{
								selectedUserStatus=100;
							}
							else
							{
								selectedUserStatus = Integer.valueOf(request.getParameter("selectedUserStatus"));							
							}
							if("".equals(request.getParameter("oldSelectedUserStatus")))
							{
								oldSelectedUserStatus=100;
							}
							else	
							{							
								oldSelectedUserStatus = Integer.valueOf(request.getParameter("oldSelectedUserStatus"));
							}
							if(selectedUserStatus != oldSelectedUserStatus) 
							{							
								session.setAttribute("selectedUserStatus",selectedUserStatus);
								session.setAttribute("oldSelectedUserStatus",selectedUserStatus);								
								response.sendRedirect(sourceJSP);
							}
							else
							{
								if ("updateUser".equals(submitValue) || (!"updateUser".equals(submitValue) && !"selectAnotherUser".equals(submitValue) && "updateUser".equals(onChangeValue)))
								{
									int userID = Integer.valueOf(request.getParameter("userID"));
									String orgUserType = request.getParameter("orgUserType");
									String newUserType = request.getParameter("newUserType");
									String oldUserType = request.getParameter("oldUserType");									
									if(!newUserType.equals(oldUserType))
									{						
										session.setAttribute("newUserType",newUserType);
										session.setAttribute("oldUserType",newUserType);																			
									}
									else
									{
										String new1UserType = newUserType;
										int newVendorCompanyID = Integer.valueOf(request.getParameter("newVendorCompanyID"));
										int oldVendorCompanyID = Integer.valueOf(request.getParameter("oldVendorCompanyID"));					
										if(newVendorCompanyID == 0 && !"employee".equals(new1UserType))
										{						
											session.setAttribute("Message1","Select VendorCompany");
											session.setAttribute("AlertMessage1","Error!");
											session.setAttribute("AlertType1","alert-danger");						
										}
										else
										{
											int new1VendorCompanyID = newVendorCompanyID;
											int newBranchID = Integer.valueOf(request.getParameter("newBranchID"));
											int oldBranchID = Integer.valueOf(request.getParameter("oldBranchID"));
											String newEmployeeID = request.getParameter("newEmployeeID").toLowerCase().replaceAll("\\s+","").trim();
											String oldEmployeeID = request.getParameter("oldEmployeeID").toLowerCase().replaceAll("\\s+","").trim();
											if("".equals(newEmployeeID))
											{
												newEmployeeID = oldEmployeeID;
											}
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
												String newJoiningDateString=request.getParameter("newJoiningDate");								
												String oldJoiningDateString=request.getParameter("oldJoiningDate");								
												if("".equals(newJoiningDateString))
												{
													newJoiningDateString = oldJoiningDateString;									
												}					
												SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
												Date newJoiningDate = null;
												Date oldJoiningDate = null;															
												try 
												{
													newJoiningDate = dateFormat.parse(newJoiningDateString);
													newJoiningDateString = new SimpleDateFormat("dd-MM-yyyy").format(newJoiningDate);
													oldJoiningDate = dateFormat.parse(oldJoiningDateString);
													oldJoiningDateString = new SimpleDateFormat("dd-MM-yyyy").format(oldJoiningDate);
												} 
												catch (ParseException e) 
												{						
													e.printStackTrace();
												}
												String newRoleName=request.getParameter("newRoleName");
												String oldRoleName=request.getParameter("oldRoleName");
												if(newRoleName.equals("selectrolename"))
												{
													session.setAttribute("Message1","Select RoleName");
													session.setAttribute("AlertMessage1","Error!");
													session.setAttribute("AlertType1","alert-danger");								
												}
												else
												{
													int newDepartmentID = Integer.valueOf(request.getParameter("newDepartmentID"));
													int oldDepartmentID = Integer.valueOf(request.getParameter("oldDepartmentID"));
													int newDesignationID = Integer.valueOf(request.getParameter("newDesignationID"));
													int oldDesignationID = Integer.valueOf(request.getParameter("oldDesignationID"));
													String newGender = request.getParameter("newGender");
													String oldGender = request.getParameter("oldGender");
													int oldStatus = Integer.valueOf(request.getParameter("oldStatus"));
													int newStatus = Integer.valueOf(request.getParameter("newStatus"));												
													if(orgUserType.equals(new1UserType) && oldVendorCompanyID == new1VendorCompanyID && oldBranchID == newBranchID && oldEmployeeID.equals(newEmployeeID) && "".equals(newLoginPassword) && "".equals(newConfirmLoginPassword) && oldUserFirstName.equals(newUserFirstName) && oldUserLastName.equals(newUserLastName) && oldMobileNo.equals(newMobileNo) && oldEmailID.equals(newEmailID) && oldJoiningDate.equals(newJoiningDate) && oldRoleName.equals(newRoleName) && oldDepartmentID == newDepartmentID && oldDesignationID == newDesignationID && oldGender.equals(newGender) && oldStatus == newStatus)
													{	
														session.setAttribute("Message1","No Changes Occured");
														session.setAttribute("AlertMessage1","Info!");
														session.setAttribute("AlertType1","alert-info");				    
													}
													else
													{
														int currentSessionUserID = (Integer)session.getAttribute("currentSessionUserID");
														UserBean userBeanOB1 = new UserBean();
														userBeanOB1.setUserID(userID);
														userBeanOB1.setCreatedByUserID(currentSessionUserID);
														userBeanOB1.setUserType(new1UserType);
														userBeanOB1.setOldUserType(orgUserType);									
														userBeanOB1.setUserVendorCompanyID(new1VendorCompanyID);
														userBeanOB1.setOldUserVendorCompanyID(oldVendorCompanyID);
														userBeanOB1.setUserBranchID(newBranchID);
														userBeanOB1.setOldUserBranchID(oldBranchID);
														userBeanOB1.setUserPassword(newLoginPassword);
														userBeanOB1.setUserDepartmentID(newDepartmentID);
														userBeanOB1.setOldUserDepartmentID(oldDepartmentID);
														userBeanOB1.setUserDesignationID(newDesignationID);
														userBeanOB1.setOldUserDesignationID(oldDesignationID);
														userBeanOB1.setUserEmployeeID(newEmployeeID);
														userBeanOB1.setOldUserEmployeeID(oldEmployeeID);
														userBeanOB1.setUserFirstName(newUserFirstName);
														userBeanOB1.setOldUserFirstName(oldUserFirstName);	
														userBeanOB1.setUserLastName(newUserLastName);
														userBeanOB1.setOldUserLastName(oldUserLastName);
														userBeanOB1.setUserMobileNo(newMobileNo);
														userBeanOB1.setOldUserMobileNo(oldMobileNo);
														userBeanOB1.setUserEmailID(newEmailID);
														userBeanOB1.setOldUserEmailID(oldEmailID);
														userBeanOB1.setUserJoiningDate(newJoiningDateString);
														userBeanOB1.setOldUserJoiningDate(oldJoiningDateString);
														userBeanOB1.setUserRole(newRoleName);
														userBeanOB1.setOldUserRole(oldRoleName);
														userBeanOB1.setUserStatus(newStatus);
														userBeanOB1.setOldUserStatus(oldStatus);
														userBeanOB1.setUserGender(newGender);
														userBeanOB1.setOldUserGender(oldGender);									
														UserDAO userDAOOB1 = new UserDAO();									
														UserBean userBeanOB2 = userDAOOB1.editUser(userBeanOB1);
														String actionResult=userBeanOB2.getActionResult();
														String actionReport=userBeanOB2.getActionReport();
														selectedUserStatus = userBeanOB2.getUserStatus();
														selectedUserType = userBeanOB2.getUserType();
														newVendorCompanyID = userBeanOB2.getUserVendorCompanyID();
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
														session.setAttribute("selectedUserType",selectedUserType);
														session.setAttribute("oldSelectedUserType",selectedUserType);
														session.setAttribute("selectedUserStatus",selectedUserStatus);
														session.setAttribute("oldSelectedUserStatus",selectedUserStatus);
														session.setAttribute("newVendorCompanyID",newVendorCompanyID);
														session.setAttribute("oldVendorCompanyID",newVendorCompanyID);
													}
												}
											}						
										}
									}
									response.sendRedirect("editUser.jsp");
								}
								else if ("selectAnotherUser".equals(submitValue))
								{										
									session.setAttribute("selectedUserID",0);
									response.sendRedirect(sourceJSP);
								}
								else
								{									
									int selectedUserID = Integer.valueOf(submitValue);
									if("editUser.jsp".equals(sourceJSP))
									{
										UserBean userBeanOB1 = new UserBean();
										userBeanOB1.setSearchQuery(" where userid='"+selectedUserID+"'");
										List<UserBean> userBeanOB2 = new ArrayList<UserBean>();
										userBeanOB2.add(userBeanOB1);
										UserDAO userDAOOB1 = new UserDAO();
										List<UserBean> userBeanOB3 = userDAOOB1.viewUser(userBeanOB2);						
										String newUserType = userBeanOB3.get(0).getUserType();
										int newVendorCompanyID = userBeanOB3.get(0).getUserVendorCompanyID();
										userBeanOB1 = null;
										userBeanOB2 = null;
										userBeanOB3 = null;
										userDAOOB1 = null; 						
										session.setAttribute("newUserType",newUserType);
										session.setAttribute("oldUserType",newUserType);										
										session.setAttribute("newVendorCompanyID",newVendorCompanyID);
										session.setAttribute("oldVendorCompanyID",newVendorCompanyID);
									}
									session.setAttribute("selectedUserID",selectedUserID);
									response.sendRedirect(sourceJSP);
								} 
							}
						}
					}
				}
			}
			else
			{
				response.sendRedirect("home.jsp");
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
