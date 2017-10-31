package com.tt.asset;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;



public class DesignationDAO 
{
	Connection con;
	Statement stmt;
	ResultSet rs;
	String searchQuery;
	String searchQuery1;
	String insertQuery;
	
	private int companyID;
	private int designationID;
	private int createdByUserID;
	private String designationName;
	private String actionResult;
	private String actionReport;
	public DesignationBean newDesignation(DesignationBean designationBeanOB1)
	{
		companyID = designationBeanOB1.getCompanyID();
		createdByUserID = designationBeanOB1.getCreatedByUserID();
		designationName = designationBeanOB1.getDesignationName();
		
		// Verifying Duplicate Designation Name		
		CommonSearchBean commonSearchBeanOB1 = new CommonSearchBean();
		searchQuery = "select designationid from designations where designationname='"+designationName+"' and companyid='"+companyID+"'";
		commonSearchBeanOB1.setSearchQuery(searchQuery);
		CommonSearchDAO commonSearchDAOOB1 = new CommonSearchDAO();
		CommonSearchBean commonSearchBeanOB2 = commonSearchDAOOB1.findData(commonSearchBeanOB1);
		actionReport = commonSearchBeanOB2.getActionReport();
		commonSearchBeanOB1 = null;
		commonSearchBeanOB2 = null;
		commonSearchDAOOB1 = null;
		// Verifying Duplicate Designation Name
		
		if("NoData".equals(actionReport))
		{		
			try
			{
				con = ConnectionManager.getConnection();
				stmt = con.createStatement();			
				insertQuery = "insert into designations(designationid,designationname,companyid,status,createdby,creationdatetime) values(designationid.nextval,'"+designationName+"','"+companyID+"','1','"+createdByUserID+"',current_timestamp)";
				rs = stmt.executeQuery(insertQuery);
				searchQuery = "select designationid from designations where designationname='"+designationName+"' and companyid='"+companyID+"'";
				rs = stmt.executeQuery(searchQuery);
				if(rs.next())
				{	
					int designationid = rs.getInt("designationid"); 
					insertQuery = "insert into designationlog(designationid,designationname,status,modifiedby,modifydatetime,description) values('"+designationid+"','"+designationName+"','1','"+createdByUserID+"',current_timestamp,'newly created')";
					stmt.executeQuery(insertQuery);
					actionResult = "Success";
					actionReport = "DesignationName "+designationName.toUpperCase()+" Created Successfully";
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
			actionReport = "DesignationName "+designationName.toUpperCase()+" Already Exist";
			System.out.println(actionResult+" "+actionReport);		
		}
		designationBeanOB1.setActionResult(actionResult);
		designationBeanOB1.setActionReport(actionReport);
		return designationBeanOB1;
	}
	public List<DesignationBean> viewDesignation(List<DesignationBean> designationBeanOB1)
	{
		searchQuery = designationBeanOB1.get(0).getSearchQuery();
		designationBeanOB1.clear();
		
		try
		{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();			
			searchQuery1 = "select companyid,designationid,designationname,status,createdby,creationdatetime from designations";
			searchQuery1 = searchQuery1.concat(searchQuery);			
			rs = stmt.executeQuery(searchQuery1);
			
			while(rs.next())
			{
				DesignationBean designationBeanOB2 = new DesignationBean();
				designationBeanOB2.setCompanyID(rs.getInt("companyid"));
				designationBeanOB2.setDesignationID(rs.getInt("designationid"));
				designationBeanOB2.setDesignationName(rs.getString("designationname"));
				designationBeanOB2.setDesignationStatus(rs.getInt("status"));
				designationBeanOB2.setCreatedByUserID(rs.getInt("createdby"));
				designationBeanOB2.setCreationDate(rs.getDate("creationdatetime"));
				designationBeanOB2.setCreationTime(rs.getTime("creationdatetime"));
				designationBeanOB1.add(designationBeanOB2);
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
		return designationBeanOB1;
	}
	public DesignationBean editDesignation(DesignationBean designationBeanOB1)
	{
		designationID = designationBeanOB1.getDesignationID();
		createdByUserID = designationBeanOB1.getCreatedByUserID();
		String newDesignationName = designationBeanOB1.getDesignationName();
		String oldDesignationName = designationBeanOB1.getOldDesignationName();
		int newStatus = designationBeanOB1.getDesignationStatus();
		int oldStatus = designationBeanOB1.getOldDesignationStatus();
		String updateQuery = "";
		String updateQuery1 = "";
		String description = "";
		String designationNameReport=null;
		String designationStatusReport=null;
		
		try
		{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
			searchQuery = "select companyid from designations where designationid ='"+designationID+"'";			
			rs = stmt.executeQuery(searchQuery);
			rs.next();
			companyID = rs.getInt("companyid");
			rs.close();
			if(!newDesignationName.equals(oldDesignationName))
			{
				// Verifying Duplicate Designation Name		
				CommonSearchBean commonSearchBeanOB1 = new CommonSearchBean();
				searchQuery = "select designationid from designations where designationname='"+newDesignationName+"' and companyid='"+companyID+"'";
				commonSearchBeanOB1.setSearchQuery(searchQuery);
				CommonSearchDAO commonSearchDAOOB1 = new CommonSearchDAO();
				CommonSearchBean commonSearchBeanOB2 = commonSearchDAOOB1.findData(commonSearchBeanOB1);
				actionReport = commonSearchBeanOB2.getActionReport();
				commonSearchBeanOB1 = null;
				commonSearchBeanOB2 = null;
				commonSearchDAOOB1 = null;
				// Verifying Duplicate Designation Name
				
				if("NoData".equals(actionReport))
				{									
					designationNameReport="Success";
					updateQuery = "DesignationName='"+newDesignationName+"'";
					description = "DesignationName";
				}
				else
				{
					designationNameReport="Error";
					actionResult = "Error";
					actionReport = "DesignationName "+newDesignationName.toUpperCase()+" Already Exist";
				}
			}
			else
			{
				designationNameReport="Success";
			}
			if(newStatus != oldStatus && "Success".equals(designationNameReport))
			{
				if(newStatus == 0)
				{
					// Verifying Existing User Status		
					CommonSearchBean commonSearchBeanOB1 = new CommonSearchBean();
					searchQuery="select userid from users where designationid='"+designationID+"' and status='1'";
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
						designationStatusReport="Success";						
					}
					else
					{
						designationStatusReport="Error";
						actionResult = "Error";
						actionReport = "One or More Users Are Still Active in this Designation";
					}
				}
				else
				{
					designationStatusReport="Success";
				}
				if("Success".equals(designationStatusReport))
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
				designationStatusReport="Success";
			}
			if("Success".equals(designationNameReport) && "Success".equals(designationStatusReport))
			{
				
				description = description.concat(" Modified");				
				updateQuery1="update designations set "+updateQuery+ " where designationid='"+designationID+"'";
				stmt.executeQuery(updateQuery1);
				String searchQuery1 = "select designationname,status from designations where designationid='"+designationID+"' and designationname='"+newDesignationName+"' and status='"+newStatus+"'";
				rs = stmt.executeQuery(searchQuery1);
				if(!rs.next())
				{
					actionResult = "Error";
					actionReport = "Unexpected Error While Updating Designation";
					System.out.println(actionResult+" "+actionReport);
					rs.close();
				}
				else
				{
					insertQuery = "insert into designationlog(designationid,designationname,status,modifiedby,modifydatetime,description) values('"+designationID+"','"+newDesignationName+"','"+newStatus+"','"+createdByUserID+"',current_timestamp,'"+description+"')";					
					stmt.executeQuery(insertQuery);
					actionResult = "Success";
					actionReport = "Designation "+newDesignationName.toUpperCase()+" Updated Successfully";
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
		designationBeanOB1.setActionResult(actionResult);
		designationBeanOB1.setActionReport(actionReport);
		return designationBeanOB1;
	}
	public List<DesignationBean> designationLog(List<DesignationBean> designationBeanOB1)
	{		
		searchQuery = designationBeanOB1.get(0).getSearchQuery();
		designationBeanOB1.clear();
		
		try
		{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();			
			searchQuery1 = "select designationname,status,modifiedby,modifydatetime,description from designationlog";
			searchQuery1 = searchQuery1.concat(searchQuery);
			rs = stmt.executeQuery(searchQuery1);
			
			while(rs.next())
			{
				DesignationBean designationBeanOB2 = new DesignationBean();								
				designationBeanOB2.setDesignationName(rs.getString("designationname"));
				designationBeanOB2.setDesignationStatus(rs.getInt("status"));
				designationBeanOB2.setCreatedByUserID(rs.getInt("modifiedby"));
				designationBeanOB2.setCreationDate(rs.getDate("modifydatetime"));
				designationBeanOB2.setCreationTime(rs.getTime("modifydatetime"));
				designationBeanOB2.setDescription(rs.getString("description"));
				designationBeanOB1.add(designationBeanOB2);
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
		return designationBeanOB1;
	}
}