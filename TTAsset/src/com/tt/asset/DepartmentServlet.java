package com.tt.asset;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class DepartmentServlet
 */
@WebServlet("/DepartmentServlet")
public class DepartmentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DepartmentServlet() {
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
				if("createDepartment".equals(submitValue))
				{
					int selectedCompanyID = Integer.valueOf(request.getParameter("selectedCompanyID"));
					String departmentName=request.getParameter("departmentname").toLowerCase().replaceAll("( +)"," ").trim();															
					int currentSessionUserID = (Integer)session.getAttribute("currentSessionUserID");
					DepartmentBean departmentBeanOB1 = new DepartmentBean();
					departmentBeanOB1.setCompanyID(selectedCompanyID);
					departmentBeanOB1.setCreatedByUserID(currentSessionUserID);
					departmentBeanOB1.setDepartmentName(departmentName);
					DepartmentDAO departmentDAOOB1 = new DepartmentDAO();
					DepartmentBean departmentBeanOB2 = departmentDAOOB1.newDepartment(departmentBeanOB1);
					String actionResult = departmentBeanOB2.getActionResult();
					String actionReport = departmentBeanOB2.getActionReport();
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
					response.sendRedirect("newDepartment.jsp");										
				}
				else if ("updateDepartment".equals(submitValue))
				{
					int departmentID = Integer.valueOf(request.getParameter("departmentID"));
					String newDepartmentName=request.getParameter("newDepartmentName").toLowerCase().replaceAll("( +)"," ").trim();
					String oldDepartmentName=request.getParameter("oldDepartmentName").toLowerCase().replaceAll("( +)"," ").trim();
					String new1DepartmentName = newDepartmentName; 
					if ("".equals(new1DepartmentName))
					{
						new1DepartmentName = oldDepartmentName;
					}
					int oldStatus = Integer.valueOf(request.getParameter("oldStatus"));			
					int newStatus = Integer.valueOf(request.getParameter("newStatus"));
					int new1Status = newStatus;
					if(oldDepartmentName.equals(new1DepartmentName) && oldStatus == new1Status)
					{
						session.setAttribute("Message1","No Changes Occured");
						session.setAttribute("AlertMessage1","Info!");
						session.setAttribute("AlertType1","alert-info");				    
					}
					else
					{
						int currentSessionUserID = (Integer)session.getAttribute("currentSessionUserID");
						DepartmentBean departmentBeanOB1 = new DepartmentBean();
						departmentBeanOB1.setCreatedByUserID(currentSessionUserID);
						departmentBeanOB1.setOldDepartmentName(oldDepartmentName);
						departmentBeanOB1.setDepartmentName(new1DepartmentName);
						departmentBeanOB1.setDepartmentStatus(new1Status);
						departmentBeanOB1.setOldDepartmentStatus(oldStatus);
						departmentBeanOB1.setDepartmentID(departmentID);
						
						DepartmentDAO departmentDAOOB1 = new DepartmentDAO();
						DepartmentBean departmentBeanOB2 = departmentDAOOB1.editDepartment(departmentBeanOB1);
					
						String actionResult = departmentBeanOB2.getActionResult();
						String actionReport = departmentBeanOB2.getActionReport();
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
					session.setAttribute("selectedDepartmentID",departmentID);
					response.sendRedirect("editDepartment.jsp");
				}
				else if ("selectanotherdepartment".equals(submitValue))
				{	
					String sourceJSP = request.getParameter("sourceJSP");
					session.setAttribute("selectedDepartmentID",0);
					response.sendRedirect(sourceJSP);
				}
				else
				{
					String sourceJSP = request.getParameter("sourceJSP");
					int selectedDepartmentID = Integer.valueOf(submitValue);								
					session.setAttribute("selectedDepartmentID",selectedDepartmentID);
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
