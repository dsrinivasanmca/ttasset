<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@ include file="actionBar.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<link rel="stylesheet" type="text/css" href="css\bootstrap-datetimepicker.min.css">
<script type="text/javascript" src="css\bootstrap-datetimepicker.js"></script>
<%
 if( session != null && session.getAttribute("currentSessionUserID") != null && session.getAttribute("currentSessionUserID") != null) 
 {
	int currentSessionUserID = (Integer) session.getAttribute("currentSessionUserID");
	String currentSessionUserRole = (String) session.getAttribute("currentSessionUserRole");
	if("rootadmin".equals(currentSessionUserRole) || "companyadmin".equals(currentSessionUserRole))
	{
 %>
		<body>
			<div class="container">
				<div class="row">
  					<div class="col-sm-2"></div>
  					<div class="col-sm-8">
  						<div class="panel panel-primary well well-sm">
							<div class="panel-heading" align="center">Add New User</div>
							<div class="panel-body">
  							<form class="form-horizontal" name="newUser" method="post" action="UserServlet">
  								<%
  								String userType = (String) session.getAttribute("userType");
								String oldUserType = (String) session.getAttribute("oldUserType");
								%>
								<div class="form-group">  
      								<label class="control-label col-sm-4" for="role">UserType</label>  
      								<div class="col-sm-8"> 
      									<input type="hidden" name="oldUserType" value=<%=oldUserType%>> 
        								<select class="form-control" name="userType" required onchange="this.form.submit()">
  	    									<option value="">Select UserType</option>
        									<%
        									UserTypeBean userTypeBeanOB1 = new UserTypeBean();
      										if("rootadmin".equals(currentSessionUserRole))
      										{
      											userTypeBeanOB1.setSearchQuery(" where usertype='employee'");
      											//userTypeBeanOB1.setSearchQuery(" where usertype like '%%'");
      										}
      										else if("companyadmin".equals(currentSessionUserRole))
      										{
      											userTypeBeanOB1.setSearchQuery(" where usertype like '%%'");      											
      										}
      										List<UserTypeBean> userTypeBeanOB2 = new ArrayList<UserTypeBean>();
      										userTypeBeanOB2.add(userTypeBeanOB1);
      										UserTypeDAO userTypeDAOOB1 = new UserTypeDAO();
      										List<UserTypeBean> userTypeBeanOB3 = userTypeDAOOB1.viewUserType(userTypeBeanOB2);
      										int noOfUserTypes = userTypeBeanOB3.size();
      										String userTypeValue = null;      										  	    							
      										for(int i=0;i<noOfUserTypes;i++)
      										{      										
      											userTypeValue = userTypeBeanOB3.get(i).getUserType();
      											if(userTypeValue.equals(userType))
      											{
      										%>	
    	      										<option value="<%=userTypeValue.toLowerCase()%>" selected><%=userTypeValue.toUpperCase()%></option>
          									<%	
      											}
      											else
      											{
      										%>	
    	      										<option value="<%=userTypeValue.toLowerCase()%>"><%=userTypeValue.toUpperCase()%></option>
          									<%	
      											}
      										}
      										userTypeBeanOB1 = null;
      										userTypeBeanOB2 = null;
      										userTypeBeanOB3 = null;
      										userTypeDAOOB1 = null;  	    							
        									%>
        								</select>
      								</div>  
    							</div>    							    								
  	  							<div class="form-group">  
  		      						<label class="control-label col-sm-4" for="status">Company</label>
  	  								<div class="col-sm-8">
  	  									<%
  										int currentSessionUserCompanyID = (Integer)session.getAttribute("currentSessionUserCompanyID");
	  									int selectedCompanyID = (Integer) session.getAttribute("selectedCompanyID");
	  									int oldSelectedCompanyID = (Integer) session.getAttribute("oldSelectedCompanyID");	  									
	  									%>
  	  									<input type="hidden" name="oldSelectedCompanyID" value=<%=oldSelectedCompanyID%>>
  	  									<input type="hidden" name="submitValue" value="createUser">  	  										 										       
  	    								<select class="form-control" name="selectedCompanyID" required onchange="this.form.submit()">
  	    									<%  	    									
	  										CompanyBean companyBeanOB1 = new CompanyBean();
  											if("rootadmin".equals(currentSessionUserRole))
  											{  									  									
  	  											companyBeanOB1.setSearchQuery(" where companyname!='admincompany' and status=1");
  											}
  											else if("companyadmin".equals(currentSessionUserRole))
  											{
  												companyBeanOB1.setSearchQuery(" where companyid='"+currentSessionUserCompanyID+"'");  												
  											}  								
  	  										List<CompanyBean> companyBeanOB2 = new ArrayList<CompanyBean>();
  	  										companyBeanOB2.add(companyBeanOB1);
  	  										CompanyDAO companyDAOOB1 = new CompanyDAO();
  	  										List<CompanyBean> companyBeanOB3 = companyDAOOB1.viewCompany(companyBeanOB2);
  	  										int NoOfCompanies = companyBeanOB3.size();
  	  										int companyID;
  											String companyName = null;
  											if("".equals(userType))
  											{
  											%>
  	  											<option value="">Select Company</option>
	  										<%
  											}
  											else
  											{
  	  											if("rootadmin".equals(currentSessionUserRole))
  												{
  	  											%>
	  	  											<option value="">Select Company</option>
  	  											<%
  												}  	    									  	    								
    											for(int i=0;i<NoOfCompanies;i++)
												{
													companyID = companyBeanOB3.get(i).getCompanyID();
													companyName = companyBeanOB3.get(i).getCompanyName().toUpperCase();
													if(selectedCompanyID == companyID)
													{
												%>
														<option value=<%=companyID%> selected><%=companyName%></option>
												<%											
													}
													else
													{
													%>
														<option value=<%=companyID%>><%=companyName%></option>
													<%	
													}
												}
  	    										companyBeanOB1 = null;
  	    										companyBeanOB2 = null;
  	    										companyBeanOB3 = null;
  	    										companyDAOOB1 = null;
  	    									}
											%>    										    										
										</select>															 
									</div>
								</div>								  								
  	  							<div class="form-group">  
  		      						<label class="control-label col-sm-4" for="status">Vendor Company</label>
  	  								<div class="col-sm-8">
  	  									<%
      									int selectedVendorCompanyID = (Integer) session.getAttribute("selectedVendorCompanyID");      								
      									VendorCompanyBean vendorCompanyBeanOB1 = new VendorCompanyBean();
      									vendorCompanyBeanOB1.setSearchQuery(" where companyid='"+selectedCompanyID+"' and status=1");
      									List<VendorCompanyBean> vendorCompanyBeanOB2 = new ArrayList<VendorCompanyBean>();
      									vendorCompanyBeanOB2.add(vendorCompanyBeanOB1);		
      									VendorCompanyDAO vendorCompanyDAOOB1 = new VendorCompanyDAO();
      									List<VendorCompanyBean> vendorCompanyBeanOB3 = vendorCompanyDAOOB1.viewVendorCompany(vendorCompanyBeanOB2);
      									int noOfVendorCompanies = vendorCompanyBeanOB3.size();
      									int vendorCompanyID;
  										String vendorCompanyName = null;
  	  									%>  										        
  	    								<select class="form-control" name="vendorCompanyID">
  	    								<%
  										if("employee".equals(userType))
  										{  																
  	  									%>
  	    									<option value="0">Own Company</option>
  	    								<%
  										}
  										else if(!"employee".equals(userType))
  										{  																
  	  	  								%>
  	  	    								<option value="">Select Vendor Company</option>
  	  	    								<%
  	    									if(selectedCompanyID != 0)
  	    									{  	    									
  	    										for(int i=0;i<noOfVendorCompanies;i++)
												{
  	    											vendorCompanyID = vendorCompanyBeanOB3.get(i).getVendorCompanyID();
  	    											vendorCompanyName = vendorCompanyBeanOB3.get(i).getVendorCompanyName().toUpperCase();
													if(selectedVendorCompanyID == vendorCompanyID)
													{
											 		%>
														<option value=<%=vendorCompanyID%> selected><%=vendorCompanyName%></option>
													<%											
													}
													else
													{
													%>	
														<option value=<%=vendorCompanyID%>><%=vendorCompanyName%></option>
													<%	
													}
												}  	    										
  	    									}
  	  									}  											
  	    								%>  	    						    										    										
										</select>
										<%
										vendorCompanyBeanOB1 = null;
										vendorCompanyBeanOB2 = null;
										vendorCompanyBeanOB3 = null;
										vendorCompanyDAOOB1 = null;
										%>							  
									</div>
								</div>  	    						
  								<div class="form-group">  
      								<label class="control-label col-sm-4" for="branch">Branch</label>  
      								<div class="col-sm-8">
      									<%
      									int selectedBranchID = (Integer) session.getAttribute("selectedBranchID");      								
      									BranchBean branchBeanOB1 = new BranchBean();
      									branchBeanOB1.setSearchQuery(" where companyid='"+selectedCompanyID+"' and status=1");
      									List<BranchBean> branchBeanOB2 = new ArrayList<BranchBean>();
      									branchBeanOB2.add(branchBeanOB1);		
      									BranchDAO branchDAOOB1 = new BranchDAO();
      									List<BranchBean> branchBeanOB3 = branchDAOOB1.viewBranch(branchBeanOB2);
      									int noOfBranches = branchBeanOB3.size();
      									int branchID;
  										String branchName = null;
  	  									%>	  	  									  	  									 										       
  	    								<select class="form-control" name="selectedBranchID" required>
  	    									<option value="">Select Branch</option>
  	    									<%
  	    									if(selectedCompanyID != 0)
  	    									{  	    									
  	    										for(int i=0;i<noOfBranches;i++)
												{
													branchID = branchBeanOB3.get(i).getBranchID();
													branchName = branchBeanOB3.get(i).getBranchName().toUpperCase();
													if(selectedBranchID == branchID)
													{
													%>
														<option value=<%=branchID%> selected><%=branchName%></option>
													<%											
													}
													else
													{
													%>	
														<option value=<%=branchID%>><%=branchName%></option>
													<%	
													}
												}  	    										
  	    									}
											%>    										    										
										</select>
										<%
										branchBeanOB1 = null;
  										branchBeanOB2 = null;
  										branchBeanOB3 = null;
  										branchDAOOB1 = null;
										%>							  
									</div>
								</div>    																
  								<div class="form-group">  
      								<label class="control-label col-sm-4" for="EmployeeID">EmployeeID</label>  
      								<div class="col-sm-8">  
	        							<input type="text" class="form-control" name="employeeID" placeholder="Enter EmployeeID" required pattern="^(?=.*[A-Za-z0-9])[0-9a-zA-Z\/]{2,34}$"
        title="Olny Letters, Numbers and Special Characters(/) Allowed(1 Alphanumeric Mandatory)-(Length Min-2 Max-34)">  
      								</div>  
    							</div>
    							<fieldset>                            		
    								<div class="form-group">  
      									<label class="control-label col-sm-4" for="LoginPassword">LoginPassword</label>  
      									<div class="col-sm-8">  
	        								<input type="password" class="form-control" name="loginPassword" id="loginPassword" placeholder="Enter Password" required pattern="^(?=.*[A-Za-z0-9])[0-9a-zA-Z\@\#\-\.\!\^\$]{2,34}$"
        	title="Olny Letters, Numbers and Special Characters(@,#,-,.,!,%,$) Allowed(1 Alphanumeric Mandatory)-(Length Min-3 Max-34)">  
      									</div>  
    								</div>
    								<div class="form-group">  
      									<label class="control-label col-sm-4" for="ConfirmLoginPassword">ConfirmLoginPassword</label>  
      									<div class="col-sm-8">  
	        								<input type="password" class="form-control" name="confirmLoginPassword" id="confirmLoginPassword" placeholder="Enter ConfirmPassword" required pattern="^(?=.*[A-Za-z0-9])[0-9a-zA-Z\@\#\-\.\!\^\$]{2,34}$"
        title="Olny Letters, Numbers and Special Characters(@,#,-,.,!,%,$) Allowed(1 Alphanumeric Mandatory)-(Length Min-3 Max-34)">  
      									</div>  
    								</div>
    							</fieldset>
    							<div class="form-group">  
      								<label class="control-label col-sm-4" for="UserFirstName">UserFirstName</label>
      								<div class="col-sm-8">  
	        							<input type="text" class="form-control" name="userFirstName" placeholder="Enter UserFirstName" required pattern="^(?=.*[A-Za-z0-9])[0-9a-zA-Z\s]{2,34}$"
        title="Olny Letters, Numbers and Special Characters(Space) Allowed(1 Alphanumeric Mandatory)-(Length Min-2 Max-34)">  
      								</div>  
    							</div>
    							<div class="form-group">  
      								<label class="control-label col-sm-4" for="UserLastName">UserLastName</label>  
      								<div class="col-sm-8">  
	        							<input type="text" class="form-control" name="userLastName" placeholder="Enter UserLastName" required pattern="^(?=.*[A-Za-z0-9])[0-9a-zA-Z\s]{2,34}$"
        title="Olny Letters, Numbers and Special Characters(Space) Allowed(1 Alphanumeric Mandatory)-(Length Min-2 Max-34)">  
      								</div>  
    							</div>      			 		    							
    							<div class="form-group">  
      								<label class="control-label col-sm-4" for="MobileNo">MobileNo</label>  
      								<div class="col-sm-8">  
        								<input type="text" class="form-control" name="mobileNo" placeholder="Enter MobileNo" required pattern="^(?=.*[A-Za-z0-9])[0-9a-zA-Z\/]{2,34}$"
        title="Olny Letters, Numbers and Special Characters(/) Allowed(1 Alphanumeric Mandatory)-(Length Min-2 Max-34)">  
      								</div>  
    							</div>
    							<div class="form-group">  
      								<label class="control-label col-sm-4" for="EmailID">EmailID</label>  
      								<div class="col-sm-8">  
        								<input type="text" class="form-control" name="emailID" placeholder="Enter EmailAddress" required pattern="^(?=.*[A-Za-z0-9])[0-9a-zA-Z\/\-\.\@]{2,34}$"
        title="Olny Letters, Numbers and Special Characters(/,-,.,@) Allowed(1 Alphanumeric Mandatory)-(Length Min-2 Max-34)">  
      								</div>  
    							</div>
    							<div class="form-group">  
      								<label class="control-label col-sm-4" for="joiningdate">JoiningDate</label>  
      								<div class="col-sm-8">        								
                    					<%
                    					if(selectedCompanyID == 0)
  	    								{
                    					%>                    						                    								
                        					<input class="form-control" type="text" value="" placeholder="Joining Date" disabled>                        					
                    					<%	
  	    								}
                    					else
                    					{
                    						companyBeanOB1 = new CompanyBean();
          	  								companyBeanOB1.setSearchQuery(" where companyid='"+selectedCompanyID+"'");
          	  								companyBeanOB2 = new ArrayList<CompanyBean>();
          	  								companyBeanOB2.add(companyBeanOB1);
          	  								companyDAOOB1 = new CompanyDAO();
          	  								companyBeanOB3 = companyDAOOB1.viewCompany(companyBeanOB2);
          	  								Date companyOpeningDate = companyBeanOB3.get(0).getOpeningDate();          	  								
                    						DateBean dateBeanOB1 = new DateBean();	
                    						String todayDate = dateBeanOB1.getTodayDate();
                    						dateBeanOB1.setDateFormat1(companyOpeningDate);
                    						String companyOpeningDateString = dateBeanOB1.getDateFormat2();
                    						dateBeanOB1 = null;
                    						companyBeanOB1 = null;
                    						companyBeanOB2 = null;
                    						companyBeanOB3 = null;
                    						companyDAOOB1 = null;
                    					%>
                    					
    										<input type="hidden" id="startDate" value=<%=companyOpeningDateString%>>
    										<input type="hidden" id="endDate" value="<%=todayDate%>">      										        									        								                    
                    						<div class="input-group date form_date" data-date="" data-date-format="dd-mm-yyyy" data-link-field="joiningDate" data-link-format="dd-mm-yyyy">
                    							<input class="form-control" size="16" type="text" name="joiningDate1" value="<%=todayDate%>" placeholder="<%=todayDate%>" readonly>                    							
												<span class="input-group-addon">
													<span class="glyphicon glyphicon-calendar"></span>
												</span>
                							</div>                       							                		                     						                							                   						                    			
											<input type="hidden" id="joiningDate" name="joiningDate" value=""/>      										     					    				
	                					<%
                    					}
                    					%>                     						                							                   						                    														
      								</div> 
    							</div>
    							<div class="form-group">  
      								<label class="control-label col-sm-4" for="role">Role</label>  
      								<div class="col-sm-8">  
        								<select class="form-control" name="roleName" required>
  	    									<option value="">Select Role</option>
        									<%
        									RoleBean roleBeanOB1 = new RoleBean();
      										if("rootadmin".equals(currentSessionUserRole))
      										{
      											roleBeanOB1.setSearchQuery(" where rolename='companyadmin'");
      											//roleBeanOB1.setSearchQuery(" where rolename like '%%'");
      										}
      										else if("companyadmin".equals(currentSessionUserRole))
      										{
      											if("employee".equals(userType))
      											{
      												roleBeanOB1.setSearchQuery(" where rolename!='rootadmin'");	
      											}
      											else if(!"employee".equals(userType))
      											{
      												roleBeanOB1.setSearchQuery(" where rolename='guest'");	
      											}
      											
      										}
      										List<RoleBean> roleBeanOB2 = new ArrayList<RoleBean>();
      										roleBeanOB2.add(roleBeanOB1);
      										RoleDAO roleDAOOB1 = new RoleDAO();
      										List<RoleBean> roleBeanOB3 = roleDAOOB1.viewRole(roleBeanOB2);
      										int noOfRoles = roleBeanOB3.size();
      										String roleName = null;      										
  	    									if(selectedCompanyID != 0)
  	    									{
      											for(int i=0;i<noOfRoles;i++)
      											{      										
      												roleName = roleBeanOB3.get(i).getRoleName();      												      												
      											%>	
    	      										<option value="<%=roleName.toLowerCase()%>"><%=roleName.toUpperCase()%></option>
          										<%	
      											}
      											roleBeanOB1 = null;
      											roleBeanOB2 = null;
      											roleBeanOB3 = null;
      											roleDAOOB1 = null;
  	    									}
        									%>
        								</select>
      								</div>  
    							</div>
    							<div class="form-group">  
      								<label class="control-label col-sm-4" for="department">Department</label>  
      								<div class="col-sm-8">          						
        								<select class="form-control" name="departmentID" required>
  	    									<option value="">Select Department</option>
        									<%
        									DepartmentBean departmentBeanOB1 = new DepartmentBean();
      										departmentBeanOB1.setSearchQuery(" where companyid='"+selectedCompanyID+"' and status=1");      										
      										List<DepartmentBean> departmentBeanOB2 = new ArrayList<DepartmentBean>();
      										departmentBeanOB2.add(departmentBeanOB1);
      										DepartmentDAO departmentDAOOB1 = new DepartmentDAO();
      										List<DepartmentBean> departmentBeanOB3 = departmentDAOOB1.viewDepartment(departmentBeanOB2);
      										int noOfDepartments = departmentBeanOB3.size();
      										String departmentName = null;
      										int departmentID;
      										if(selectedCompanyID != 0)
  	    									{
      											for(int i=0;i<noOfDepartments;i++)
      											{      										
      												departmentName = departmentBeanOB3.get(i).getDepartmentName();
      												departmentID = departmentBeanOB3.get(i).getDepartmentID();
      											%>
	      											<option value="<%=departmentID%>"><%=departmentName.toUpperCase()%></option>
    	  										<%
      											}
      											departmentBeanOB1 = null;
      											departmentBeanOB2 = null;
      											departmentBeanOB3 = null;
      											departmentDAOOB1 = null;
  	    									}
        									%>
        								</select>
      								</div>  
    							</div>
    							<div class="form-group">  
      								<label class="control-label col-sm-4" for="designation">Designation</label>  
      								<div class="col-sm-8">  
        								<select class="form-control" name="designationID" required>
  	    									<option value="">Select Designation</option>
        									<%
        									DesignationBean designationBeanOB1 = new DesignationBean();
      										designationBeanOB1.setSearchQuery(" where companyid='"+selectedCompanyID+"' and status=1");      										
      										List<DesignationBean> designationBeanOB2 = new ArrayList<DesignationBean>();
      										designationBeanOB2.add(designationBeanOB1);
      										DesignationDAO designationDAOOB1 = new DesignationDAO();
      										List<DesignationBean> designationBeanOB3 = designationDAOOB1.viewDesignation(designationBeanOB2);
      										int noOfDesignations = designationBeanOB3.size();
      										String designationName = null;
      										int designationID;
      										if(selectedCompanyID != 0)
  	    									{
      											for(int i=0;i<noOfDesignations;i++)
      											{      										
      												designationName = designationBeanOB3.get(i).getDesignationName();
      												designationID = designationBeanOB3.get(i).getDesignationID();
      											%>
	      											<option value="<%=designationID%>"><%=designationName.toUpperCase()%></option>
    	  										<%
      											}
      											designationBeanOB1 = null;
      											designationBeanOB2 = null;
      											designationBeanOB3 = null;
      											designationDAOOB1 = null;      											
  	    									}
        									%>
        								</select>
      								</div>  
    							</div>    							    						
    							<div class="form-group">  
      								<label class="control-label col-sm-4" for="gender">Gender</label>  
      								<div class="col-sm-8">
        								<select class="form-control" name="gender" required>
  	    									<option value="">Select Gender</option>
  	    									<option value="m">MALE</option>
  	    									<option value="f">FEMALE</option>
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
    												<strong>
    													<%=AlertMessage1%>
    												</strong>
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
      								<div class="col-sm-offset-6 col-sm-8">  
        								<button type="submit" class="btn btn-success" name="submitValue" value="createUser">
        									<strong>CreateUser</strong>
        								</button>  
      								</div>  
    							</div>
    						</form>
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
		</body>
	<%
	}
 }
%>
</html>