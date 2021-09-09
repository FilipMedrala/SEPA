<?php
## binary upload handler for fuzzing files
session_start();
$upload_dir = "/var/www/html/usr/";
$exec_cmd1 = 'mkdir ' . $upload_dir  . $_SESSION["usrId"];
$exec_cmd2 = 'mkdir ' . $upload_dir  . $_SESSION["usrId"] . '/' . $_SESSION["jobId"];
exec($exec_cmd1);
exec($exec_cmd2);
$upload_usr_dir = '/var/www/html/usr/' . $_SESSION["usrId"] . '/' . $_SESSION["jobId"] . '/';
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
}
else {
  echo '<p>Binary not uploaded successfully, please check logs!</p>';


}
#echo 'Here is some more debugging info:';
#print_r($_FILES);
?>
