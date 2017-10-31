package com.tt.asset;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;


public class RoleDAO 
{
	Connection con;
	Statement stmt;
	ResultSet rs;
		
	String searchQuery;
	String searchQuery1;
	public List<RoleBean> viewRole(List<RoleBean> roleBeanOB1)
	{		
		searchQuery = roleBeanOB1.get(0).getSearchQuery();
		roleBeanOB1.clear();
		try
		{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();		
			searchQuery1="select rolename,description from roles";
			searchQuery1=searchQuery1.concat(searchQuery);
			rs = stmt.executeQuery(searchQuery1);
			while (rs.next())
			{
				RoleBean roleBeanOB2 = new RoleBean();
				roleBeanOB2.setRoleName(rs.getString("rolename"));
				roleBeanOB2.setDescription(rs.getString("description"));
				roleBeanOB1.add(roleBeanOB2);
				roleBeanOB2 = null;
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
		return roleBeanOB1;
	}
}
