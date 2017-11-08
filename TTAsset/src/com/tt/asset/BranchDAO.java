package com.tt.asset;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;


public class BranchDAO 
{
	Connection con;
	Statement stmt;
	ResultSet rs;
	String searchQuery;
	String searchQuery1;
	String insertQuery;
	
	private int companyID;
	private int branchID;
	private int createdByUserID;
	private String branchName;
	private String address1;
	private String address2;
	private String address3;
	private String address4;
	private String postalCode;
	private String city;
	private String state;
	private String country;
	private String actionResult;
	private String actionReport;
	public BranchBean newBranch(BranchBean branchBeanOB1)
	{
		companyID = branchBeanOB1.getCompanyID();
		createdByUserID = branchBeanOB1.getCreatedByUserID();
		branchName = branchBeanOB1.getBranchName();
		address1 = branchBeanOB1.getAddress1();
		address2 = branchBeanOB1.getAddress2();
		address3 = branchBeanOB1.getAddress3();
		address4 = branchBeanOB1.getAddress4();
		postalCode = branchBeanOB1.getPostalCode();
		city = branchBeanOB1.getCity();
		state = branchBeanOB1.getState();
		country = branchBeanOB1.getCountry();

		// Verifying Duplicate Branch Name		
		CommonSearchBean commonSearchBeanOB1 = new CommonSearchBean();
		searchQuery = "select branchid from branches where branchname='"+branchName+"' and companyid='"+companyID+"'";
		commonSearchBeanOB1.setSearchQuery(searchQuery);
		CommonSearchDAO commonSearchDAOOB1 = new CommonSearchDAO();
		CommonSearchBean commonSearchBeanOB2 = commonSearchDAOOB1.findData(commonSearchBeanOB1);
		actionReport = commonSearchBeanOB2.getActionReport();
		commonSearchBeanOB1 = null;
		commonSearchBeanOB2 = null;
		commonSearchDAOOB1 = null;
		// Verifying Duplicate Branch Name
		
		if("NoData".equals(actionReport))
		{		
			try
			{
				con = ConnectionManager.getConnection();
				stmt = con.createStatement();
				insertQuery = "insert into branches(branchid,branchname,companyid,address1,address2,address3,address4,postalcode,city,state,country,status,createdby,creationdatetime) values(branchid.nextval,'"+branchName+"','"+companyID+"','"+address1+"','"+address2+"','"+address3+"','"+address4+"','"+postalCode+"','"+city+"','"+state+"','"+country+"','1','"+createdByUserID+"',current_timestamp)";
				rs = stmt.executeQuery(insertQuery);
				rs.close();
				
				// Verifying Newly Added Company Name Exist
				searchQuery = "select branchid from branches where branchname='"+branchName+"' and companyid='"+companyID+"'";
				rs = stmt.executeQuery(searchQuery);
				// Verifying Newly Added Company Name Exist
				
				if(rs.next())
				{	
					int branchid = rs.getInt("branchid"); 
					insertQuery = "insert into branchlog(branchid,branchname,address1,address2,address3,address4,postalcode,city,state,country,status,modifiedby,modifydatetime,description) values('"+branchid+"','"+branchName+"','"+address1+"','"+address2+"','"+address3+"','"+address4+"','"+postalCode+"','"+city+"','"+state+"','"+country+"','1','"+createdByUserID+"',(select to_char(current_timestamp,'DD-MM-YYYY HH24:MI:SS') from dual),'newly created')";
					stmt.executeQuery(insertQuery);
					actionResult = "Success";
					actionReport = "BranchName "+branchName.toUpperCase()+" Created Successfully";
					System.out.println(actionResult+" "+actionReport);
					rs.close();
				}
				else
				{
					actionResult = "Error";
					actionReport = "UnExpected Error Occurred";
					System.out.println(actionResult+" "+actionReport);
					rs.close();
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
			actionReport = "BranchName "+branchName.toUpperCase()+" Already Exist";
			System.out.println(actionResult+" "+actionReport);			
		}			
		branchBeanOB1.setActionResult(actionResult);
		branchBeanOB1.setActionReport(actionReport);
		return branchBeanOB1;
	}
	public List<BranchBean> viewBranch(List<BranchBean> branchBeanOB1)
	{
		searchQuery=branchBeanOB1.get(0).getSearchQuery();
		branchBeanOB1.clear();		
		try
		{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();			
			searchQuery1 = "select companyid,branchid,branchname,address1,address2,address3,address4,postalcode,city,state,country,status,createdby,creationdatetime from branches";
			searchQuery1 = searchQuery1.concat(searchQuery);			
			rs = stmt.executeQuery(searchQuery1);
			
			while(rs.next())
			{
				BranchBean branchBeanOB2 = new BranchBean();
				branchBeanOB2.setCompanyID(rs.getInt("companyid"));
				branchBeanOB2.setBranchID(rs.getInt("branchid"));
				branchBeanOB2.setBranchName(rs.getString("branchname"));
				branchBeanOB2.setAddress1(rs.getString("address1"));
				branchBeanOB2.setAddress2(rs.getString("address2"));
				branchBeanOB2.setAddress3(rs.getString("address3"));
				branchBeanOB2.setAddress4(rs.getString("address4"));
				branchBeanOB2.setPostalCode(rs.getString("postalCode"));
				branchBeanOB2.setCity(rs.getString("city"));
				branchBeanOB2.setState(rs.getString("state"));
				branchBeanOB2.setCountry(rs.getString("country"));
				branchBeanOB2.setBranchStatus(rs.getInt("status"));
				branchBeanOB2.setCreatedByUserID(rs.getInt("createdby"));
				branchBeanOB2.setCreationDateTime(rs.getString("creationdatetime"));				
				branchBeanOB1.add(branchBeanOB2);
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
		return branchBeanOB1;
	}
	public BranchBean editBranch(BranchBean branchBeanOB1)
	{
		branchID = branchBeanOB1.getBranchID();
		createdByUserID = branchBeanOB1.getCreatedByUserID();
		String newBranchName = branchBeanOB1.getBranchName();
		String oldBranchName = branchBeanOB1.getOldBranchName();
		String newAddress1 = branchBeanOB1.getAddress1();
		String oldAddress1 = branchBeanOB1.getOldAddress1();
		String newAddress2 = branchBeanOB1.getAddress2();
		String oldAddress2 = branchBeanOB1.getOldAddress2();
		String newAddress3 = branchBeanOB1.getAddress3();
		String oldAddress3 = branchBeanOB1.getOldAddress3();
		String newAddress4 = branchBeanOB1.getAddress4();
		String oldAddress4 = branchBeanOB1.getOldAddress4();
		String newPostalCode = branchBeanOB1.getPostalCode();
		String oldPostalCode = branchBeanOB1.getOldPostalCode();
		String newCity = branchBeanOB1.getCity();
		String oldCity = branchBeanOB1.getOldCity();
		String newState = branchBeanOB1.getState();
		String oldState = branchBeanOB1.getOldState();
		String newCountry = branchBeanOB1.getCountry();
		String oldCountry = branchBeanOB1.getOldCountry();
		int newStatus = branchBeanOB1.getBranchStatus();
		int oldStatus = branchBeanOB1.getOldBranchStatus();
		String updateQuery = "";
		String updateQuery1 = "";
		String description = "";
		String branchNameReport=null;
		String branchStatusReport=null;
		String userStatusReport=null;
		String roomStatusReport=null;
		
		try
		{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
			searchQuery = "select companyid from branches where branchid ='"+branchID+"'";		
			rs = stmt.executeQuery(searchQuery);
			rs.next();
			companyID = rs.getInt("companyid");
			rs.close();
			if(!newBranchName.equals(oldBranchName))
			{
				// Verifying Duplicate BranchName		
				CommonSearchBean commonSearchBeanOB1 = new CommonSearchBean();
				searchQuery = "select branchid from branches where branchname='"+newBranchName+"' and companyid='"+companyID+"'";
				commonSearchBeanOB1.setSearchQuery(searchQuery);
				CommonSearchDAO commonSearchDAOOB1 = new CommonSearchDAO();
				CommonSearchBean commonSearchBeanOB2 = commonSearchDAOOB1.findData(commonSearchBeanOB1);
				actionReport = commonSearchBeanOB2.getActionReport();
				commonSearchBeanOB1 = null;
				commonSearchBeanOB2 = null;
				commonSearchDAOOB1 = null;
				// Verifying Duplicate BranchName							
				if("NoData".equals(actionReport))
				{
					branchNameReport="Success";
					updateQuery = "BranchName='"+branchName+"'";
					description = "BranchName";
				}
				else
				{
					branchNameReport="Error";
					actionResult = "Error";
					actionReport = "BranchName "+branchName.toUpperCase()+" Already Exist";								
				}			
			}
			else
			{
				branchNameReport="Success";
			}						
			if(newStatus != oldStatus && "Success".equals(branchNameReport))
			{
				if( newStatus == 0 )
				{
					// Verifying Existing User Status		
					CommonSearchBean commonSearchBeanOB1 = new CommonSearchBean();
					searchQuery="select userid from users where branchid='"+branchID+"' and status='1'";
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
						branchStatusReport="Success";
						userStatusReport="Success";					
					
						// Verifying Existing User Status		
						commonSearchBeanOB1 = new CommonSearchBean();
						searchQuery="select roomid from rooms where branchid='"+branchID+"' and status='1'";
						commonSearchBeanOB1.setSearchQuery(searchQuery);
						commonSearchDAOOB1 = new CommonSearchDAO();
						commonSearchBeanOB2 = commonSearchDAOOB1.findData(commonSearchBeanOB1);
						actionReport = commonSearchBeanOB2.getActionReport();
						commonSearchBeanOB1 = null;
						commonSearchBeanOB2 = null;
						commonSearchDAOOB1 = null;
						// Verifying Existing Room Status
						if("NoData".equals(actionReport))
						{
							branchStatusReport="Success";
							roomStatusReport="Success";						
						}
						else
						{
							branchStatusReport="Error";
							roomStatusReport="Error";
						}
					}
					else
					{
						userStatusReport="Error";
						branchStatusReport="Error";
					}
				}
				else if( newStatus == 1 )
				{
					branchStatusReport="Success";
				}
				if("Error".equals(branchStatusReport))
				{				
					actionResult = "Error";
					if("Error".equals(userStatusReport))
					{
						actionReport = "One or More Users Are Still Active in this Branch";						
					}
					else if("Error".equals(roomStatusReport))
					{											
						actionReport = "One or More Rooms Are Still Active in this Branch";					
					}
				}
				else if("Success".equals(branchStatusReport))
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
				branchStatusReport="Success";
			}
			if("Success".equals(branchNameReport) && "Success".equals(branchStatusReport))
			{				
				if(!newAddress1.equals(oldAddress1))
				{
					if("".equals(updateQuery))
					{
						updateQuery = "address1='"+newAddress1+"'";					
					}
					else
					{
						updateQuery = updateQuery.concat(",address1='"+newAddress1+"'");
					}	
					if("".equals(description))
					{
						description = "Address1";				
					}
					else
					{
						description = description.concat(",Address1");
					}							
				}
				if(!newAddress2.equals(oldAddress2))
				{
					if("".equals(updateQuery))
					{
						updateQuery = "address2='"+newAddress2+"'";					
					}
					else
					{
						updateQuery = updateQuery.concat(",address2='"+newAddress2+"'");
					}	
					if("".equals(description))
					{
						description = "Address2";				
					}
					else
					{
						description = description.concat(",Address2");
					}							
				}
				if(!newAddress3.equals(oldAddress3))
				{
					if("".equals(updateQuery))
					{
						updateQuery = "address3='"+newAddress3+"'";					
					}
					else
					{
						updateQuery = updateQuery.concat(",address3='"+newAddress3+"'");
					}	
					if("".equals(description))
					{
						description = "Address3";				
					}
					else
					{
						description = description.concat(",Address3");
					}
				}
				if(!newAddress4.equals(oldAddress4))
				{
					if("".equals(updateQuery))
					{
						updateQuery = "address4='"+newAddress4+"'";					
					}
					else
					{
						updateQuery = updateQuery.concat(",address4='"+newAddress4+"'");
					}	
					if("".equals(description))
					{
						description = "Address4";				
					}
					else
					{
						description = description.concat(",Address4");
					}
				}
				if(!newPostalCode.equals(oldPostalCode))
				{
					if("".equals(updateQuery))
					{
						updateQuery = "postalCode='"+newPostalCode+"'";					
					}
					else
					{
						updateQuery = updateQuery.concat(",postalCode='"+newPostalCode+"'");
					}	
					if("".equals(description))
					{
						description = "PostalCode";				
					}
					else
					{
						description = description.concat(",PostalCode");
					}
				}
				if(!newCity.equals(oldCity))
				{				
					if("".equals(updateQuery))
					{
						updateQuery = "city='"+newCity+"'";					
					}
					else
					{
						updateQuery = updateQuery.concat(",city='"+newCity+"'");
					}	
					if("".equals(description))
					{
						description = "City";				
					}
					else
					{
						description = description.concat(",City");
					}
				}
				if(!newState.equals(oldState))
				{
					if("".equals(updateQuery))
					{
						updateQuery = "state='"+newState+"'";					
					}
					else
					{
						updateQuery = updateQuery.concat(",state='"+newState+"'");
					}	
					if("".equals(description))
					{
						description = "State";				
					}
					else
					{
						description = description.concat(",State");
					}
				}
				if(!newCountry.equals(oldCountry))
				{
					if("".equals(updateQuery))
					{
						updateQuery = "country='"+newCountry+"'";					
					}
					else
					{
						updateQuery = updateQuery.concat(",Country='"+newCountry+"'");
					}	
					if("".equals(description))
					{
						description = "Country";				
					}
					else
					{
						description = description.concat(",Country");
					}
				}				
				description = description.concat(" Modified");				
				updateQuery1="update branches set "+updateQuery+ " where branchid='"+branchID+"'";
				stmt.executeQuery(updateQuery1);				
				String searchQuery1 = "select branchname,address1,address2,address3,address4,postalcode,city,state,country,status from branches where branchid='"+branchID+"' and branchname='"+newBranchName+"' and address1='"+newAddress1+"' and address2='"+newAddress2+"' and address3='"+newAddress3+"' and address4='"+newAddress4+"' and postalcode='"+newPostalCode+"' and city='"+newCity+"' and state='"+newState+"' and country='"+newCountry+"' and status='"+newStatus+"'";				
				rs = stmt.executeQuery(searchQuery1);
				if(!rs.next())
				{
					actionResult = "Error";
					actionReport = "Unexpected Error While Updating Branch";
					System.out.print(actionReport);
					rs.close();
				}
				else
				{
					rs.close();
					insertQuery = "insert into branchlog(branchid,branchname,address1,address2,address3,address4,postalcode,city,state,country,status,modifiedby,modifydatetime,description) values('"+branchID+"','"+newBranchName+"','"+newAddress1+"','"+newAddress2+"','"+newAddress3+"','"+newAddress4+"','"+newPostalCode+"','"+newCity+"','"+newState+"','"+newCountry+"','"+newStatus+"','"+createdByUserID+"',(select to_char(current_timestamp,'DD-MM-YYYY HH24:MI:SS') from dual),'"+description+"')";				
					stmt.executeQuery(insertQuery);
					actionResult = "Success";
					actionReport = "Branch "+newBranchName.toUpperCase()+" Updated Successfully";
					System.out.print(actionReport);
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
		branchBeanOB1.setActionResult(actionResult);
		branchBeanOB1.setActionReport(actionReport);
		return branchBeanOB1;
	}
	public List<BranchBean> branchLog(List<BranchBean> branchBeanOB1)
	{		
		searchQuery = branchBeanOB1.get(0).getSearchQuery();
		
		branchBeanOB1.clear();		
		try
		{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();			
			searchQuery1 = "select branchname,address1,address2,address3,address4,postalcode,city,state,country,status,modifiedby,modifydatetime,description from branchlog";
			searchQuery1 = searchQuery1.concat(searchQuery);
			rs = stmt.executeQuery(searchQuery1);
			
			while(rs.next())
			{
				BranchBean branchBeanOB2 = new BranchBean();								
				branchBeanOB2.setBranchName(rs.getString("branchname"));
				branchBeanOB2.setAddress1(rs.getString("address1"));
				branchBeanOB2.setAddress2(rs.getString("address2"));
				branchBeanOB2.setAddress3(rs.getString("address3"));
				branchBeanOB2.setAddress4(rs.getString("address4"));
				branchBeanOB2.setPostalCode(rs.getString("postalcode"));
				branchBeanOB2.setCity(rs.getString("city"));
				branchBeanOB2.setState(rs.getString("state"));
				branchBeanOB2.setCountry(rs.getString("country"));
				branchBeanOB2.setBranchStatus(rs.getInt("status"));
				branchBeanOB2.setCreatedByUserID(rs.getInt("modifiedby"));
				branchBeanOB2.setCreationDateTime(rs.getString("modifydatetime"));				
				branchBeanOB2.setDescription(rs.getString("description"));
				branchBeanOB1.add(branchBeanOB2);
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
		return branchBeanOB1;
	}
}