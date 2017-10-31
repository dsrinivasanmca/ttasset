package com.tt.asset;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class BranchServlet
 */
@WebServlet("/BranchServlet")
public class BranchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BranchServlet() {
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
				if("createBranch".equals(submitValue))
				{
					int currentSessionUserID = (Integer)session.getAttribute("currentSessionUserID");
					int selectedCompanyID = Integer.valueOf(request.getParameter("selectedCompanyID"));
					String branchName=request.getParameter("branchName").toLowerCase().replaceAll("\\s+","").trim();
					String address1=request.getParameter("address1").toLowerCase().replaceAll("( +)"," ").trim();
					String address2=request.getParameter("address2").toLowerCase().replaceAll("( +)"," ").trim();
					String address3=request.getParameter("address3").toLowerCase().replaceAll("\\s+","").trim();
					String address4=request.getParameter("address4").toLowerCase().replaceAll("\\s+","").trim();
					String postalCode=request.getParameter("postalCode").toLowerCase().replaceAll("\\s+","").trim();
					String city=request.getParameter("city").toLowerCase().replaceAll("\\s+","").trim();
					String state=request.getParameter("state").toLowerCase().replaceAll("\\s+","").trim();
					String country=request.getParameter("country").toLowerCase().replaceAll("\\s+","").trim();
					BranchBean branchBeanOB1 = new BranchBean();
					branchBeanOB1.setCompanyID(selectedCompanyID);
					branchBeanOB1.setCreatedByUserID(currentSessionUserID);
					branchBeanOB1.setBranchName(branchName);
					branchBeanOB1.setAddress1(address1);
					branchBeanOB1.setAddress2(address2);
					branchBeanOB1.setAddress3(address3);
					branchBeanOB1.setAddress4(address4);
					branchBeanOB1.setPostalCode(postalCode);
					branchBeanOB1.setCity(city);
					branchBeanOB1.setState(state);
					branchBeanOB1.setCountry(country);
					BranchDAO branchDAOOB1 = new BranchDAO();
					BranchBean branchBeanOB2 = branchDAOOB1.newBranch(branchBeanOB1);
					String actionResult = branchBeanOB2.getActionResult();
					String actionReport = branchBeanOB2.getActionReport();
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
					response.sendRedirect("newBranch.jsp");										
				}
				else if ("updateBranch".equals(submitValue))
				{
					int branchID = Integer.valueOf(request.getParameter("branchID"));
					String oldBranchName = request.getParameter("oldBranchName").toLowerCase().replaceAll("( +)"," ").trim();
					String newBranchName = request.getParameter("newBranchName").toLowerCase().replaceAll("( +)"," ").trim();
					String new1BranchName = newBranchName; 
					if ("".equals(new1BranchName))
					{
						new1BranchName = oldBranchName;
					}
					String oldAddress1 = request.getParameter("oldAddress1").toLowerCase().replaceAll("( +)"," ").trim();
					String newAddress1 = request.getParameter("newAddress1").toLowerCase().replaceAll("( +)"," ").trim();
					String new1Address1 = newAddress1;
					if ("".equals(new1Address1))
					{
						new1Address1 = oldAddress1;
					}
					String oldAddress2 = request.getParameter("oldAddress2").toLowerCase().replaceAll("( +)"," ").trim();
					String newAddress2 = request.getParameter("newAddress2").toLowerCase().replaceAll("( +)"," ").trim();
					String new1Address2 = newAddress2;
					if ("".equals(new1Address2))
					{
						new1Address2 = oldAddress2;
					}
					String oldAddress3 = request.getParameter("oldAddress3").toLowerCase().replaceAll("( +)"," ").trim();
					String newAddress3 = request.getParameter("newAddress3").toLowerCase().replaceAll("( +)"," ").trim();
					String new1Address3 = newAddress3;
					if ("".equals(new1Address3))
					{
						new1Address3 = oldAddress3;
					}
					String oldAddress4 = request.getParameter("oldAddress4").toLowerCase().replaceAll("( +)"," ").trim();
					String newAddress4 = request.getParameter("newAddress4").toLowerCase().replaceAll("( +)"," ").trim();
					String new1Address4 = newAddress4;
					if ("".equals(new1Address4))
					{
						new1Address4 = oldAddress4;
					}
					String oldCity = request.getParameter("oldCity").toLowerCase().replaceAll("\\s+"," ").trim();
					String newCity = request.getParameter("newCity").toLowerCase().replaceAll("\\s+","").trim();
					String new1City = newCity;
					if ("".equals(new1City))
					{
						new1City = oldCity;
					}
					String oldState = request.getParameter("oldState").toLowerCase().replaceAll("\\s+"," ").trim();
					String newState = request.getParameter("newState").toLowerCase().replaceAll("\\s+","").trim();
					String new1State = newState;
					if ("".equals(new1State))
					{
						new1State = oldState;
					}
					String oldCountry = request.getParameter("oldCountry").toLowerCase().replaceAll("\\s+"," ").trim();
					String newCountry = request.getParameter("newCountry").toLowerCase().replaceAll("\\s+","").trim();
					String new1Country = newCountry;
					if ("".equals(new1Country))
					{
						new1Country = oldCountry;
					}
					String oldPostalCode = request.getParameter("oldPostalCode").toLowerCase().replaceAll("( +)"," ").trim();
					String newPostalCode = request.getParameter("newPostalCode").toLowerCase().replaceAll("( +)"," ").trim();
					String new1PostalCode = newPostalCode;
					if ("".equals(new1PostalCode))
					{
						new1PostalCode = oldPostalCode;
					}
					int oldStatus = Integer.valueOf(request.getParameter("oldStatus"));			
					int newStatus = Integer.valueOf(request.getParameter("newStatus"));
					int new1Status = newStatus;
					if(oldBranchName.equals(new1BranchName) && oldAddress1.equals(new1Address1) && oldAddress2.equals(new1Address2) && oldAddress3.equals(new1Address3) && oldAddress4.equals(new1Address4) && oldCity.equals(new1City) && oldState.equals(new1State) && oldCountry.equals(new1Country) && oldPostalCode.equals(new1PostalCode) && oldStatus == new1Status)
					{
						session.setAttribute("Message1","No Changes Occured");
						session.setAttribute("AlertMessage1","Info!");
						session.setAttribute("AlertType1","alert-info");				    
					}
					else
					{
						int currentSessionUserID = (Integer)session.getAttribute("currentSessionUserID");
						BranchBean branchBeanOB1 = new BranchBean();
						branchBeanOB1.setCreatedByUserID(currentSessionUserID);
						branchBeanOB1.setOldBranchName(oldBranchName);
						branchBeanOB1.setBranchName(new1BranchName);
						branchBeanOB1.setAddress1(new1Address1);
						branchBeanOB1.setOldAddress1(oldAddress1);
						branchBeanOB1.setAddress2(new1Address2);
						branchBeanOB1.setOldAddress2(oldAddress2);
						branchBeanOB1.setAddress3(new1Address3);
						branchBeanOB1.setOldAddress3(oldAddress3);
						branchBeanOB1.setAddress4(new1Address4);
						branchBeanOB1.setOldAddress4(oldAddress4);
						branchBeanOB1.setCity(new1City);
						branchBeanOB1.setOldCity(oldCity);
						branchBeanOB1.setState(new1State);
						branchBeanOB1.setOldState(oldState);
						branchBeanOB1.setCountry(new1Country);
						branchBeanOB1.setOldCountry(oldCountry);
						branchBeanOB1.setPostalCode(new1PostalCode);
						branchBeanOB1.setOldPostalCode(oldPostalCode);
						branchBeanOB1.setBranchStatus(new1Status);
						branchBeanOB1.setOldBranchStatus(oldStatus);
						branchBeanOB1.setBranchID(branchID);
						
						BranchDAO branchDAOOB1 = new BranchDAO();
						BranchBean branchBeanOB2 = branchDAOOB1.editBranch(branchBeanOB1);
					
						String actionResult = branchBeanOB2.getActionResult();
						String actionReport = branchBeanOB2.getActionReport();
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
					session.setAttribute("selectedBranchID",branchID);
					response.sendRedirect("editBranch.jsp");
				}
				else if ("selectAnotherBranch".equals(submitValue))
				{	
					String sourceJSP = request.getParameter("sourceJSP");
					session.setAttribute("selectedBranchID",0);
					response.sendRedirect(sourceJSP);
				}
				else
				{
					String sourceJSP = request.getParameter("sourceJSP");
					int selectedBranchID = Integer.valueOf(submitValue);								
					session.setAttribute("selectedBranchID",selectedBranchID);
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
