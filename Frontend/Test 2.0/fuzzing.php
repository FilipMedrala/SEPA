<html>
<body>
<?php
Application name: echo $_POST["appname"]; <br>

## Get Parameters
$P1 = ($_POST['userid']);
$P2 = ($_POST['jobid']);
$P3 = ($_POST['appname']);
$P4 = ($_POST['jobtype']);
$P5 = ($_POST['fastcalc']);
$P6 = ($_POST['statsd']);

echo "<p>$P1 - $P2 - $P3 - $P4 - $P5 - $P6</p>"

$upload_dir = "/var/www/html/aflfuzzerweb/files/uploadtmp/";
$upload_file = $upload_usr_dir . basename($_FILES["usrFile"]["name"]);
## move from temporary directory to acutal user directory
if (move_uploaded_file($_FILES["usrFile"]["tmp_name"], $upload_file)) {
  $upload_is_ok = 1;
}
else {
  $upload_is_ok = 0;
}
## check upload status and print message
if ($upload_is_ok === 1) {
  echo '<p>Binary uploaded successfully!</p>';
  echo "website should work"
  #exec(/bin/bash /home/sepadmin/Documents/AFLscripts/startTheJobs.sh
else {
  echo '<p>Binary not uploaded successfully, please check logs!</p>';
  echo "website is cooked"
}




?>
</body>
</html>
