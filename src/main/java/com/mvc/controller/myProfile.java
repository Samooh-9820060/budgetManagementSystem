/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mvc.controller;

import com.mvc.model.userLogsModel;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
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
public class myProfile extends HttpServlet {

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
            request.setAttribute("username", username);
            
            request.setAttribute("first_name", getDetailOfUser("first_name", username));
            request.setAttribute("last_name", getDetailOfUser("last_name", username));
            request.setAttribute("email", getDetailOfUser("email", username));
            request.setAttribute("phone_number", getDetailOfUser("phone_number", username));
            request.setAttribute("date_of_birth", getDateOrTime(Timestamp.valueOf(getDetailOfUser("date_of_birth", username)),"date"));
            request.setAttribute("country", getDetailOfUser("country",username));
            request.setAttribute("address", getDetailOfUser("address", username));
            request.setAttribute("gender", getDetailOfUser("gender", username));
            request.setAttribute("two_factor_authentication", getDetailOfUser("two_factor_authentication", username));
            request.setAttribute("user_id", getDetailOfUser("user_id", username));
            request.setAttribute("user_logs", getUserLogs(username));
            
            
            Timestamp createdDate = Timestamp.valueOf(getDetailOfUser("created_date", username));
            long diff = System.currentTimeMillis() - createdDate.getTime();
            int age = (int) (diff / (24 * 60 * 60 * 1000));

            request.setAttribute("account_age", age);
            request.setAttribute("credit_score", getDetailOfUser("credit_score", username));
            
            RequestDispatcher rd = request.getRequestDispatcher("./jsp/myProfile.jsp");
            rd.forward(request, response); 
        }
    }
    
    public List<userLogsModel> getUserLogs(String username) throws SQLException{
        List<userLogsModel> userLogs = new ArrayList<userLogsModel>();
        
        String query = "SELECT L.LOG_ID, U.USERNAME, L.DESCRIPTION, L.UPDATED_AT, L.TYPE, L.MESSAGE "
                + "FROM USER_LOGS L JOIN USERS U ON U.USER_ID = L.USER_ID ORDER BY L.UPDATED_AT DESC";
        ResultSet resultSet = dbconnection.statement().executeQuery(query);
        while (resultSet.next()){
            if (resultSet.getObject(2).toString().equals(username)){
                userLogsModel log = new userLogsModel();
                log.id = resultSet.getObject(1).toString();
                log.date = getDateOrTime((Timestamp) resultSet.getObject(4), "date");
                log.time = getDateOrTime((Timestamp) resultSet.getObject(4), "time");
                log.day = getDay((Timestamp) resultSet.getObject(4));
                log.description = resultSet.getObject(3).toString().replace("\n", ", ");
                log.message = resultSet.getObject(6).toString();
                log.type = resultSet.getObject(5).toString();
                
                userLogs.add(log);
            }
        }
        return userLogs;
    }
    
        
    public String getDay(Timestamp timestamp){
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(timestamp);
        int dayInt = calendar.get(Calendar.DAY_OF_WEEK);
        String[] days = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"};
        String day = days[dayInt - 1];
        return day;
    }
    
    public String getDateOrTime(Timestamp timestamp, String type){
        LocalDateTime dateTime = timestamp.toLocalDateTime();
        String formattedTime = null;
        if (type.equals("date")){
            formattedTime = dateTime.format(DateTimeFormatter.ofPattern("yyyy-dd-MM"));
        } else if (type.equals("time")){
            formattedTime = dateTime.format(DateTimeFormatter.ofPattern("HH:mm:ss"));
        }
        return formattedTime;
    }
    
    public String getDetailOfUser(String detailName, String username) throws SQLException{
        String detail = "";
        String query = "";
        if (detailName.equals("country")){
            query = "SELECT C.COUNTRY_NAME, USERNAME FROM USERS U JOIN COUNTRIES C ON U.COUNTRY_ID = C.COUNTRY_ID";
        } else {
            query = "SELECT "+detailName+", USERNAME FROM USERS";
        }
        ResultSet resultSet = dbconnection.statement().executeQuery(query);
        while (resultSet.next()){
            if (resultSet.getObject(2).toString().equals(username)){
                try {
                    detail = (String) resultSet.getObject(1).toString();
                    return detail;
                } catch (Exception e){

                }                
            }

        }
        
        return detail;
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
            Logger.getLogger(myProfile.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(myProfile.class.getName()).log(Level.SEVERE, null, ex);
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
