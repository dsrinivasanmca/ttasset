package com.tt.asset;

import java.util.Date;

public class DepartmentBean 
{	
	private int companyID;
	private int departmentID;
	private String departmentName;
	private String oldDepartmentName;
	private int createdByUserID;	
	private Date creationDate;
	private Date creationTime;
	private int departmentStatus;
	private int oldDepartmentStatus;
	private String description;
	private String actionResult;
	private String actionReport;
	private String searchQuery;	
	public void setCompanyID(int newCompanyID)
	{
		companyID = newCompanyID;	
	}	
	public void setDepartmentID(int newDepartmetnID)
	{
		departmentID = newDepartmetnID; 
	}
	public int getDepartmentID()
	{
		return departmentID; 
	}
	public void setDepartmentName(String newDepartmentName)
	{
		departmentName = newDepartmentName;
	}
	public void setOldDepartmentName(String newOldDepartmentName)
	{
		oldDepartmentName = newOldDepartmentName;
	}	
	public int getCompanyID()
	{
		return companyID;
	}	
	public String getDepartmentName()
	{
		return departmentName;
	}
	public String getOldDepartmentName()
	{
		return oldDepartmentName;
	}
	public void setCreatedByUserID(int newCreatedByUserID)
	{
		createdByUserID = newCreatedByUserID;
	}
	public int getCreatedByUserID()
	{
		return createdByUserID;
	}
	public void setCreationDate(Date newCreationDate)
	{
		creationDate = newCreationDate;		
	}
	public void setCreationTime(Date newCreationTime)
	{
		creationTime = newCreationTime;		
	}
	public Date getCreationDate()
	{
		return creationDate;
	}
	public Date getCreationTime()
	{
		return creationTime;
	}
	public void setDepartmentStatus(int newDepartmentStatus)
	{
		departmentStatus = newDepartmentStatus;
	}
	public int getDepartmentStatus()
	{
		return departmentStatus;
	}
	public void setOldDepartmentStatus(int newOldDepartmentStatus)
	{
		oldDepartmentStatus = newOldDepartmentStatus;
	}
	public int getOldDepartmentStatus()
	{
		return oldDepartmentStatus;
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