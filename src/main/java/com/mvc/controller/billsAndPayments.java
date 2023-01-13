/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mvc.controller;

import com.mvc.model.billsModel;
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
import java.time.LocalDate;
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
        
        String query = "SELECT BILL_ID, USERNAME, BILLTYPE, DUEDATE, AMOUNT, DETAILS, STATUS FROM BILLS ORDER BY DUEDATE DESC";
        ResultSet resultSet = dbconnection.statement().executeQuery(query);
        while (resultSet.next()){
            String resultUsername = (String) resultSet.getObject(2);
            if  (resultUsername.equals(username)){
                String day = getDay((Date) resultSet.getObject(4));
                billsModel bill = new billsModel();
                bill.bill_Id = (String) resultSet.getObject(1).toString();
                bill.amount = (String) resultSet.getObject(5).toString();
                bill.type = (String) resultSet.getObject(3).toString();
                bill.dueDate = (String) resultSet.getObject(4).toString();
                bill.dueDay = getDay((Date) resultSet.getObject(4));
                bill.details = (String) resultSet.getObject(6).toString();
                bill.status = (String) resultSet.getObject(7).toString();
                bills.add(bill);
            }
        }
        return bills;
    }
    
    public int getSelectedMonthExpense(String username, String month, String year) throws SQLException{
        int value = 0;
        
        String query = "SELECT USERNAME, DUEDATE, AMOUNT, STATUS FROM BILLS";
        ResultSet resultSet = dbconnection.statement().executeQuery(query);
        while (resultSet.next()){
            String resultUsername = (String) resultSet.getObject(1).toString();
            if (resultUsername.equals(username)){
                Date dueDate = (Date) resultSet.getObject(2);
                LocalDate localDueDate = dueDate.toLocalDate();
                String resultYear = localDueDate.getYear()+"";
                Month resultMonth = localDueDate.getMonth();
                String resultMonthInLongFormat = resultMonth.toString();
                
                if (resultYear.equals(year) && (resultMonthInLongFormat.equalsIgnoreCase(month))){
                    String status = (String) resultSet.getObject(4).toString();
                    if (status.equals("1")){
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
        
        String query = "SELECT USERNAME, DUEDATE, AMOUNT, STATUS FROM BILLS";
        ResultSet resultSet = dbconnection.statement().executeQuery(query);
        while (resultSet.next()){
            String resultUsername = (String) resultSet.getObject(1).toString();
            if (resultUsername.equals(username)){
                Date dueDate = (Date) resultSet.getObject(2);
                LocalDate localDueDate = dueDate.toLocalDate();
                String resultYear = localDueDate.getYear()+"";
                
                if (resultYear.equals(year)){
                    String status = (String) resultSet.getObject(4).toString();
                    if (status.equals("1")){
                        int amount = (int) resultSet.getObject(3);
                        value += amount;    
                    }
                }
            }
        }
        
        return value;
    } 
    
    
    public String getDay(Date date){
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        int dayInt = calendar.get(Calendar.DAY_OF_WEEK);
        String[] days = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"};
        String day = days[dayInt - 1];
        return day;
    }
}
