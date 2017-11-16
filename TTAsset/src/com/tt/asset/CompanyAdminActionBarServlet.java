package com.tt.asset;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class CompanyAdminActionBarServlet
 */
@WebServlet("/CompanyAdminActionBarServlet")
public class CompanyAdminActionBarServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CompanyAdminActionBarServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String actionValue=request.getParameter("actionvalue");
		HttpSession session = request.getSession(true);
		if( session != null && session.getAttribute("currentSessionUserID") != null)
		{			
			if("companyadmin".equals(session.getAttribute("currentSessionUserRole")))
			{	
				int currentSessionUserCompanyID = (Integer)session.getAttribute("currentSessionUserCompanyID");
				if("viewcompany".equals(actionValue))
				{					
					response.sendRedirect("viewCompany.jsp");
				}
				else if("editcompany".equals(actionValue))
				{
					session.setAttribute("selectedCompanyID",0);
					response.sendRedirect("editCompany.jsp");
				}
				else if("companylog".equals(actionValue))
				{
					session.setAttribute("selectedCompanyID",0);
					response.sendRedirect("companyLog.jsp");
				}
				else if("newbranch".equals(actionValue))
				{
					session.setAttribute("selectedCompanyID",0);
					response.sendRedirect("newBranch.jsp");
				}
				else if("viewbranch".equals(actionValue))
				{
					session.setAttribute("selectedCompanyID",0);
					response.sendRedirect("viewBranch.jsp");
				}
				else if("editbranch".equals(actionValue))
				{
					session.setAttribute("selectedCompanyID",0);
					session.setAttribute("selectedBranchID",0);
					response.sendRedirect("editBranch.jsp");
				}
				else if("branchlog".equals(actionValue))
				{
					session.setAttribute("selectedCompanyID",0);
					session.setAttribute("selectedBranchID",0);
					response.sendRedirect("branchLog.jsp");
				}
				else if("newdepartment".equals(actionValue))
				{					
					response.sendRedirect("newDepartment.jsp");
				}
				else if("viewdepartment".equals(actionValue))
				{					
					response.sendRedirect("viewDepartment.jsp");
				}
				else if("editdepartment".equals(actionValue))
				{
					session.setAttribute("selectedDepartmentID",0);
					response.sendRedirect("editDepartment.jsp");
				}
				else if("departmentlog".equals(actionValue))
				{					
					session.setAttribute("selectedDepartmentID",0);
					response.sendRedirect("departmentLog.jsp");
				}
				else if("newdesignation".equals(actionValue))
				{					
					response.sendRedirect("newDesignation.jsp");
				}
				else if("viewdesignation".equals(actionValue))
				{					
					response.sendRedirect("viewDesignation.jsp");
				}
				else if("editdesignation".equals(actionValue))
				{
					session.setAttribute("selectedDesignationID",0);
					response.sendRedirect("editDesignation.jsp");
				}
				else if("designationlog".equals(actionValue))
				{					
					session.setAttribute("selectedDesignationID",0);
					response.sendRedirect("designationLog.jsp");
				}
				else if("newuser".equals(actionValue))
				{					
					session.setAttribute("userType","");
					session.setAttribute("oldUserType","");
					session.setAttribute("selectedCompanyID",0);
					session.setAttribute("oldSelectedCompanyID",0);
					session.setAttribute("selectedVendorCompanyID",0);
					session.setAttribute("oldSelectedVendorCompanyID",0);
					session.setAttribute("selectedBranchID",0);
					session.setAttribute("oldSelectedBranchID",0);					
					response.sendRedirect("newUser.jsp");
				}
				else if("viewuser".equals(actionValue))
				{
					session.setAttribute("selectedCompanyID",currentSessionUserCompanyID);
					session.setAttribute("oldSelectedCompanyID",currentSessionUserCompanyID);
					session.setAttribute("selectedUserType","unKnown");
					session.setAttribute("oldSelectedUserType","unKnown");
					session.setAttribute("selectedUserStatus",100);
					session.setAttribute("oldSelectedUserStatus",100);
					response.sendRedirect("viewUser.jsp");
				}
				else if("edituser".equals(actionValue))
				{
					session.setAttribute("selectedCompanyID",currentSessionUserCompanyID);
					session.setAttribute("oldSelectedCompanyID",currentSessionUserCompanyID);					
					session.setAttribute("selectedUserType","unKnown");
					session.setAttribute("oldSelectedUserType","unKnown");
					session.setAttribute("selectedUserStatus",100);
					session.setAttribute("oldSelectedUserStatus",100);					
					session.setAttribute("selectedUserID",0);
					session.setAttribute("oldSelectedUserID",0);
					response.sendRedirect("editUser.jsp");
				}
				else if("userlog".equals(actionValue))
				{					
					session.setAttribute("selectedCompanyID",currentSessionUserCompanyID);
					session.setAttribute("oldSelectedCompanyID",currentSessionUserCompanyID);					
					session.setAttribute("selectedUserType","unKnown");
					session.setAttribute("oldSelectedUserType","unKnown");
					session.setAttribute("selectedUserStatus",100);
					session.setAttribute("oldSelectedUserStatus",100);
					session.setAttribute("selectedUserID",0);
					session.setAttribute("oldSelectedUserID",0);
					response.sendRedirect("userLog.jsp");
				}
				else if("importuser".equals(actionValue))
				{						
					response.sendRedirect("importUser.jsp");
				}
				else if("newvendorcompany".equals(actionValue))
				{					
					response.sendRedirect("newVendorCompany.jsp");
				}
				else if("viewvendorcompany".equals(actionValue))
				{					
					response.sendRedirect("viewVendorCompany.jsp");
				}
				else if("editvendorcompany".equals(actionValue))
				{					
					session.setAttribute("selectedVendorCompanyID",0);
					response.sendRedirect("editVendorCompany.jsp");
				}
				else if("vendorcompanylog".equals(actionValue))
				{					
					session.setAttribute("selectedVendorCompanyID",0);
					response.sendRedirect("vendorCompanyLog.jsp");
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
