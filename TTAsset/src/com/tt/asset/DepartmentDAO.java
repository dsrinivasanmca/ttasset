package com.tt.asset;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;



public class DepartmentDAO 
{
	Connection con;
	Statement stmt;
	ResultSet rs;
	String searchQuery;
	String searchQuery1;
	String insertQuery;
	
	private int companyID;
	private int departmentID;
	private int createdByUserID;
	private String departmentName;
	private String actionResult;
	private String actionReport;
	public DepartmentBean newDepartment(DepartmentBean departmentBeanOB1)
	{
		companyID = departmentBeanOB1.getCompanyID();
		createdByUserID = departmentBeanOB1.getCreatedByUserID();
		departmentName = departmentBeanOB1.getDepartmentName();
		
		// Verifying Duplicate Department Name		
		CommonSearchBean commonSearchBeanOB1 = new CommonSearchBean();
		searchQuery = "select departmentid from departments where departmentname='"+departmentName+"' and companyid='"+companyID+"'";
		commonSearchBeanOB1.setSearchQuery(searchQuery);
		CommonSearchDAO commonSearchDAOOB1 = new CommonSearchDAO();
		CommonSearchBean commonSearchBeanOB2 = commonSearchDAOOB1.findData(commonSearchBeanOB1);
		actionReport = commonSearchBeanOB2.getActionReport();
		commonSearchBeanOB1 = null;
		commonSearchBeanOB2 = null;
		commonSearchDAOOB1 = null;
		// Verifying Duplicate Department Name
		
		if("NoData".equals(actionReport))
		{
			try
			{
				con = ConnectionManager.getConnection();
				stmt = con.createStatement();
				insertQuery = "insert into departments(departmentid,departmentname,companyid,status,createdby,creationdatetime) values(departmentid.nextval,'"+departmentName+"','"+companyID+"','1','"+createdByUserID+"',current_timestamp)";
				rs = stmt.executeQuery(insertQuery);
				searchQuery = "select departmentid from departments where departmentname='"+departmentName+"' and companyid='"+companyID+"'"; 
				rs = stmt.executeQuery(searchQuery);
				if(rs.next())
				{	
					int departmentid = rs.getInt("departmentid"); 
					insertQuery = "insert into departmentlog(departmentid,departmentname,status,modifiedby,modifydatetime,description) values('"+departmentid+"','"+departmentName+"','1','"+createdByUserID+"',current_timestamp,'newly created')";
					stmt.executeQuery(insertQuery);
					actionResult = "Success";
					actionReport = "DepartmentName "+departmentName.toUpperCase()+" Created Successfully";
					System.out.println(actionResult+" "+actionReport);					
				}
				else
				{
					actionResult = "Error";
					actionReport = "UnExpected Error Occurred";
					System.out.println(actionResult+" "+actionReport);					
				}							
			}			
			catch (SQLException e)
		    {
		        e.printStackTrace();
		    }
			finally
			{
				if(rs != null){try{rs.close();}catch(SQLException e){e.printStackTrace();}}
				if(stmt != null){try{stmt.close();}catch(SQLException e){e.printStackTrace();}}
				if(con != null){try{con.close();}catch(SQLException e){e.printStackTrace();}}
			}
		}
		else
		{
			actionResult = "Error";
			actionReport = "DepartmentName "+departmentName.toUpperCase()+" Already Exist";
			System.out.println(actionResult+" "+actionReport);		
		}
		
		departmentBeanOB1.setActionResult(actionResult);
		departmentBeanOB1.setActionReport(actionReport);
		return departmentBeanOB1;
	}
	public List<DepartmentBean> viewDepartment(List<DepartmentBean> departmentBeanOB1)
	{
		searchQuery = departmentBeanOB1.get(0).getSearchQuery();
		departmentBeanOB1.clear();
		
		try
		{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();			
			searchQuery1 = "select companyid,departmentid,departmentname,status,createdby,creationdatetime from departments";
			searchQuery1 = searchQuery1.concat(searchQuery);			
			rs = stmt.executeQuery(searchQuery1);
			
			while(rs.next())
			{
				DepartmentBean departmentBeanOB2 = new DepartmentBean();
				departmentBeanOB2.setCompanyID(rs.getInt("companyid"));
				departmentBeanOB2.setDepartmentID(rs.getInt("departmentid"));
				departmentBeanOB2.setDepartmentName(rs.getString("departmentname"));
				departmentBeanOB2.setDepartmentStatus(rs.getInt("status"));
				departmentBeanOB2.setCreatedByUserID(rs.getInt("createdby"));
				departmentBeanOB2.setCreationDate(rs.getDate("creationdatetime"));
				departmentBeanOB2.setCreationTime(rs.getTime("creationdatetime"));
				departmentBeanOB1.add(departmentBeanOB2);
			}			
		}		
		catch (SQLException e)
	    {
	        e.printStackTrace();
	    }
		finally
		{
			if(rs != null){try{rs.close();}catch(SQLException e){e.printStackTrace();}}
			if(stmt != null){try{stmt.close();}catch(SQLException e){e.printStackTrace();}}
			if(con != null){try{con.close();}catch(SQLException e){e.printStackTrace();}}
		}	
		return departmentBeanOB1;
	}
	public DepartmentBean editDepartment(DepartmentBean departmentBeanOB1)
	{
		departmentID = departmentBeanOB1.getDepartmentID();
		createdByUserID = departmentBeanOB1.getCreatedByUserID();
		String newDepartmentName = departmentBeanOB1.getDepartmentName();
		String oldDepartmentName = departmentBeanOB1.getOldDepartmentName();
		int newStatus = departmentBeanOB1.getDepartmentStatus();
		int oldStatus = departmentBeanOB1.getOldDepartmentStatus();
		String updateQuery = "";
		String updateQuery1 = "";
		String description = "";
		String departmentNameReport=null;
		String departmentStatusReport=null; 
		
		try
		{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
			searchQuery = "select companyid from departments where departmentid ='"+departmentID+"'";			
			rs = stmt.executeQuery(searchQuery);
			rs.next();
			companyID = rs.getInt("companyid");
			rs.close();
			if(!newDepartmentName.equals(oldDepartmentName))				
			{
				// Verifying Duplicate Department Name		
				CommonSearchBean commonSearchBeanOB1 = new CommonSearchBean();
				searchQuery = "select departmentid from departments where departmentname='"+newDepartmentName+"' and companyid='"+companyID+"'";
				commonSearchBeanOB1.setSearchQuery(searchQuery);
				CommonSearchDAO commonSearchDAOOB1 = new CommonSearchDAO();
				CommonSearchBean commonSearchBeanOB2 = commonSearchDAOOB1.findData(commonSearchBeanOB1);
				actionReport = commonSearchBeanOB2.getActionReport();
				commonSearchBeanOB1 = null;
				commonSearchBeanOB2 = null;
				commonSearchDAOOB1 = null;
				// Verifying Duplicate Department Name
				
				if("NoData".equals(actionReport))
				{									
					departmentNameReport="Success";
					updateQuery = "DepartmentName='"+newDepartmentName+"'";
					description = "DepartmentName";
				}
				else
				{
					departmentNameReport="Error";
					actionResult = "Error";
					actionReport = "DepartmentName "+newDepartmentName.toUpperCase()+" Already Exist";
				}
			}
			else
			{
				departmentNameReport="Success";
			}
			if(newStatus != oldStatus && "Success".equals(departmentNameReport))
			{
				if(newStatus == 0)
				{
					// Verifying Existing User Status		
					CommonSearchBean commonSearchBeanOB1 = new CommonSearchBean();
					searchQuery="select userid from users where departmentid='"+departmentID+"' and status='1'";
					commonSearchBeanOB1.setSearchQuery(searchQuery);
					CommonSearchDAO commonSearchDAOOB1 = new CommonSearchDAO();
					CommonSearchBean commonSearchBeanOB2 = commonSearchDAOOB1.findData(commonSearchBeanOB1);
					actionReport = commonSearchBeanOB2.getActionReport();
					commonSearchBeanOB1 = null;
					commonSearchBeanOB2 = null;
					commonSearchDAOOB1 = null;
					// Verifying Existing Room Status							
					if("NoData".equals(actionReport))
					{
						departmentStatusReport="Success";						
					}
					else
					{
						departmentStatusReport="Error";
						actionResult = "Error";
						actionReport = "One or More Users Are Still Active in this Department";
					}
				}
				else
				{
					departmentStatusReport="Success";
				}
				if("Success".equals(departmentStatusReport))
				{
					if("".equals(updateQuery))
					{
						updateQuery = "status='"+newStatus+"'";					
					}
					else
					{
						updateQuery = updateQuery.concat(",status='"+newStatus+"'");
					}	
					if("".equals(description))
					{
						description = "Status";				
					}
					else
					{
						description = description.concat(",Status");
					}
				}				
			}
			else
			{
				departmentStatusReport="Success";
			}
			if("Success".equals(departmentNameReport) && "Success".equals(departmentStatusReport))
			{
				
				description = description.concat(" Modified");				
				updateQuery1="update departments set "+updateQuery+ " where departmentid='"+departmentID+"'";
				stmt.executeQuery(updateQuery1);
				String searchQuery1 = "select departmentname,status from departments where departmentid='"+departmentID+"' and departmentname='"+newDepartmentName+"' and status='"+newStatus+"'";
				rs = stmt.executeQuery(searchQuery1);
				if(!rs.next())
				{
					actionResult = "Error";
					actionReport = "Unexpected Error While Updating Department";
					System.out.println(actionResult+" "+actionReport);
					rs.close();
				}
				else
				{
					insertQuery = "insert into departmentlog(departmentid,departmentname,status,modifiedby,modifydatetime,description) values('"+departmentID+"','"+newDepartmentName+"','"+newStatus+"','"+createdByUserID+"',current_timestamp,'"+description+"')";					
					stmt.executeQuery(insertQuery);
					actionResult = "Success";
					actionReport = "Department "+newDepartmentName.toUpperCase()+" Updated Successfully";
					System.out.println(actionResult+" "+actionReport);
					rs.close();
				}
			}
		}		
		catch (SQLException e)
	    {
	        e.printStackTrace();
	    }
		finally
		{
			if(rs != null){try{rs.close();}catch(SQLException e){e.printStackTrace();}}
			if(stmt != null){try{stmt.close();}catch(SQLException e){e.printStackTrace();}}
			if(con != null){try{con.close();}catch(SQLException e){e.printStackTrace();}}
		}
		departmentBeanOB1.setActionResult(actionResult);
		departmentBeanOB1.setActionReport(actionReport);
		return departmentBeanOB1;
	}
	public List<DepartmentBean> departmentLog(List<DepartmentBean> departmentBeanOB1)
	{		
		searchQuery = departmentBeanOB1.get(0).getSearchQuery();
		departmentBeanOB1.clear();
		
		try
		{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();			
			searchQuery1 = "select departmentname,status,modifiedby,modifydatetime,description from departmentlog";			
			searchQuery1 = searchQuery1.concat(searchQuery);
			rs = stmt.executeQuery(searchQuery1);
			
			while(rs.next())
			{
				DepartmentBean departmentBeanOB2 = new DepartmentBean();								
				departmentBeanOB2.setDepartmentName(rs.getString("departmentname"));
				departmentBeanOB2.setDepartmentStatus(rs.getInt("status"));
				departmentBeanOB2.setCreatedByUserID(rs.getInt("modifiedby"));
				departmentBeanOB2.setCreationDate(rs.getDate("modifydatetime"));
				departmentBeanOB2.setCreationTime(rs.getTime("modifydatetime"));
				departmentBeanOB2.setDescription(rs.getString("description"));
				departmentBeanOB1.add(departmentBeanOB2);
			}			
		}		
		catch (SQLException e)
	    {
	        e.printStackTrace();
	    }
		finally
		{
			if(rs != null){try{rs.close();}catch(SQLException e){e.printStackTrace();}}
			if(stmt != null){try{stmt.close();}catch(SQLException e){e.printStackTrace();}}
			if(con != null){try{con.close();}catch(SQLException e){e.printStackTrace();}}
		}	
		return departmentBeanOB1;
	}
}
