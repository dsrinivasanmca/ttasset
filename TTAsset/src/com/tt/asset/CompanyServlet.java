package com.tt.asset;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class CompanyServlet
 */
@WebServlet("/CompanyServlet")
public class CompanyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CompanyServlet() {
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
			if("createCompany".equals(submitValue))
			{
				if("rootadmin".equals(session.getAttribute("currentSessionUserRole")))
				{
					String companyName=request.getParameter("companyName").toLowerCase().replaceAll("( +)"," ").trim();
					String openingDateString=request.getParameter("openingDate");
					String openingDateString1=request.getParameter("openingDate1");					
					if("".equals(openingDateString))
					{
						openingDateString = openingDateString1;
					}					
					SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
					Date openingDate = null;
					try 
					{
						openingDate = dateFormat.parse(openingDateString);
						openingDateString = new SimpleDateFormat("yyyy-MM-dd").format(openingDate);
					} 
					catch (ParseException e) 
					{						
						e.printStackTrace();
					}																			
					CompanyBean companyBeanOB1 = new CompanyBean();
					companyBeanOB1.setCompanyName(companyName);
					companyBeanOB1.setOpeningDate(openingDate);
					companyBeanOB1.setCreatedByUserID(currentSessionUserID);
					CompanyDAO companyDAOOB1 = new CompanyDAO();
					CompanyBean companyBeanOB2 = companyDAOOB1.newCompany(companyBeanOB1);
					String actionResult=companyBeanOB2.getActionResult();
					String actionReport=companyBeanOB2.getActionReport();
					String alertType1 = null;
					companyBeanOB1 = null;
					companyBeanOB2 = null;
					companyDAOOB1 = null;
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
					response.sendRedirect("newCompany.jsp");					
				}
				else
				{
					response.sendRedirect("home.jsp");
				}
			}
			else if("updateCompany".equals(submitValue))
			{
				if("rootadmin".equals(session.getAttribute("currentSessionUserRole")) || "companyadmin".equals(session.getAttribute("currentSessionUserRole")))
				{
					int companyID = Integer.valueOf(request.getParameter("companyID"));
					String newCompanyName=request.getParameter("newCompanyName").toLowerCase().replaceAll("( +)"," ").trim();
					String oldCompanyName=request.getParameter("oldCompanyName").toLowerCase().replaceAll("( +)"," ").trim();
					String new1CompanyName = newCompanyName;					
					if ("".equals(new1CompanyName))
					{
						new1CompanyName = oldCompanyName;
					}
					String newOpeningDateString=request.getParameter("newOpeningDate");					
					String oldOpeningDateString=request.getParameter("oldOpeningDate");
					String new1OpeningDateString = newOpeningDateString;
					if("".equals(new1OpeningDateString))
					{
						new1OpeningDateString = oldOpeningDateString;
					}					
					SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
					Date new1OpeningDate = null;
					Date oldOpeningDate = null;
					try 
					{
						new1OpeningDate = dateFormat.parse(new1OpeningDateString);
						oldOpeningDate = dateFormat.parse(oldOpeningDateString);
						new1OpeningDateString = new SimpleDateFormat("yyyy-MM-dd").format(new1OpeningDate);
						oldOpeningDateString = new SimpleDateFormat("yyyy-MM-dd").format(oldOpeningDate);						
					} 
					catch (ParseException e) 
					{						
						e.printStackTrace();
					}
					int oldStatus = Integer.valueOf(request.getParameter("oldStatus"));			
					int newStatus = Integer.valueOf(request.getParameter("newStatus"));
					int new1Status = newStatus;
					if(oldCompanyName.equals(new1CompanyName) && oldOpeningDateString.equals(new1OpeningDateString) && oldStatus == new1Status)
					{
						session.setAttribute("Message1","No Changes Occured");
						session.setAttribute("AlertMessage1","Info!");
						session.setAttribute("AlertType1","alert-info");				    
					}
					else
					{
												
						CompanyBean companyBeanOB1 = new CompanyBean();												
						companyBeanOB1.setCompanyName(new1CompanyName);
						companyBeanOB1.setOldCompanyName(oldCompanyName);
						companyBeanOB1.setOpeningDate(new1OpeningDate);
						companyBeanOB1.setOldOpeningDate(oldOpeningDate);
						companyBeanOB1.setCompanyStatus(new1Status);
						companyBeanOB1.setOldCompanyStatus(oldStatus);
						companyBeanOB1.setCompanyID(companyID);
						companyBeanOB1.setCreatedByUserID(currentSessionUserID);						
						CompanyDAO companyDAOOB1 = new CompanyDAO();
						CompanyBean companyBeanOB2 = companyDAOOB1.editCompany(companyBeanOB1);
					
						String actionResult = companyBeanOB2.getActionResult();
						String actionReport = companyBeanOB2.getActionReport();
						String alertMessage1= null;
						String alertType1= null;
						
						companyBeanOB1 = null;
						companyBeanOB2 = null;
						companyDAOOB1 = null;
						
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
					session.setAttribute("selectedCompanyID",companyID);
					response.sendRedirect("editCompany.jsp");
				}
				else
				{
					response.sendRedirect("home.jsp");
				}
			}
			else if ("selectAnotherCompany".equals(submitValue))
			{	
				String sourceJSP = request.getParameter("sourceJSP");
				session.setAttribute("selectedCompanyID",0);
				response.sendRedirect(sourceJSP);
			}
			else
			{
				String sourceJSP = request.getParameter("sourceJSP");
				int selectedCompanyID = Integer.valueOf(submitValue);
				session.setAttribute("selectedCompanyID",selectedCompanyID);
				response.sendRedirect(sourceJSP);
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
