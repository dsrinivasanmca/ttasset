package com.tt.asset;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;



public class CompanyDAO 
{
	Connection con;
	Statement stmt;
	ResultSet rs;
	String searchQuery;
	String searchQuery1;
	
	private String companyName;
	private int createdByUserID;
	private Date openingDate;
	private int companyID;
	private String actionResult;
	private String actionReport;
	
	public CompanyBean newCompany(CompanyBean companyBeanOB1)
	{
		companyName = companyBeanOB1.getCompanyName();
		createdByUserID = companyBeanOB1.getCreatedByUserID();
		openingDate = companyBeanOB1.getOpeningDate();
		DateFormat dateFormate = new SimpleDateFormat("yyyy-MM-dd");
		String openingDateString =dateFormate.format(openingDate);		 
		
		// Verifying Duplicate Company Name		
		CommonSearchBean commonSearchBeanOB1 = new CommonSearchBean();
		searchQuery = "select companyid from companies where companyname='"+companyName+"'";
		commonSearchBeanOB1.setSearchQuery(searchQuery);
		CommonSearchDAO commonSearchDAOOB1 = new CommonSearchDAO();
		CommonSearchBean commonSearchBeanOB2 = commonSearchDAOOB1.findData(commonSearchBeanOB1);
		actionReport = commonSearchBeanOB2.getActionReport();
		commonSearchBeanOB1 = null;
		commonSearchBeanOB2 = null;
		commonSearchDAOOB1 = null;
		// Verifying Duplicate Company Name
		
		if("NoData".equals(actionReport))
		{
			try 
			{
				con = ConnectionManager.getConnection();
				stmt = con.createStatement();
				String insertQuery = "insert into companies(companyid,companyname,openingdate,status,createdby,creationdatetime) values(companyid.nextval,'"+companyName+"',to_date('"+openingDateString+"','YYYY-MM-DD'),'1','"+createdByUserID+"',current_timestamp)";				
				rs = stmt.executeQuery(insertQuery);
				rs.close();
				
				// Verifying Newly Added Company Name Exist
				searchQuery = "select companyid from companies where companyname='"+companyName+"'";				
				rs = stmt.executeQuery(searchQuery);
				// Verifying Newly Added Company Name Exist
				
				if(rs.next())
				{	
					actionResult = "Success";
					actionReport = "Company "+companyName.toUpperCase()+" Created Successfully.";
					System.out.println(actionReport);
					int newCompanyid = rs.getInt("companyid");					
					insertQuery="insert into companylog(companyid,companyname,openingdate,status,modifiedby,modifydatetime,description) values('"+newCompanyid+"','"+companyName+"',to_date('"+openingDateString+"','YYYY-MM-DD'),'1','"+createdByUserID+"',current_timestamp,'Newly Added')";
					stmt.executeQuery(insertQuery);						
				}
				else
				{
					actionResult = "Error";
					actionReport = "UnExpected Error Occured";
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
			actionReport = "CompanyName "+companyName.toUpperCase()+" Already Exist";
		}		
		companyBeanOB1.setActionResult(actionResult);
		companyBeanOB1.setActionReport(actionReport);
		return companyBeanOB1;
	}
	public List<CompanyBean> viewCompany(List<CompanyBean> companyBeanOB1)
	{
		searchQuery = companyBeanOB1.get(0).getSearchQuery();		
		companyBeanOB1.clear();
		
		try
		{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();			
			searchQuery1 = "select companyid,companyname,openingdate,status,createdby,creationdatetime from companies";
			searchQuery1 = searchQuery1.concat(searchQuery);
			rs = stmt.executeQuery(searchQuery1);
			while(rs.next())
			{
				CompanyBean companyBeanOB2 = new CompanyBean();
				companyBeanOB2.setCompanyID(rs.getInt("companyid"));
				companyBeanOB2.setCompanyName(rs.getString("companyname"));
				companyBeanOB2.setOpeningDate(rs.getDate("openingdate"));
				companyBeanOB2.setCompanyStatus(rs.getInt("status"));
				companyBeanOB2.setCreatedByUserID(rs.getInt("createdby"));
				companyBeanOB2.setCreationDate(rs.getDate("creationdatetime"));
				companyBeanOB2.setCreationTime(rs.getTime("creationdatetime"));
				companyBeanOB1.add(companyBeanOB2);
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
		return companyBeanOB1;
	}
	public CompanyBean editCompany(CompanyBean companyBeanOB1)
	{
		companyID = companyBeanOB1.getCompanyID();
		companyName = companyBeanOB1.getCompanyName();		
		Date openingDate = companyBeanOB1.getOpeningDate();
		String openingDateString = new SimpleDateFormat("yyyy-MM-dd").format(openingDate);
		int companyStatus = companyBeanOB1.getCompanyStatus();
		createdByUserID = companyBeanOB1.getCreatedByUserID();
		
		String oldCompanyName = companyBeanOB1.getOldCompanyName();
		Date oldOpeningDate = companyBeanOB1.getOldOpeningDate();
		String oldOpeningDateString = new SimpleDateFormat("yyyy-MM-dd").format(oldOpeningDate);
		int oldCompanyStatus = companyBeanOB1.getOldCompanyStatus();
		String companyNameReport=null;
		String openingDateReport=null;
		String companyStatusReport=null;
		String branchStatusReport=null;
		String departmentStatusReport=null;
		String designationStatusReport=null;
		String updateQuery="";
		String updateQuery1=null;
		String description="";
		
		if(!companyName.equals(oldCompanyName))
		{
			// Verifying Duplicate CompanyName		
			CommonSearchBean commonSearchBeanOB1 = new CommonSearchBean();
			searchQuery = "select companyid from companies where companyname='"+companyName+"' and companyid!='"+companyID+"'";
			commonSearchBeanOB1.setSearchQuery(searchQuery);
			CommonSearchDAO commonSearchDAOOB1 = new CommonSearchDAO();
			CommonSearchBean commonSearchBeanOB2 = commonSearchDAOOB1.findData(commonSearchBeanOB1);
			actionReport = commonSearchBeanOB2.getActionReport();
			commonSearchBeanOB1 = null;
			commonSearchBeanOB2 = null;
			commonSearchDAOOB1 = null;
			// Verifying Duplicate CompanyName		
			if("NoData".equals(actionReport))
			{
				companyNameReport="Success";
				updateQuery = "CompanyName='"+companyName+"'";
				description = "CompanyName";
			}
			else
			{
				companyNameReport="Error";
				actionResult = "Error";
				actionReport = "CompanyName "+companyName.toUpperCase()+" Already Exist";								
			}			
		}
		else
		{
			companyNameReport="Success";
		}
		if(!openingDateString.equals(oldOpeningDateString) && "Success".equals(companyNameReport))
		{
			// Verifying Existing Users JoiningDate		
			CommonSearchBean commonSearchBeanOB1 = new CommonSearchBean();
			searchQuery = "select userid from users where companyid='"+companyID+"' and trunc(joiningdate) < to_date('"+openingDateString+"','YYYY-MM-DD')";
			commonSearchBeanOB1.setSearchQuery(searchQuery);
			CommonSearchDAO commonSearchDAOOB1 = new CommonSearchDAO();
			CommonSearchBean commonSearchBeanOB2 = commonSearchDAOOB1.findData(commonSearchBeanOB1);
			actionReport = commonSearchBeanOB2.getActionReport();
			commonSearchBeanOB1 = null;
			commonSearchBeanOB2 = null;
			commonSearchDAOOB1 = null;
			// Verifying Existing Users JoiningDate		
			if("NoData".equals(actionReport))
			{
				openingDateReport="Success";
				if("".equals(updateQuery))
				{				
					updateQuery = "openingdate=to_date('"+openingDateString+"','YYYY-MM-DD')";
				}
				else
				{
					updateQuery = updateQuery.concat(",openingdate=to_date('"+openingDateString+"','YYYY-MM-DD')");
				}
				if("".equals(description))
				{
					description = "OpeningDate";				
				}
				else
				{
					description = description.concat(",OpeningDate");
				}
			}
			else
			{
				openingDateReport="Error";
				actionResult = "Error"; 
				actionReport = "One or More User's Joiningdates Are Lesser than the New Opening Date "+openingDateString;
			}			
		}
		else
		{
			openingDateReport="Success";
		}
		if(companyStatus != oldCompanyStatus && "Success".equals(companyNameReport) && "Success".equals(openingDateReport))
		{
			if(companyStatus == 0 )
			{
				//Verifying Existing Branch Status		
				CommonSearchBean commonSearchBeanOB1 = new CommonSearchBean();
				searchQuery = "select branchid from branches where companyid='"+companyID+"' and status='1'";
				commonSearchBeanOB1.setSearchQuery(searchQuery);
				CommonSearchDAO commonSearchDAOOB1 = new CommonSearchDAO();
				CommonSearchBean commonSearchBeanOB2 = commonSearchDAOOB1.findData(commonSearchBeanOB1);
				actionReport = commonSearchBeanOB2.getActionReport();			
				//Verifying Existing Branch Status		
				if("NoData".equals(actionReport))
				{
					companyStatusReport="Success";
					branchStatusReport="Success";
					//Verifying Existing Department Status
					searchQuery = "select departmentid from departments where companyid='"+companyID+"' and status='1'";
					commonSearchBeanOB1.setSearchQuery(searchQuery);				
					commonSearchBeanOB2 = commonSearchDAOOB1.findData(commonSearchBeanOB1);
					actionReport = commonSearchBeanOB2.getActionReport();
					//Verifying Existing Department Status
					if("NoData".equals(actionReport))
					{
						companyStatusReport="Success";
						departmentStatusReport="Success";
						// Verifying Existing Designation Status
						searchQuery = "select designationid from designations where companyid='"+companyID+"' and status='1'";
						commonSearchBeanOB1.setSearchQuery(searchQuery);				
						commonSearchBeanOB2 = commonSearchDAOOB1.findData(commonSearchBeanOB1);
						actionReport = commonSearchBeanOB2.getActionReport();
						// Verifying Existing Designation Status
						if("NoData".equals(actionReport))
						{
							companyStatusReport="Success";
							designationStatusReport="Success";
						}
						else
						{
							companyStatusReport="Error";
							designationStatusReport="Error";
						}
					}
					else
					{
						companyStatusReport="Error";
						departmentStatusReport="Error";						
					}
				}			
				else
				{
					companyStatusReport="Error";
					branchStatusReport="Error";					
				}
				commonSearchBeanOB1 = null;
				commonSearchBeanOB2 = null;
				commonSearchDAOOB1 = null;
			}
			else if (companyStatus == 1 )
			{
				companyStatusReport="Success";
			}
			if("Error".equals(companyStatusReport))
			{
				actionResult = "Error";
				if("Error".equals(designationStatusReport))
				{
					actionReport = "One or More Designations Are Still Active in this Company";
				}
				else if("Error".equals(departmentStatusReport))
				{
					actionReport = "One or More Departments Are Still Active in this Company";
				}
				else if("Error".equals(branchStatusReport))
				{
					actionReport = "One or More Branches Are Still Active in this Company";
				}
			}
			else if("Success".equals(companyStatusReport))
			{
				if("".equals(updateQuery))
				{
					updateQuery = "status='"+companyStatus+"'";					
				}
				else
				{
					updateQuery = updateQuery.concat(",status='"+companyStatus+"'");
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
			companyStatusReport="Success";
		}
		if("Success".equals(companyNameReport) && "Success".equals(openingDateReport) && "Success".equals(companyStatusReport))
		{
			try
			{
				con = ConnectionManager.getConnection();
				stmt = con.createStatement();
				description = description.concat(" Modified");												
				updateQuery1="update companies set "+updateQuery+ " where companyid='"+companyID+"'";				
				stmt.executeQuery(updateQuery1);
				searchQuery = "select companyname,openingdate,status from companies where companyid='"+companyID+"' and companyname='"+companyName+"' and trunc(openingdate)=to_date('"+openingDateString+"','YYYY-MM-DD') and status='"+companyStatus+"'";				
				rs = stmt.executeQuery(searchQuery);
				if(!rs.next())
				{
					actionResult = "Error";
					actionReport = "Unexpected Error While Updating Company";
					rs.close();
				}
				else
				{
					rs.close();
					System.out.println("Company "+companyName+" Modified Successfully");
					String insertQuery="insert into companylog(companyid,companyname,openingdate,status,modifiedby,modifydatetime,description) values('"+companyID+"','"+companyName+"',to_date('"+openingDateString+"','YYYY-MM-DD'),'"+companyStatus+"','"+createdByUserID+"',current_timestamp,'"+description+"')";					
					stmt.executeQuery(insertQuery);
					actionResult = "Success";
					actionReport = "Company "+companyName+" Updated Successfully";
				
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
		companyBeanOB1.setActionResult(actionResult);
		companyBeanOB1.setActionReport(actionReport);
		return companyBeanOB1;
	}
	public List<CompanyBean> companyLog(List<CompanyBean> companyBeanOB1)
	{		
		searchQuery = companyBeanOB1.get(0).getSearchQuery();
		companyBeanOB1.clear();
		
		try
		{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();			
			searchQuery1 = "select companyname,openingdate,status,modifiedby,modifydatetime,description from companylog";
			searchQuery1 = searchQuery1.concat(searchQuery);
			rs = stmt.executeQuery(searchQuery1);			
			while(rs.next())
			{
				CompanyBean companyBeanOB2 = new CompanyBean();								
				companyBeanOB2.setCompanyName(rs.getString("companyname"));
				companyBeanOB2.setOpeningDate(rs.getDate("openingdate"));
				companyBeanOB2.setCompanyStatus(rs.getInt("status"));
				companyBeanOB2.setCreatedByUserID(rs.getInt("modifiedby"));
				companyBeanOB2.setCreationDate(rs.getDate("modifydatetime"));
				companyBeanOB2.setCreationTime(rs.getTime("modifydatetime"));
				companyBeanOB2.setDescription(rs.getString("description"));
				companyBeanOB1.add(companyBeanOB2);
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
		return companyBeanOB1;
	}
}