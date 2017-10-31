package com.tt.asset;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;


public class UserTypeDAO 
{
	Connection con;
	Statement stmt;
	ResultSet rs;
		
	String searchQuery;
	String searchQuery1;
	public List<UserTypeBean> viewUserType(List<UserTypeBean> userTypeBeanOB1)
	{		
		searchQuery = userTypeBeanOB1.get(0).getSearchQuery();
		userTypeBeanOB1.clear();
		try
		{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();		
			searchQuery1="select usertype,description from usertypes";
			searchQuery1=searchQuery1.concat(searchQuery);
			rs = stmt.executeQuery(searchQuery1);
			while (rs.next())
			{
				UserTypeBean userTypeBeanOB2 = new UserTypeBean();
				userTypeBeanOB2.setUserType(rs.getString("usertype"));
				userTypeBeanOB2.setDescription(rs.getString("description"));
				userTypeBeanOB1.add(userTypeBeanOB2);
				userTypeBeanOB2 = null;
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
		return userTypeBeanOB1;
	}	
}
