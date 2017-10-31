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
<link rel="stylesheet" type="text/css" href="css/bootstrap-datetimepicker.min.css">
<link rel="stylesheet" type="text/css" href="css/dataTableWithSearch.css">
<script type="text/javascript" language="javascript" src="css/jquery-1.12.4.js"></script>
<script type="text/javascript" language="javascript" src="css/jquery.dataTables.min.js"></script>
<script type="text/javascript" language="javascript" src="css/dataTables.bootstrap.min.js"></script>
<script type="text/javascript" src="css/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="css/dataTableWithSearch.js"></script>
<%
if( session != null && session.getAttribute("currentSessionUserID") != null && session.getAttribute("currentSessionUserRole") != null) 
{
	int currentSessionUserID = (Integer) session.getAttribute("currentSessionUserID");
	String currentSessionUserRole = (String) session.getAttribute("currentSessionUserRole");
	int selectedCompanyID = (Integer) session.getAttribute("selectedCompanyID");
	if("rootadmin".equals(currentSessionUserRole) || "companyadmin".equals(currentSessionUserRole))
	{
		int companyID;
		String companyName;
		Date openingDate;
		int status;
		String statusValue="null";
		Date creationDate;
		Date creationTime;
		int createdByUserID;
		String createdByUserEmployeeID;
		String createdByUserFirstName;
		int currentSessionUserCompanyID = (Integer) session.getAttribute("currentSessionUserCompanyID");
		if(!"rootadmin".equals(currentSessionUserRole))
		{
			selectedCompanyID = currentSessionUserCompanyID;
		}
		CompanyBean companyBeanOB1 = new CompanyBean();
		if(selectedCompanyID == 0)
		{
			companyBeanOB1.setSearchQuery(" where companyname!='admincompany'");	
		}
		else
		{
			companyBeanOB1.setSearchQuery(" where companyid='"+selectedCompanyID+"'");
		}
		
		List<CompanyBean> companyBeanOB2 = new ArrayList<CompanyBean>();
		companyBeanOB2.add(companyBeanOB1);
		CompanyDAO companyDAOOB1 = new CompanyDAO();
		List<CompanyBean> companyBeanOB3 = companyDAOOB1.viewCompany(companyBeanOB2);	
		int NoOfCompanies = companyBeanOB3.size();
		CapitalizeFirstLetter cfl = new CapitalizeFirstLetter();		
 	%>
		<body>
		<form class="form-horizontal" method="post" action="CompanyServlet">
		<%
		if(selectedCompanyID == 0)
		{		
		%>
			<div class="container-fluid">
				<div class="row">
					<div class="panel panel-primary">
						<div class="panel-heading">
							<h3 class="panel-title">Select Company</h3>
						</div>
					</div>
				</div>
			</div>
			<div class="container-fluid">
				<table id="dataTable" class="table table-striped table-bordered" cellspacing="0">
					<thead>
						<tr>
							<th>S.No</th>
							<th>Name</th>
							<th>OpeningDate</th>																									
							<th>Status</th>
							<th>CreatedBy</th>
							<th>CreatedOn</th>
							<th>Edit</th>
						</tr>
					</thead>
					<tfoot>
						<tr>
							<th>S.No</th>
							<th>Name</th>
							<th>OpeningDate</th>																			
							<th>Status</th>
							<th>CreatedBy</th>
							<th>CreatedOn</th>
							<td></td>
						</tr>
					</tfoot>
					<tbody>
						<%
						for(int i=0;i<NoOfCompanies;i++)
						{
							companyID = companyBeanOB3.get(i).getCompanyID();
							companyName =  companyBeanOB3.get(i).getCompanyName();
							openingDate = companyBeanOB3.get(i).getOpeningDate();
							status = companyBeanOB3.get(i).getCompanyStatus();
							if (status == 1)
							{
								statusValue="Active";
							}
							else
							{
								statusValue="DeActive";
							}				
							creationDate = companyBeanOB3.get(i).getCreationDate();
							creationTime = companyBeanOB3.get(i).getCreationTime();
							createdByUserID = companyBeanOB3.get(i).getCreatedByUserID();
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
								<td><%=cfl.capitalizeName(companyName)%></td>
								<td><%=openingDate%></td>								
								<td><%=statusValue%></td>							
								<td>
									<%=createdByUserEmployeeID%>
									<br>
									<%=cfl.capitalizeName(createdByUserFirstName)%>
								</td>
								<td>
									<%=creationDate%>
									<br>
									<%=creationTime%>
								</td>
								<td>
									<input type="hidden" name="sourceJSP" value="editCompany.jsp"></input>
									<button type="submit" class="btn btn-info btn-sm" name="submitValue" value="<%=companyID%>">Edit</button>
								</td>
							</tr>
						<%
						}
						%>
					</tbody>
				</table>
			</div>
		<%
		}
		else
		{			
			companyID = companyBeanOB3.get(0).getCompanyID();
			companyName =  companyBeanOB3.get(0).getCompanyName();
			openingDate = companyBeanOB3.get(0).getOpeningDate();
			DateBean dateBeanOB1 = new DateBean();	
			String todayDate = dateBeanOB1.getTodayDate();
			dateBeanOB1.setDateFormat1(openingDate);
			String openingDate1 = dateBeanOB1.getDateFormat2();
			dateBeanOB1 = null;
			status = companyBeanOB3.get(0).getCompanyStatus();
			if (status == 1)
			{
				statusValue="Active";
			}
			else
			{
				statusValue="DeActive";
			}
			creationDate = companyBeanOB3.get(0).getCreationDate();
			creationTime = companyBeanOB3.get(0).getCreationTime();
			createdByUserID = companyBeanOB3.get(0).getCreatedByUserID();
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
			<div class="container-fluid">
				<div class="row">
					<div class="panel panel-primary">
						<div class="panel-heading">
							<h3 class="panel-title">Selected Company</h3>
						</div>
					</div>
				</div>
			</div>
			<div class="container-fluid">
				<table id="dataTable1" class="table table-striped table-bordered" cellspacing="0">
					<thead>
						<tr>
							<th>Name</th>	
							<th>OpeningDate</th>																									
							<th>Status</th>						
							<th>CreatedBy</th>
							<th>CreatedOn</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><%=companyName%></td>
							<td><%=openingDate%></td>													
							<td><%=statusValue%></td>												
							<td>
								<%=createdByUserEmployeeID%>
								<br>	
								<%=createdByUserFirstName%>
							</td>
							<td>
								<%=creationDate%>
								<br>
								<%=creationTime%>
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
							<div class="panel-heading" align="center">Edit Company</div>
							<div class="panel-body"> 
								<input type="hidden" class="form-control" name="companyID" value="<%=companyID%>"> 						  
  								<div class="form-group">  
      								<label class="control-label col-sm-4" for="companyfullname">CompanyFullName:</label>  
      								<div class="col-sm-8">
      									<input type="hidden" class="form-control" name="oldCompanyName" value="<%=companyName%>">  
        								<input type="text" class="form-control" name="newCompanyName" placeholder="<%=companyName%>" pattern="^(?=.*[A-Za-z0-9])[0-9a-zA-Z\#\-\.\s]{2,34}$"
        title="Olny Letters, Numbers and Special Characters(-,.,Space,#) Allowed(1 Alphanumeric Mandatory)-(Length Min-2 Max-34)">  
      								</div>  
    							</div>
    							<div class="form-group">
    								<input type="hidden" id="startDate" value="01-01-1981">
    								<input type="hidden" id="endDate" value="<%=todayDate%>">  
      								<label class="control-label col-sm-4" for="joiningdate">OpeningDate</label>  
      								<div class="col-sm-8">
      									<input type="hidden" class="form-control" name="oldOpeningDate" value="<%=openingDate1%>">        								                    		
                    					<div class="input-group date form_date" data-date="" data-date-format="dd-mm-yyyy" data-link-field="newOpeningDate" data-link-format="dd-mm-yyyy">                    						
                    						<input class="form-control" type="text" name="newOpeningDate1" value="<%=openingDate1%>" placeholder="<%=openingDate1%>" readonly>                    							
											<span class="input-group-addon">
												<span class="glyphicon glyphicon-calendar"></span>
											</span>
                						</div>                       							                		                     						                							                   						                    			
										<input type="hidden" id="newOpeningDate" name="newOpeningDate" value=""/><br/>
      								</div> 
    							</div>      			 				
    							<input type="hidden" class="form-control" name="oldStatus" value="<%=status%>">
    							<div class="form-group">  
	      							<label class="control-label col-sm-4" for="status">Status:</label>
      								<div class="col-sm-8">        	
	    								<select class="form-control" name="newStatus">
	    									<%
	    									if("rootadmin".equals(currentSessionUserRole))
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
	    									else if("companyadmin".equals(currentSessionUserRole))
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
  									if("rootadmin".equals(currentSessionUserRole))
  									{
  									%>          
      									<div class="col-sm-offset-4 col-sm-8">  
	        								<button type="submit" class="btn btn-success" name="submitValue" value="updateCompany">
        										<strong>Update</strong>
        									</button>
        									<input type="hidden" name="sourceJSP" value="editCompany.jsp"></input>
        									<button type="submit" class="btn btn-info col-sm-offset-2" name="submitValue" value="selectAnotherCompany">
	        									<strong>Select Another Company</strong>
        									</button>  
      									</div>
      								<%
  									}
      								else if("companyadmin".equals(currentSessionUserRole))
      								{
      								%>
      									<div class="col-sm-offset-6 col-sm-8">  
	        								<button type="submit" class="btn btn-success" name="submitValue" value="updateCompany">
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
			<script type="text/javascript">
				var startDate=document.getElementById("startDate");
				var endDate=document.getElementById("endDate");
				$('.form_date').datetimepicker
				({
					startDate: startDate.value,
					endDate: endDate.value,
					orientation: "auto",
        			language:  'en',
        			weekStart: 1,
        			todayBtn:  1,
					autoclose: 1,
					todayHighlight: 1,
					startView: 2,
					minView: 2,
					forceParse: 0,
					sideBySide: true,
	        		widgetPositioning: 
	        		{
	            		horizontal: 'right',
	            		vertical: 'top'
	        		}
    			});
			</script>
		<%
		}
	}
	else
	{
	%>
		<%="You Are Not Authorised To Access This Page"%>;
	<%
	}
	%>
	</form>
</body>
<%
}
%>
</html>