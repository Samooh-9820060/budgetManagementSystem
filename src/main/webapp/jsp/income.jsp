
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
    <title>Home Page</title>
    <link href="https://fonts.googleapis.com/css?family=Ubuntu:300,500,700" rel="stylesheet">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
    <link href="./assets/css/homePage.css" rel="stylesheet"></head>

    <link rel="icon" type="image/png" href="https://colorlib.com/etc/tb/Table_Highlight_Vertical_Horizontal/images/icons/favicon.ico">

    <link rel="stylesheet" type="text/css" href="./assets/css/bootstrap2.min.css">

    <link rel="stylesheet" type="text/css" href="./assets/css/font-awesome.min.css">

    <link rel="stylesheet" type="text/css" href="./assets/css/animate.css">

    <link rel="stylesheet" type="text/css" href="./assets/css/select2.min.css">

    <link rel="stylesheet" type="text/css" href="./assets/css/perfect-scrollbar.css">

    <link rel="stylesheet" type="text/css" href="./assets/css/util.css">
    <link rel="stylesheet" type="text/css" href="./assets/css/main.css">
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
                            <span>Dashboard</span>
                        </a>
                    </li>
                    <li>
                        <a href="billsAndPayments">
                            <i class="fas fa-file-invoice-dollar"></i>
                            <span>Bills & Payments</span>
                        </a>
                    </li>
                    <li>
                        <a href="expenses">
                            <i class="fas fa-chart-bar"></i>
                            <span>Expenses</span>
                        </a>
                    </li>
                    <li class="active">
                        <a href="income">
                            <i class="fas fa-chart-line"></i>
                            <span>Incomes</span>
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <i class="fas fa-balance-scale"></i>
                            <span>Savings</span>
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <i class="fas fa-battery-half"></i>
                            <span>Investments</span>
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <i class="fas fa-check"></i>
                            <span>Pension</span>
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <i class="fas fa-book"></i>
                            <span>Report</span>
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <i class="fas fa-hands-helping"></i>
                            <span>Contact Us</span>
                        </a>
                    </li>
                </ul>
        </aside>
        <!-- Sidebar -->

        <!--Main Area-->
        <div class="main-area container-fluid">
            <div class="row">
                <div class="col-5">
                        <div class="card shadow">
                            <div class="card-body">
                                <div class="imp-info income-txt">
                                    <span class="info-text mx-auto">
                                        Filter By Date
                                    </span>
                                    <span class="mx-auto">
                                        <input type="date" class="mt-3">
                                        <input type="date" class="mt-3">
                                    </span>
                                    
                                </div>
                            </div>
                        </div>
                </div>
                <div class="col-4">
                    <div class="card shadow">
                        <div class="card-body">
                            <div class="imp-info savings-txt">
                                <span class="info-text ">
                                    Filter By Type
                                </span>
                                <select class="btn-sm mt-3">
                                    <c:forEach var="data" items="${requestScope.categories}">
                                        <option><c:out value="${data.type}" /></option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-3">
                    <div class="card shadow">
                        <div class="card-body">
                            <div class="imp-info savings-txt">
                                <span class="info-text ">
                                    Sort By
                                </span>
                                <select class="btn-sm mt-3">
                                    <option>Amount</option>
                                    <option>Date</option>
                                    <option>Time</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12 col-md-12 col-lg-8 main-area-content">
                    <form id="addNewTransactionForm" class="row" method="POST" action="./addTransaction" hidden>
                        <input id="typeChosen" name="typeChosen" value="" hidden>
                        <div class="col-sm-6 col-md-6 col-lg-6">
                            <div class="card shadow">
                                <div class="card-body">
                                    <div class="imp-info income-txt">
                                        <span class="info-text ">
                                            Enter Income
                                        </span>
                                        <input name="transactionAmountIncome" placeholder="Enter Amount" class="mt-3" autocomplete="off">
                                        <input type="date" name="transactionDateIncome" class="mt-3">
                                        <input type="time" name="transactionTimeIncome" class="mt-3">
                                        <input type="text" name="transactionCategoryIncome" placeholder="Enter Category" class="mt-3" autocomplete="off">
                                        <input type="text" name="transactionDetailsIncome" placeholder="Enter Details" class="mt-3" autocomplete="off">
                                        <label style="color: red; font-family: sans-serif; font-size: 12px;" id="errorMessage">${errorMessage}</label>
                                        <button class="mt-3 col-sm-6 btn-primary mx-auto" onclick="chooseType('income')">Add</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6 col-md-6 col-lg-6">
                            <div class="card shadow">
                                <div class="card-body">
                                    <div class="imp-info expense-txt">
                                        <span class="info-text ">
                                            Enter Expense
                                        </span>
                                        <input id="amount" name="transactionAmountExpense" placeholder="Enter Amount" class="mt-3" autocomplete="off">
                                        <input type="date" name="transactionDateExpense" class="mt-3">
                                        <input type="time" name="transactionTimeExpense" class="mt-3">
                                        <input type="text" name="transactionCategoryExpense" placeholder="Enter Category" class="mt-3" autocomplete="off">
                                        <input type="text" name="transactionDetailsExpense" placeholder="Enter Details" class="mt-3" autocomplete="off">
                                        <label style="color: red; font-family: sans-serif; font-size: 12px;" id="errorMessage">${errorMessage}</label>
                                        <button class="mt-3 col-sm-6 btn-primary mx-auto" onclick="chooseType('expense')">Add</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                    <div class="row">
                        <div class="col-12">
                            <form id="transactionDetails" hidden>
                                <div class="card shadow">
                                    <div class="card-body">
                                        <div id="typeOfTransactionSelected" class="imp-info">
                                            <span id="typeOfTransactionSelectedValue" class="info-text" style="font-size: 20px"></span>
                                            <label id="dateOfTransactionSelectedValue" class="mt-4 text-dark"></label>
                                            <label id="timeOfTransactionSelectedValue" class="text-dark"></label>
                                            <label id="dayOfTransactionSelectedValue" class="text-dark"></label>
                                            <label id="categoryOfTransactionSelectedValue" class="text-dark"></label>
                                            <label id="amountOfTransactionSelectedValue" class="text-dark"></label>
                                            <label id="detailsOfTransactionSelectedValue" class="text-dark"></label>
                                            <div class="float-right mt-3">
                                                <button>Delete</button>
                                                <button class="mx-5">Modify</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>

                </div>
                <div class="col-sm-12 col-md-12 col-lg-12 transaction-history transaction-history-size-medium">
                    <div class="card shadow">
                        <div class="limiter">
                            <div class="container-fluid">
                                <div class="wrap-pic-max-h">
                                    <div class="table ver1 m-b-110">
                                        <table data-vertable="ver1">
                                            <thead>
                                                <tr class="row100 head">
                                                <th class="column100 column1" data-column="column1">Amount</th>
                                                <th class="column100 column2" data-column="column2">Date</th>
                                                <th class="column100 column3" data-column="column3">Day</th>
                                                <th class="column100 column4" data-column="column4">Time</th>
                                                <th class="column100 column5" data-column="column5">Category</th>
                                                <th class="column100 column6" data-column="column6">Details</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="data" items="${requestScope.incomes}">
                                                    <tr class="row100">
                                                        <td class="column100 column1" data-column="column1"><c:out value="MVR ${data.amount}"/></td>
                                                        <td class="column100 column2" data-column="column2"><c:out value="${data.date}"/></td>
                                                        <td class="column100 column3" data-column="column3"><c:out value="${data.day}"/></td>
                                                        <td class="column100 column4" data-column="column4"><c:out value="${data.time}"/></td>
                                                        <td class="column100 column5" data-column="column5"><c:out value="${data.category}"/></td>
                                                        <td class="column100 column6" data-column="column6"><c:out value="${data.details}"/></td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="card-footer">
                            <div class="transaction-footer">
                                <button class="btn btn-info" onclick="addNewTransactionForm()">Add New</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
    <form id="goToMyProfile" method="POST" action="./myProfile" hidden>
        <button>Submit</button>
    </form>
    <form id="goToDashboard" method="POST" action="./dashboard" hidden></form>
    <script type="text/javascript" src="./assets/js/vendor.js"></script>
    <script type="text/javascript" src="./assets/js/app.js"></script>
    <form id="changeBillDateForm" method="POST" action="changeBillDates" hidden>
        <input id="selectedMonth" name="selectedMonth">
        <input id="selectedYear" name="selectedYear">
        <button>submit</button>
    </form>
    <script>
        function goToMyProfile(){
            document.getElementById("goToMyProfile").submit();
        }
        function goToDashboard(){
            document.getElementById("goToDashboard").submit();
        }
        refreshDate();
        function refreshDate(){
            var selectMonth = document.getElementById("selectMonth");
            var selectYear = document.getElementById("selectYear");
            var today = new Date();
            var yyyy = today.getFullYear();
            var currentMonth = today.getMonth() + 1;
            selectMonth.value = currentMonth;
            selectYear.value = yyyy;
        }
        
        function updateBillDates(){
            document.getElementById("selectedMonth").value = document.getElementById("selectMonth").value;
            document.getElementById("selectedYear").value = document.getElementById("selectYear").value;
            document.getElementById("changeBillDateForm").submit();
        }
    </script>
    <style>
        .table  {
            height: 350px;
            overflow: auto;
         }
         .transaction-history-size-medium {
            height: 250px;
         }
    </style>
</html>