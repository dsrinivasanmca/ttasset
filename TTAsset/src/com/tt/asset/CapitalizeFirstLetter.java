package com.tt.asset;

public class CapitalizeFirstLetter 
{
	public String capitalizeName(String name) 
	{
	    String fullName = "";
	    if (name != null)
	    {
	    	String inputName = name.replaceAll("( +)"," ").trim();
	    	String names[] = inputName.trim().split(" ");
	    	for (String n: names) 
	    	{
	    		fullName = fullName + n.substring(0, 1).toUpperCase() + n.toLowerCase().substring(1, n.length()) + " ";
	    	}
	    }
	    else
	    {
	    	fullName = name;
	    }
	    return fullName;
	}
}
