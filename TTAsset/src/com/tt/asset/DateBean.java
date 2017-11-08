package com.tt.asset;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateBean 
{
	private String todayDate;	
	public String getTodayDate()
	{			    	
		Date date = new Date();	
		DateFormat dateFormate = new SimpleDateFormat("dd-MM-yyyy");
		todayDate=dateFormate.format(date);
		return todayDate;
	}	
}
