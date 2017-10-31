package com.tt.asset;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class BranchLogServlet
 */
@WebServlet("/BranchLogServlet")
public class BranchLogServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BranchLogServlet() {
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
			String currentSessionUserRole = (String)session.getAttribute("currentSessionUserRole");
			if(currentSessionUserRole.equals("rootadmin") || currentSessionUserRole.equals("companyadmin"))
			{
				String submitValue = request.getParameter("submitValue");
				int selectedBranchID = 0;
				if ("selectanotherbranch".equals(submitValue))
				{
					session.setAttribute("selectedBranchID",0);
					response.sendRedirect("branchLog.jsp");
				}
				else
				{
					selectedBranchID = Integer.valueOf(submitValue);					
					session.setAttribute("selectedBranchID",selectedBranchID);
					response.sendRedirect("branchLog.jsp");
				}
			}
			else
			{
				response.sendRedirect("home.jsp"); //error page
			}
		}
		else
		{
			session.setAttribute("Message1","Authendication Failed");
			session.setAttribute("AlertMessage1","Error!");
			session.setAttribute("AlertType1","alert-danger");
			response.sendRedirect("index.jsp"); //error page
		}
	}

}
