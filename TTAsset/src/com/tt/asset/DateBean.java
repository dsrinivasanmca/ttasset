package com.tt.asset;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateBean 
{
	private String todayDate;
	private Date dateFormat1;
	private String dateFormat2;
	public String getTodayDate()
	{			    	
		Date date = new Date();	
		DateFormat dateFormate = new SimpleDateFormat("dd-MM-yyyy");
		todayDate=dateFormate.format(date);
		return todayDate;
	}
	public void setDateFormat1(Date newDateFormat1)
	{
		dateFormat1 = newDateFormat1;
	}
	public String getDateFormat2()
	{
		DateFormat dateFormate = new SimpleDateFormat("dd-MM-yyyy");
		dateFormat2=dateFormate.format(dateFormat1);		
		return dateFormat2;
	}
}
