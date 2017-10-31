package com.tt.asset;

public class UserTypeBean 
{
	String userType;
	String description;
	String searchQuery;
	
	public void setUserType(String newUserType)
	{
		userType=newUserType;
	}
	public String getUserType()
	{
		return userType;
	}
	public void setDescription(String newDescription)
	{
		description = newDescription;
	}
	public String getDescription()
	{
		return description;
	}
	public void setSearchQuery(String newSearchQuery)
	{
		searchQuery = newSearchQuery;	
	}
	public String getSearchQuery()
	{
		return searchQuery;		
	}
}
