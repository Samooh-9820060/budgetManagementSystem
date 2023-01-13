/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mvc.controller;

import com.mvc.model.categories;
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
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;


/**
 *
 * @author samoo
 */
public class expenses extends HttpServlet {

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
            HttpSession session = request.getSession();
            String username = (String) session.getAttribute("session");
            
            request.setAttribute("expenses", getAllExpeneses(username));
            request.setAttribute("categories", getAllCategories(username));
            request.setAttribute("username", username);
            RequestDispatcher rd = request.getRequestDispatcher("./jsp/expenses.jsp");
            rd.forward(request, response);   
        }
    }
    
    public List<transactionsModel> getAllExpeneses(String username) throws SQLException{
        List<transactionsModel> transactions = new ArrayList<>();
        
        String query = "SELECT TRANSACTION_ID, USERNAME, TYPE, AMOUNT, DATE, TIME, CATEGORY, DETAILS FROM TRANSACTIONS WHERE TYPE='expense'"
                + "ORDER BY DATE DESC, TIME DESC";
        ResultSet resultSet = dbconnection.statement().executeQuery(query);
        while (resultSet.next()){
            String resultUsername = (String) resultSet.getObject(2);
            if  (resultUsername.equals(username)){
                String day = getDay((Date) resultSet.getObject(5));
                transactionsModel transaction = new transactionsModel();
                transaction.transaction_Id = (String) resultSet.getObject(1).toString();
                transaction.details = (String) resultSet.getObject(8).toString();
                transaction.category = (String) resultSet.getObject(7);
                transaction.date = (String) resultSet.getObject(5).toString();
                transaction.time = (String) resultSet.getObject(6).toString();
                transaction.day = day;
                transaction.type = (String) resultSet.getObject(3);
                transaction.amount = (String) resultSet.getObject(4).toString();
                transactions.add(transaction);
            }
        }
        
        return transactions;
    }
    
    public String getDay(Date date){
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        int dayInt = calendar.get(Calendar.DAY_OF_WEEK);
        String[] days = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"};
        String day = days[dayInt - 1];
        return day;
    }
    
    public List<categories> getAllCategories(String username) throws SQLException{
        List<categories> types = new ArrayList<>();
        
        String query = "SELECT DISTINCT CATEGORY FROM TRANSACTIONS WHERE TYPE='expense' AND USERNAME='"+username+"'";
        ResultSet resultSet = dbconnection.statement().executeQuery(query);
        while(resultSet.next()){
            categories type = new categories();
            type.type = resultSet.getObject(1).toString();
            types.add(type);
        }
        
        return types;
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
            Logger.getLogger(expenses.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(expenses.class.getName()).log(Level.SEVERE, null, ex);
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
