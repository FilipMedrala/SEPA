<?php
## binary upload handler for fuzzing files
session_start();
$upload_dir = $_SESSION['dir'];
$exec_cmd1 = 'mkdir ' . $upload_dir  . $_SESSION["usrId"];
$exec_cmd2 = 'mkdir ' . $upload_dir  . $_SESSION["usrId"] . '/' . $_SESSION["jobId"];
exec($exec_cmd1);
exec($exec_cmd2);
$upload_usr_dir = $_SESSION['dir'];
$upload_file = $upload_usr_dir . basename($_FILES["usrFile"]["name"]);
$upload_temp_is_ok = 1;
## move from temporary directory to acutal user directory
if (move_uploaded_file($_FILES["usrFile"]["tmp_name"], $upload_file)) {
  $upload_is_ok = 1;
}
else {
  $upload_is_ok = 0;
}
## check upload status and print message
if ($upload_temp_is_ok === 1 && $upload_is_ok === 1) {
  echo '<p>Binary uploaded successfully!</p>';

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
    $id = $_COOKIE['userID'];
    $dir = $_SESSION["dir"];
    $date = date('d/m/Y');
    $file = basename($_FILES["usrFile"]["name"]);
    $sql = "INSERT INTO `files`(`uID`, `Date`,`Adr`, `File` )
    VALUES('$id', '$date', '$dir', '$file')";

    if ($conn->query($sql) === TRUE) {
    echo "Table inserted  successfully";
    }
    else {
      echo "Error inserting into the table: " . $conn->error;
    }
}
}

#echo 'Here is some more debugging info:';
#print_r($_FILES);
?>
