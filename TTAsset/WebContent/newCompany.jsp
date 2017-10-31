<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@ include file="actionBar.jsp"%>
<link rel="stylesheet" type="text/css" href="css\bootstrap-datetimepicker.min.css">
<script type="text/javascript" src="css\bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="css\moment.min.js"></script>
<%
 if( session != null && session.getAttribute("currentSessionUserID") != null) 
 {
	int currentSessionUserid = (Integer) session.getAttribute("currentSessionUserID");
	String currentSessionUserRole = (String) session.getAttribute("currentSessionUserRole");
	DateBean dateBeanOB1 = new DateBean();	
	String todayDate = dateBeanOB1.getTodayDate();
	dateBeanOB1 = null;
	if("rootadmin".equals(currentSessionUserRole))
	{
 %> 		
		<body>
		<div class="container">
		<div class="row">
  		<div class="col-sm-2"></div>
  		<div class="col-sm-8">
  		<div class="panel panel-primary well well-sm">
			<div class="panel-heading" align="center">Add New Company</div>
				<div class="panel-body">
  					<form class="form-horizontal" method="post" action="CompanyServlet">   
  						<div class="form-group">  
      						<label class="control-label col-sm-4" for="companyname">CompanyName:</label>  
      						<div class="col-sm-8">  
        						<input type="text" class="form-control" name="companyName" placeholder="Enter CompanyName" required pattern="^(?=.*[A-Za-z0-9])[0-9a-zA-Z\#\-\.\s]{2,34}$"
        title="Olny Letters, Numbers and Special Characters(-,.,Space,#) Allowed(1 Alphanumeric Mandatory)-(Length Min-2 Max-34)">  
      						</div>  
    					</div>
    					<div class="form-group">
    						<input type="hidden" id="startDate" value="01-01-1981">
    						<input type="hidden" id="endDate" value="<%=todayDate%>">  
      						<label class="control-label col-sm-4" for="joiningdate">OpeningDate</label>  
      						<div class="col-sm-8">        								                    		
                    			<div class="input-group date form_date" data-date="" data-date-format="dd-mm-yyyy" data-link-field="openingDate" data-link-format="dd-mm-yyyy">
                    				<input class="form-control" size="16" type="text" name="openingDate1" value="<%=todayDate%>" placeholder="<%=todayDate%>" readonly>                    							
									<span class="input-group-addon">
										<span class="glyphicon glyphicon-calendar"></span>
									</span>
                				</div>                       							                		                     						                							                   						                    			
								<input type="hidden" id="openingDate" name="openingDate" value=""/><br/>
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
        					<button type="submit" class="btn btn-success" name="submitValue" value="createCompany">
        						<strong>CreateCompany</strong>
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
	else
	{
	%>
		<%="YOU ARE NOT AUTHORISED TO ACCESS THIS PAGE"%>
	<%
	}
}
%>
</html>