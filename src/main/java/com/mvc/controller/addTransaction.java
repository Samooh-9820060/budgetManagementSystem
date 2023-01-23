/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mvc.controller;

import com.mvc.model.transactionsModel;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;


/**
 *
 * @author samoo
 */
public class addTransaction extends HttpServlet {

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
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            String choosenType = request.getParameter("typeChosen");
            //get username from session
            HttpSession session = request.getSession();
            String username = (String) session.getAttribute("session");
            
            int amount = 0;
            Date date = Date.valueOf("1999-12-31");
            Time time = Time.valueOf("12:34:56");
            String category = "";
            String details = "";
            Boolean error = false;
            if (choosenType.equalsIgnoreCase("income")){
                try {
                    amount = Integer.parseInt(request.getParameter("transactionAmountIncome"));
                } catch (NumberFormatException e){
                    out.println("Enter Valid Amount.");
                    error = true;
                }
                try {
                    date = Date.valueOf(request.getParameter("transactionDateIncome"));
                } catch (Exception f){
                    out.println("Enter valid date.");
                    error = true;
                }
                
                try {
                    time = Time.valueOf(request.getParameter("transactionTimeIncome")+":00");
                } catch (Exception g){
                    out.println("Enter valid time.");
                    error = true;
                }
                category = request.getParameter("transactionCategoryIncome");
                details = request.getParameter("transactionDetailsIncome");
                
                if (category.equals("")||details.equals("")){
                    out.println("Category and Details cannot be blank.");
                    error = true;
                }
            } 
            else if (choosenType.equalsIgnoreCase("expense")){
                try {
                    amount = Integer.parseInt(request.getParameter("transactionAmountExpense"));
                } catch (NumberFormatException e){
                    out.println("Enter Valid Amount.");
                    error = true;
                }
                try {
                    date = Date.valueOf(request.getParameter("transactionDateExpense"));
                } catch (Exception f){
                    out.println("Enter valid date.");
                    error = true;
                }
                
                try {
                    time = Time.valueOf(request.getParameter("transactionTimeExpense")+":00");
                } catch (Exception g){
                    out.println("Enter valid time.");
                    error = true;
                }
                category = request.getParameter("transactionCategoryExpense");
                details = request.getParameter("transactionDetailsExpense");
                
                if (category.equals("")||details.equals("")){
                    out.println("Category and Details cannot be blank.");
                    error = true;
                }
            }
            
            //add data to database
            if (error == false){
                String query = "INSERT INTO TRANSACTIONS (username,type,amount,date,time,details,category, is_deleted) VALUES (?,?,?,?,?,?,?)";
                PreparedStatement statement = dbconnection.connectDB().prepareStatement(query);
                statement.setString(1,username);
                statement.setString(2,choosenType);
                statement.setInt(3,amount);
                statement.setDate(4, date);
                statement.setTime(5, time);
                statement.setString(6, details);
                statement.setString(7, category);
                statement.setInt(8, 0);
                statement.executeUpdate();
                
                response.sendRedirect("./dashboard");
            }
        }
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
        } catch (SQLException ex) {
            Logger.getLogger(addTransaction.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (SQLException ex) {
            Logger.getLogger(addTransaction.class.getName()).log(Level.SEVERE, null, ex);
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
