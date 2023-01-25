/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mvc.controller;

import com.mvc.model.billsModel;
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
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.Month;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;


/**
 *
 * @author samoo
 */
public class billsAndPayments extends HttpServlet {

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
            

            List<billsModel> bills = getBillDetails(username);
            LocalDate currentDate = LocalDate.now();
            String currentMonth = DateTimeFormatter.ofPattern("MMMM").format(currentDate);
            String currentYear = DateTimeFormatter.ofPattern("yyyy").format(currentDate);
            
            String selectedMonth = (String)request.getParameter("selectedMonth");
            if (selectedMonth== null){
                request.setAttribute("selectedMonth", currentMonth);
                request.setAttribute("selectedYear", currentYear);
            }
            
            
            
            request.setAttribute("selectedMonthExpense", getSelectedMonthExpense(username, currentMonth, currentYear));
            request.setAttribute("selectedYearExpense", getSelectedYearExpense(username, currentYear));
            request.setAttribute("bills", bills);
            request.setAttribute("username", username);
            RequestDispatcher rd = request.getRequestDispatcher("./jsp/billsAndPayments.jsp");
            rd.forward(request, response);   
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
            Logger.getLogger(billsAndPayments.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(billsAndPayments.class.getName()).log(Level.SEVERE, null, ex);
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

    public List<billsModel> getBillDetails(String username) throws SQLException{
        List<billsModel> bills = new ArrayList<>();
        
        String query = "SELECT B.BILL_ID, U.USERNAME, B.BILL_NAME, B.DUE_DATE, B.AMOUNT, B.DESCRIPTION, B.PAYMENT_STATUS "
                + "FROM BILLS B "
                + "JOIN USERS U ON U.USER_ID = B.USER_ID "
                + "ORDER BY B.DUE_DATE DESC";
        ResultSet resultSet = dbconnection.statement().executeQuery(query);
        while (resultSet.next()){
            String resultUsername = (String) resultSet.getObject(2);
            if  (resultUsername.equals(username)){
                billsModel bill = new billsModel();
                bill.bill_Id = (String) resultSet.getObject(1).toString();
                bill.amount = (String) resultSet.getObject(5).toString();
                bill.type = (String) resultSet.getObject(3).toString();
                
                Timestamp timestamp = (Timestamp) resultSet.getObject(4);
                LocalDateTime dateTime = timestamp.toLocalDateTime();
                String formattedTime = dateTime.format(DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss"));  
                
                bill.dueDate = formattedTime;
                bill.dueDay = getDay((Timestamp) resultSet.getObject(4));
                bill.details = (String) resultSet.getObject(6).toString();
                bill.status = (String) resultSet.getObject(7).toString();
                bills.add(bill);
            }
        }
        return bills;
    }
    
    public int getSelectedMonthExpense(String username, String month, String year) throws SQLException{
        int value = 0;
        
        String query = "SELECT U.USERNAME, B.DUE_DATE, B.AMOUNT, B.PAYMENT_STATUS "
                + "FROM BILLS B "
                + "JOIN USERS U ON U.USER_ID = B.USER_ID";
        ResultSet resultSet = dbconnection.statement().executeQuery(query);
        while (resultSet.next()){
            String resultUsername = (String) resultSet.getObject(1).toString();
            if (resultUsername.equals(username)){
                
                Timestamp timestamp = (Timestamp) resultSet.getObject(2);
                LocalDateTime dateTime = timestamp.toLocalDateTime();
                String formattedTime = dateTime.format(DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss"));                
                
                String resultYear = dateTime.getYear()+"";
                Month resultMonth = dateTime.getMonth();
                String resultMonthInLongFormat = resultMonth.toString();
                
                if (resultYear.equals(year) && (resultMonthInLongFormat.equalsIgnoreCase(month))){
                    String status = (String) resultSet.getObject(4).toString();
                    if (status.equals("true")){
                        int amount = (int) resultSet.getObject(3);
                        value += amount;    
                    }
                }
            }
        }
        
        return value;
    } 
    
    public int getSelectedYearExpense(String username, String year) throws SQLException{
        int value = 0;
        
        String query = "SELECT U.USERNAME, B.DUE_DATE, B.AMOUNT, B.PAYMENT_STATUS "
                + "FROM BILLS B "
                + "JOIN USERS U ON U.USER_ID = B.USER_ID";
        ResultSet resultSet = dbconnection.statement().executeQuery(query);
        while (resultSet.next()){
            String resultUsername = (String) resultSet.getObject(1).toString();
            if (resultUsername.equals(username)){
                
                Timestamp timestamp = (Timestamp) resultSet.getObject(2);
                LocalDateTime dateTime = timestamp.toLocalDateTime();
                String formattedTime = dateTime.format(DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss"));   
                
                String resultYear = dateTime.getYear()+"";
                
                if (resultYear.equals(year)){
                    String status = (String) resultSet.getObject(4).toString();
                    if (status.equals("true")){
                        int amount = (int) resultSet.getObject(3);
                        value += amount;    
                    }
                }
            }
        }
        
        return value;
    } 
    
    
    
    public String getDay(Timestamp timestamp){
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(timestamp);
        int dayInt = calendar.get(Calendar.DAY_OF_WEEK);
        String[] days = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"};
        String day = days[dayInt - 1];
        return day;
    }
}
