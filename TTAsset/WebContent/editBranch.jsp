<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@ page import="com.tt.asset.*"%>
<%@ include file="actionBar.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Date"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.ArrayList"%>
<link rel="stylesheet" type="text/css" href="css/bootstrap.min1.css">
<link rel="stylesheet" type="text/css" href="css/dataTables.bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/dataTableWithSearch.css">
<script type="text/javascript" language="javascript" src="css/jquery-1.12.4.js"></script>
<script type="text/javascript" language="javascript" src="css/jquery.dataTables.min.js"></script>
<script type="text/javascript" language="javascript" src="css/dataTables.bootstrap.min.js"></script>
<script type="text/javascript" language="javascript" src="css/dataTableWithSearch.js"></script>
<%
if( session != null && session.getAttribute("currentSessionUserID") != null && session.getAttribute("currentSessionUserRole") != null) 
{
	String currentSessionUserRole = (String) session.getAttribute("currentSessionUserRole");	
	if("rootadmin".equals(currentSessionUserRole) || "companyadmin".equals(currentSessionUserRole) || "branchadmin".equals(currentSessionUserRole))
	{
		int companyID;
		String companyName;
		String branchName;
		int branchID;
		String address1;
		String address2;
		String address3;
		String address4;
		String postalCode;
		String city;
		String state;
		String country;
		int status;
		String statusValue="null";
		String creationDateTime;		
		int createdByUserID;
		String createdByUserEmployeeID;
		String createdByUserFirstName;
		int currentSessionUserID = (Integer) session.getAttribute("currentSessionUserID");		
		int currentSessionUserCompanyID = (Integer) session.getAttribute("currentSessionUserCompanyID");
		int currentSessionUserBranchID = (Integer) session.getAttribute("currentSessionUserBranchID");
		int selectedBranchID = (Integer) session.getAttribute("selectedBranchID");		
		BranchBean branchBeanOB1 = new BranchBean();
		if("branchadmin".equals(currentSessionUserRole))
		{
			selectedBranchID = currentSessionUserBranchID;
		}
		if(selectedBranchID == 0)
		{
			if("rootadmin".equals(currentSessionUserRole))
			{
				branchBeanOB1.setSearchQuery(" where branchname!='adminbranch'");	
			}
			else if("companyadmin".equals(currentSessionUserRole))
			{
				branchBeanOB1.setSearchQuery(" where companyid='"+currentSessionUserCompanyID+"'");
			}			
		}
		else
		{
			branchBeanOB1.setSearchQuery(" where branchid='"+selectedBranchID+"'");
		}
		branchBeanOB1.setBranchID(selectedBranchID);
		List<BranchBean> branchBeanOB2 = new ArrayList<BranchBean>();
		branchBeanOB2.add(branchBeanOB1);		
		BranchDAO branchDAOOB1 = new BranchDAO();
		List<BranchBean> branchBeanOB3 = branchDAOOB1.viewBranch(branchBeanOB2);
		int noOfBranches = branchBeanOB3.size();
		CapitalizeFirstLetter cfl = new CapitalizeFirstLetter();
	 %>
	<body>
	<form class="form-horizontal" method="post" action="BranchServlet">
		<%
		if(selectedBranchID == 0)
		{		
		%>
			<div class="container-fluid">
				<div class="row">
					<div class="panel panel-primary">
						<div class="panel-heading">
							<h3 class="panel-title">Select Branch</h3>
						</div>
					</div>
				</div>
			</div>
			<div class="container-fluid">
				<table id="dataTable" class="table table-striped table-bordered" cellspacing="0">
					<thead>
						<tr>
							<th>S.No</th>
							<%
							if("rootadmin".equals(currentSessionUserRole))
							{
							%>
								<th>CompanyName</th>
							<%
							}
							%>						
							<th>BranchName</th>
							<th>Address</th>
							<th>City</th>
							<th>State</th>
							<th>Country</th>																			
							<th>Status</th>
							<th>CreatedBy</th>
							<th>CreatedOn</th>
							<th>Edit</th>
						</tr>
					</thead>
					<tfoot>
						<tr>
							<th>S.No</th>
							<%
							if("rootadmin".equals(currentSessionUserRole))
							{
							%>
								<th>CompanyName</th>
							<%
							}
							%>
							<th>BranchName</th>
							<th>Address</th>
							<th>City</th>
							<th>State</th>
							<th>Country</th>													
							<th>Status</th>
							<th>CreatedBy</th>
							<th>CreatedOn</th>
							<td></td>					
						</tr>
					</tfoot>
					<tbody>
						<%
						for(int i=0;i<noOfBranches;i++)
						{
							companyID = branchBeanOB3.get(i).getCompanyID();
							CompanyBean companyBeanOB1 = new CompanyBean();
							companyBeanOB1.setSearchQuery(" where companyid='"+companyID+"'");
							List<CompanyBean> companyBeanOB2 = new ArrayList<CompanyBean>();
							companyBeanOB2.add(companyBeanOB1);
							CompanyDAO companyDAOOB1 = new CompanyDAO();
							List<CompanyBean> companyBeanOB3 = companyDAOOB1.viewCompany(companyBeanOB2);
							companyName = cfl.capitalizeName(companyBeanOB3.get(0).getCompanyName());							
							companyBeanOB1 = null;
							companyBeanOB2 = null;
							companyBeanOB3 = null;
							companyDAOOB1 = null;
							branchName = cfl.capitalizeName(branchBeanOB3.get(i).getBranchName());
							branchID = branchBeanOB3.get(i).getBranchID();
							address1 = cfl.capitalizeName(branchBeanOB3.get(i).getAddress1());
							address2 = cfl.capitalizeName(branchBeanOB3.get(i).getAddress2());
							address3 = branchBeanOB3.get(i).getAddress3();
							address4 = branchBeanOB3.get(i).getAddress4();
							postalCode = cfl.capitalizeName(branchBeanOB3.get(i).getPostalCode());
							city = cfl.capitalizeName(branchBeanOB3.get(i).getCity());
							state = cfl.capitalizeName(branchBeanOB3.get(i).getState());
							country = cfl.capitalizeName(branchBeanOB3.get(i).getCountry());
							status = branchBeanOB3.get(i).getBranchStatus();
							if (status == 1)
							{
								statusValue="Active";
							}
							else
							{
								statusValue="DeActive";
							}				
							creationDateTime = branchBeanOB3.get(i).getCreationDateTime();							
							createdByUserID = branchBeanOB3.get(i).getCreatedByUserID();							
							UserBean userBeanOB1 = new UserBean();
							userBeanOB1.setSearchQuery(" where userid='"+createdByUserID+"'");
							List<UserBean> userBeanOB2 = new ArrayList<UserBean>();
							userBeanOB2.add(userBeanOB1);
							UserDAO userDAOOB1 = new UserDAO();
							List<UserBean> userBeanOB3 = userDAOOB1.viewUser(userBeanOB2);
							createdByUserFirstName = cfl.capitalizeName(userBeanOB3.get(0).getUserFirstName());
							createdByUserEmployeeID = cfl.capitalizeName(userBeanOB3.get(0).getUserEmployeeID());
							userBeanOB1 = null;
							userBeanOB2 = null;
							userBeanOB3 = null;
							userDAOOB1 = null;
						%>					
							<tr>
								<td><%=i+1%></td>
								<%
								if("rootadmin".equals(currentSessionUserRole))
								{
								%>
									<td><%=companyName%></td>
								<%
								}
								%>
								<td><%=branchName%></td>
								<td>
									<%=address1%>
									<br>
									<%=address2%>
									<%if(address3 != null)
									{
									%>
										<br>
									<%		
										out.println(cfl.capitalizeName(address3));
									}
									if(address4 != null)
									{
									%>
										<br>
									<%		
										out.println(cfl.capitalizeName(address4));
									}
									%>
									<br>
									PostalCode=<%=postalCode%>
								</td>							
								<td><%=city%></td>
								<td><%=state%></td>
								<td><%=country%></td>
								<td><%=statusValue%></td>							
								<td>
									<%=createdByUserEmployeeID%>
									<br>
									<%=createdByUserFirstName%>
								</td>
								<td>
									<%=creationDateTime%>									
								</td>
								<td>
									<input type="hidden" name="sourceJSP" value="editBranch.jsp"></input>
									<button type="submit" class="btn btn-info btn-sm" name="submitValue" value="<%=branchID%>">Edit</button>
								</td>
							</tr>
						<%
						}
						branchBeanOB1 = null;
						branchBeanOB2 = null;
						branchBeanOB3 = null;
						branchDAOOB1 = null;
						%>
					</tbody>
				</table>
			</div>
		<%
		}
		else
		{
			branchID = branchBeanOB3.get(0).getBranchID();
			branchName = cfl.capitalizeName(branchBeanOB3.get(0).getBranchName());
			address1 = cfl.capitalizeName(branchBeanOB3.get(0).getAddress1());
			address2 = cfl.capitalizeName(branchBeanOB3.get(0).getAddress2());
			address3 = branchBeanOB3.get(0).getAddress3();
			if (address3 != null)
			{
				address3 = cfl.capitalizeName(address3);
			}
			address4 = branchBeanOB3.get(0).getAddress4();
			if (address4 != null)
			{
				address4 = cfl.capitalizeName(address4);
			}
			postalCode = cfl.capitalizeName(branchBeanOB3.get(0).getPostalCode());
			city = cfl.capitalizeName(branchBeanOB3.get(0).getCity());
			state = cfl.capitalizeName(branchBeanOB3.get(0).getState());
			country = cfl.capitalizeName(branchBeanOB3.get(0).getCountry());
			status = branchBeanOB3.get(0).getBranchStatus();
			createdByUserID = branchBeanOB3.get(0).getCreatedByUserID();
			UserBean userBeanOB1 = new UserBean();
			userBeanOB1.setSearchQuery(" where userid='"+createdByUserID+"'");
			List<UserBean> userBeanOB2 = new ArrayList<UserBean>();
			userBeanOB2.add(userBeanOB1);
			UserDAO userDAOOB1 = new UserDAO();
			List<UserBean> userBeanOB3 = userDAOOB1.viewUser(userBeanOB2);
			createdByUserFirstName = cfl.capitalizeName(userBeanOB3.get(0).getUserFirstName());
			createdByUserEmployeeID = cfl.capitalizeName(userBeanOB3.get(0).getUserEmployeeID());
			userBeanOB1 = null;
			userBeanOB2 = null;
			userBeanOB3 = null;
			userDAOOB1 = null;
			if (status == 1)
			{
				statusValue="Active";
			}
			else
			{
				statusValue="DeActive";
			}
			creationDateTime = branchBeanOB3.get(0).getCreationDateTime();			
			branchBeanOB1 = null;
			branchBeanOB2 = null;
			branchBeanOB3 = null;
			branchDAOOB1 = null;
		%>	 		
			<div class="container-fluid">
				<div class="row">
					<div class="panel panel-primary">
						<div class="panel-heading">
							<h3 class="panel-title">Selected Branch</h3>
						</div>
					</div>
				</div>
			</div>
			<div class="container-fluid">
				<table id="dataTable1" class="table table-striped table-bordered" cellspacing="0">
					<thead>
						<tr>
							<th>BranchName</th>
							<th>Address</th>
							<th>City</th>
							<th>State</th>
							<th>Country</th>																				
							<th>Status</th>						
							<th>CreatedBy</th>
							<th>CreatedOn</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><%=branchName%></td>
							<td>
								<%=address1%>
								<br>
								<%=address2%>
								<%if(address3 != null)
								{
								%>
									<br>
								<%		
									out.println(address3);
								}
								if(address4 != null)
								{
								%>
									<br>
								<%		
									out.println(address4);
								}
								%>
								<br>
								PostalCode=<%=postalCode%>
							</td>							
							<td><%=city%></td>
							<td><%=state%></td>
							<td><%=country%></td>							
							<td><%=statusValue%></td>												
							<td>
								<%=createdByUserEmployeeID%>
								<br>	
								<%=createdByUserFirstName%>
							</td>
							<td>
								<%=creationDateTime%>								
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="container">
				<div class="row">
  					<div class="col-sm-2"></div>
  					<div class="col-sm-8">
	  					<div class="panel panel-primary well well-sm">
							<div class="panel-heading" align="center">Edit Branch</div>
							<div class="panel-body"> 
								<input type="hidden" class="form-control" name="branchID" value="<%=branchID%>"> 						  
  								<div class="form-group">  
      								<label class="control-label col-sm-4" for="branchname">BranchName</label>  
      								<div class="col-sm-8">
      									<input type="hidden" class="form-control" name="oldBranchName" value="<%=branchName%>">  
        								<input type="text" class="form-control" name="newBranchName" placeholder="<%=branchName%>" pattern="[0-9a-zA-Z]{2,24}"
        title="Only Letters and Numbers Allowed-(Length Min-2 Max-24)">
      								</div>  
    							</div>  
    							<div class="form-group">  
      								<label class="control-label col-sm-4" for="address1">Address1</label>  
      								<div class="col-sm-8">
      									<input type="hidden" class="form-control" name="oldAddress1" value="<%=address1%>">  
        								<input type="text" class="form-control" name="newAddress1" placeholder="<%=address1%>" pattern="^(?=.*[A-Za-z0-9])[0-9a-zA-Z\/\#\-\.\s]{2,34}$"
        title="Olny Letters, Numbers and Special Characters(/,-,.,Space,#) Allowed(1 Alphanumeric Mandatory)-(Length Min-2 Max-34)">  
      								</div>  
    							</div>
    							<div class="form-group">
	      							<label class="control-label col-sm-4" for="address2">Address2</label>  
    	  							<div class="col-sm-8">
      									<input type="hidden" class="form-control" name="oldAddress2" value="<%=address2%>">  
        								<input type="text" class="form-control" name="newAddress2" placeholder="<%=address2%>" pattern="^(?=.*[A-Za-z0-9])[0-9a-zA-Z\/\#\-\.\s]{1,34}$"
        title="Olny Letters, Numbers and Special Characters(/,-,.,Space,#) Allowed(1 Alphanumeric Mandatory)-(Length Min-1 Max-34)">  
      								</div>  
    							</div>
    							<div class="form-group">  
      								<label class="control-label col-sm-4" for="address3">Address3</label>  
      								<div class="col-sm-8">	      								
										<input type="hidden" class="form-control" name="oldAddress3" value="<%=address3%>"> 
        								<input type="text" class="form-control" name="newAddress3" placeholder="<%=address3%>" pattern="^(?=.*[A-Za-z0-9])[0-9a-zA-Z\/\#\-\.\s]{2,34}$"
        title="Olny Letters, Numbers and Special Characters(/,-,.,Space,#) Allowed(1 Alphanumeric Mandatory)-(Length Min-2 Max-34)">        								
      								</div>  
    							</div>
    							<div class="form-group">
	      							<label class="control-label col-sm-4" for="address4">Address4</label>  
      								<div class="col-sm-8">	      								
										<input type="hidden" class="form-control" name="oldAddress4" value="<%=address4%>">
        								<input type="text" class="form-control" name="newAddress4" placeholder="<%=address4%>" pattern="^(?=.*[A-Za-z0-9])[0-9a-zA-Z\/\#\-\.\s]{2,34}$"
        title="Olny Letters, Numbers and Special Characters(/,-,.,Space,#) Allowed(1 Alphanumeric Mandatory)-(Length Min-2 Max-34)">        								
      								</div>  
    							</div>
    							<div class="form-group">  
	      							<label class="control-label col-sm-4" for="city">City</label>  
      								<div class="col-sm-8">
	      								<input type="hidden" class="form-control" name="oldCity" value="<%=city%>">          						
        								<input type="text" class="form-control" name="newCity" placeholder="<%=city%>" pattern="[a-zA-Z]{2,20}"
        title="Letters only Allowed-(Length Min-2 Max-20)">
      								</div>  
    							</div>
    							<div class="form-group">  
	      							<label class="control-label col-sm-4" for="state">State</label>  
      								<div class="col-sm-8">
	      								<input type="hidden" class="form-control" name="oldState" value="<%=state%>">  
        								<input type="text" class="form-control" name="newState" placeholder="<%=state%>" pattern="[a-zA-Z]{2,20}"
        title="Letters only Allowed-(Length Min-2 Max-20)">
      								</div>  
    							</div>
    							<div class="form-group">  
	      							<label class="control-label col-sm-4" for="country">Country</label>  
      								<div class="col-sm-8">
	      								<input type="hidden" class="form-control" name="oldCountry" value="<%=country%>">  
	        							<input type="text" class="form-control" name="newCountry" placeholder="<%=country%>" pattern="[a-zA-Z]{2,20}"
        title="Letters only Allowed-(Length Min-2 Max-20)">
    	  							</div> 
    							</div>
    							<div class="form-group">  
	      							<label class="control-label col-sm-4" for="pincode">PostalCode</label>  
      								<div class="col-sm-8">
	      								<input type="hidden" class="form-control" name="oldPostalCode" value="<%=postalCode%>">  
        								<input type="text" class="form-control" name="newPostalCode" placeholder="<%=postalCode%>" pattern="[a-zA-Z0-9]{2,10}"
        title="Letters and Numbers only Allowed-(Length Min-2 Max-10)">  
      								</div>  
    							</div>
    							<input type="hidden" class="form-control" name="oldStatus" value="<%=status%>">
    							<div class="form-group">  
	      							<label class="control-label col-sm-4" for="status">Status</label>
      								<div class="col-sm-8">        	
	    								<select class="form-control" name="newStatus">
	    									<%
	    									if("rootadmin".equals(currentSessionUserRole) || "companyadmin".equals(currentSessionUserRole))
        									{
        										if("Active".equals(statusValue))
        										{
        										%>
	        										<option value=1 selected>Active</option>
													<option value=0>DeActive</option>
												<%
        										}
        										else
        										{
        										%>
	        										<option value=1>Active</option>
													<option value=0 selected>DeActive</option>
        										<%	
        										}
        									}											
	    									else if("branchadmin".equals(currentSessionUserRole))
        									{
        									%>
        										<option value=1 selected>Active</option>												
											<%
        									}
        									%>
    									</select>							  
    								</div>
    							</div>	
    							<%    					 
    							if (session != null) 
								{	
									if (session.getAttribute("Message1") != null) 
									{
										String Message1 = (String)session.getAttribute("Message1");
										String AlertType1 = (String)session.getAttribute("AlertType1");
										String AlertMessage1 = (String)session.getAttribute("AlertMessage1");
									%>
										<div class="form-group">          
      										<div class="col-sm-offset-4 col-sm-8">
				 								<div class="alert <% out.println(AlertType1); %> fade in">    								
    												<strong><%=AlertMessage1%></strong>
													<%=Message1%>
												</div>
											</div>
										</div>
									<%
	        							session.removeAttribute("AlertType1");
    	    							session.removeAttribute("AlertMessage1");
        								session.removeAttribute("Message1");
									}
								}
        						%>
  								<div class="form-group">
  								<%
  								if("rootadmin".equals(currentSessionUserRole) || "companyadmin".equals(currentSessionUserRole))
  								{
  								%>          
      								<div class="col-sm-offset-4 col-sm-8">  
	        							<button type="submit" class="btn btn-success" name="submitValue" value="updateBranch">
        									<strong>Update</strong>
        								</button>
        								<input type="hidden" name="sourceJSP" value="editBranch.jsp"></input>
        								<button type="submit" class="btn btn-info col-sm-offset-2" name="submitValue" value="selectAnotherBranch">
	        								<strong>Select Another Branch</strong>
        								</button>  
      								</div>
      							<%
  								}
  								else if("branchadmin".equals(currentSessionUserRole))
  								{
  								%>          
      								<div class="col-sm-offset-6 col-sm-8">  
	        							<button type="submit" class="btn btn-success" name="submitValue" value="updateBranch">
        									<strong>Update</strong>
        								</button>        								 
      								</div>
      							<%
  								}
      							%>  
    							</div>    			
    						</div>
    					</div>
    				</div>
  					<div class="col-sm-2"></div>
				</div>
			</div>
		<%
		}
	}
	%>
	</form>
</body>
<%
}
%>
</html>