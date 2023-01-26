/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mvc.controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.time.LocalDateTime;

/**
 *
 * @author samoo
 */
public class dbconnection {
    public static Statement statement() throws SQLException{
        Statement statement;
        statement = connectDB().createStatement();
        return statement;
    }
    
    public static Connection connectDB() throws SQLException{
        Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/budgetManagementDB","budgetManager","user@123");
        return connection;
    }
    
    public static void updateLogsTable(String username, String description, String type, String message) throws SQLException{
        
        String query = "INSERT INTO USER_LOGS (USER_ID ,DESCRIPTION, UPDATED_AT, TYPE, MESSAGE) VALUES "
            + "((SELECT user_id FROM USERS WHERE username = ?),?,?,?,?)";
        LocalDateTime currentDate = LocalDateTime.now();
        Timestamp timestamp = Timestamp.valueOf(currentDate);
        PreparedStatement statement = dbconnection.connectDB().prepareStatement(query);
        statement.setString(1,username);
        statement.setString(2, description);
        statement.setTimestamp(3,timestamp);
        statement.setString(4, type);
        statement.setString(5, message);
        statement.executeUpdate();    
    }

    public static String getCountryDetail(String country_name, String detail) throws SQLException{
        String info = "";
        String query = "SELECT "+detail+", COUNTRY_NAME FROM COUNTRIES";
        ResultSet resultSet = dbconnection.statement().executeQuery(query);
        while (resultSet.next()){
            if (resultSet.getObject(2).toString().equals(country_name)){
                try {
                    info = (String) resultSet.getObject(1).toString();
                    return info;
                } catch (SQLException e){

                }                
            }

        }
        
        
        return info;
    }
    
    public static void updateUserDetails(String username, String first_name, String last_name, String email, Timestamp dateOfBirth, int phoneNumber, String countryName, String address, String gender, boolean tfa) throws SQLException{
        String query = "UPDATE USERS SET FIRST_NAME = ?, LAST_NAME = ?, EMAIL = ?, DATE_OF_BIRTH = ?, PHONE_NUMBER = ?, COUNTRY_ID = ?, ADDRESS = ?, GENDER = ?, TWO_FACTOR_AUTHENTICATION = ? WHERE USERNAME = ?";
        PreparedStatement statement = dbconnection.connectDB().prepareStatement(query);
        statement.setString(1, first_name);
        statement.setString(2, last_name);
        statement.setString(3, email);
        statement.setTimestamp(4, dateOfBirth);
        statement.setInt(5, phoneNumber);
        statement.setInt(6, Integer.parseInt(getCountryDetail(countryName, "COUNTRY_ID")));
        statement.setString(7, address);
        statement.setString(8, gender);
        statement.setBoolean(9, tfa);
        statement.setString(10, username);
        statement.executeUpdate();
    }


}
