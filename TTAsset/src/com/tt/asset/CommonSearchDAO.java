package com.tt.asset;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


public class CommonSearchDAO 
{
	Connection con;
	Statement stmt;
	ResultSet rs;
	private String searchQuery;
	private String actionResult;
	public CommonSearchBean findData(CommonSearchBean commonSearchBeanOB1)
	{
		searchQuery = commonSearchBeanOB1.getSearchQuery();
		try
		{
			con = ConnectionManager.getConnection();
			stmt =con.createStatement();
			rs = stmt.executeQuery(searchQuery);
			if(rs.next())
			{
				actionResult = "DataExist";
			}
			else
			{
				actionResult = "NoData";
			}
			commonSearchBeanOB1.setActionReport(actionResult);
		}
		catch (SQLException e)
	    {
	        e.printStackTrace();
	    }
		return commonSearchBeanOB1;
	}
}