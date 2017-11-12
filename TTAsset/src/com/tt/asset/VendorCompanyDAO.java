package com.tt.asset;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;


public class VendorCompanyDAO 
{
	Connection con;
	Statement stmt;
	ResultSet rs;
	
	String searchQuery;
	String searchQuery1;
	String insertQuery;
	
	private int companyID;
	private int vendorCompanyID;
	private int createdByUserID;
	private String vendorCompanyName;
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
	public VendorCompanyBean newVendorCompany(VendorCompanyBean vendorCompanyBeanOB1)
	{
		
		companyID = vendorCompanyBeanOB1.getCompanyID();			
		createdByUserID = vendorCompanyBeanOB1.getCreatedByUserID();
		vendorCompanyName = vendorCompanyBeanOB1.getVendorCompanyName();
		address1 = vendorCompanyBeanOB1.getAddress1();
		address2 = vendorCompanyBeanOB1.getAddress2();
		address3 = vendorCompanyBeanOB1.getAddress3();
		address4 = vendorCompanyBeanOB1.getAddress4();
		postalCode = vendorCompanyBeanOB1.getPostalCode();
		city = vendorCompanyBeanOB1.getCity();
		state = vendorCompanyBeanOB1.getState();
		country = vendorCompanyBeanOB1.getCountry();
		CommonSearchBean commonSearchBeanOB1 = new CommonSearchBean();
		searchQuery = "select vendorcompanyid from vendorcompanies where vendorcompanyname='"+vendorCompanyName+"' and companyid='"+companyID+"'";
		commonSearchBeanOB1.setSearchQuery(searchQuery);
		CommonSearchDAO commonSearchDAOOB1 = new CommonSearchDAO();
		CommonSearchBean commonSearchBeanOB2 = commonSearchDAOOB1.findData(commonSearchBeanOB1);
		actionReport = commonSearchBeanOB2.getActionReport();
		commonSearchBeanOB1 = null;
		commonSearchBeanOB2 = null;
		commonSearchDAOOB1 = null;
		// Verifying Duplicate VendorCompany Name
		
		if("NoData".equals(actionReport))
		{
			try
			{
				con = ConnectionManager.getConnection();
				stmt = con.createStatement();
				insertQuery = "insert into vendorCompanies(vendorCompanyid,vendorCompanyname,companyid,address1,address2,address3,address4,postalcode,city,state,country,status,createdby,creationdatetime) values(vendorCompanyid.nextval,'"+vendorCompanyName+"','"+companyID+"','"+address1+"','"+address2+"','"+address3+"','"+address4+"','"+postalCode+"','"+city+"','"+state+"','"+country+"','1','"+createdByUserID+"',(select to_char(current_timestamp,'DD-MM-YYYY HH24:MI:SS') from dual))";
				rs = stmt.executeQuery(insertQuery);
				rs.close();
				
				// Verifying Newly Added Company Name Exist
				searchQuery = "select vendorCompanyid from vendorCompanies where vendorCompanyname='"+vendorCompanyName+"' and companyid='"+companyID+"'";
				rs = stmt.executeQuery(searchQuery);
				// Verifying Newly Added Company Name Exist
				
				if(rs.next())
				{	
					int vendorCompanyid = rs.getInt("vendorCompanyid"); 
					insertQuery = "insert into vendorCompanylog(vendorCompanyid,vendorCompanyname,address1,address2,address3,address4,postalcode,city,state,country,status,modifiedby,modifydatetime,description) values('"+vendorCompanyid+"','"+vendorCompanyName+"','"+address1+"','"+address2+"','"+address3+"','"+address4+"','"+postalCode+"','"+city+"','"+state+"','"+country+"','1','"+createdByUserID+"',(select to_char(current_timestamp,'DD-MM-YYYY HH24:MI:SS') from dual),'newly created')";
					stmt.executeQuery(insertQuery);
					actionResult = "Success";
					actionReport = "VendorCompany "+vendorCompanyName.toUpperCase()+" Created Successfully";
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
			actionReport = "VendorCompany "+vendorCompanyName.toUpperCase()+" Already Exist";
			System.out.println(actionResult+" "+actionReport);			
		}			
		vendorCompanyBeanOB1.setActionResult(actionResult);
		vendorCompanyBeanOB1.setActionReport(actionReport);		
		return vendorCompanyBeanOB1;
	}
	public List<VendorCompanyBean> viewVendorCompany(List<VendorCompanyBean> vendorCompanyBeanOB1)
	{
		searchQuery=vendorCompanyBeanOB1.get(0).getSearchQuery();
		vendorCompanyBeanOB1.clear();		
		try
		{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();			
			searchQuery1 = "select companyid,vendorCompanyid,vendorCompanyname,address1,address2,address3,address4,postalcode,city,state,country,status,createdby,creationdatetime from vendorCompanies";
			searchQuery1 = searchQuery1.concat(searchQuery);			
			rs = stmt.executeQuery(searchQuery1);
			
			while(rs.next())
			{
				VendorCompanyBean vendorCompanyBeanOB2 = new VendorCompanyBean();
				vendorCompanyBeanOB2.setCompanyID(rs.getInt("companyid"));
				vendorCompanyBeanOB2.setVendorCompanyID(rs.getInt("vendorCompanyid"));
				vendorCompanyBeanOB2.setVendorCompanyName(rs.getString("vendorCompanyname"));
				vendorCompanyBeanOB2.setAddress1(rs.getString("address1"));
				vendorCompanyBeanOB2.setAddress2(rs.getString("address2"));
				vendorCompanyBeanOB2.setAddress3(rs.getString("address3"));
				vendorCompanyBeanOB2.setAddress4(rs.getString("address4"));
				vendorCompanyBeanOB2.setPostalCode(rs.getString("postalCode"));
				vendorCompanyBeanOB2.setCity(rs.getString("city"));
				vendorCompanyBeanOB2.setState(rs.getString("state"));
				vendorCompanyBeanOB2.setCountry(rs.getString("country"));
				vendorCompanyBeanOB2.setVendorCompanyStatus(rs.getInt("status"));
				vendorCompanyBeanOB2.setCreatedByUserID(rs.getInt("createdby"));
				vendorCompanyBeanOB2.setCreationDateTime(rs.getString("creationdatetime"));
				vendorCompanyBeanOB1.add(vendorCompanyBeanOB2);
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
		return vendorCompanyBeanOB1;
	}
	public VendorCompanyBean editVendorCompany(VendorCompanyBean vendorCompanyBeanOB1)
	{
		vendorCompanyID = vendorCompanyBeanOB1.getVendorCompanyID();
		createdByUserID = vendorCompanyBeanOB1.getCreatedByUserID();
		String newVendorCompanyName = vendorCompanyBeanOB1.getVendorCompanyName();
		String oldVendorCompanyName = vendorCompanyBeanOB1.getOldVendorCompanyName();
		String newAddress1 = vendorCompanyBeanOB1.getAddress1();
		String oldAddress1 = vendorCompanyBeanOB1.getOldAddress1();
		String newAddress2 = vendorCompanyBeanOB1.getAddress2();
		String oldAddress2 = vendorCompanyBeanOB1.getOldAddress2();
		String newAddress3 = vendorCompanyBeanOB1.getAddress3();
		String oldAddress3 = vendorCompanyBeanOB1.getOldAddress3();
		String newAddress4 = vendorCompanyBeanOB1.getAddress4();
		String oldAddress4 = vendorCompanyBeanOB1.getOldAddress4();
		String newPostalCode = vendorCompanyBeanOB1.getPostalCode();
		String oldPostalCode = vendorCompanyBeanOB1.getOldPostalCode();
		String newCity = vendorCompanyBeanOB1.getCity();
		String oldCity = vendorCompanyBeanOB1.getOldCity();
		String newState = vendorCompanyBeanOB1.getState();
		String oldState = vendorCompanyBeanOB1.getOldState();
		String newCountry = vendorCompanyBeanOB1.getCountry();
		String oldCountry = vendorCompanyBeanOB1.getOldCountry();
		int newStatus = vendorCompanyBeanOB1.getVendorCompanyStatus();
		int oldStatus = vendorCompanyBeanOB1.getOldVendorCompanyStatus();
		String updateQuery = "";
		String updateQuery1 = "";
		String description = "";
		String vendorCompanyNameReport=null;
		String vendorCompanyStatusReport=null;
		String userStatusReport=null;		
		
		try
		{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
			searchQuery = "select companyid from vendorCompanies where vendorCompanyid ='"+vendorCompanyID+"'";		
			rs = stmt.executeQuery(searchQuery);
			rs.next();
			companyID = rs.getInt("companyid");
			rs.close();
			if(!newVendorCompanyName.equals(oldVendorCompanyName))
			{
				// Verifying Duplicate VendorCompanyName		
				CommonSearchBean commonSearchBeanOB1 = new CommonSearchBean();
				searchQuery = "select vendorCompanyid from vendorCompanies where vendorCompanyname='"+newVendorCompanyName+"' and companyid='"+companyID+"'";
				commonSearchBeanOB1.setSearchQuery(searchQuery);
				CommonSearchDAO commonSearchDAOOB1 = new CommonSearchDAO();
				CommonSearchBean commonSearchBeanOB2 = commonSearchDAOOB1.findData(commonSearchBeanOB1);
				actionReport = commonSearchBeanOB2.getActionReport();
				commonSearchBeanOB1 = null;
				commonSearchBeanOB2 = null;
				commonSearchDAOOB1 = null;
				// Verifying Duplicate VendorCompanyName							
				if("NoData".equals(actionReport))
				{
					vendorCompanyNameReport="Success";
					updateQuery = "VendorCompanyName='"+newVendorCompanyName+"'";
					description = "VendorCompanyName";
				}
				else
				{
					vendorCompanyNameReport="Error";
					actionResult = "Error";
					actionReport = "VendorCompanyName "+newVendorCompanyName.toUpperCase()+" Already Exist";								
				}			
			}
			else
			{
				vendorCompanyNameReport="Success";
			}						
			if(newStatus != oldStatus && "Success".equals(vendorCompanyNameReport))
			{
				if( newStatus == 0 )
				{
					// Verifying Existing User Status		
					CommonSearchBean commonSearchBeanOB1 = new CommonSearchBean();
					searchQuery="select userid from users where vendorCompanyid='"+vendorCompanyID+"' and status='1'";
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
						vendorCompanyStatusReport="Success";
						userStatusReport="Error";
					}
					else
					{
						userStatusReport="Error";
						vendorCompanyStatusReport="Error";
					}
				}
				else if( newStatus == 1 )
				{
					vendorCompanyStatusReport="Success";
				}
				if("Error".equals(vendorCompanyStatusReport))
				{				
					actionResult = "Error";
					if("Error".equals(userStatusReport))
					{
						actionReport = "One or More Users Are Still Active in this VendorCompany";						
					}					
				}
				else if("Success".equals(vendorCompanyStatusReport))
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
				vendorCompanyStatusReport="Success";
			}
			if("Success".equals(vendorCompanyNameReport) && "Success".equals(vendorCompanyStatusReport))
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
				updateQuery1="update vendorCompanies set "+updateQuery+ " where vendorCompanyid='"+vendorCompanyID+"'";				
				stmt.executeQuery(updateQuery1);				
				String searchQuery1 = "select vendorCompanyname,address1,address2,address3,address4,postalcode,city,state,country,status from vendorCompanies where vendorCompanyid='"+vendorCompanyID+"' and vendorCompanyname='"+newVendorCompanyName+"' and address1='"+newAddress1+"' and address2='"+newAddress2+"' and address3='"+newAddress3+"' and address4='"+newAddress4+"' and postalcode='"+newPostalCode+"' and city='"+newCity+"' and state='"+newState+"' and country='"+newCountry+"' and status='"+newStatus+"'";				
				rs = stmt.executeQuery(searchQuery1);
				if(!rs.next())
				{
					actionResult = "Error";
					actionReport = "Unexpected Error While Updating VendorCompany";
					System.out.print(actionReport);
					rs.close();
				}
				else
				{
					rs.close();
					insertQuery = "insert into vendorCompanylog(vendorCompanyid,vendorCompanyname,address1,address2,address3,address4,postalcode,city,state,country,status,modifiedby,modifydatetime,description) values('"+vendorCompanyID+"','"+newVendorCompanyName+"','"+newAddress1+"','"+newAddress2+"','"+newAddress3+"','"+newAddress4+"','"+newPostalCode+"','"+newCity+"','"+newState+"','"+newCountry+"','"+newStatus+"','"+createdByUserID+"',(select to_char(current_timestamp,'DD-MM-YYYY HH24:MI:SS') from dual),'"+description+"')";				
					stmt.executeQuery(insertQuery);
					actionResult = "Success";
					actionReport = "VendorCompany "+newVendorCompanyName.toUpperCase()+" Updated Successfully";
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
		vendorCompanyBeanOB1.setActionResult(actionResult);
		vendorCompanyBeanOB1.setActionReport(actionReport);
		return vendorCompanyBeanOB1;
	}
	public List<VendorCompanyBean> vendorCompanyLog(List<VendorCompanyBean> vendorCompanyBeanOB1)
	{		
		searchQuery = vendorCompanyBeanOB1.get(0).getSearchQuery();
		
		vendorCompanyBeanOB1.clear();		
		try
		{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();			
			searchQuery1 = "select vendorCompanyname,address1,address2,address3,address4,postalcode,city,state,country,status,modifiedby,modifydatetime,description from vendorCompanylog";
			searchQuery1 = searchQuery1.concat(searchQuery);
			rs = stmt.executeQuery(searchQuery1);
			
			while(rs.next())
			{
				VendorCompanyBean vendorCompanyBeanOB2 = new VendorCompanyBean();								
				vendorCompanyBeanOB2.setVendorCompanyName(rs.getString("vendorCompanyname"));
				vendorCompanyBeanOB2.setAddress1(rs.getString("address1"));
				vendorCompanyBeanOB2.setAddress2(rs.getString("address2"));
				vendorCompanyBeanOB2.setAddress3(rs.getString("address3"));
				vendorCompanyBeanOB2.setAddress4(rs.getString("address4"));
				vendorCompanyBeanOB2.setPostalCode(rs.getString("postalcode"));
				vendorCompanyBeanOB2.setCity(rs.getString("city"));
				vendorCompanyBeanOB2.setState(rs.getString("state"));
				vendorCompanyBeanOB2.setCountry(rs.getString("country"));
				vendorCompanyBeanOB2.setVendorCompanyStatus(rs.getInt("status"));
				vendorCompanyBeanOB2.setCreatedByUserID(rs.getInt("modifiedby"));
				vendorCompanyBeanOB2.setCreationDateTime(rs.getString("modifydatetime"));
				vendorCompanyBeanOB2.setDescription(rs.getString("description"));
				vendorCompanyBeanOB1.add(vendorCompanyBeanOB2);
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
		return vendorCompanyBeanOB1;
	}
}