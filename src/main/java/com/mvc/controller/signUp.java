/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mvc.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.sql.Statement;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;


/**
 *
 * @author samoo
 */
public class signUp extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, NoSuchAlgorithmException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            String username = request.getParameter("username");
            String password = hashPass(request.getParameter("password"));
            
            LocalDateTime currentDate = LocalDateTime.now();
            Timestamp timestamp = Timestamp.valueOf(currentDate);
            
            boolean duplicate = checkDuplicate(username);
            
            if (duplicate == false){                
                String sql = "INSERT INTO USERS (username,password,created_date,status,two_factor_authentication,credit_score) VALUES (?,?,?,?,?,?)";
                PreparedStatement statement = dbconnection.connectDB().prepareStatement(sql);
                statement.setString(1,username);
                statement.setString(2,password);
                statement.setTimestamp(3, timestamp);
                statement.setBoolean(4, true);
                statement.setBoolean(5, false);
                statement.setInt(6, 0);
                statement.executeUpdate();  
                
                dbconnection.updateLogsTable(username, "Sign Up", "Sign Up", "Success");
                response.sendRedirect("index.html");
            } else {
                out.println("Duplicate");
            }

            
            //out.println(username+password);
            //RequestDispatcher rd = request.getRequestDispatcher("./jsp/homeScreen.jsp");
            //rd.forward(request, response);
        }
    }
    
    public boolean checkDuplicate(String username) throws SQLException{
        boolean duplicate = false;
        ResultSet resultSet = dbconnection.statement().executeQuery("SELECT USERNAME FROM USERS");
        while (resultSet.next()){
            String resultUsername = (String) resultSet.getObject(1);
            if (resultUsername.matches(username)){
                duplicate = true;
                return duplicate;
            }
        }
        
        return duplicate;
    }
    
    //hash password in SHA 256 format to store in database
    public String hashPass(String password) throws NoSuchAlgorithmException{
        String hashedPass = "";
        MessageDigest digest = MessageDigest.getInstance("SHA-256");
        byte[] hash = digest.digest(password.getBytes(StandardCharsets.UTF_8));
        // convert bytes to hexadecimal
        StringBuilder s = new StringBuilder();
        for (byte b : hash) {
            s.append(Integer.toString((b & 0xff) + 0x100, 16).substring(1));
        }
        hashedPass = s.toString();
        
        return hashedPass;
        
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(signUp.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(signUp.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(signUp.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(signUp.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
