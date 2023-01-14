
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
                    <li>
                        <a href="dashboard">
                            <i class="fas fa-columns"></i>
                            <span>Dashboard</span>
                        </a>
                    </li>
                    <li class="active">
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
                <div class="col-sm-12 col-md-12 col-lg-8 main-area-content">
                    <div id="currentIncomeExpenseValues" class="row">
                        <div class="col-sm-6 col-md-6 col-lg-6">
                            <div class="card shadow">
                                <div class="card-body">
                                    <div>
                                        <select id="selectMonth" class="border-0">
                                            <option value="1">January</option>
                                            <option value="2">February</option>
                                            <option value="3">March</option>
                                            <option value="4">April</option>
                                            <option value="5">May</option>
                                            <option value="6">June</option>
                                            <option value="7">July</option>
                                            <option value="8">August</option>
                                            <option value="9">September</option>
                                            <option value="10">October</option>
                                            <option value="11">November</option>
                                            <option value="12">December</option>
                                        </select>
                                    </div>
                                    <div class="imp-info expense-txt">
                                        <span class="info-text ">
                                            Monthly - ${selectedMonth}
                                        </span>
                                        <span class="info-amt bold">
                                            MVR ${selectedMonthExpense}
                                        </span>
                                    </div>
                                        
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6 col-md-6 col-lg-6">
                            <div class="card shadow">
                                <div class="card-body">
                                    <div>
                                        <input id="selectYear" type="text" class="border-info" placeholder="Enter Year">
                                        <button class="btn-info" onclick="updateBillDates()">Update</button>
                                    </div>
                                    <div class="imp-info expense-txt">
                                        <span class="info-text ">
                                            Annually - ${selectedYear}
                                        </span>
                                        <span class="info-amt bold">
                                            MVR ${selectedYearExpense}
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
                            <div class="ads" style="min-height:60px">
                            </div>
                        </div>
                    </div>


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
                <div class="col-sm-12 col-md-12 col-lg-4 transaction-history transaction-history-size-normal">
                    <div class="card shadow">
                        <div class="card-header text-center">
                            <i class="fas fa-file-signature"></i> Upcoming Bills Due
                        </div>
                        <div class="card-body">
                            <ul class="transaction-history-wrapper">
                                <c:forEach var="data" items="${requestScope.bills}">
                                    <li>
                                        <div class="row">
                                            <div class="col-8 f">
                                                <i class="fab fa-aviato"></i>
                                                <span class="spending-text">
                                                    <span class="heading">
                                                        <a href="#" onclick="showTransactionDetails()"><c:out value="${data.type}" /></a>
                                                    </span>
                                                    <span class="sub">
                                                        <c:out value="${data.dueDate}" /> <br><c:out value="${data.dueDay}" />
                                                    </span>
                                                </span>
                                            </div>
                                            <div class="col-4 amt-right">
                                                <span class="amount expense">
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
    </main>
    <script type="text/javascript" src="./assets/js/vendor.js"></script>
    <script type="text/javascript" src="./assets/js/app.js"></script>
    <form id="changeBillDateForm" method="POST" action="changeBillDates" hidden>
        <input id="selectedMonth" name="selectedMonth">
        <input id="selectedYear" name="selectedYear">
        <button>submit</button>
    </form>
    <script>
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
</html>