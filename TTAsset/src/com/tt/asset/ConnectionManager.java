package com.tt.asset;

import java.sql.*;

//import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class ConnectionManager 
{
	static Connection con;
	static String url;
	         
	   public static Connection getConnection()
	   {
		  try
		  {
			  	//Context initContext = new InitialContext();
	            //Context envContext = (Context) initContext.lookup("java:comp/env/");
	            //DataSource ds = (DataSource) envContext.lookup("Connect2DB");
	            //con = ds.getConnection();
	            	          			  			  
			  	//Context initContext = new InitialContext();
	            //DataSource ds = (DataSource) initContext.lookup("java:comp/env/jdbc/connect2DB");
	            //con = ds.getConnection();
			  
			  	/*InitialContext context = new InitialContext();
	            DataSource dataSource = (DataSource) context.lookup("jdbc/Connect2DB");
	            if (dataSource != null) 
	            {
	            	con = dataSource.getConnection();
	            }
	            else 
	            {
	                System.out.println("Failed to lookup datasource jdbc/Connect2DB");
	            }*/
	            
			  			    	     
			  
		        Class.forName("oracle.jdbc.driver.OracleDriver");
		        //con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","srinivasan","password");
		        con = DriverManager.getConnection("jdbc:oracle:thin:@192.168.223.4:1521:oracle","srinivasan","password");
		  }
		  catch(ClassNotFoundException e)
		  {		  
			  e.printStackTrace();
		  }
		  
		  /*catch (NamingException e)
	      {
	         e.printStackTrace();
	         System.out.println(e);
	      }*/
	      
		  catch (SQLException e)
	      {
	         e.printStackTrace();
	         System.out.println(e);
	      }
	   return con;
	   }
}