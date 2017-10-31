<form method="post" action=RootAdminActionBarServlet>
	<nav class="navbar navbar-inverse">
  		<div class="container-fluid">
    		<div class="navbar-header">
    			<div class="active">
      				<a class="navbar-brand" href="home.jsp">Home</a>
      			</div>
    		</div>
	    	<ul class="nav navbar-nav">
       		<li class="dropdown">
        		<a class="dropdown-toggle" data-toggle="dropdown">Company<span class="caret"></span></a>
        		<ul class="dropdown-menu">
        			<li><button type="submit" class="btn btn-primary btn-block" name="actionvalue" value="newcompany">New</button></li>          
          			<li><button type="submit" class="btn btn-primary btn-block" name="actionvalue" value="viewcompany">View</button></li>        
        			<li><button type="submit" class="btn btn-primary btn-block" name="actionvalue" value="editcompany">Edit</button></li>                  
          			<li><button type="submit" class="btn btn-primary btn-block" name="actionvalue" value="companylog">Log</button></li>
        		</ul>
      		</li>
      		<li class="dropdown">
        		<a class="dropdown-toggle" data-toggle="dropdown">Branch<span class="caret"></span></a>
        		<ul class="dropdown-menu">
          			<li><button type="submit" class="btn btn-primary btn-block" name="actionvalue" value="newbranch">New</button></li>          
          			<li><button type="submit" class="btn btn-primary btn-block" name="actionvalue" value="viewbranch">View</button></li>        
        			<li><button type="submit" class="btn btn-primary btn-block" name="actionvalue" value="editbranch">Edit</button></li>                  
          			<li><button type="submit" class="btn btn-primary btn-block" name="actionvalue" value="branchlog">Log</button></li>
        		</ul>
      		</li>
      		<li class="dropdown">
        		<a class="dropdown-toggle" data-toggle="dropdown">Department<span class="caret"></span></a>
        		<ul class="dropdown-menu">
          			<li><button type="submit" class="btn btn-primary btn-block" name="actionvalue" value="newdepartment">New</button></li>          
          			<li><button type="submit" class="btn btn-primary btn-block" name="actionvalue" value="viewdepartment">View</button></li>        
        			<li><button type="submit" class="btn btn-primary btn-block" name="actionvalue" value="editdepartment">Edit</button></li>                  
          			<li><button type="submit" class="btn btn-primary btn-block" name="actionvalue" value="departmentlog">Log</button></li>
        		</ul>
      		</li>
      		<li class="dropdown">
        		<a class="dropdown-toggle" data-toggle="dropdown">Designation<span class="caret"></span></a>
        		<ul class="dropdown-menu">
          			<li><button type="submit" class="btn btn-primary btn-block" name="actionvalue" value="newdesignation">New</button></li>          
          			<li><button type="submit" class="btn btn-primary btn-block" name="actionvalue" value="viewdesignation">View</button></li>        
        			<li><button type="submit" class="btn btn-primary btn-block" name="actionvalue" value="editdesignation">Edit</button></li>                  
          			<li><button type="submit" class="btn btn-primary btn-block" name="actionvalue" value="designationlog">Log</button></li>
        		</ul>
      		</li>
      		<li class="dropdown">
        		<a class="dropdown-toggle" data-toggle="dropdown">User<span class="caret"></span></a>
        		<ul class="dropdown-menu">
          			<li><button type="submit" class="btn btn-primary btn-block" name="actionvalue" value="newuser">New</button></li>          
          			<li><button type="submit" class="btn btn-primary btn-block" name="actionvalue" value="viewuser">View</button></li>        
        			<li><button type="submit" class="btn btn-primary btn-block" name="actionvalue" value="edituser">Edit</button></li>                  
          			<li><button type="submit" class="btn btn-primary btn-block" name="actionvalue" value="userlog">Log</button></li>
        		</ul>
      		</li>
     		</ul>
		</div>
	</nav>
</form>