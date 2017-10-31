package com.tt.asset;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class DesignationServlet
 */
@WebServlet("/DesignationServlet")
public class DesignationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DesignationServlet() {
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
			if("rootadmin".equals(session.getAttribute("currentSessionUserRole")) || "companyadmin".equals(session.getAttribute("currentSessionUserRole")))
			{
				String submitValue = request.getParameter("submitValue");				
				if("createDesignation".equals(submitValue))
				{
					int selectedCompanyID = Integer.valueOf(request.getParameter("selectedCompanyID"));
					String designationName=request.getParameter("designationname").toLowerCase().replaceAll("( +)"," ").trim();															
					int currentSessionUserID = (Integer)session.getAttribute("currentSessionUserID");
					DesignationBean designationBeanOB1 = new DesignationBean();
					designationBeanOB1.setCompanyID(selectedCompanyID);
					designationBeanOB1.setCreatedByUserID(currentSessionUserID);
					designationBeanOB1.setDesignationName(designationName);
					DesignationDAO designationDAOOB1 = new DesignationDAO();
					DesignationBean designationBeanOB2 = designationDAOOB1.newDesignation(designationBeanOB1);
					String actionResult = designationBeanOB2.getActionResult();
					String actionReport = designationBeanOB2.getActionReport();
					String AlertType1 = null;
					if (actionResult.equals("Error"))
					{
						AlertType1 = "alert-danger";
					}
					else if (actionResult.equals("Success"))
					{
						AlertType1 = "alert-success"; 
					}							
					session.setAttribute("Message1",actionReport);
					session.setAttribute("AlertMessage1",actionResult+"!");
					session.setAttribute("AlertType1",AlertType1);
					response.sendRedirect("newDesignation.jsp");										
				}
				else if ("updateDesignation".equals(submitValue))
				{
					int designationID = Integer.valueOf(request.getParameter("designationID"));
					String newDesignationName=request.getParameter("newDesignationName").toLowerCase().replaceAll("( +)"," ").trim();
					String oldDesignationName=request.getParameter("oldDesignationName").toLowerCase().replaceAll("( +)"," ").trim();
					String new1DesignationName = newDesignationName; 
					if ("".equals(new1DesignationName))
					{
						new1DesignationName = oldDesignationName;
					}
					int oldStatus = Integer.valueOf(request.getParameter("oldStatus"));			
					int newStatus = Integer.valueOf(request.getParameter("newStatus"));
					int new1Status = newStatus;
					if(oldDesignationName.equals(new1DesignationName) && oldStatus == new1Status)
					{
						session.setAttribute("Message1","No Changes Occured");
						session.setAttribute("AlertMessage1","Info!");
						session.setAttribute("AlertType1","alert-info");				    
					}
					else
					{
						int currentSessionUserID = (Integer)session.getAttribute("currentSessionUserID");
						DesignationBean designationBeanOB1 = new DesignationBean();
						designationBeanOB1.setCreatedByUserID(currentSessionUserID);
						designationBeanOB1.setOldDesignationName(oldDesignationName);
						designationBeanOB1.setDesignationName(new1DesignationName);
						designationBeanOB1.setDesignationStatus(new1Status);
						designationBeanOB1.setOldDesignationStatus(oldStatus);
						designationBeanOB1.setDesignationID(designationID);
						
						DesignationDAO designationDAOOB1 = new DesignationDAO();
						DesignationBean designationBeanOB2 = designationDAOOB1.editDesignation(designationBeanOB1);
					
						String actionResult = designationBeanOB2.getActionResult();
						String actionReport = designationBeanOB2.getActionReport();
						String alertMessage1= null;
						String alertType1= null;
						if("Error".equals(actionResult))
						{
							alertMessage1="Error!";
							alertType1="alert-danger";
						}
						else
						{
							if("Success".equals(actionResult))
							{
								alertMessage1="Success!";
								alertType1="alert-success";
							}
						}
						session.setAttribute("Message1",actionReport);
						session.setAttribute("AlertMessage1",alertMessage1);
						session.setAttribute("AlertType1",alertType1);
					}
					session.setAttribute("selectedDesignationID",designationID);
					response.sendRedirect("editDesignation.jsp");
				}
				else if ("selectanotherdesignation".equals(submitValue))
				{	
					String sourceJSP = request.getParameter("sourceJSP");
					session.setAttribute("selectedDesignationID",0);
					response.sendRedirect(sourceJSP);
				}
				else
				{
					String sourceJSP = request.getParameter("sourceJSP");
					int selectedDesignationID = Integer.valueOf(submitValue);								
					session.setAttribute("selectedDesignationID",selectedDesignationID);
					response.sendRedirect(sourceJSP);
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
