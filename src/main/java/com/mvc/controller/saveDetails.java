/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mvc.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.logging.Level;
import java.util.logging.Logger;


/**
 *
 * @author samoo
 */
public class saveDetails extends HttpServlet {

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
            
            String firstNameNew = request.getParameter("first_name_input");
            String firstNameCurrent = getDetailOfUser(username, "first_name");
            String lastNameNew = request.getParameter("last_name_input");
            String lastNameCurrent = getDetailOfUser(username, "last_name");
            String emailNew = request.getParameter("email_input");
            String emailCurrent = getDetailOfUser(username, "email");
            String phoneNumberNew = request.getParameter("phone_number_input");
            String phoneNumberCurrent = getDetailOfUser(username, "phone_number");
            String dateOfBirthNew = request.getParameter("date_of_birth_input");
            String dateOfBirthCurrent = getDateOrTime(Timestamp.valueOf(getDetailOfUser(username, "date_of_birth")),"date");
            String countryNew = request.getParameter("country_input");
            String countryCurrent = getDetailOfUser(username, "country");
            String addressNew = request.getParameter("address_input");
            String addressCurrent = getDetailOfUser(username, "address");
            String genderNew = request.getParameter("gender_input");
            String genderCurrent = getDetailOfUser(username, "gender");
            String twoFactorAuthenticationNew = request.getParameter("two_factor_authentication_input");
            String twoFactorAuthenticationCurrent = getDetailOfUser(username, "two_factor_authentication");
            
            Timestamp dateTime = Timestamp.valueOf(dateOfBirthNew+" 00:00:00");
            LocalDateTime dt = dateTime.toLocalDateTime();
            String formattedValue = dt.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
            dateTime = Timestamp.valueOf(formattedValue);        
            
            String changedDetails = "";
            
            if (!firstNameCurrent.equals(firstNameNew)){changedDetails += "First Name "+firstNameCurrent+" changed to "+firstNameNew+"\n";}
            if (!lastNameCurrent.equals(lastNameNew)){changedDetails += "Last Name "+lastNameCurrent+" changed to "+lastNameNew+"\n";}
            if (!emailCurrent.equals(emailNew)){changedDetails += "Email "+emailCurrent+" changed to "+emailNew+"\n";}
            if (!phoneNumberCurrent.equals(phoneNumberNew)){changedDetails += "Phone Number "+phoneNumberCurrent+" changed to "+phoneNumberNew+"\n";}
            if (!dateOfBirthCurrent.equals(dateOfBirthNew)){changedDetails += "DOB "+dateOfBirthCurrent+" changed to "+dateOfBirthNew+"\n";}
            if (!countryCurrent.equals(countryNew)){changedDetails += "Country "+countryCurrent+" changed to "+countryNew+"\n";}
            if (!addressCurrent.equals(addressNew)){changedDetails += "Address "+addressCurrent+" changed to "+addressNew+"\n";}
            if (!genderCurrent.equals(genderNew)){changedDetails += "Gender "+genderCurrent+" changed to "+genderNew+"\n";}
            if (!twoFactorAuthenticationCurrent.equals(twoFactorAuthenticationNew)){changedDetails += "TFA "+twoFactorAuthenticationCurrent+" changed to "+twoFactorAuthenticationNew+"\n";}
            
            
            String dataUpdated = "Fail";
            
            boolean tfa = false;
            if (twoFactorAuthenticationNew.equals("true")){
                tfa = true;
            } else if (twoFactorAuthenticationNew.equals("false")){
                tfa = false;
            }   
            
            
            if (!changedDetails.equals("")){
                dbconnection.updateUserDetails(username, firstNameNew, lastNameNew, emailNew, dateTime, Integer.parseInt(phoneNumberNew), countryNew, addressNew, genderNew, tfa);
                dataUpdated = "Success";
            }
            
            if (!changedDetails.equals("")) {
                dbconnection.updateLogsTable(username, changedDetails.trim(),"Profile Update", dataUpdated);
            }
            
            response.sendRedirect("./myProfile");
        }
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
    
    public String getDetailOfUser(String username, String detailName) throws SQLException{
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
            Logger.getLogger(saveDetails.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(saveDetails.class.getName()).log(Level.SEVERE, null, ex);
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
