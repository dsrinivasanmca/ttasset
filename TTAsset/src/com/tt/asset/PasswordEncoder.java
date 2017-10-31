package com.tt.asset;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class PasswordEncoder 
{
    
     public String encodePassword(String passwordToHash)
     {
             String generatedPassword = null;
             String salt="TeknoTurf";
             try
             {
                     MessageDigest md = MessageDigest.getInstance("SHA-1");
                     md.update(salt.getBytes());
                     byte[] bytes = md.digest(passwordToHash.getBytes());
                     StringBuilder sb = new StringBuilder();
                     for(int i=0; i< bytes.length ;i++)
                     {
                             sb.append(Integer.toString((bytes[i] & 0xff) + 0x100, 16).substring(1));
                     }
                     generatedPassword = sb.toString();
             }
             catch (NoSuchAlgorithmException e)
             {
                     e.printStackTrace();
             }             
             return generatedPassword;
     }
}
