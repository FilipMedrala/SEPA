<?php
session_start();
    $_SESSION['dir'] = "C:/xampp";
    require_once ("settings.php");
    $conn = @mysqli_connect(
    $host,
    $user,
    $pwd,
    $sql_db
    );
    if (!$conn)
    {
      echo "mysql not connected ";
      echo mysqli_connect_errno() . ":" . mysqli_connect_error();
      exit;
    }
    else
    {
      echo "<p>Access granted.</p>";
      $sql = "CREATE TABLE IF NOT EXISTS files (
        uID VARCHAR(50)  NOT NULL,
        Adr VARCHAR(50) NOT NULL
      )";
        $query = mysqli_query($conn, $sql);
      if ($query === TRUE) {
      echo "Table Files created successfully or already created";
        }
        else
        {
      echo "Error creating table: " . $conn->error;
        }
    }
?>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="style.css">
<title>Untitled Document</title>
</head>

<body>
<div class="container" id="container">
	<div class="card" id="card">
		<div id="sign-up-container" class="form-container">
			<form id="signUpForm" action="#">
				<h1>Create Account</h1>
				<br><input class="displayName" type="text" placeholder="Name" />
				<input class="email" type="email" placeholder="Email" />
				<input class="password" type="password" placeholder="Password" />
				<span class="errorText"></span>
				<button id="signUp">Sign Up</button>
				<a href="#" onclick="flip(this)" class="signInFlip">Already have an account? Sign in!</a>
			</form>
		</div>
		<div id="sign-in-container" class="form-container">
			<form id="signInForm" action="#">
				<h1>Sign in</h1>
				<input class="email" type="email" placeholder="Email" />
				<input class="password" type="password" placeholder="Password" />
				<a href="#" style="margin-bottom: 0px;" onclick="flip(this)" id="forgotPasswordFlip">Forgot your password?</a>
				<a href="#"style="margin-top: 7px" onclick="flip(this)" id="signUpFlip">Don't have an account? Sign up!</a>
				<span class="errorText"></span>
				<button id="signIn">Sign In</button>
			</form>
		</div>
		<div id="forgot-password-container" class="form-container">
			<form id="forgotPasswordForm" action="#">
				<h1>Forgot Password?</h1>
				<input class="email" type="email" placeholder="Email" />
				<a href="#" onclick="flip(this)" class="signInFlip">Didn't forget your password? Sign In!</a>
				<span class="errorText"></span>
				<button id="forgotPassword">Email Me</button>
			</form>
		</div>
	</div>
</div>

<script src="https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js"></script>
<script src="https://www.gstatic.com/firebasejs/8.10.0/firebase-auth.js"></script>

<script src="firebase.js"></script>
<script src=script.js></script>

</body>
</html>
