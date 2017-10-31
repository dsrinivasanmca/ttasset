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
/**
 * Servlet implementation class LogoutServlet
 */
@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LogoutServlet() {
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
		 DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
		 Date date = new Date();
		 if(session.getAttribute("currentSessionUserEmployeeID") != null)
		 {	 
			 String currentSessionUserEmployeeID = (String)session.getAttribute("currentSessionUserEmployeeID");			 	    	 
			 System.out.println("User "+currentSessionUserEmployeeID+" Successfully LoggedOut at "+dateFormat.format(date));			
		 }
		 else
		 {
			 System.out.println("User Session Timeout Occured and Successfully LoggedOut at "+dateFormat.format(date));
		 }
		 dateFormat = null;
		 date = null;
	     session.setAttribute("Message1","Loggedout Sucessfully");
	     session.setAttribute("AlertMessage1","Success!");
	     session.setAttribute("AlertType1","alert-success");
         response.sendRedirect("index.jsp"); 
	}

}