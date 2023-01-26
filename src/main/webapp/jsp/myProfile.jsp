<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="author" content="Samooh Moosa">
    <title>My Profile</title>
    <link href="./assets/css/custom.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Ubuntu:300,500,700" rel="stylesheet">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
    <link href="./assets/css/homePage.css" rel="stylesheet"></head>
<body>
    <!--Hader Navigation-->
    <header class="top-nav">
        <div class="logo-container">
            <div class="logo-icon">
                <i class="fas fa-chart-line"></i>
            </div>
            <div class="logo-text">
                <h2 style="cursor: pointer" onclick="goToDashboard();">Budget Management System</h2>
            </div>
        </div>

        <div class="nav-link-right">
            <ul>
                <li>
                    <input style="align-content: center" type="text" placeholder="Search ..." class="btn-group-sm">
                </li>
                <li>
                    <a style="cursor: pointer" onclick="goToMyProfile();">Hi, ${username}</a>
                </li>
                <li class="max-1200" id="navOpener">
                    <i class="fas fa-bars"></i>
                </li>
            </ul>
        </div>
    </header>
    <!--Hader Navigation-->

    <!--- Main Content -->
    <main class="main">

        <!-- Sidebar -->
        <aside class="main-sidebar-nav">
                <ul class="wrapper">
                    <li>
                        <a href="dashboard">
                            <i class="fas fa-columns"></i>
                            <span>Go Home</span>
                        </a>
                    </li>
                    <li>User ID: ${user_id}</li>
                    <li>User Name: ${username}</li>
                    <li>Email: ${email}</li>
                    <li>Phone: ${phone_number}</li>
                    <li>Account Age: ${account_age}</li>
                    <li>Credit Score: ${credit_score}</li>
                </ul>
        </aside>
        <!-- Sidebar -->

        <!--Main Area-->
        <div class="main-area container-fluid">
            <div class="row">
                <div class="col-8">
                        <div class="card shadow">
                            <div class="card-body">
                                <div class="row">
                                    <span class="col-6">
                                        <label for="inp" class="inp">
                                            <input type="text" id="first_name" name="first_name" placeholder="&nbsp;" autocomplete="off" value="${first_name}">
                                                <span class="label">First Name</span>
                                                <span class="focus-bg"></span>
                                        </label>
                                    </span>
                                    <span class="col-6">
                                        <label for="inp" class="inp">
                                            <input type="text" id="last_name" name="last_name" placeholder="&nbsp;" autocomplete="off" value="${last_name}">
                                                <span class="label">Last Name</span>
                                                <span class="focus-bg"></span>
                                        </label>
                                    </span>
                                </div>
                                <div class="row mt-5">
                                    <span class="col-6">
                                        <label for="inp" class="inp">
                                            <input type="text" id="email" name="email" placeholder="&nbsp;" autocomplete="off" value="${email}">
                                                <span class="label">Email</span>
                                                <span class="focus-bg"></span>
                                        </label>
                                    </span>
                                    <span class="col-6">
                                        <label for="inp" class="inp">
                                            <input type="text" id="phone_number" name="phone_number" placeholder="&nbsp;" autocomplete="off" value="${phone_number}">
                                                <span class="label">Phone Number</span>
                                                <span class="focus-bg"></span>
                                        </label>
                                    </span>
                                </div>
                                <div class="row mt-5">
                                    <span class="col-6">
                                        <label for="inp" class="inp">
                                            <input type="date" id="date_of_birth" name="date_of_birth" placeholder="&nbsp;" autocomplete="off" value="${date_of_birth}">
                                                <span class="label">DOB</span>
                                                <span class="focus-bg"></span>
                                        </label>
                                    </span>
                                    <span class="col-6">
                                        <label for="inp" class="inp">
                                            <input type="text" id="country" name="country" placeholder="&nbsp;" value="${country}" autocomplete="off">
                                                <span class="label">Country</span>
                                                <span class="focus-bg"></span>
                                        </label>
                                    </span>
                                </div>
                                <div class="row mt-5">
                                    <span class="col-6">
                                        <label for="inp" class="inp">
                                            <input type="text" id="address" name="address" placeholder="&nbsp;" autocomplete="off" value="${address}">
                                                <span class="label">Address</span>
                                                <span class="focus-bg"></span>
                                        </label>
                                    </span>
                                    <span class="col-6">
                                        <label for="inp" class="inp">
                                            <input type="text" id="gender" name="gender" placeholder="&nbsp;" autocomplete="off" value="${gender}">
                                                <span class="label">Gender</span>
                                                <span class="focus-bg"></span>
                                        </label>
                                    </span>
                                </div>
                                <div class="row mt-5 mx-auto">
                                    <span>
                                        <div class="checkbox-wrapper-49">
                                            <div class="block">
                                                <input data-index="0" id="cheap-49" type="checkbox"/>
                                                <label for="cheap-49"></label>
                                            </div>
                                        </div>
                                    </span>
                                    <span>
                                        <div>Two Factor Authentication</div>                                        
                                    </span>
                                    <span class="mx-auto col-4" >
                                        <input id="submitButton" type="submit" onclick="saveDetailsButton()" value="Save" class="btn btn-block btn-primary" >
                                    </span>
                                </div>
                                                
                            </div>
                        </div>
                </div>
                <div class="col-sm-12 col-md-12 col-lg-4 transaction-history transaction-history-size-normal" >
                    <div class="card shadow">
                        <div class="card-header text-center">
                            <i class="fas fa-file-signature"></i> Your History
                        </div>
                        <div class="card-body">
                            <ul class="transaction-history-wrapper">
                                <c:forEach var="data" items="${requestScope.user_logs}">
                                    <li>
                                        <div class="row">
                                            <div class="col-8 f">
                                                <i class="fab fa-aviato"></i>
                                                <span class="spending-text">
                                                    <span class="heading">
                                                        <a href="#" onclick="showDetails('${data.description}')"><c:out value="${data.type}" /></a>
                                                    </span>
                                                    <span class="sub">
                                                        <c:out value="${data.date}" /> <br><c:out value="${data.time}"/> <br><c:out value="${data.day}" />
                                                    </span>
                                                </span>
                                            </div>
                                            <div class="col-4 amt-right">
                                                <span class="<c:choose>
                                                                <c:when test="${data.message=='Success'}">
                                                                    amount income
                                                                </c:when>
                                                                <c:when test="${data.message=='Fail'}">
                                                                    amount expense
                                                                </c:when>
                                                            </c:choose>">
                                                    <c:out value="${data.message}" />
                                                </span>
                                            </div>
                                        </div>
                                    </li>                    
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12 col-md-12 col-lg-8 main-area-content">
                    <div class="row">
                        <div class="col-12">
                            <div style="min-height:60px">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--Main Area-->
        <form id="saveDetails" method="POST" action="./saveDetails" hidden>
            <input id="first_name_input" name="first_name_input">
            <input id="last_name_input" name="last_name_input">
            <input id="email_input" name="email_input">
            <input id="phone_number_input" name="phone_number_input">
            <input id="date_of_birth_input" name="date_of_birth_input">
            <input id="country_input" name="country_input">
            <input id="address_input" name="address_input">
            <input id="gender_input" name="gender_input">
            <input id="two_factor_authentication_input" name="two_factor_authentication_input">
        </form>
    </main>
    <!--- Main Content -->
    <script type="text/javascript" src="./assets/js/vendor.js"></script>
    <script type="text/javascript" src="./assets/js/app.js"></script>
    </body>
    <form id="goToMyProfile" method="POST" action="./myProfile" hidden></form>
    <form id="goToDashboard" method="POST" action="./dashboard" hidden></form>
    <script>
        function goToDashboard(){
            document.getElementById("goToDashboard").submit();
        }
        function goToMyProfile(){
            document.getElementById("goToMyProfile").submit();
        }
        var checkboxValue = "<%= request.getAttribute("two_factor_authentication") %>";
        if (checkboxValue === "true") {
            document.getElementById("cheap-49").checked = true;
        } else {
            document.getElementById("cheap-49").checked = false;
        }
        
                
        function showDetails(description){
            alert(description);
        }
        
        function saveDetailsButton(){
            document.getElementById("first_name_input").value = document.getElementById("first_name").value;
            document.getElementById("last_name_input").value = document.getElementById("last_name").value;
            document.getElementById("email_input").value = document.getElementById("email").value;
            document.getElementById("phone_number_input").value = document.getElementById("phone_number").value;
            document.getElementById("date_of_birth_input").value = document.getElementById("date_of_birth").value;
            document.getElementById("country_input").value = document.getElementById("country").value;
            document.getElementById("address_input").value = document.getElementById("address").value;
            document.getElementById("gender_input").value = document.getElementById("gender").value;
            if (document.getElementById("cheap-49").checked == true){
                document.getElementById("two_factor_authentication_input").value = "true";
            } else if (document.getElementById("cheap-49").checked == false){
                document.getElementById("two_factor_authentication_input").value = "false";
            }
            
            document.getElementById("saveDetails").submit();
        }
    </script>
</html>