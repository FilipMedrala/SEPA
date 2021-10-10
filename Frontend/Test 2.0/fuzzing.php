<html>
<body>
<?php
echo "Application name: " . ($_POST['appname']);

## Get Parameters
$P1 = ($_POST['userid']);
$P2 = ($_POST['jobid']);
$P3 = ($_POST['appname']);
$P4 = ($_POST['jobtype']);
$P5 = ($_POST['fastcal']);
$P6 = ($_POST['statsd']);
$P7 = ($_POST['compiler']);

echo "<p>Variables dump: $P1, $P2, $P3, $P4, $P5, $P6</p>";

$upload_dir = "/var/www/html/aflfuzzerweb/files/uploadtmp/";
$upload_file = $upload_dir . basename($_FILES["chooseFile"]["name"]);

if (move_uploaded_file($_FILES["chooseFile"]["tmp_name"], $upload_file)) {
  $upload_is_ok = 1;
  $filename=$_FILES['chooseFile']['name'];
  echo 'your filename is: ' . $filename;
  echo '<p>Binary uploaded successfully!</p>';
  echo 'website should work';
}
else {
  $upload_is_ok = 0;
  $filename=$_FILES['chooseFile']['name'];
  echo 'your filename is: ' . $filename;
  echo '<p>Binary not uploaded successfully, please check logs!</p>';
  echo 'website is cooked';
}




?>
</body>
</html>
