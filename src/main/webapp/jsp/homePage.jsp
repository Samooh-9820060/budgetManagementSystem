

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
<body>
    <!--Hader Navigation-->
    <header class="top-nav">
        <div class="logo-container">
            <div class="logo-icon">
                <i class="fas fa-chart-line"></i>
            </div>
            <div class="logo-text">
                <h2>Budget Management System</h2>
            </div>
        </div>

        <div class="nav-link-right">
            <ul>
                <li>
                    <input style="align-content: center" type="text" placeholder="Search ..." class="btn-group-sm">
                </li>
                <li>
                    <a>Hi, ${username}</a>
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
                    <li class="active">
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
                    <li>
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
                <div class="col-8">
                        <div class="card shadow">
                            <div class="card-body">
                                <div class="imp-info income-txt">
                                    <span class="info-text ">
                                        Balance
                                    </span>
                                    <span class="info-amt bold">
                                        MVR ${balanceValue}
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
                                    Savings
                                </span>
                                <span class="info-amt bold">
                                    MVR ${balanceValue}
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12 col-md-12 col-lg-8 main-area-content">
                    <div id="currentIncomeExpenseValues" class="row">
                        <div class="col-sm-6 col-md-6 col-lg-6">
                            <div class="card shadow">
                                <div class="card-body">
                                    <div class="imp-info income-txt">
                                        <span class="info-text ">
                                            Income
                                        </span>
                                        <span class="info-amt bold">
                                            MVR ${incomeValue}
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6 col-md-6 col-lg-6">
                            <div class="card shadow">
                                <div class="card-body">
                                    <div class="imp-info expense-txt">
                                        <span class="info-text ">
                                            Expense
                                        </span>
                                        <span class="info-amt bold">
                                            MVR ${expenseValue}
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
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
                            <div id="incomeExpenseChart">

                            </div>
                        </div>
                    </div>
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

                    <div class="row">
                        <div class="col-12">
                            <div style="min-height:60px">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-12 col-md-12 col-lg-4 transaction-history transaction-history-size-small" >
                    <div class="card shadow">
                        <div class="card-header text-center">
                            <i class="fas fa-file-signature"></i> Your Transaction History
                        </div>
                        <div class="card-body">
                            <ul class="transaction-history-wrapper">
                                <c:forEach var="data" items="${requestScope.transactions}">
                                    <li>
                                        <div class="row">
                                            <div class="col-8 f">
                                                <i class="fab fa-aviato"></i>
                                                <span class="spending-text">
                                                    <span class="heading">
                                                        <a href="#" onclick="showTransactionDetails(${data.transaction_Id}, '${data.category}', '${data.date}', '${data.time}', '${data.day}', '${data.type}', '${data.amount}', '${data.details}')"><c:out value="${data.category}" /></a>
                                                    </span>
                                                    <span class="sub">
                                                        <c:out value="${data.date}" /> <br><c:out value="${data.day}" />
                                                    </span>
                                                </span>
                                            </div>
                                            <div class="col-4 amt-right">
                                                <span class="<c:choose>
                                                                <c:when test="${data.type=='income'}">
                                                                    amount income
                                                                </c:when>
                                                                <c:when test="${data.type=='expense'}">
                                                                    amount expense
                                                                </c:when>
                                                            </c:choose>">
                                                    $ <c:out value="${data.amount}" />
                                                </span>
                                            </div>
                                        </div>
                                    </li>                    
                                </c:forEach>
                            </ul>
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
        <!--Main Area-->
    </main>
    <!--- Main Content -->
    <script type="text/javascript" src="./assets/js/vendor.js"></script>
    <script type="text/javascript" src="./assets/js/app.js"></script>
    </body>
    <script>
        function addNewTransactionForm(){
            if (document.getElementById("addNewTransactionForm").hidden === true){
                document.getElementById("incomeExpenseChart").hidden = true;
                document.getElementById("currentIncomeExpenseValues").hidden = true;
                document.getElementById("addNewTransactionForm").hidden = false;
                refreshDate();
            } else {
                document.getElementById("incomeExpenseChart").hidden = false;
                document.getElementById("currentIncomeExpenseValues").hidden = false;
                document.getElementById("addNewTransactionForm").hidden = true;
                refreshDate();    
            }
        }    
        
        function chooseType(type){
            document.getElementById("typeChosen").value = type;
        }
        
        function showTransactionDetails(transactionId,category, date, time, day, type, amount, details) {
            document.getElementById("incomeExpenseChart").hidden = true;
            document.getElementById("transactionDetails").hidden = false;
            
            if (type === "income"){
                document.getElementById("typeOfTransactionSelected").classList.remove("expense-txt");
                document.getElementById("typeOfTransactionSelected").classList.add("income-txt");
                document.getElementById("typeOfTransactionSelectedValue").innerHTML = "Income";
            } else if (type === "expense"){
                document.getElementById("typeOfTransactionSelected").classList.remove("income-txt");
                document.getElementById("typeOfTransactionSelected").classList.add("expense-txt");
                document.getElementById("typeOfTransactionSelectedValue").innerHTML = "Expense";
            }
            
            document.getElementById("dateOfTransactionSelectedValue").innerHTML = "Date: "+date;
            document.getElementById("timeOfTransactionSelectedValue").innerHTML = "Time: "+time;
            document.getElementById("dayOfTransactionSelectedValue").innerHTML = "Day: "+day;
            document.getElementById("categoryOfTransactionSelectedValue").innerHTML = "Category: "+category;
            document.getElementById("amountOfTransactionSelectedValue").innerHTML = "Amount: "+amount;
            document.getElementById("detailsOfTransactionSelectedValue").innerHTML = "Details: "+details;
        }

    </script>
    <script>
        function refreshDate(){
            var dateInputIncome = document.getElementsByName("transactionDateIncome")[0];
            var dateInputExpense = document.getElementsByName("transactionDateExpense")[0];
            var today = new Date();
            var dd = today.getDate();
            var mm = today.getMonth()+1; //January is 0!
            var yyyy = today.getFullYear();
            if(dd<10) {
                dd = '0'+dd
            } 
            if(mm<10) {
                mm = '0'+mm
            } 
            today = yyyy + '-' + mm + '-' + dd;
            dateInputIncome.value = today;
            dateInputExpense.value = today;
            var timeInputIncome = document.getElementsByName("transactionTimeIncome")[0];
            var timeInputExpense = document.getElementsByName("transactionTimeExpense")[0];
            var now = new Date();
            var hours = now.getHours();
            var minutes = now.getMinutes();
            if (minutes < 10) {
                minutes = "0" + minutes;
            }
            if (hours < 10) {
                hours = "0" + hours;
            }
            now = hours + ':' + minutes;
            timeInputIncome.value = now;
            timeInputExpense.value = now;
        }    
    </script><!-- select current date and time -->
</html>