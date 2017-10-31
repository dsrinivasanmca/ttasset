<html>
<%@ include file="header.jsp"%>
<body>
<%
if ( (session != null) && (session.getAttribute("currentSessionUserID") != null) )
{    
    String currentSessionUserRole = (String)session.getAttribute("currentSessionUserRole");        
    if("rootadmin".equals(currentSessionUserRole))
    {
	%>
		<%@include file="rootadminActionBar.jsp"%>
	<%
    }
    else if("companyadmin".equals(currentSessionUserRole))
    {
	%>
		<%@include file="companyadminActionBar.jsp"%>
	<%
    }
}
%>
</body>
</html>