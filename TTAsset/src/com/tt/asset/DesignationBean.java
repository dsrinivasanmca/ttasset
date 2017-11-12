package com.tt.asset;

import java.util.Date;

public class DesignationBean 
{
	private int companyID;	
	private int designationID;
	private String designationName;
	private String oldDesignationName;
	private int createdByUserID;	
	private String creationDateTime;
	private int designationStatus;
	private int oldDesignationStatus;
	private String description;
	private String actionResult;
	private String actionReport;
	private String searchQuery;
	public void setCompanyID(int newCompanyID)
	{
		companyID = newCompanyID;	
	}
	public void setDesignationID(int newDepartmetnID)
	{
		designationID = newDepartmetnID; 
	}
	public int getDesignationID()
	{
		return designationID; 
	}
	public void setDesignationName(String newDesignationName)
	{
		designationName = newDesignationName;
	}
	public void setOldDesignationName(String newOldDesignationName)
	{
		oldDesignationName = newOldDesignationName;
	}
	public int getCompanyID()
	{
		return companyID;
	}
	public String getDesignationName()
	{
		return designationName;
	}
	public String getOldDesignationName()
	{
		return oldDesignationName;
	}
	public void setCreatedByUserID(int newCreatedByUserID)
	{
		createdByUserID = newCreatedByUserID;
	}
	public int getCreatedByUserID()
	{
		return createdByUserID;
	}
	public void setCreationDateTime(String newCreationDateTime)
	{
		creationDateTime = newCreationDateTime;		
	}
	public String getCreationDateTime()
	{
		return creationDateTime;
	}
	public void setDesignationStatus(int newDesignationStatus)
	{
		designationStatus = newDesignationStatus;
	}
	public int getDesignationStatus()
	{
		return designationStatus;
	}
	public void setOldDesignationStatus(int newOldDesignationStatus)
	{
		oldDesignationStatus = newOldDesignationStatus;
	}
	public int getOldDesignationStatus()
	{
		return oldDesignationStatus;
	}
	public void setDescription(String newDescription)
	{
		description = newDescription;
	}
	public String getDescription()
	{
		return description;
	}
	public void setActionResult(String newActionResult)
	{
		actionResult = newActionResult;
	}
	public String getActionResult()
	{
		return actionResult;
	}
	public void setActionReport(String newActionReport)
	{
		actionReport = newActionReport;
	}
	public String getActionReport()
	{
		return actionReport;
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
