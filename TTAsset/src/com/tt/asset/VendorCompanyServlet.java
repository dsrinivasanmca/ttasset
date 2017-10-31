package com.tt.asset;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class VendorCompanyServlet
 */
@WebServlet("/VendorCompanyServlet")
public class VendorCompanyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public VendorCompanyServlet() {
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
			if("companyadmin".equals(session.getAttribute("currentSessionUserRole")))
			{
				String submitValue = request.getParameter("submitValue");				
				if("createVendorCompany".equals(submitValue))
				{					
					int currentSessionUserCompanyID = (Integer)session.getAttribute("currentSessionUserCompanyID");
					int currentSessionUserID = (Integer)session.getAttribute("currentSessionUserID");
					String vendorCompanyName=request.getParameter("vendorCompanyName").toLowerCase().replaceAll("\\s+","").trim();
					String address1=request.getParameter("address1").toLowerCase().replaceAll("( +)"," ").trim();
					String address2=request.getParameter("address2").toLowerCase().replaceAll("( +)"," ").trim();
					String address3=request.getParameter("address3").toLowerCase().replaceAll("\\s+","").trim();
					String address4=request.getParameter("address4").toLowerCase().replaceAll("\\s+","").trim();
					String postalCode=request.getParameter("postalCode").toLowerCase().replaceAll("\\s+","").trim();
					String city=request.getParameter("city").toLowerCase().replaceAll("\\s+","").trim();
					String state=request.getParameter("state").toLowerCase().replaceAll("\\s+","").trim();
					String country=request.getParameter("country").toLowerCase().replaceAll("\\s+","").trim();				
					VendorCompanyBean vendorCompanyBeanOB1 = new VendorCompanyBean();					
					vendorCompanyBeanOB1.setCompanyID(currentSessionUserCompanyID);
					vendorCompanyBeanOB1.setVendorCompanyName(vendorCompanyName);
					vendorCompanyBeanOB1.setCreatedByUserID(currentSessionUserID);					
					vendorCompanyBeanOB1.setAddress1(address1);
					vendorCompanyBeanOB1.setAddress2(address2);
					vendorCompanyBeanOB1.setAddress3(address3);
					vendorCompanyBeanOB1.setAddress4(address4);
					vendorCompanyBeanOB1.setPostalCode(postalCode);
					vendorCompanyBeanOB1.setCity(city);
					vendorCompanyBeanOB1.setState(state);
					vendorCompanyBeanOB1.setCountry(country);
					VendorCompanyDAO vendorCompanyDAOOB1 = new VendorCompanyDAO();
					VendorCompanyBean vendorCompanyBeanOB2 = vendorCompanyDAOOB1.newVendorCompany(vendorCompanyBeanOB1);
					String actionResult = vendorCompanyBeanOB2.getActionResult();
					String actionReport = vendorCompanyBeanOB2.getActionReport();
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
					response.sendRedirect("newVendorCompany.jsp");										
				}
				else if ("updateVendorCompany".equals(submitValue))
				{
					int vendorCompanyID = Integer.valueOf(request.getParameter("vendorCompanyID"));
					String oldVendorCompanyName = request.getParameter("oldVendorCompanyName").toLowerCase().replaceAll("( +)"," ").trim();
					String newVendorCompanyName = request.getParameter("newVendorCompanyName").toLowerCase().replaceAll("( +)"," ").trim();
					String new1VendorCompanyName = newVendorCompanyName; 
					if ("".equals(new1VendorCompanyName))
					{
						new1VendorCompanyName = oldVendorCompanyName;
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
					if(oldVendorCompanyName.equals(new1VendorCompanyName) && oldAddress1.equals(new1Address1) && oldAddress2.equals(new1Address2) && oldAddress3.equals(new1Address3) && oldAddress4.equals(new1Address4) && oldCity.equals(new1City) && oldState.equals(new1State) && oldCountry.equals(new1Country) && oldPostalCode.equals(new1PostalCode) && oldStatus == new1Status)
					{
						session.setAttribute("Message1","No Changes Occured");
						session.setAttribute("AlertMessage1","Info!");
						session.setAttribute("AlertType1","alert-info");				    
					}
					else
					{
						int currentSessionUserID = (Integer)session.getAttribute("currentSessionUserID");
						VendorCompanyBean vendorCompanyBeanOB1 = new VendorCompanyBean();
						vendorCompanyBeanOB1.setCreatedByUserID(currentSessionUserID);
						vendorCompanyBeanOB1.setOldVendorCompanyName(oldVendorCompanyName);
						vendorCompanyBeanOB1.setVendorCompanyName(new1VendorCompanyName);
						vendorCompanyBeanOB1.setAddress1(new1Address1);
						vendorCompanyBeanOB1.setOldAddress1(oldAddress1);
						vendorCompanyBeanOB1.setAddress2(new1Address2);
						vendorCompanyBeanOB1.setOldAddress2(oldAddress2);
						vendorCompanyBeanOB1.setAddress3(new1Address3);
						vendorCompanyBeanOB1.setOldAddress3(oldAddress3);
						vendorCompanyBeanOB1.setAddress4(new1Address4);
						vendorCompanyBeanOB1.setOldAddress4(oldAddress4);
						vendorCompanyBeanOB1.setCity(new1City);
						vendorCompanyBeanOB1.setOldCity(oldCity);
						vendorCompanyBeanOB1.setState(new1State);
						vendorCompanyBeanOB1.setOldState(oldState);
						vendorCompanyBeanOB1.setCountry(new1Country);
						vendorCompanyBeanOB1.setOldCountry(oldCountry);
						vendorCompanyBeanOB1.setPostalCode(new1PostalCode);
						vendorCompanyBeanOB1.setOldPostalCode(oldPostalCode);
						vendorCompanyBeanOB1.setVendorCompanyStatus(new1Status);
						vendorCompanyBeanOB1.setOldVendorCompanyStatus(oldStatus);
						vendorCompanyBeanOB1.setVendorCompanyID(vendorCompanyID);
						
						VendorCompanyDAO vendorCompanyDAOOB1 = new VendorCompanyDAO();
						VendorCompanyBean vendorCompanyBeanOB2 = vendorCompanyDAOOB1.editVendorCompany(vendorCompanyBeanOB1);
					
						String actionResult = vendorCompanyBeanOB2.getActionResult();
						String actionReport = vendorCompanyBeanOB2.getActionReport();
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
					session.setAttribute("selectedVendorCompanyID",vendorCompanyID);
					response.sendRedirect("editVendorCompany.jsp");
				}
				else if ("selectAnotherVendorCompany".equals(submitValue))
				{	
					String sourceJSP = request.getParameter("sourceJSP");
					session.setAttribute("selectedVendorCompanyID",0);
					response.sendRedirect(sourceJSP);
				}
				else
				{
					String sourceJSP = request.getParameter("sourceJSP");
					int selectedVendorCompanyID = Integer.valueOf(submitValue);								
					session.setAttribute("selectedVendorCompanyID",selectedVendorCompanyID);
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
