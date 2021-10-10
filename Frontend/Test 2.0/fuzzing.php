<?php
#echo "Application name: " . ($_POST['appname']);

### Input Sanitisation
## Most inputs are predefined however perform this anyway...
function sanitise_input($data)
{
  $data = trim($data);
  $data = stripslashes($data);
  $data = htmlspecialchars($data);
  return $data;
}
function sanitise_input_l2($data)
{
  $data = sanitise_input($data);
  $data = filter_var($data, FILTER_SANITIZE_STRING);
  return $data;
}
function sanitise_input_l3($data)
{
  $data = sanitise_input($data);
  $data = filter_var($data, FILTER_SANITIZE_NUMBER_INT);
  return $data;
}

### Get Parameters
## leave uuid untouched, format included hyphen & digits, Will be fixed later
## Raw Variable BLock
$P1 = ($_POST['userid']);
$P2 = ($_POST['jobid']);
$P3 = ($_POST['appname']);
$P4 = ($_POST['jobtype']);
$P5 = ($_POST['fastcal']);
$P6 = ($_POST['statsd']);
$P7 = ($_POST['compiler']);
## Sanitised Variable Block
$P1san = $P1;
$P2san = sanitise_input_l3($P2);
$P3san = sanitise_input_l2($P3);
$P4san = sanitise_input_l3($P4);
$P5san = sanitise_input_l3($P5);
$P6san = sanitise_input_l2($P6);
$P7san = sanitise_input_l2($P7);

#echo "<p>Variables dump: $P1san, $P2san, $P3san, $P4san, $P5san, $P6san, $P7san</p>";

$upload_dir = "/var/www/html/aflfuzzerweb/files/uploadtmp/";
$upload_file1 = $upload_dir . basename($_FILES["chooseFile"]["name"]);
$upload_file2 = $upload_dir . basename($_FILES["chooseFile2"]["name"]);

if (move_uploaded_file($_FILES["chooseFile"]["tmp_name"], $upload_file1)) {
  $upload1_is_ok = 1;
  $filename1=$_FILES['chooseFile']['name'];
#  echo 'your filename is: ' . $filename;
#  echo '<p>First binary uploaded successfully!</p>';
#  echo 'website should work';
#  exec(/bin/bash /home/sepadmin/Documents/AFLscripts/startTheJobs.sh $P1 $P2 $P4 $P5 $P6 $filename1)
}
else {
  $upload1_is_ok = 0;
  $filename1=$_FILES['chooseFile']['name'];
#  echo 'your first filename is: ' . $filename;
#  echo '<p>First binary not uploaded successfully, please check logs!</p>';
#  echo 'website is cooked';
}
if (move_uploaded_file($_FILES["chooseFile2"]["tmp_name"], $upload_file2)) {
  $upload2_is_ok = 1;
  $filename2=$_FILES['chooseFile2']['name'];
#  echo 'your second filename is: ' . $filename;
#  echo '<p>Second binary uploaded successfully!</p>';
#  echo 'website should work';
}
else {
  $upload2_is_ok = 0;
  $filename2=$_FILES['chooseFile2']['name'];
#  echo 'your second filename is: ' . $filename;
#  echo '<p>Second binary not uploaded successfully, please check logs!</p>';
#  echo 'website is cooked';
}

if ($upload1_is_ok === 1 && $upload2_is_ok === 1) {
  ## Start fuzzing job
  exec("/bin/bash /home/sepadmin/Documents/AFLscripts/startTheJobs.sh $P1 $P2 $P4 $P5 $P6 $filename2", );
}
else {
  echo "Failed to start the requested AFL job: $P2, as one or both of the file uploads weren't successful.";
}


?>
