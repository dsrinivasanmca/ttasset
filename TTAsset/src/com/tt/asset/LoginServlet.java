package com.tt.asset;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet 
{
	private static final long serialVersionUID = 1L;

    public LoginServlet() 
    {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{		     			
	     String employeeID = request.getParameter("employeeID").toLowerCase().replaceAll("\\s+","").trim();
	     String employeePassword = request.getParameter("employeePassword").replaceAll("\\s+","").trim();
	     PasswordEncoder passwordEncoderOB1 = new PasswordEncoder();
	     String encryptedPassword = passwordEncoderOB1.encodePassword(employeePassword);
	     passwordEncoderOB1 = null;
	     UserBean userBeanOB1 = new UserBean();
	     userBeanOB1.setUserEmployeeID(employeeID);
	     userBeanOB1.setUserPassword(encryptedPassword);
	     UserDAO userDAOOB1 = new UserDAO();
	     UserBean userBeanOB2 = userDAOOB1.authendicateUser(userBeanOB1);
	     String actionResult = userBeanOB2.getActionResult();	    
	     
	     if("Success".equals(actionResult))
	     {	 
	    	 DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");	    	 
	    	 Date date = new Date();	    	 
	    	 System.out.println("User "+employeeID+" Successfully LoggedIn at "+dateFormat.format(date));
	    	 //DateFormat dateFormate1 = new SimpleDateFormat("dd-MM-yyyy");
	    	 //String todayDate=dateFormate1.format(date);
	    	 int currentSessionUserID = userBeanOB2.getUserID();
	    	 String currentSessionUserRole = userBeanOB2.getUserRole();
		     int currentSessionUserCompanyID = userBeanOB2.getUserCompanyID();
		     int currentSessionUserBranchID = userBeanOB2.getUserBranchID();
		     int currentSessionUserVendorCompanyID = userBeanOB2.getUserVendorCompanyID();
		     String currentSessionUserType = userBeanOB2.getUserType();
			 HttpSession session = request.getSession(true);
			 session.setAttribute("currentSessionUserEmployeeID",employeeID);
			 session.setAttribute("currentSessionUserID",currentSessionUserID);
			 session.setAttribute("currentSessionUserRole",currentSessionUserRole);
			 session.setAttribute("currentSessionUserCompanyID", currentSessionUserCompanyID);
			 session.setAttribute("currentSessionUserBranchID", currentSessionUserBranchID);
			 session.setAttribute("currentSessionUserVendorCompanyID", currentSessionUserVendorCompanyID);
			 session.setAttribute("currentSessionUserType", currentSessionUserType);
			 response.sendRedirect("home.jsp");   
		 }	 
		 else
		 {
			 String actionReport = userBeanOB2.getActionReport();
			 HttpSession session = request.getSession(true);
			 System.out.println("User "+employeeID+" Authendication Failed");
			 session.setAttribute("Message1",actionReport);
			 session.setAttribute("AlertMessage1","Error!");
			 session.setAttribute("AlertType1","alert-danger");
			 response.sendRedirect("index.jsp");
		 }
	     userBeanOB1 = null;
	     userBeanOB2 = null;
	     userDAOOB1 = null;
	}
}
