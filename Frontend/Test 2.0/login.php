<?php
session_start();
if(!isset($_COOKIE['userID'])) {
  echo "Cookie named '" . 'userID' . "' is not set!";
} else {
  echo "Cookie '" . $_COOKIE['userID'] . "' is set!<br>";
}


require_once ("settings.php");
$conn = @mysqli_connect(
$host,
$user,
$pwd,
$sql_db
);
if (!$conn) {
  echo "mysql not connected ";
  echo mysqli_connect_errno() . ":" . mysqli_connect_error();
  exit;
}
else {
  echo "<p>Access granted.</p>";
$dir = $_SESSION['dir'];
$dirs = array_filter(glob('*'), 'is_dir');
$sql = "SELECT File, Date FROM files ORDER BY File";
$query = mysqli_query($conn, $sql);
$table_rows = array();
$i = 0;
if ($query) {
  while ($row = $query -> fetch_row()) {
  //  printf ("%s (%s)\n", $row[0], $row[1]);
    $table_rows[$i]['file'] = $row[0];
    $table_rows[$i]['date'] = $row[1];
    $i++;
  }
  $count = $i;
  $query -> free_result();
}
$i = 0;
foreach($dirs as $folder)
{
     $table_rows[$i]['download'] = $folder;
  //   echo  '<a href="$folder" download>' . $folder.'</a>';
    // echo "<br>";
    $i++;
}

for($i=0; $i < $count; $i++)
{
  echo $table_rows[$i]['file'] . "-" . $table_rows[$i]['date'] . "-" . $table_rows[$i]['download'];
  echo '<p><br></p>';
}
}
 ?>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="style.css">
<title>Login and Sign-up</title>
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
