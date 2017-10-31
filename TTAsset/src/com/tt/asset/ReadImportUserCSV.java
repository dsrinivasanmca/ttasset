package com.tt.asset;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class ReadImportUserCSV 
{
	//Delimiters used in the CSV file
    private static final String COMMA_DELIMITER = ",";
    
    public List<ImportUserBean> readInputCSV(File importUserCSVFile)
    {
        BufferedReader br = null;
        
        //Create List for holding Employee objects
        List<ImportUserBean> importUserBeanOB1 = new ArrayList<ImportUserBean>();
        try
        {
            //Reading the csv file
            br = new BufferedReader(new FileReader(importUserCSVFile));
            
                                    
            String line = "";
            //Read to skip the header
            br.readLine();
            //Reading from the second line
            while ((line = br.readLine()) != null) 
            {
                String[] importUserColumn = line.split(COMMA_DELIMITER);
                
                if(importUserColumn.length > 0 )
                {
                    //Save the employee details in Employee object
                	ImportUserBean importUserBeanOB2 = new ImportUserBean();
                	importUserBeanOB2.setUserType(importUserColumn[0]);
                	importUserBeanOB2.setUserCompanyName(importUserColumn[1]);
    				importUserBeanOB2.setUserVendorCompanyName(importUserColumn[2]);				
    				importUserBeanOB2.setUserBranchName(importUserColumn[3]);
    				importUserBeanOB2.setUserEmployeeID(importUserColumn[4]);
    				importUserBeanOB2.setUserPassword(importUserColumn[5]);
    				importUserBeanOB2.setUserConfirmPassword(importUserColumn[6]);
    				importUserBeanOB2.setUserFirstName(importUserColumn[7]);
    				importUserBeanOB2.setUserLastName(importUserColumn[8]);
    				importUserBeanOB2.setUserMobileNo(importUserColumn[9]);
    				importUserBeanOB2.setUserEmailID(importUserColumn[10]);    				
    				importUserBeanOB2.setUserJoiningDate(importUserColumn[11]);
    				importUserBeanOB2.setUserRole(importUserColumn[12]);
    				importUserBeanOB2.setUserDepartmentName(importUserColumn[13]);
    				importUserBeanOB2.setUserDesignationName(importUserColumn[14]);    				    				    				    				    				   
    				importUserBeanOB2.setUserGender(importUserColumn[15]);    				
    				importUserBeanOB1.add(importUserBeanOB2);
                }
            }                                 
        }
        catch(Exception ee)
        {
            ee.printStackTrace();
        }
        finally
        {
            try
            {
                br.close();
            }
            catch(IOException ie)
            {
                System.out.println("Error occured while closing the BufferedReader");
                ie.printStackTrace();
            }
        }        
		return importUserBeanOB1;
    }
}
