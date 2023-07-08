//Write Package Name Always Above
package com;         

import java.sql.*;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.table.DefaultTableModel;


public class StudentDB {
   
    public boolean validateLogin(String email,String password){
        try{
            Class.forName("com.mysql.jdbc.Driver");
            Connection cn= DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube","root","");
            PreparedStatement ls=cn.prepareStatement("Select * from users  where EMAIL=? and PASSWORD=? ");
            
            ls.setString(1,email);
            ls.setString(2,password);
            
            ResultSet rs = ls.executeQuery();
            boolean temp = rs.next();
            ls.close();
            
            return temp;
        }catch(Exception e){
            e.printStackTrace();
        }
        return false;
    }
    public boolean validateInsert(String password,String name,String email){
        try{
            Class.forName("com.mysql.jdbc.Driver");
            Connection cn= DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube","root","");
            PreparedStatement ls=cn.prepareStatement("Insert into users (name,email,password) values (?,?,?) ");
            
            ls.setString(1,name);
            ls.setString(2,email);
            ls.setString(3,password);
            
            int rs = ls.executeUpdate();
            
            /*ResultSet rs= ls.executeQuery();
            boolean temp=rs.next();*/
            ls.close();
            
            if(rs>0){
                return true;
            }else{
                return false;
            }
            
            //return temp;
        }catch(Exception e){
            e.printStackTrace();
        }
        return false;
    }
}
