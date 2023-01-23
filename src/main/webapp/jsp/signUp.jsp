<!doctype html>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href="https://fonts.googleapis.com/css?family=Roboto:300,400&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="../assets/fonts/icomoon/style.css">

    <link rel="stylesheet" href="../assets/css/owl.carousel.min.css">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="../assets/css/bootstrap.min.css">
    
    <!-- Style -->
    <link rel="stylesheet" href="../assets/css/style.css">

    <title>Sign  Up</title>
  </head>
  <body>
  

  
  <div class="content">
    <div class="container">
      <div class="row">
        <div class="col-md-6">
          <img src="../assets/images/bg_2.png" alt="Image" class="img-fluid">
        </div>
        <div class="col-md-6 contents">
          <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="mb-4">
                    <h3>Sign Up</h3>
                    <p class="mb-4">Please enter a username and password.</p>
                </div>
                <form action="../signUp" method="post">
                    <div class="form-group last mb-4">
                        <label for="username">Username</label>
                        <input name="username" type="text" class="form-control" id="username" oninput="onPasswordChange()">
                    </div>

                    <div class="form-group first">
                        <label for="password">Password</label>
                        <input name="password" type="password" class="form-control" id="password" oninput="onPasswordChange()">

                    </div>
                    <div class="form-group last mb-1">
                        <label for="password">Repeat Password</label>
                        <input type="password" class="form-control" id="passwordRepeat" oninput="onPasswordChange()">
                    </div>
                        <label style="font-size: 12px; color: red;" class="mb-3" id="validationText"></label>

                    <div class="d-flex mb-5 align-items">
                        <span class="m0-auto"><a href="../index.html" class="forgot-pass">Sign In</a></span> 
                    </div>
                        <input id="signUpButton" type="submit" value="Sign Up" class="btn btn-block btn-primary" disabled="true">
                </form>
            </div>
          </div>
          
        </div>
        
      </div>
    </div>
  </div>

  
    <script src="../assets/js/jquery-3.3.1.min.js"></script>
    <script src="../assets/js/popper.min.js"></script>
    <script src="../assets/js/bootstrap.min.js"></script>
    <script src="../assets/js/main.js"></script>
  </body>
  <script>
      //check if password and repeat password are same
      function onPasswordChange(){
          if (document.getElementById("username").value.length > 6){
            if (document.getElementById("password").value.length > 6){
                if (document.getElementById("password").value === (document.getElementById("passwordRepeat").value)){
                    document.getElementById("signUpButton").disabled = false;
                    document.getElementById("validationText").innerHTML = "";
                } else {
                    document.getElementById("signUpButton").disabled = true;
                    document.getElementById("validationText").innerHTML = "Password 1 and Password 2 does not match";
                }
              } else {
                  document.getElementById("signUpButton").disabled = true;
                document.getElementById("validationText").innerHTML = "Password should be greater than 6 characters";
              }
          } else {
              document.getElementById("signUpButton").disabled = true;
              document.getElementById("validationText").innerHTML = "Username should be greater than 6 characters";
          }
      }
  </script>
  <style>
  </style>
</html>