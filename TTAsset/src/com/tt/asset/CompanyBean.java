package com.tt.asset;

import java.util.Date;

public class CompanyBean 
{
	private int companyID;
	private String companyName;
	private String oldCompanyName;
	private Date openingDate;
	private Date oldOpeningDate;
	private String actionResult;
	private String actionReport;
	private int companyStatus;
	private int oldCompanyStatus;
	private int createdByUserID;
	private Date creationDate;
	private Date creationTime;
	private String description;
	private String searchQuery;	
			
	public void setCompanyID(int newCompanyID)
	{
		companyID = newCompanyID;
	}
	public int getCompanyID()
	{
		return companyID;
	}
	public void setCompanyName(String newCompanyName)
	{
		companyName = newCompanyName;
	}
	public String getCompanyName()
	{
		return companyName;
	}
	public void setOldCompanyName(String OldCompanyName)
	{
		oldCompanyName = OldCompanyName;
	}
	public String getOldCompanyName()
	{
		return oldCompanyName;
	}
	public void setOldOpeningDate(Date OldOpeningDate)
	{
		oldOpeningDate = OldOpeningDate;
	}
	public Date getOldOpeningDate()
	{
		return oldOpeningDate;
	}
	public void setOpeningDate(Date newOpeningDate)
	{
		openingDate = newOpeningDate;
	}
	public Date getOpeningDate()
	{
		return openingDate;
	}
	public void setCompanyStatus(int newCompanyStatus)
	{
		companyStatus = newCompanyStatus;
	}
	public int getCompanyStatus()
	{
		return companyStatus;
	}
	public void setOldCompanyStatus(int OldCompanyStatus)
	{
		oldCompanyStatus = OldCompanyStatus;
	}
	public int getOldCompanyStatus()
	{
		return oldCompanyStatus;
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
