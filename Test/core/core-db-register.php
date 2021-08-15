<?php
session_start();

## Fetch user information from the POST message (email & password)
$post_usr_email = $_POST["usrEmail"];
$post_usr_pw = $_POST["usrPassword"];
#$user_uid =

## Sanitise user input (2 passes)
function sanitise_input($data)
{
  $data = trim($data);
  $data = stripslashes($data);
  $data = htmlspecialchars($data);
  return $data;
}
## stage 1 filtering
$post_usr_email = sanitise_input($post_usr_email)
$post_usr_pw = sanitise_input($post_usr_pw)
## stage 2 filtering
$post_usr_email = filter_var($post_usr_email, FILTER_SANITIZE_EMAIL)
$post_usr_pw = filter_var($post_usr_email, FILTER_SANITIZE_STRING)

## Hash user password using the Argon2id algorithm (SHA256 feature coming later)
$sql_usr_pw = password_hash($post_usr_pw, PASSWORD_ARGON2ID)

## Generate user id hexadecimal with pseudo-random function
$sql_usr_uid = random_bytes(8);

## SQL query preparation
$sql_query = "INSERT INTO useraccounts (Username, Password, UID) VALUES ('$post_usr_email', '$sql_usr_pw', '$sql_usr_uid')";

## Fetch user password from the SQL database
$sql_result = mysqli_query($sql_conn, $sql_query)

if ($sql_result == true) {
  ## Display success message
  echo '
  <div class="modal fade" id="loginFailModal" tabindex="-1">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="loginFailModalLabel">Login Failed</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <div class="alert alert-success" role="alert">
            <p>Your account has been registered!</p>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
          <button type="button" class="btn btn-primary">Save changes</button>
        </div>
      </div>
    </div>
  </div>
  ';
}
else {
  ## Reject the login and show a popup message as the password doesn't match
  echo '
  <div class="modal fade" id="loginFailModal" tabindex="-1">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="loginFailModalLabel">Login Failed</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <div class="alert alert-danger" role="alert">
            <p>Your username or password is incorrect!</p>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
          <button type="button" class="btn btn-primary">Save changes</button>
        </div>
      </div>
    </div>
  </div>
  ';
  ## Redirect the user back to the login page
  # currently not working as intended, temporarily disabled
  #header("location: login.php");
}
?>
