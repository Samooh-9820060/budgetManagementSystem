/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mvc.controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

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
}
