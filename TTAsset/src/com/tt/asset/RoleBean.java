package com.tt.asset;

public class RoleBean 
{
	String roleName;
	String description;
	String searchQuery;
	
	public void setRoleName(String newRoleName)
	{
		roleName=newRoleName;
	}
	public String getRoleName()
	{
		return roleName;
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
